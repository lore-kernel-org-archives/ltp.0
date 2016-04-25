From: Mason <slash.tmp@free.fr>
Date: Mon, 25 Apr 2016 16:24:58 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <20160425133115.GB20158@rei.lan>
References: <5718D4CA.5010607@free.fr> <5718E81B.6060101@free.fr>
 <20160421153041.GA25307@rei> <5718F4EE.2060009@free.fr>
 <571907A2.10208@free.fr> <571A274A.60707@free.fr> <571DCF8D.30306@free.fr>
 <571E0226.3020104@free.fr> <571E118C.1080707@free.fr>
 <20160425133115.GB20158@rei.lan>
Message-ID: <571E28BA.8030409@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25/04/2016 15:31, Cyril Hrubis wrote:
> Hi!
>> These two tests are not being built.
>> FILTER_OUT_DIRS		:= $(if $(AIO_LIBS),,aio ltp-aiodio)
>>
>> so pan fails to launch them, obviously.
>> pan(1130): execvp of 'aio01' (tag aio01) failed.  errno:2  No such file or directory
>> pan(1130): execvp of 'aio_tio' (tag aio02) failed.  errno:2  No such file or directory
>>
>> I don't think these should be considered failures?
> 
> I guess that we should report TCONF if test binary was missing instead.
> I can try to prototype a patch for this, but I would prefer doing that
> after release.

OK.

Similar issue with fanotify.

Some tests are correctly marked TCONF, but some FAIL because of TWARN.

fanotify01    1  TCONF  :  fanotify01.c:348: fanotify is not configured in this kernel.
fanotify01    2  TCONF  :  fanotify01.c:348: Remaining cases not appropriate for configuration
fanotify01    0  TWARN  :  fanotify01.c:359: close(-1) failed

fanotify02    1  TCONF  :  fanotify02.c:237: fanotify is not configured in this kernel.
fanotify02    2  TCONF  :  fanotify02.c:237: Remaining cases not appropriate for configuration
fanotify02    0  TWARN  :  fanotify02.c:248: close(-1) failed

fanotify04    1  TCONF  :  fanotify04.c:280: fanotify is not configured in this kernel.
fanotify04    2  TCONF  :  fanotify04.c:280: Remaining cases not appropriate for configuration
fanotify04    0  TWARN  :  fanotify04.c:291: close(-1) failed


Also the mq_* tests FAIL instead of TCONF.

mq_notify01    0  TINFO  :  (case00) START
mq_notify01    1  TFAIL  :  mq_notify01.c:206: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented


As do several netns_* tests.

netns_breakns_ns_exec_ipv6_netlink 1 TINFO : ns_create    0  TINFO  :  ltp_clone_quick: errno=EINVAL(22): Invalid argument
netns_breakns_ns_exec_ipv6_netlink 1 TBROK : unable to create a new network namespace


Regards.
