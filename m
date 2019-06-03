From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 15:10:09 +0200
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <20190221112201.18324-1-chrubis@suse.cz>
References: <20190221112201.18324-1-chrubis@suse.cz>
Message-ID: <20190603131009.GA7970@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril,

> The dev parameter needs to be casted to unsigned in some cases, let's
> move call to tst_syscall() from the tests to lapi so that the tests does
> not have to worry about the low level details.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Steve Muckle <smuckle@google.com>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
I guess you send a v2 with test variants, so closing this in patchwork.


Kind regards,
Petr
