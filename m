From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 28 Jun 2019 07:09:33 -0400 (EDT)
Subject: [LTP] Bug Report: diotest4 fails on mips64
In-Reply-To: <dc4e1e30-face-9039-db90-5a6dae2fc2ea@windriver.com>
References: <dc4e1e30-face-9039-db90-5a6dae2fc2ea@windriver.com>
Message-ID: <1731168043.30655111.1561720172996.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> *Ltp:*
> 
> latest master
> 
> 
> *Kernel:*
> 
> After v5.1 ARCH=mips64
> 
> 
> *Error info:*
> 
> diotest4 10 TBROK : diotest4.c:368: can't mmap file: Invalid argument
> diotest4 11 TBROK : diotest4.c:368: Remaining cases broken
> 
> 
> I think the first argument of mmap is invalid.
> 
>  ?? >shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
> 
>  ?? >shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,

I don't see any note why that mmap needs to be MAP_FIXED. I'd drop it,
let kernel pick an address:

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index e4616e400abd..bf200cd41a27 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -352,18 +352,14 @@ int main(int argc, char *argv[])
        total++;

        /* Test-10: read, write to a mmaped file */
-       shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
-       if (shm_base == NULL) {
-               tst_brkm(TBROK, cleanup, "sbrk failed: %s", strerror(errno));
-       }
        offset = 4096;
        count = bufsize;
        if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
                tst_brkm(TBROK, cleanup, "can't open %s: %s",
                         filename, strerror(errno));
        }
-       shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
-                       MAP_SHARED | MAP_FIXED, fd, 0);
+       shm_base = mmap(0, 0x100000, PROT_READ | PROT_WRITE,
+                       MAP_SHARED, fd, 0);
        if (shm_base == (caddr_t) - 1) {
                tst_brkm(TBROK, cleanup, "can't mmap file: %s",
                         strerror(errno));
