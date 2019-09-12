From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 23:51:27 +0200
Subject: [LTP] [PATCH v2 1/3] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20190911165225.2122-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
Message-ID: <20190912215126.GA9524@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

...
> -	local tst_sec=$(expr $3 \* 1000000)
> +	local tst_sec=$(tst_adjust_timeout $(expr $3 \* 1000000))
Just a style comment: instead of using $(expr ), I'd switch to $(( )).

Kind regards,
Petr
