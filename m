From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2019 12:42:48 +0200
Subject: [LTP] [PATCH] syscalls/fanotify03: skip events from other pids
 when testing MOUNT|FILESYSTEM
In-Reply-To: <CAOQ4uxhe2NJ+pj67ZhviL3++7oKMo_FYvM64gnGch_vXDpSw4g@mail.gmail.com>
References: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
 <CAOQ4uxgExCCq+Ky4PV5NG8XLgp7CaWjtuAK0uAbYiNpXb4352A@mail.gmail.com>
 <1782236297.5156886.1551772932632.JavaMail.zimbra@redhat.com>
 <CAOQ4uxg-8nTXPRj2tXsbU4uMKvwty_Pxgk0TrknzL9yTO-R0fA@mail.gmail.com>
 <1828199858.5175836.1551776496417.JavaMail.zimbra@redhat.com>
 <CAOQ4uxhe2NJ+pj67ZhviL3++7oKMo_FYvM64gnGch_vXDpSw4g@mail.gmail.com>
Message-ID: <CAOQ4uxifhwKnBubJCpAzxpDR_aH+L4k3s55WnwUDD_JoiH2s7g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > > I see fanotify01 failing as well.
> > > >
> > >
> > > Failing how? please provide more details.
> >
> > tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
> > fanotify01.c:68: INFO: Test #0: inode mark events
> > fanotify01.c:290: PASS: got event: mask=31 pid=28138 fd=8
> > fanotify01.c:290: PASS: got event: mask=11 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=10 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=2a pid=28138 fd=9
> > fanotify01.c:290: PASS: got event: mask=a pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=20 pid=28138 fd=11
> > fanotify01.c:290: PASS: got event: mask=b pid=28138 fd=10
> > fanotify01.c:290: PASS: got event: mask=9 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=2 pid=28138 fd=13
> > fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=12
> > fanotify01.c:68: INFO: Test #1: mount mark events
> > fanotify01.c:290: PASS: got event: mask=31 pid=28138 fd=8
> > fanotify01.c:290: PASS: got event: mask=11 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=10 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=2a pid=28138 fd=9
> > fanotify01.c:290: PASS: got event: mask=a pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
> > fanotify01.c:290: PASS: got event: mask=20 pid=28138 fd=11
> > fanotify01.c:256: FAIL: got event: mask=20 (expected 2) pid=5277 fd=10
> > fanotify01.c:256: FAIL: got event: mask=20 (expected 1) pid=5277 fd=-2
> > fanotify01.c:256: FAIL: got event: mask=20 (expected 8) pid=5277 fd=-2
> > fanotify01.c:256: FAIL: got event: mask=20 (expected 2) pid=5277 fd=-2
> > fanotify01.c:256: FAIL: got event: mask=20 (expected 8) pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
> > ... <previous message repeats hundreds of times>
> > fanotify01.c:249: FAIL: got unnecessary event: mask=1 pid=28138 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=1 pid=28138 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=14
> > fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=-2
> > fanotify01.c:249: FAIL: got unnecessary event: mask=8 pid=28138 fd=13
> > fanotify01.c:68: INFO: Test #2: filesystem mark events
> > fanotify01.c:77: CONF: FAN_MARK_FILESYSTEM not supported in kernel?
> >
>
> Which kernel is that?
>
> Can you say which program is run by the processes with pid 5277? 28138?
>

Nevermind. My work branch has already isolated fanotify01, so I didn't
realize it was also buggy on master.

Your fix should have resolved those errors I presume.

Thanks,
Amir.
