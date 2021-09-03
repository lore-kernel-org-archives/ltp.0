From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat, 4 Sep 2021 00:41:48 +0200
Subject: [LTP] Rewrite fmtmsg01.c
Message-ID: <YTKkrHbMHeKCJiTr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm going to rewrite testcases/kernel/syscalls/fmtmsg/fmtmsg01.c which tests
addseverity() and fmtmsg(). The reason is that addseverity() is not POSIX,
thus not in musl. Taking an usual approach (*) is not enough, because the test
logic depends on all tests being run. Thus just hope the test is valid (thus
worth of cleanup).

(*) check with autotools whether addseverity() available and comment out parts
which test it; + TCONF test if fmtmsg() is not available - uclibc.

Kind regards,
Petr

