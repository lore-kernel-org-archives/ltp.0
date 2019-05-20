From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 17:43:15 +0200
Subject: [LTP] [PATCH 1/1] tst_net.sh: Remove -B option from
	tst_rhost_run()
In-Reply-To: <20190429124630.4834-1-pvorel@suse.cz>
References: <20190429124630.4834-1-pvorel@suse.cz>
Message-ID: <20190520154314.GA15837@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This option was added in 6bcf7ce05 ("lib: tst_rhost_run: new option -B
> for saving background log") and used in tst_dump_rhost_cmd() added in
> 921fb2d2c ("network/tst_netload: dump background netstress output on
> failure").
> But d6ce33a2e ("netstress: set port dynamically on the server-side")
> moved logging into netstress.log, created by netstress.c, -B is not
> used any more.

> NOTE: if this feature is reintroduced, it should check whether
> TST_NEEDS_TMPDIR=1 is set (similar to fix e3a1aa106 ("net/tst_netload:
> TBROK when TST_NEEDS_TMPDIR not set")).

> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Merged.

Kind regards,
Petr
