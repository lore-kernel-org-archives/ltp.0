From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 11:01:13 +0100
Subject: [LTP] [PATCH] cpuset: disable for UCLIBC
In-Reply-To: <1552412679-28694-1-git-send-email-vgupta@synopsys.com>
References: <1552412679-28694-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20190314100113.GA13609@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vineet,

> libcpuset.c relies on FTS which is not enabled by default on uClibc.
> Instead of needing to reconfigure, rebuild uClibc lets disable this test
> for uClibc
Which uClibc version are you using?
Both uClibc and uclibc-ng has it [1] since 2011, version v0.9.32, in commit
a4aa01c12 ("Added fts support for traversing UNIX file hierarchies.")

It's actually MUSL, what is missing it [2]. Although there is some
implementation [3], we should skip it for musl. But the clearest way is really
to check presence of <fts.h>, that's fix it for all libc.

Kind regards,
Petr

[1] https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/tree/include/fts.h
[2] https://wiki.musl-libc.org/faq.html#Q:-Why-is-%3Ccode%3Efts.h%3C/code%3E-not-included?
[3] https://github.com/pullmoll/musl-fts
