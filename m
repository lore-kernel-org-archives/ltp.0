From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Apr 2016 16:46:43 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <571E28BA.8030409@free.fr>
References: <5718E81B.6060101@free.fr> <20160421153041.GA25307@rei>
 <5718F4EE.2060009@free.fr> <571907A2.10208@free.fr>
 <571A274A.60707@free.fr> <571DCF8D.30306@free.fr>
 <571E0226.3020104@free.fr> <571E118C.1080707@free.fr>
 <20160425133115.GB20158@rei.lan> <571E28BA.8030409@free.fr>
Message-ID: <20160425144643.GC20158@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Similar issue with fanotify.
> 
> Some tests are correctly marked TCONF, but some FAIL because of TWARN.
> 
> fanotify01    1  TCONF  :  fanotify01.c:348: fanotify is not configured in this kernel.
> fanotify01    2  TCONF  :  fanotify01.c:348: Remaining cases not appropriate for configuration
> fanotify01    0  TWARN  :  fanotify01.c:359: close(-1) failed
> 
> fanotify02    1  TCONF  :  fanotify02.c:237: fanotify is not configured in this kernel.
> fanotify02    2  TCONF  :  fanotify02.c:237: Remaining cases not appropriate for configuration
> fanotify02    0  TWARN  :  fanotify02.c:248: close(-1) failed
> 
> fanotify04    1  TCONF  :  fanotify04.c:280: fanotify is not configured in this kernel.
> fanotify04    2  TCONF  :  fanotify04.c:280: Remaining cases not appropriate for configuration
> fanotify04    0  TWARN  :  fanotify04.c:291: close(-1) failed

These should have been fixed in:

commit 2d8cac4caeb21ae8e5426b7c839bd5ff3896bd37
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Mar 15 12:52:41 2016 +0100

    syscalls/fanotify: Fix clenaups


Not to call close(-1) in cleanup when the test exits with TCONF.

> Also the mq_* tests FAIL instead of TCONF.
> 
> mq_notify01    0  TINFO  :  (case00) START
> mq_notify01    1  TFAIL  :  mq_notify01.c:206: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented

Looks like nobody has run the tests with CONFIG_POSIX_MQUEUE missing from
.config, this should be easy to fix.

> As do several netns_* tests.
> 
> netns_breakns_ns_exec_ipv6_netlink 1 TINFO : ns_create    0  TINFO  :  ltp_clone_quick: errno=EINVAL(22): Invalid argument
> netns_breakns_ns_exec_ipv6_netlink 1 TBROK : unable to create a new network namespace

These should be fixed as well.


-- 
Cyril Hrubis
chrubis@suse.cz
