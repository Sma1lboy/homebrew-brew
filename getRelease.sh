###
 # @Author: Vincent Young
 # @Date: 2023-02-17 19:18:08
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-03-03 02:16:13
 # @FilePath: /homebrew-brew/getRelease.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 

#!/bin/bash

update_deeplx(){
    # Get the latest version of Deeplx
    last_version=$(curl -Ls "https://api.github.com/repos/OwO-Network/DeepLX/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Update the version number in the formula
    sed -i '' "s/version \".*/version \"${last_version}\"/g" Formula/deeplx.rb

    # Download the new binaries
    wget -O deeplx_darwin_amd64 https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_amd64
    wget -O deeplx_darwin_arm64 https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum deeplx_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum deeplx_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i '' "8s/.*/    sha256 \"${arm64_sha256}\"/" Formula/deeplx.rb
    sed -i '' "11s/.*/    sha256 \"${amd64_sha256}\"/" Formula/deeplx.rb

    # Delete the new binaries
    rm -f deeplx_darwin*
}

update_claude2openai(){
    # Get the latest version of Claude2OpenAI
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/claude2openai/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Update version in the formula
    sed -i '' "s/version \".*\"/version \"${last_version}\"/" Formula/claude2opneai.rb

    # Download the new binaries
    wget -O claude2openai_darwin_amd64 https://github.com/missuo/claude2openai/releases/download/v${last_version}/claude2openai-darwin-amd64
    wget -O claude2openai_darwin_arm64 https://github.com/missuo/claude2openai/releases/download/v${last_version}/claude2openai-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum claude2openai_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum claude2openai_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i '' "7s/.*/    sha256 \"${arm64_sha256}\"/" Formula/claude2opneai.rb
    sed -i '' "10s/.*/    sha256 \"${amd64_sha256}\"/" Formula/claude2opneai.rb

    # Delete the new binaries
    rm -f claude2openai_darwin*
}

update_deeplx
update_claude2openai