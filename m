From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 11:45:02 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/ioctl_loop06: Using
 LOOP_CONFIGURE to test invalid block size
In-Reply-To: <1594363189-20972-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200708140034.GD7276@yuki.lan>
 <1594363189-20972-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200722094502.GB2319@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Do we really need to close and open the dev_fd repeatedly and also we
don't have to attach the device in the test setup?

I.e. it should work the same with:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 2f172a09d..7936af4ac 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -81,12 +81,9 @@ static void run(unsigned int n)
                return;
        }
        if (attach_flag) {
-               SAFE_CLOSE(dev_fd);
                tst_detach_device(dev_path);
                attach_flag = 0;
        }
-       if (dev_fd < 0)
-               dev_fd = SAFE_OPEN(dev_path, O_RDWR);
        loopconfig.block_size = *(tc->setvalue);
        verify_ioctl_loop(n);
 }
@@ -101,8 +98,6 @@ static void setup(void)
                tst_brk(TBROK, "Failed to find free loop device");

        tst_fill_file("test.img", 0, 1024, 1024);
-       tst_attach_device(dev_path, "test.img");
-       attach_flag = 1;
        half_value = 256;
        pg_size = getpagesize();
        invalid_value = pg_size * 2;

-- 
Cyril Hrubis
chrubis@suse.cz
