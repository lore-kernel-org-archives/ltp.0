From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2019 08:31:03 +0200
Subject: [LTP] [PATCH] syscalls/fanotify03: skip events from other pids
 when testing MOUNT|FILESYSTEM
In-Reply-To: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
References: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
Message-ID: <CAOQ4uxgExCCq+Ky4PV5NG8XLgp7CaWjtuAK0uAbYiNpXb4352A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 5, 2019 at 12:16 AM Jan Stancek <jstancek@redhat.com> wrote:
>
> FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM sets up monitoring that can
> cover entire root "/". So a random background process can interfere
> with test.
>
> For example run test while running following on another terminal
> to reproduce:
>   while [ True ]; do ls -la /root > /dev/null; done
>
> Test fails and hangs until timeout:
>   tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
>   fanotify03.c:168: INFO: Test #0: inode mark permission events
>   fanotify03.c:236: PASS: got event: mask=10000 pid=7317 fd=7
>   fanotify03.c:236: PASS: got event: mask=20000 pid=7317 fd=7
>   fanotify03.c:136: PASS: child exited correctly
>   fanotify03.c:168: INFO: Test #1: mount mark permission events
>   fanotify03.c:236: PASS: got event: mask=10000 pid=7318 fd=7
>   fanotify03.c:231: FAIL: got event: mask=20000 pid=7306 (expected 7318) fd=7
>   fanotify03.c:223: FAIL: got event: mask=20000 (expected 0) pid=7318 fd=7
>   Test timeouted, sending SIGKILL!
>   tst_test.c:1125: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>   tst_test.c:1126: BROK: Test killed! (timeout?)
>
> Skip events that are not from our child when testing FAN_MARK_MOUNT and
> FAN_MARK_FILESYSTEM. If these are permission events, allow everything.
>

That's the wrong way to fix the problem.

Please use .mount_device = 1 to contain the effects of
FAN_MARK_FILESYSTEM/FAN_MARK_MOUNT to events on the
test device.

While at it, I see that fanotify05 also sets a FAN_MARK_MOUNT
without having a private test mount.
Can fix this by either .mount_device = 1 or using the bind mount
approach taken by fanotify06.

I am assuming you will take care of this.
If you need me to get involved with the fix let me know.

Thanks,
Amir.
