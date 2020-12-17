From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 13:22:31 +0100
Subject: [LTP] [PATCH 2/2] docparse/parse.sh: Fix running with relative
 path
In-Reply-To: <20201217121520.25713-3-pvorel@suse.cz>
References: <20201217121520.25713-1-pvorel@suse.cz>
 <20201217121520.25713-3-pvorel@suse.cz>
Message-ID: <X9tNhwYzPyXpOEfx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> that's not needed for build, but useful for debugging.
> 
> Running as ./parse.sh fails:
> cat: ./../VERSION: No such file or directory
> 
> top_srcdir must be absolute path.
> 
> Fixes: a069cd36b ("docparse: Add test documentation parser")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  docparse/parse.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docparse/parse.sh b/docparse/parse.sh
> index 172eab702..79011bc10 100755
> --- a/docparse/parse.sh
> +++ b/docparse/parse.sh
> @@ -5,7 +5,7 @@
>  set -e
>  
>  top_builddir=$PWD/..
> -top_srcdir="$(dirname $0)/.."
> +top_srcdir="$(cd $(dirname $0)/..; pwd)"
>  
>  cd $top_srcdir

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
