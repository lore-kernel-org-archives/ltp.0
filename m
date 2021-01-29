From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 14:47:19 +0100
Subject: [LTP] [PATCH] sctp/func_test: add check on the sctp driver
In-Reply-To: <20210129090759.16534-1-kory.maincent@bootlin.com>
References: <20210129090759.16534-1-kory.maincent@bootlin.com>
Message-ID: <YBQR50ltZa+d1Or7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> +	if (tst_check_driver("sctp"))
> +		tst_brkm(TCONF, tst_exit, "sctp driver not available");
Using tst_check_driver requires #include "tst_kernel.h".

Kind regards,
Petr
