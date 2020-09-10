From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Sep 2020 17:30:35 +0200
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF
 for < v5.9
In-Reply-To: <20200910121628.18505-1-pvorel@suse.cz>
References: <20200910121628.18505-1-pvorel@suse.cz>
Message-ID: <20200910153035.GA12601@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  			if (ret > 0) {
> -				tst_res(TFAIL, "group %d (%x) with %s and "
> -					"%s ignore mask got event",
> +				tst_res((tst_kvercmp(5, 9, 0)) < 0 ? TCONF : TFAIL,
> +					"group %d (%x) with %s and %s ignore mask got event",
>  					i, fanotify_class[p], mark->name, ignore_mark->name);

I do not like that much, how the tst_kvercmp() is sandwitched inside of
the tst_res() call, since it makes it easier to be overlooked.

The question is how can we do better, maybe set a variable in test
setup?

Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
