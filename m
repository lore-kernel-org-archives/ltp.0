From: niravparmar <niravparmar@zilogic.com>
Date: Mon, 22 Jun 2020 09:49:50 -0000
Subject: [LTP] [PATCH v1] Add test case for CVE-2018-11508
Message-ID: <03810e4636b8c7eca94b0d2692f3b105.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello petr,

The fix 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to
native counterparts"), was fixed in the v4.13-rc1. With this fix, the bug
introduced CVE-2018-11508. This bug was then resolved in v4.17-rc5. In
that case, shouldn't we test the 'CVE-2018-11508' bug after the kernel
version where it got resolved ?

Thanks and regards,
Nirav

