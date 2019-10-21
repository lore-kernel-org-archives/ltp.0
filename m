From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Oct 2019 14:42:22 +0200
Subject: [LTP] [PATCH v4 1/5] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20191018124502.25599-2-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-2-cfamullaconrad@suse.de>
Message-ID: <20191021124221.GB31069@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

...
> +	tst_multiply_timeout tst_sec
> +
>  	if [ $# -ne 3 ]; then
>  		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3 parameters"
>  	fi
> @@ -376,16 +378,12 @@ _tst_rescmp()
>  	fi
>  }

> -
> -_tst_setup_timer()
> +tst_multiply_timeout()
This is a private function, it should be called '_tst_multiply_timeout'.
This can be changed by person who merges the patchset.

Kind regards,
Petr
