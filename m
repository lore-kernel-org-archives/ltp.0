From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 08:58:35 +0100
Subject: [LTP] [RFC PATCH 1/1] rpc-tirpc: Remove authdes related tests
In-Reply-To: <e01fdaab-617b-dfc3-021c-ea04d0ab42cf@RedHat.com>
References: <20191230201122.9749-1-petr.vorel@gmail.com>
 <e01fdaab-617b-dfc3-021c-ea04d0ab42cf@RedHat.com>
Message-ID: <20200109075835.GB12486@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

...
> > or is it safe to expect that authdes is compiled out when authdes_create() returning NULL?
> This was the way the glibc people suggested I do it... 
Thanks for info (deprecating features in library is new thing to me).

> > I also decided to remove tests because authdes is deprecated and uClibc
> > and musl does not provide DES authentication.

> > FYI I've sent patch to libtirpc to add authdes_seccreate() interface [1].
> > [1] https://sourceforge.net/p/libtirpc/mailman/message/36889142/
> This is fixed in tag libtirpc-1-2-6-rc1 which I just pushed upstream.
Thanks!

> Is there anything else from my side that is needed?
Hope distros will backport the fix soon.

Can you please either ack this patch or request we detect authdes support
support (i.e. libtirpc < 1.2.5) and keep tests in this case?
(I'd be for removing these tests, but if you consider them useful for testing,
I'll do the detection).

Kind regards,
Petr
