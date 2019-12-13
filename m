From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 16:39:33 +0100
Subject: [LTP] [PATCH 2/3] Port test_1_to_1_initmsg_connect (SCTP) to
 new API
In-Reply-To: <20191126120241.5460-3-mdoucha@suse.cz>
References: <20191126120241.5460-1-mdoucha@suse.cz>
 <20191126120241.5460-3-mdoucha@suse.cz>
Message-ID: <20191213153933.GB8241@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks for the rewrite!

...
> +++ b/utils/sctp/func_tests/test_1_to_1_initmsg_connect.c
...
> -	tst_resm(TPASS, "connect() with init timeout set to 0 - SUCCESS");
> +	if (TST_RET != msglen) {
> +		tst_res(TFAIL | TTERRNO, "recv() failed");
> +	} else {
> +		tst_res(TPASS, "connect() with init timeout set to 0 - SUCCESS");
If you don't mind, I'd remove " - SUCCESS" from the message before merge.
> +	}

Kind regards,
Petr
