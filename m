From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jul 2020 11:26:34 +0200
Subject: [LTP] [PATCH v1 2/2] syscalls/ioctl: Use
 tst_detach_device_by_fd api
In-Reply-To: <1595493001-15724-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595493001-15724-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595493001-15724-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200723092634.GB9768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with fix for ioctl_loop04, thanks.

I've fixed the -i 2 case for ioctl_loop04 with:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index af3e90ddc..b4ab44a74 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -42,6 +42,8 @@ static void verify_ioctl_loop(void)
 	SAFE_TRUNCATE("test.img", NEW_SIZE);
 	SAFE_IOCTL(dev_fd, LOOP_SET_CAPACITY);
 
+	SAFE_LSEEK(dev_fd, 0, SEEK_SET);
+
 	/*check that we can't write data beyond 5K into loop device*/
 	TEST(write(dev_fd, wrbuf, OLD_SIZE));
 	if (TST_RET == NEW_SIZE) {

-- 
Cyril Hrubis
chrubis@suse.cz
