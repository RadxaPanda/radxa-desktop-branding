#! /bin/bash

# KDE wallpaper generator
wp_source="wallpapers/" # example $wp_source/$wp_type_$wp_color.svg
wp_path="src/radxa-theme/wallpapers"
wp_types=("wavy" "blocky" "mountain")
wp_colors=("pink" "blue" "light/dark")

for wp_type in "${wp_types[@]}"; do
    for wp_color in "${wp_colors[@]}"; do
        wp_type_ucfirst="$(tr '[:lower:]' '[:upper:]' <<< ${wp_type:0:1})${wp_type:1}"
        if [ "$wp_color" == "light/dark" ]; then
            wp_file_dark="$wp_path/$wp_type/contents/images_dark/3840x2160.svg"
            wp_file_light="$wp_path/$wp_type/contents/images/3840x2160.svg"
            wp_source_file_dark="$wp_source/${wp_type}-dark.svg"
            light_source_file="$wp_source/${wp_type}-green.svg"
            echo "Generating $wp_type light/dark"
            mkdir -pv $wp_path/$wp_type/contents/images_dark
            mkdir -pv $wp_path/$wp_type/contents/images
            cp -v $wp_source_file_dark $wp_file_dark
            cp -v $light_source_file $wp_file_light
            echo "Generating metadata.json for $wp_type Light/Dark"
            cat <<EOF > $wp_path/$wp_type/metadata.json
{
    "KPlugin": {
        "Name": "$wp_type_ucfirst Light/Dark",
        "Id": "$wp_type",
        "License": "cc-by-nc",
        "Authors": [
            {
                "Name": "Radxa",
                "Email": "dev@radxa.com"
            }
        ]
    },
    "X-KDE-PlasmaImageWallpaper-AccentColor": {
        "Dark": "#018786",
        "Light": "#3d818d"
    }
}
EOF
        else
            wp_file="$wp_path/$wp_type-$wp_color/contents/images/3840x2160.svg"
            wp_source_file="$wp_source/${wp_type}-${wp_color}.svg"
            echo "Generating $wp_type $wp_color"
            mkdir -pv $wp_path/$wp_type-$wp_color/contents/images
            cp -v $wp_source_file $wp_file
            echo "Generating metadata.json for $wp_type_ucfirst $wp_color"
            cat <<EOF > $wp_path/$wp_type-$wp_color/metadata.json
{
    "KPlugin": {
        "Name": "$wp_type_ucfirst $wp_color",
        "Id": "$wp_type-$wp_color",
        "License": "cc-by-nc",
        "Authors": [
            {
                "Name": "Radxa",
                "Email": "dev@radxa.com"
            }
        ]
    }
}
EOF
        fi
    done
done
