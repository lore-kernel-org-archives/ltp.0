From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 May 2020 08:37:07 -0400 (EDT)
Subject: [LTP] [PATCH] pty04: Avoid receiving packets from all interfaces
In-Reply-To: <914267680.12582166.1589545134812.JavaMail.zimbra@redhat.com>
References: <20200515103910.8703-1-rpalethorpe@suse.com>
 <20200515114837.GB3395@yuki.lan>
 <914267680.12582166.1589545134812.JavaMail.zimbra@redhat.com>
Message-ID: <1899128312.12583700.1589546227679.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> ----- Original Message -----
> > Hi!
> > Sounds reasonable, also hope it's the last patch. :-)
> > 
> > @Jan do you want to test this as well, or should I apply and proceed
> > with the release?
> 
> I haven't spotted potential issue while looking at kernel code,
> will test the patch just to be sure.

It still gets occasionally stuck on 5.7.0-rc4, but the chance to hit
it appears lower. I think merge the patch and we'll see how frequently
it happens with single iteration. We can always disable it later in
runtest file.

# ./pty04 -i 10
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
pty04.c:130: INFO: PTS path is /dev/pts/2
pty04.c:207: INFO: Netdev is sl0
pty04.c:216: INFO: Netdev MTU is 8192 (we set 8192)
pty04.c:233: INFO: Bound netdev 245 to socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:324: INFO: Reading from socket 5
tst_buffers.c:55: INFO: Test is using guarded buffers
pty04.c:180: PASS: Wrote PTY N_SLIP 3 (1)
pty04.c:191: PASS: Wrote PTY N_SLIP 3 (2)
pty04.c:328: PASS: Read netdev N_SLIP 5 (1)


tst_checkpoint.c:149: BROK: pty04.c:364: tst_checkpoint_wait(0, 100000): ETIMEDOUT (110)
tst_test.c:373: BROK: Reported by child (2990)
pty04.c:306: BROK: Read 0 of 8191 bytes: ENETDOWN (100)
pty04.c:196: PASS: Writing to PTY interrupted by hangup
tst_test.c:373: WARN: Reported by child (2987)

