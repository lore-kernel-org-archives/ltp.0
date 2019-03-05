From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 Mar 2019 04:01:36 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/fanotify03: skip events from other pids
 when testing MOUNT|FILESYSTEM
In-Reply-To: <CAOQ4uxg-8nTXPRj2tXsbU4uMKvwty_Pxgk0TrknzL9yTO-R0fA@mail.gmail.com>
References: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
 <CAOQ4uxgExCCq+Ky4PV5NG8XLgp7CaWjtuAK0uAbYiNpXb4352A@mail.gmail.com>
 <1782236297.5156886.1551772932632.JavaMail.zimbra@redhat.com>
 <CAOQ4uxg-8nTXPRj2tXsbU4uMKvwty_Pxgk0TrknzL9yTO-R0fA@mail.gmail.com>
Message-ID: <1828199858.5175836.1551776496417.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Mar 5, 2019 at 10:02 AM Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > On Tue, Mar 5, 2019 at 12:16 AM Jan Stancek <jstancek@redhat.com> wrote:
> > > >
> > > > FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM sets up monitoring that can
> > > > cover entire root "/". So a random background process can interfere
> > > > with test.
> > > >
> > > > For example run test while running following on another terminal
> > > > to reproduce:
> > > >   while [ True ]; do ls -la /root > /dev/null; done
> > > >
> > > > Test fails and hangs until timeout:
> > > >   tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
> > > >   fanotify03.c:168: INFO: Test #0: inode mark permission events
> > > >   fanotify03.c:236: PASS: got event: mask=10000 pid=7317 fd=7
> > > >   fanotify03.c:236: PASS: got event: mask=20000 pid=7317 fd=7
> > > >   fanotify03.c:136: PASS: child exited correctly
> > > >   fanotify03.c:168: INFO: Test #1: mount mark permission events
> > > >   fanotify03.c:236: PASS: got event: mask=10000 pid=7318 fd=7
> > > >   fanotify03.c:231: FAIL: got event: mask=20000 pid=7306 (expected
> > > >   7318)
> > > >   fd=7
> > > >   fanotify03.c:223: FAIL: got event: mask=20000 (expected 0) pid=7318
> > > >   fd=7
> > > >   Test timeouted, sending SIGKILL!
> > > >   tst_test.c:1125: INFO: If you are running on slow machine, try
> > > >   exporting
> > > >   LTP_TIMEOUT_MUL > 1
> > > >   tst_test.c:1126: BROK: Test killed! (timeout?)
> > > >
> > > > Skip events that are not from our child when testing FAN_MARK_MOUNT and
> > > > FAN_MARK_FILESYSTEM. If these are permission events, allow everything.
> > > >
> > >
> > > That's the wrong way to fix the problem.
> >
> > Can you elaborate? The test still fails if we don't get event
> > from our child.
> >
> 
> I overlooked the fact that test sets a mark on TEST_APP
> outside of test device.
> 
> fanotify tests need to be contained to the test device, so that
> changes to /root will not interfere with the tests.
> 
> Therefore, TEST_APP should be copied to MOUNT_PATH on setup.
> 
> This is done by fanotify10 and SHOULD be done by fanotify03
> and fanotify12 as well.

OK, I'll look into .mount_device for now.

> 
> > >
> > > Please use .mount_device = 1 to contain the effects of
> > > FAN_MARK_FILESYSTEM/FAN_MARK_MOUNT to events on the
> > > test device.
> >
> > I recall (from long time ago) that we saw some daemons that
> > could probe new mount points, like gvsfd.
> >
> 
> I am not following. How is that related to our case?

It's a potential (outside) source of events, that won't originate
from test child process.

> 
> > >
> > > While at it, I see that fanotify05 also sets a FAN_MARK_MOUNT
> > > without having a private test mount.
> > > Can fix this by either .mount_device = 1 or using the bind mount
> > > approach taken by fanotify06.
> >
> > I see fanotify01 failing as well.
> >
> 
> Failing how? please provide more details.

tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
fanotify01.c:68: INFO: Test #0: inode mark events
fanotify01.c:290: PASS: got event: mask=31 pid=28138 fd=8
fanotify01.c:290: PASS: got event: mask=11 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=10 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=2a pid=28138 fd=9
fanotify01.c:290: PASS: got event: mask=a pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=20 pid=28138 fd=11
fanotify01.c:290: PASS: got event: mask=b pid=28138 fd=10
fanotify01.c:290: PASS: got event: mask=9 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=2 pid=28138 fd=13
fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=12
fanotify01.c:68: INFO: Test #1: mount mark events
fanotify01.c:290: PASS: got event: mask=31 pid=28138 fd=8
fanotify01.c:290: PASS: got event: mask=11 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=10 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=2a pid=28138 fd=9
fanotify01.c:290: PASS: got event: mask=a pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=8 pid=28138 fd=-2
fanotify01.c:290: PASS: got event: mask=20 pid=28138 fd=11
fanotify01.c:256: FAIL: got event: mask=20 (expected 2) pid=5277 fd=10
fanotify01.c:256: FAIL: got event: mask=20 (expected 1) pid=5277 fd=-2
fanotify01.c:256: FAIL: got event: mask=20 (expected 8) pid=5277 fd=-2
fanotify01.c:256: FAIL: got event: mask=20 (expected 2) pid=5277 fd=-2
fanotify01.c:256: FAIL: got event: mask=20 (expected 8) pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=20 pid=5277 fd=-2
... <previous message repeats hundreds of times>
fanotify01.c:249: FAIL: got unnecessary event: mask=1 pid=28138 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=1 pid=28138 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=14
fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=2 pid=28138 fd=-2
fanotify01.c:249: FAIL: got unnecessary event: mask=8 pid=28138 fd=13
fanotify01.c:68: INFO: Test #2: filesystem mark events
fanotify01.c:77: CONF: FAN_MARK_FILESYSTEM not supported in kernel?

Regards,
Jan
