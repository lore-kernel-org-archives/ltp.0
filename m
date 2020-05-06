From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 May 2020 16:14:12 +0200
Subject: [LTP] [PATCH 1/1] pty04: Fix build for kernel headers < v4.2-rc1
In-Reply-To: <1588328084.11511511.1588773609302.JavaMail.zimbra@redhat.com>
References: <20200506134858.23919-1-pvorel@suse.cz>
 <1588328084.11511511.1588773609302.JavaMail.zimbra@redhat.com>
Message-ID: <20200506141412.GA26506@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> ----- Original Message -----
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > https://travis-ci.org/github/pevik/ltp/builds/683787204

> >  configure.ac                 |  1 +
> >  include/lapi/tty.h           | 17 +++++++++++++++++
> >  testcases/kernel/pty/pty04.c | 17 ++++++++++-------
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >  create mode 100644 include/lapi/tty.h


> Works for me (rhel6/7), thanks Petr.

OK, I'll merge with your ack and Cyril's and Richard's suggestion.

I want to fix minimal version as well. Works well on our 3.0 kernel.
Other kernel has a problem 2.6.32-696.el6.x86_64, but IMHO that does not mean
that the test is not valid for this kernel.

./pty04
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
pty04.c:95: INFO: PTS path is /dev/pts/1
pty04.c:149: INFO: Netdev is sl0
pty04.c:158: INFO: Netdev MTU is 8192 (we set 8192)
pty04.c:175: INFO: Bound netdev 5 to socket 5
pty04.c:208: INFO: Reading from socket 5
pty04.c:123: PASS: Wrote PTY 1
pty04.c:133: PASS: Wrote PTY 2
pty04.c:213: PASS: Read netdev 1
pty04.c:217: PASS: Read netdev 2
pty04.c:249: BROK: ioctl(4,TIOCVHANGUP,...) failed: EINVAL (22)
tst_test.c:373: BROK: Reported by child (12112)

Can please anybody double check, that with this patch it should be possible to
run this test even on v2.6.25 (which added can module)?

Kind regards,
Petr
