From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Aug 2019 11:33:54 +0200
Subject: [LTP] [PATCH v3 4/4] build: Move
 -Werror-implicit-function-declaration from make to build.sh
In-Reply-To: <20190806164523.557-1-pvorel@suse.cz>
References: <20190806164523.557-1-pvorel@suse.cz>
Message-ID: <20190809093354.GA13178@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Previously it was passed only to Android build. Generally Werror flags
> should be on for development but disabled for releases and production.
> We don't have any configure flag stating development build, so using it
> in build.sh should be sufficient as it can be used in both Travis CI
> builds and local development.
> 
> + respect CC variable in build.sh (for these lazy to pass it via -c flag)
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Change v2->v3:
> * move flag to build.sh, so it can be reused for local development
> * respect CC
> 
>  build.sh               | 4 +++-
>  include/mk/env_post.mk | 4 ----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/build.sh b/build.sh
> index 3da2adf55..78845bf95 100755
> --- a/build.sh
> +++ b/build.sh
> @@ -9,6 +9,9 @@
>  
>  set -e
>  
> +CFLAGS="${CFLAGS:--Werror-implicit-function-declaration}"

Shouldn't this be -Werror=implicit-function-declaration ?

Hmm, looks like both variants actually work, but the gcc manual speaks
only about -Werror= one.


Otherwise it looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
