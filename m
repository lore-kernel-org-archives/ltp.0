From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Aug 2021 20:13:06 +0200
Subject: [LTP] [PATCH v3 2/8] Add 'make check' to the build system
In-Reply-To: <YSzsPWJd66G7OoO+@yuki>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
 <20210728123412.31858-3-rpalethorpe@suse.com>
 <YSjVND0kRfXGQe6g@pevik> <YSzsPWJd66G7OoO+@yuki>
Message-ID: <YS0fsly/ryB5MUAN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > $ make check
> > ...
> > route-change-netlink.c:13:11: error: unable to open 'libmnl/libmnl.h'

> > <libmnl/libmnl.h> is guarded by #ifdef HAVE_LIBMNL (config.h). Maybe there is a
> > way to pass it to sparse. But that'd silently prevent to check code we want to
> > check, thus it's probably better to just require to have everything installed.

> Well if you are hacking on a test that requires libnl and you want to
> run 'make check' before submission it has to be installed anyways. So
> this is not a big problem for the intended usage...
Sure, you're right.

Kind regards,
Petr
