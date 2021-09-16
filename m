From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Sep 2021 22:55:27 +0200
Subject: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
In-Reply-To: <20210916123248.4974-1-rpalethorpe@suse.com>
References: <20210909140911.44EC9A4308@relay2.suse.de>
 <20210916123248.4974-1-rpalethorpe@suse.com>
Message-ID: <YUOvPxU5NcPq8gw0@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

Changes to this version (it's actually v3) LGTM.
I suppose Cyril wants to recheck it, thus not merging it yet.

Thanks!

Kind regards,
Petr

> +++ b/testcases/kernel/irq/.gitignore
> @@ -0,0 +1 @@
> +irqbalance01
Very nit: we usually put '/' at the beginning to: /irqbalance01
(to apply files only in testcases/kernel/irq/, but that's irrelevant in most
cases as there are no subdirectories). If we even bother, it can be changed during merge.

