#!/usr/bin/env php
<?php

function generate(string $phpVersion, string $fedoraVersion, string $repo): void
{
    if (!file_exists($phpVersion)){
        mkdir($phpVersion, 0775, true);
    }
    $dockerfile = $phpVersion . "/Dockerfile";
    $phpMMVersion = preg_replace('/^\([0-9]\)\.\([0-9]\)-rc/', '${1}.${2}', $phpVersion);
    $file = fopen($dockerfile, 'w');

    fwrite($file, "FROM fedora:$fedoraVersion\n");
    fwrite($file, "LABEL maintainer \"Matyas Kroupa <kroupa.matyas@gmail.com>\"\n\n");

    if ($repo === 'remi') {
        fwrite($file, "RUN dnf install -y https://rpms.remirepo.net/fedora/remi-release-${fedoraVersion}.rpm dnf-plugins-core && \\\n");
        fwrite($file, "    dnf config-manager --set-enabled remi && \\\n");
        fwrite($file, "    dnf config-manager --set-enabled remi-modular && \\\n");
        fwrite($file, "    dnf module install -y php:remi-$phpMMVersion && \\\n");
        fwrite($file, "    dnf install -y php-opcache php-pecl-xdebug3 php-pecl-zip\n");
    }
    fwrite($file, "\n");

    $config = yaml_parse_file('variables.yaml');
    $patterns = ['/#DEPENDENCIES#/'];
    $replacements = [$config['dependencies'][preg_replace('/\./', '-', $phpVersion)]];
    $footer = preg_replace($patterns, $replacements, file_get_contents('./Dockerfile'));
    fwrite($file, $footer);

    fclose($file);
}

function build(array $minorVersions): array
{
    $fullVersions = [];
    foreach ($minorVersions as $version) {
        echo "\nBuilding version $version\n";
        system("buildah bud --pull --no-cache -t krouma/php-xdebug:$version -f $version/Dockerfile .");
        
        $fullVersion = system("podman run -a stdout --rm krouma/php-xdebug:$version php --version | head -1 | awk '{print $2}'");
        $fullVersions[$version] = $fullVersion;

        echo "\nTagging $version as $fullVersion\n";
        system("buildah tag krouma/php-xdebug:$version krouma/php-xdebug:$fullVersion");
    }
    
    return $fullVersions;
}

function main($argv): void
{
    $command = $argv[1];
    $args = array_slice($argv, 2);
    match ($command) {
        'build' => build($args),
        'generate' => generate(...$args)
    };
}

main($argv);
