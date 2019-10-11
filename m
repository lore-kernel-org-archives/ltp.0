From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Oct 2019 14:06:34 +0200
Subject: [LTP] [PATCH v5 0/5] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20191011095442.10541-1-pvorel@suse.cz>
References: <20191011095442.10541-1-pvorel@suse.cz>
Message-ID: <20191011120633.GC2591@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Changes v4->v5:
> * remove float related code (left from v3)
> * remove "tst_test_cmds cut" check from tst_test.sh (there is check for
> cut and other later => it should be probably removed as well, but as a
> separate patch) (Cyril)
> * remove unneeded IFS from test (Cyril)
> * mention ceiling LTP_TIMEOUT_MUL in doc/user-guide.txt
> 
> Here is the diff:
> diff --git doc/user-guide.txt doc/user-guide.txt
> index 8913c3221..7f6334ec2 100644
> --- doc/user-guide.txt
> +++ doc/user-guide.txt
> @@ -15,7 +15,7 @@ For running LTP network tests see `testcases/network/README.md`.
>                            'n' or '0': never colorize.
>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
>                            slow machines to avoid unexpected timeout).
> -                          Variable is also used in shell tests.
> +                          Variable is also used in shell tests, but here ceiled to int.
                                                                        ^
									Drop
									the
									"here"

Other than that it's fine, you can add my Reviewed-by:

-- 
Cyril Hrubis
chrubis@suse.cz
