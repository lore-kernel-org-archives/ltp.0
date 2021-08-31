From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 14:01:15 +0200
Subject: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
In-Reply-To: <20210831114406.8527-1-rpalethorpe@suse.com>
References: <878s0ikl6d.fsf@suse.de>
 <20210831114406.8527-1-rpalethorpe@suse.com>
Message-ID: <YS4aC5uSPYY77L/6@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> V2:
> * Use tst_printf
> * Fix typos
> * rm .sh from Makefile
Thanks for a quick update.

> diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
...
> +	tst_res(changed ? TPASS : TFAIL,
> +		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
                                                         ^ disallowed
(will be fixed during merge)


Kind regards,
Petr
