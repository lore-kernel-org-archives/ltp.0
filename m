From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 May 2019 12:08:53 +0200
Subject: [LTP] [PATCH] net: Disable building tst_get_unused_port in old
	API
In-Reply-To: <20190524095806.GA19303@rei>
References: <20190524095317.10240-1-pvorel@suse.cz>
 <20190524095806.GA19303@rei>
Message-ID: <20190524100853.GA17393@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Commit fa6a4e708 moved tst_get_unused_port into new API, but left code
> > in Makefile built it also for old API. It was up to make which of these
> > was copied last and remain installed.

> > Also remove comparison for tst_get_unused_port from ltpapicmd.c.

> > Fixes: fa6a4e708 ("net: Introduce TST_GET_UNUSED_PORT() macro into C API")

> Sorry for not catching that during review, this is obviously fine,
> acked.
Thanks for a review, merged.

Kind regards,
Petr
