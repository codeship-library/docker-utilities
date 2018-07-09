# Codeship Environment Variable Helper Image

This is a helper image to make it easier to store secret files onto your Codeship Pro build via Codeship's environment variable file.

## Store secret file into declared `env` file

The following command will create a new env var file (if one doesn't already exist) and store the container destination as well as contents of the file to the `ENV_VAR_HELPER` environment variable.

```shell
$ docker run --rm -it -v $(pwd):/files codeship/env-var-helper cp secret_file.txt:/container/destination/for/secret_file.txt env
```

You can store multiple files to the `ENV_VAR_HELPER` environment variable. Repeated `cp` commands for the same LOCAL_FILE<-->CONTAINER_DESTINATION pair will simply overwrite `ENV_VAR_HELPER` with latest contents of local file.

## List out current entries

The following command will list out the current entries within the `ENV_VAR_HELPER` environment variable:

```shell
$ docker run --rm -it -v $(pwd):/files codeship/env-var-helper ls env

/container/destination/for/secret_file.txt - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...
```

## Show the full contents of an entry

```shell
$ docker run --rm -it -v $(pwd):/files dkcodeship/env-var-helper cat /container/destination/for/secret_file.txt env

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Ipsum dolor sit amet consectetur adipiscing elit. Convallis tellus id interdum velit laoreet id donec. Etiam non quam lacus suspendisse faucibus interdum. Malesuada proin libero nunc consequat interdum varius sit amet mattis. Volutpat est velit egestas dui id ornare arcu. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Aenean vel elit scelerisque mauris pellentesque. Orci sagittis eu volutpat odio facilisis mauris sit amet massa. Magna sit amet purus gravida quis blandit. Aliquet enim tortor at auctor urna nunc. Id diam maecenas ultricies mi. Elementum eu facilisis sed odio morbi quis commodo odio. Non diam phasellus vestibulum lorem sed. Imperdiet nulla malesuada pellentesque elit eget gravida cum sociis natoque. Vestibulum lorem sed risus ultricies tristique.

Iaculis nunc sed augue lacus viverra vitae. Facilisis volutpat est velit egestas dui id ornare. Sem integer vitae justo eget. In arcu cursus euismod quis viverra. Massa sapien faucibus et molestie ac feugiat. Enim tortor at auctor urna nunc id cursus. Neque ornare aenean euismod elementum nisi quis eleifend. Vitae auctor eu augue ut. Diam phasellus vestibulum lorem sed risus. Nunc pulvinar sapien et ligula ullamcorper malesuada proin. Nec feugiat in fermentum posuere urna nec tincidunt. Vitae congue mauris rhoncus aenean vel.

In hac habitasse platea dictumst quisque sagittis. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui. Aliquet porttitor lacus luctus accumsan tortor posuere ac ut consequat. In nisl nisi scelerisque eu ultrices vitae auctor eu augue. Mi quis hendrerit dolor magna eget est. Viverra suspendisse potenti nullam ac tortor. Donec et odio pellentesque diam volutpat commodo. Eu consequat ac felis donec et odio pellentesque. Eget felis eget nunc lobortis mattis aliquam. Fringilla est ullamcorper eget nulla. Libero enim sed faucibus turpis in eu mi. Neque egestas congue quisque egestas. Velit euismod in pellentesque massa placerat. Habitant morbi tristique senectus et netus et.

Mollis aliquam ut porttitor leo a diam. Id diam vel quam elementum pulvinar etiam non quam. Morbi tristique senectus et netus. Euismod lacinia at quis risus sed vulputate odio ut enim. Pellentesque id nibh tortor id aliquet. Mattis pellentesque id nibh tortor id. Fringilla ut morbi tincidunt augue interdum velit. Pharetra et ultrices neque ornare aenean. Risus quis varius quam quisque id diam vel quam. Bibendum neque egestas congue quisque egestas. Urna nunc id cursus metus aliquam. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis. Ac feugiat sed lectus vestibulum mattis. Cursus in hac habitasse platea dictumst. Neque egestas congue quisque egestas diam in arcu cursus. Sed velit dignissim sodales ut eu sem integer vitae justo. Arcu cursus euismod quis viverra. Libero enim sed faucibus turpis in eu.

Nisl vel pretium lectus quam id leo in. Faucibus in ornare quam viverra. Dolor sit amet consectetur adipiscing. Maecenas sed enim ut sem viverra aliquet. Velit laoreet id donec ultrices tincidunt arcu non sodales. Elementum eu facilisis sed odio morbi. Consequat id porta nibh venenatis cras sed. At in tellus integer feugiat scelerisque varius morbi. Curabitur gravida arcu ac tortor dignissim convallis. Tellus integer feugiat scelerisque varius morbi enim nunc. Duis convallis convallis tellus id interdum velit laoreet. Ornare arcu odio ut sem nulla pharetra diam sit. Egestas integer eget aliquet nibh praesent tristique.
```

## Remove an entry from `ENV_VAR_HELPER`

```shell
$ docker run --rm -it -v $(pwd):/files dkcodeship/env-var-helper rm /container/destination/for/secret_file.txt env
```
