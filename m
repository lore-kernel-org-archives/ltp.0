From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 13:39:20 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009061619.48677-3-lkml@jv-coder.de>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de>
Message-ID: <20191009113919.GB7561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If a test requires root only under certan circumstances, TST_NEEDS_ROOT
> is not sufficient, because it always requires root.
> ---
>  testcases/lib/tst_test.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c70a5abbe..07712670d 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -326,6 +326,13 @@ tst_check_cmds()
>  	return 0
>  }
>  
> +tst_test_root()
> +{
> +	if [ "$(id -ru)" != 0 ]; then
> +		tst_brk TCONF "Must be super/root for this test!"
> +	fi
> +}

Can we keep the name to be tst_require_root() please?

Historically this function has been always named like this in LTP.

-- 
Cyril Hrubis
chrubis@suse.cz
