From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Mar 2019 19:19:40 +0100
Subject: [LTP] [PATCH] cpuset: disable for UCLIBC
In-Reply-To: <1021cd54-2fbd-5fb9-f374-62761c967331@synopsys.com>
References: <1552412679-28694-1-git-send-email-vgupta@synopsys.com>
 <20190314100113.GA13609@dell5510>
 <1021cd54-2fbd-5fb9-f374-62761c967331@synopsys.com>
Message-ID: <20190318181940.GA5494@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vineet,

> >> libcpuset.c relies on FTS which is not enabled by default on uClibc.
> >> Instead of needing to reconfigure, rebuild uClibc lets disable this test
> >> for uClibc
> > Which uClibc version are you using?
> > Both uClibc and uclibc-ng has it [1] since 2011, version v0.9.32, in commit
> > a4aa01c12 ("Added fts support for traversing UNIX file hierarchies.")

> Right I'm using bleeding edge as well, and do have the header in sources, its just
> not configured/enabled by default hence not available in installation.


> > It's actually MUSL, what is missing it [2]. Although there is some
> > implementation [3], we should skip it for musl. But the clearest way is really
> > to check presence of <fts.h>, that's fix it for all libc.

> Spot on, that is indeed the best/ideal way of doing it. Do you know if such a
> mechanism already exists in LTP. If you point me to an example I can respin the
> patch accordingly.
Simple adding fts.h in AC_CHECK_HEADERS + guards in a file #ifdef HAVE_FTS_H
should do the magic :).

Kind regards,
Petr
