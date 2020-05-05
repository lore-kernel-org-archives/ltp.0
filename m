From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 17:11:23 +0200
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <87d07isaka.fsf@our.domain.is.not.set>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505133746.GB21884@dell5510>
 <87d07isaka.fsf@our.domain.is.not.set>
Message-ID: <20200505151123.GA9949@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> This looks similar to the issue reported by Jan:

> https://github.com/linux-test-project/ltp/issues/674

> Is this the full output?

Here it is:

# ./pty04
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
pty04.c:127: INFO: PTS path is /dev/pts/29
pty04.c:202: INFO: Netdev is sl0
pty04.c:211: INFO: Netdev MTU is 8192 (we set 8192)
pty04.c:228: INFO: Bound netdev 51 to socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:301: INFO: Reading from socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:176: PASS: Wrote PTY 1
pty04.c:186: PASS: Wrote PTY 2
pty04.c:305: PASS: Read netdev 1
pty04.c:309: PASS: Read netdev 2
pty04.c:315: PASS: Reading data from netdev interrupted by hangup
pty04.c:342: INFO: Sent hangup ioctl to PTS
pty04.c:191: PASS: Writing to PTY interrupted by hangup
pty04.c:344: INFO: Sent hangup ioctl to PTM
pty04.c:127: INFO: PTS path is /dev/pts/32
pty04.c:202: INFO: Netdev is slcan0
pty04.c:211: INFO: Netdev MTU is 16 (we set 16)
pty04.c:228: INFO: Bound netdev 52 to socket 8
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:301: INFO: Reading from socket 8
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:176: PASS: Wrote PTY 1
pty04.c:186: PASS: Wrote PTY 2
pty04.c:305: PASS: Read netdev 1
pty04.c:309: PASS: Read netdev 2
pty04.c:315: PASS: Reading data from netdev interrupted by hangup
pty04.c:342: INFO: Sent hangup ioctl to PTS
pty04.c:191: PASS: Writing to PTY interrupted by hangup
pty04.c:344: INFO: Sent hangup ioctl to PTM

Summary:
passed   12
failed   0
skipped  0
warnings 0

# ./pty04
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
pty04.c:127: INFO: PTS path is /dev/pts/29
pty04.c:202: INFO: Netdev is sl0
pty04.c:211: INFO: Netdev MTU is 8192 (we set 8192)
pty04.c:228: INFO: Bound netdev 53 to socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:301: INFO: Reading from socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:176: PASS: Wrote PTY 1
pty04.c:186: PASS: Wrote PTY 2
pty04.c:305: PASS: Read netdev 1
# BLOCKS
tst_checkpoint.c:147: BROK: pty04.c:340: tst_checkpoint_wait(0, 10000): ETIMEDOUT (110)
tst_test.c:373: BROK: Reported by child (10018)
safe_macros.c:258: BROK: pty04.c:307: read(5,0x7f3920c4a001,8191) failed, returned -1: ENETDOWN (100)
pty04.c:191: PASS: Writing to PTY interrupted by hangup
tst_test.c:373: WARN: Reported by child (10016)

Summary:
passed   4
failed   0
skipped  0
warnings 1

It looked like it regularly changes working and failing, but sometimes it fails
several times. Also sometimes it works when -i2 (but mostly fails).

Kind regards,
Petr
