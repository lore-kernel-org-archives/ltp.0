From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Feb 2019 12:47:17 +0100
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190206120724.GB13516@rei>
References: <20190128134656.27979-1-metan@ucw.cz> <20190206075159.GA13396@x230>
 <20190206120724.GB13516@rei>
Message-ID: <20190207114717.GA9428@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I wonder if we want either warn user or run it both via (g)libc wrapper and
> > directly the syscall.

> I guess that we may drop a hint in the error message.

> > BTW testing on kernel 4.20.0, glibc 2.28 with sys_preadv2() and still get TBROK
> > EOPNOTSUPP. I tried to test on ext[2-4], btrfs. I wonder what I'm missing.

> That's strange, are you sure that the test was calling the wrapper
> instead of the glibc call?
See diff below, but I guess it's what you meant :).

> This should really work unless the support in kernel has been disabled
> in distribution kernel for some reason. I was testing it on vanilla
> kernel where it worked as expected.
What config option is needed?

It does not work on both my machines (glibc 2.27 and 2.28) and it's working on
various VMs with these versions.


Kind regards,
Petr


+++ testcases/kernel/syscalls/preadv2/preadv203.c
@@ -95,6 +95,12 @@ static int verify_short_read(struct iovec *iov, size_t iov_cnt,
 	return 0;
 }
 
+ static ssize_t sys_preadv2(int fd, const struct iovec *iov, int iovcnt,
+                            off_t offset, int flags)
+ {
+ 	return syscall(SYS_preadv2, fd, iov, iovcnt, offset, offset>>32, flags);
+ }
+
 static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
 {
 	char buf1[CHUNK_SZ/2];
@@ -115,7 +121,7 @@ static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
 		off_t off = random() % ((CHUNKS - 2) * CHUNK_SZ);
 		int fd = fds[random() % FILES];
 
-		TEST(preadv2(fd, rd_iovec, 2, off, RWF_NOWAIT));
+		TEST(sys_preadv2(fd, rd_iovec, 2, off, RWF_NOWAIT));
 
 		if (TST_RET < 0) {
 			if (TST_ERR != EAGAIN)
