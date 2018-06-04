From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Jun 2018 23:06:29 +0200
Subject: [LTP] [RFC PATCH v6 3/5] tst_test.sh: Filter out commented out
 lines from warnings
In-Reply-To: <20180601072838.13196-4-pvorel@suse.cz>
References: <20180601072838.13196-1-pvorel@suse.cz>
 <20180601072838.13196-4-pvorel@suse.cz>
Message-ID: <20180604210628.GA19509@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
What is the usecase for this?

I know that comments does not count as a code but why would the test
need to comment with a reserved name in it?

> ---
>  testcases/lib/tst_test.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index de5d65039..098ff7bd2 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -244,13 +244,21 @@ _tst_rescmp()
>  	fi
>  }
>  
> +_tst_get_used_var()
> +{
> +	local _tst_pattern="$1"
> +
> +	grep $_tst_pattern "$TST_TEST_PATH" | grep -v '^[[:space:]]*#' | \
> +		sed "s/.*${_tst_pattern}//;"' s/[="} \t\/:`].*//'

As far as I can tell this does not work for:

foo # run function foo

> +}

-- 
Cyril Hrubis
chrubis@suse.cz
