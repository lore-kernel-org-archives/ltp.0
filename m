From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jul 2020 15:15:51 +0200
Subject: [LTP] [PATCH v1 2/4] syscalls/ioctl_loop02: Using
 LOOP_CONFIGURE to set read_only
In-Reply-To: <1591871716-21250-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1591871716-21250-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200708131551.GA7276@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few fixed, thanks.

* Shortened some overly long messages

* Fixed the code not to leak open file descriptors
  - removed useless open of file_fd in setup
  - moved TCONF check in run before fds are opened
  - added close for file_fd at the end of the run

 (this fixes runs with -i N especially on older kernels)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index 549154fa1..3a03d052a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -35,7 +35,7 @@ static struct tcase {
 	char *message;
 } tcases[] = {
 	{O_RDONLY, LOOP_SET_FD, "Using LOOP_SET_FD to setup loopdevice"},
-	{O_RDWR, LOOP_CONFIGURE, "Using LOOP_CONFIGURE with read_only flag to setup loopdevice"},
+	{O_RDWR, LOOP_CONFIGURE, "Using LOOP_CONFIGURE with read_only flag"},
 };
 
 static void verify_ioctl_loop(unsigned int n)
@@ -43,6 +43,11 @@ static void verify_ioctl_loop(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	struct loop_info loopinfoget;
 
+	if (tc->ioctl == LOOP_CONFIGURE && !loop_configure_sup) {
+		tst_res(TCONF, "LOOP_CONFIGURE ioctl not supported");
+		return;
+	}
+
 	tst_res(TINFO, "%s", tc->message);
 	file_fd = SAFE_OPEN("test.img", tc->mode);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
@@ -50,11 +55,6 @@ static void verify_ioctl_loop(unsigned int n)
 	if (tc->ioctl == LOOP_SET_FD) {
 		SAFE_IOCTL(dev_fd, LOOP_SET_FD, file_fd);
 	} else {
-		if (!loop_configure_sup) {
-			tst_res(TCONF,
-				"Current environmet doesn't support LOOP_CONFIGURE ioctl, skip this");
-			return;
-		}
 		loopconfig.fd = file_fd;
 		SAFE_IOCTL(dev_fd, LOOP_CONFIGURE, &loopconfig);
 	}
@@ -98,6 +98,7 @@ static void verify_ioctl_loop(unsigned int n)
 	}
 
 	SAFE_CLOSE(dev_fd);
+	SAFE_CLOSE(file_fd);
 	tst_detach_device(dev_path);
 	attach_flag = 0;
 }
@@ -123,7 +124,6 @@ static void setup(void)
 
 	free(tmpdir);
 
-	file_fd = SAFE_OPEN("test.img", O_RDONLY);
 	file_change_fd = SAFE_OPEN("test1.img", O_RDWR);
 	file_fd_invalid = SAFE_OPEN("test2.img", O_RDWR);
 

-- 
Cyril Hrubis
chrubis@suse.cz
