From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Apr 2020 11:52:22 +0200
Subject: [LTP] What is wrong with this program ?
In-Reply-To: <20200428094745.io5fni2txzl6n37q@vireshk-i7>
References: <20200428094745.io5fni2txzl6n37q@vireshk-i7>
Message-ID: <20200428095222.GC6221@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> #include "tst_test.h"
> 
> static void run(void)
> {
> 	int fd;
> 
> 	fd = SAFE_OPEN("file", O_RDWR | O_CREAT);
> 	SAFE_CLOSE(fd);
> 	fd = SAFE_OPEN("file", O_RDWR | O_CREAT);
> }
> 
> static struct tst_test test = {
> 	.test_all = run,
> 	.needs_tmpdir = 1,
> };
> 
> 
> It fails with:
> 
> safe_macros.c:230: BROK: foo.c:9: open(file,66,01) failed: EACCES (13)
> 
> if run as a normal user and passes with sudo.

I guess that you forget to pass the mode argument to the first
SAFE_OPEN() and hence the second one fails because the garbage passed to
mode prevents normal users from opening the file.

-- 
Cyril Hrubis
chrubis@suse.cz
