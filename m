From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Aug 2021 14:06:12 +0200
Subject: [LTP] [PATCH v3 2/8] Add 'make check' to the build system
In-Reply-To: <20210728123412.31858-3-rpalethorpe@suse.com>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
 <20210728123412.31858-3-rpalethorpe@suse.com>
Message-ID: <YSjVND0kRfXGQe6g@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

I see 'make check' requires all to have headers/dependencies installed, is that wanted?

$ make check
...
route-change-netlink.c:13:11: error: unable to open 'libmnl/libmnl.h'

<libmnl/libmnl.h> is guarded by #ifdef HAVE_LIBMNL (config.h). Maybe there is a
way to pass it to sparse. But that'd silently prevent to check code we want to
check, thus it's probably better to just require to have everything installed.

Kind regards,
Petr
