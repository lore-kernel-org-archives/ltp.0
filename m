From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 11:31:54 +0200
Subject: [LTP] [PATCH] syscalls/sendmmsg: add new test
In-Reply-To: <20190729090140.GA22913@rei.lan>
References: <20190725211119.239938-1-smuckle@google.com>
 <20190729085606.GA25517@dell5510> <20190729090140.GA22913@rei.lan>
Message-ID: <20190729093154.GA20376@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Steve,

> > > Changes since v3:
> > >  - drop resending of messages on partially successful sendmmsg()
> > >  - drop use of pthreads, do message creation and port management in
> > >    setup/cleanup

> > The only thing left in v4 is duplicate LTP_CHECK_MMSGHDR call.
> > + I'd use lapi/socket.h also in cve-2016-7117.c (as Cyril pointed out)
> > in this commit (this change is simple enough).

> > So I'd be for merging v4 with diff below.

> There is also leftover -pthread in CFLAGS in Makefile since we dropped
> pthreads from the test. Other than that and the minor issues you have
> pointed it looks good to me as well.

Cyril, thanks for pointing this out. Merged with these fixes and your ack.

Kind regards,
Petr
