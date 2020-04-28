From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 15:17:45 +0530
Subject: [LTP] What is wrong with this program ?
Message-ID: <20200428094745.io5fni2txzl6n37q@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

#include "tst_test.h"

static void run(void)
{
	int fd;

	fd = SAFE_OPEN("file", O_RDWR | O_CREAT);
	SAFE_CLOSE(fd);
	fd = SAFE_OPEN("file", O_RDWR | O_CREAT);
}

static struct tst_test test = {
	.test_all = run,
	.needs_tmpdir = 1,
};


It fails with:

safe_macros.c:230: BROK: foo.c:9: open(file,66,01) failed: EACCES (13)

if run as a normal user and passes with sudo.

-- 
viresh
