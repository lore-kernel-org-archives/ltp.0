From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Feb 2020 09:28:03 -0500 (EST)
Subject: [LTP] min_free_kbytes.c:134: FAIL: child unexpectedly failed:
 139
In-Reply-To: <MAXPR0101MB1468DB8754551B9C84AF3C0CEE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14687E3C724A815D2857EA14EE1A0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <333767604.7805569.1581940614115.JavaMail.zimbra@redhat.com>
 <MAXPR0101MB1468A92491FB531F33F10A36EE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <688644958.7809325.1581942285691.JavaMail.zimbra@redhat.com>
 <MAXPR0101MB1468DB8754551B9C84AF3C0CEE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <1121671987.7831869.1581949683671.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[adding back LTP list to CC]

----- Original Message -----
> //***************************   This is the result of strace -f
> 
> 
> pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18a08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18908000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18808000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18708000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18608000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18508000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18408000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18308000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18208000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18108000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e18008000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17f08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17e08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17d08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17c08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17b08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17a08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17908000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17808000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17708000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17608000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17508000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17408000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17308000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17208000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17108000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e17008000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e16f08000
> [pid 48522] mmap(NULL, 1048576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3e16e08000
> Segmentation fault

Ok, so we are in eatup_mem loop. mmap() suceeded, and then we seem to crash
on write to allocated area via memset(). My guess would be kernel bug.

To double-check, can you capture a core file and see where exactly child hits SIGSEGV?

> root@exaleapsemi:~/pankaj_ltp_new/ltp/testcases/kernel/mem/tunable#
> min_free_kbytes.c:173: FAIL: child unexpectedly failed: 11
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 8048240 kB before eatup mem
> min_free_kbytes.c:173: FAIL: child unexpectedly failed: 11
> mem.c:817: INFO: set overcommit_memory to 1
> mem.c:817: INFO: set min_free_kbytes to 327288
> memfree is 8047972 kB before eatup mem
> min_free_kbytes.c:155: FAIL: child unexpectedly failed: 11
> mem.c:817: INFO: set min_free_kbytes to 654576
> memfree is 8047800 kB before eatup mem
> min_free_kbytes.c:155: FAIL: child unexpectedly failed: 11
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 8039996 kB before eatup mem
> min_free_kbytes.c:155: FAIL: child unexpectedly failed: 11
> min_free_kbytes.c:103: PASS: min_free_kbytes test pass
> mem.c:817: INFO: set min_free_kbytes to 327288
> mem.c:817: INFO: set overcommit_memory to 1
> 
> Summary:
> passed   1
> failed   7
> skipped  0
> warnings 0

