From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 Jul 2020 18:15:50 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/ioctl_loop06: Using
 LOOP_CONFIGURE to test invalid block size
In-Reply-To: <20200722094502.GB2319@yuki.lan>
References: <20200708140034.GD7276@yuki.lan>
 <1594363189-20972-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200722094502.GB2319@yuki.lan>
Message-ID: <13f6db1e-f1b6-1465-b34d-ae418ead2558@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

> Hi!
> Do we really need to close and open the dev_fd repeatedly and also we
> don't have to attach the device in the test setup?
YES, we don't need to attach the device in the setup because 
LOOP_SET_BLOCK_SIZE checks works well(return ENXIO if supports, return 
EINVAL if not supports) when not attaching device.

But for close and open the dev_fd repeatedly, I think it is necessary 
because when we detach device firstly without closing dev fd, it will 
report the warnging as below:

tst_device.c:89: INFO: Found free device 0 '/dev/loop0'
ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:69: INFO: Using LOOP_CONFIGURE with block_size < 512
tst_device.c:223: WARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for 
too long
ioctl_loop06.c:62: FAIL: Set block size failed expected EINVAL got: 
EBUSY (16)

That is why I close dev_fd firstly and then detach device in cleanup 
function.

> 
> I.e. it should work the same with:
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> index 2f172a09d..7936af4ac 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> @@ -81,12 +81,9 @@ static void run(unsigned int n)
>                  return;
>          }
>          if (attach_flag) {
> -               SAFE_CLOSE(dev_fd);
>                  tst_detach_device(dev_path);
>                  attach_flag = 0;
>          }
> -       if (dev_fd < 0)
> -               dev_fd = SAFE_OPEN(dev_path, O_RDWR);
>          loopconfig.block_size = *(tc->setvalue);
>          verify_ioctl_loop(n);
>   }
> @@ -101,8 +98,6 @@ static void setup(void)
>                  tst_brk(TBROK, "Failed to find free loop device");
> 
>          tst_fill_file("test.img", 0, 1024, 1024);
> -       tst_attach_device(dev_path, "test.img");
> -       attach_flag = 1;
>          half_value = 256;
>          pg_size = getpagesize();
>          invalid_value = pg_size * 2;
> 


