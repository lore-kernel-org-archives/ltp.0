From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 Mar 2019 05:46:54 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/fanotify03: skip events from other pids
 when testing MOUNT|FILESYSTEM
In-Reply-To: <CAOQ4uxhe2NJ+pj67ZhviL3++7oKMo_FYvM64gnGch_vXDpSw4g@mail.gmail.com>
References: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
 <CAOQ4uxgExCCq+Ky4PV5NG8XLgp7CaWjtuAK0uAbYiNpXb4352A@mail.gmail.com>
 <1782236297.5156886.1551772932632.JavaMail.zimbra@redhat.com>
 <CAOQ4uxg-8nTXPRj2tXsbU4uMKvwty_Pxgk0TrknzL9yTO-R0fA@mail.gmail.com>
 <1828199858.5175836.1551776496417.JavaMail.zimbra@redhat.com>
 <CAOQ4uxhe2NJ+pj67ZhviL3++7oKMo_FYvM64gnGch_vXDpSw4g@mail.gmail.com>
Message-ID: <1053394924.5191479.1551782814682.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > > > >
> > > > > Please use .mount_device = 1 to contain the effects of
> > > > > FAN_MARK_FILESYSTEM/FAN_MARK_MOUNT to events on the
> > > > > test device.
> > > >
> > > > I recall (from long time ago) that we saw some daemons that
> > > > could probe new mount points, like gvsfd.
> > > >
> > >
> > > I am not following. How is that related to our case?
> >
> > It's a potential (outside) source of events, that won't originate
> > from test child process.
> >
> 
> Ah. I see.
> But the problem with filtering by generator pid is that
> you would need to fix all fanotify tests to do that and
> some tests actually verify that reported pid is correct,
> so chicken and egg situation.
> 
> Let's see if this is a real problem that people run into
> or just a concern. The real issue that you saw was from
> test bug that wasn't setting the mark on a test device but
> on the system mount.
> 
> 
> > >
> > > > >
> > > > > While at it, I see that fanotify05 also sets a FAN_MARK_MOUNT
> > > > > without having a private test mount.
> > > > > Can fix this by either .mount_device = 1 or using the bind mount
> > > > > approach taken by fanotify06.
> > > >
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

The specific case above was RHEL7.6 kernel (3.10.0 based).

> 
> Can you say which program is run by the processes with pid 5277? 28138?

I can't, system has been returned to pool an re-used for other jobs.

5277 is likely some daemon, my guess would be test harness.
28138 looks like the test itself, same pid is reported at the
beginning of output.

I can easily reproduce fanotify01 failure on 5.0 with
  while [ True ]; do ls -la /root > /dev/null; done
running in parallel.

> 
> Thanks,
> Amir.
> 
