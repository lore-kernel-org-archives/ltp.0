From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Dec 2018 16:25:27 +0100
Subject: [LTP] [PATCH 1/1] travis: Use gcc 8 and clang 7
In-Reply-To: <20181207093126.12901-1-pvorel@suse.cz>
References: <20181207093126.12901-1-pvorel@suse.cz>
Message-ID: <20181211152527.GD1180@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Replacing gcc 5 with gcc 8 and clang 4 with clang 7.
> This gives us shiny new versions, older and very old ones, while
> still keeping the same number of jobs.

The gcc one is hard choice gcc-5 is not that old yet, but we sure want
to have bleeding edge there to prepare for tomorrow and we do have
gcc-4.9 and gcc-6 so it's probably Ok.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .travis.yml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 078028f9b..f4e9bfe9d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -11,11 +11,11 @@ matrix:
>          ### native builds ###
>          - os: linux
>            env: BUILD="native" INSTALL_PACKAGES="$BUILD"
> -          compiler: gcc-5
> +          compiler: gcc-8
>            addons:
>                apt:
>                    sources: ['ubuntu-toolchain-r-test']
> -                  packages: ['gcc-5']
> +                  packages: ['gcc-8']
>  
>          - os: linux
>            env: BUILD="native" TREE="out" INSTALL_PACKAGES="$BUILD"
> @@ -27,11 +27,11 @@ matrix:
>  
>          - os: linux
>            env: BUILD="native" TREE="out"
> -          compiler: clang-4.0
> +          compiler: clang-7
>            addons:
>                apt:
> -                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-4.0']
> -                  packages: ['clang-4.0']
> +                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-7']
> +                  packages: ['clang-7']
>  
>          - os: linux
>            env: BUILD="native" INSTALL_PACKAGES="$BUILD"
> -- 
> 2.19.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz
