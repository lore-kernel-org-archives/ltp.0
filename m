From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
Date: Wed, 7 Apr 2021 07:25:03 +0000
Subject: [LTP] [PATCH] Makefile: Use M to build extern kernel module
 instead of SUBDIRS
In-Reply-To: <1617775951-3717-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1617775951-3717-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <606D5E48.1060307@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/4/7 14:12, Yang Xu wrote:
> Since 5.3 kernel commit 7e35b42591c0 ("kbuild: remove SUBDIRS support"),
> SUBDIRS has been removed. We can only use make M=dir or set the environment
> variable KBUILD_EXTMOD to specify the directory of external module to build.
Hi Xu,

One missing Makefile:
testcases/kernel/device-drivers/dev_sim_framework/kernel_space/Makefile

> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/device-drivers/agp/kernel_space/Makefile    |  4 ++--
>   testcases/kernel/device-drivers/base/tbase/Makefile    |  4 ++--
>   .../kernel/device-drivers/drm/kernel_space/Makefile    |  2 +-
>   testcases/kernel/device-drivers/include/Makefile       |  4 ++--
>   .../misc_modules/per_cpu_allocator_module/Makefile     |  8 ++++----
>   testcases/kernel/device-drivers/nls/Makefile           |  6 +++---
>   testcases/kernel/device-drivers/usb/tusb/Makefile      | 10 +++++-----
>   .../kernel/device-drivers/v4l/kernel_space/Makefile    |  8 ++++----
>   testcases/kernel/fs/scsi/ltpfs/Makefile                |  4 ++--
>   9 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/testcases/kernel/device-drivers/agp/kernel_space/Makefile b/testcases/kernel/device-drivers/agp/kernel_space/Makefile
> index 5357c135e..5a10064f0 100644
> --- a/testcases/kernel/device-drivers/agp/kernel_space/Makefile
> +++ b/testcases/kernel/device-drivers/agp/kernel_space/Makefile
> @@ -14,8 +14,8 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR)  SUBDIRS=$(PWD) modules
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

Is it necessary to update these comments? In other words, could we 
remove these comments directly?

Best Regards,
Xiao Yang
>   endif
>
>   clean:
> diff --git a/testcases/kernel/device-drivers/base/tbase/Makefile b/testcases/kernel/device-drivers/base/tbase/Makefile
> index 6f7e5e2c1..5e5a40e61 100644
> --- a/testcases/kernel/device-drivers/base/tbase/Makefile
> +++ b/testcases/kernel/device-drivers/base/tbase/Makefile
> @@ -13,8 +13,8 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
>   endif
>
>   clean:
> diff --git a/testcases/kernel/device-drivers/drm/kernel_space/Makefile b/testcases/kernel/device-drivers/drm/kernel_space/Makefile
> index 11e54d9be..24b768d76 100644
> --- a/testcases/kernel/device-drivers/drm/kernel_space/Makefile
> +++ b/testcases/kernel/device-drivers/drm/kernel_space/Makefile
> @@ -11,7 +11,7 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD)  modules
> +	$(MAKE) -C $(KDIR) M=$(PWD)  modules
>   endif
>
>   clean:
> diff --git a/testcases/kernel/device-drivers/include/Makefile b/testcases/kernel/device-drivers/include/Makefile
> index c9810ba5e..72d7293c2 100644
> --- a/testcases/kernel/device-drivers/include/Makefile
> +++ b/testcases/kernel/device-drivers/include/Makefile
> @@ -13,9 +13,9 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
>   	${CC} -Wall -o userBlockInclude userBlockInclude.c
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
>   endif
>
>   clean:
> diff --git a/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile b/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
> index 3bc274dad..ae802f77c 100644
> --- a/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
> +++ b/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
> @@ -9,16 +9,16 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   modules:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
>
>   clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> +	$(MAKE) -C $(KDIR) M=$(PWD) clean
>   	rm -f modules.order
>
>   help:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
> +	$(MAKE) -C $(KDIR) M=$(PWD) help
>
>   modules_install:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules_install
>
>   endif
> diff --git a/testcases/kernel/device-drivers/nls/Makefile b/testcases/kernel/device-drivers/nls/Makefile
> index 172510fe8..a1fab20f8 100644
> --- a/testcases/kernel/device-drivers/nls/Makefile
> +++ b/testcases/kernel/device-drivers/nls/Makefile
> @@ -12,12 +12,12 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
>   	${CC} $(EXTRA_CFLAGS) -o userBlockNLS userBlockNLS.c
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
>
>   clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> +	$(MAKE) -C $(KDIR) M=$(PWD) clean
>   	rm -f modules.order
>   	rm -f userBlockNLS
>
> diff --git a/testcases/kernel/device-drivers/usb/tusb/Makefile b/testcases/kernel/device-drivers/usb/tusb/Makefile
> index 9488cd563..4dcbca36c 100644
> --- a/testcases/kernel/device-drivers/usb/tusb/Makefile
> +++ b/testcases/kernel/device-drivers/usb/tusb/Makefile
> @@ -13,17 +13,17 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
>
>   clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> +	$(MAKE) -C $(KDIR) M=$(PWD) clean
>   	rm -f modules.order
>
>   help:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
> +	$(MAKE) -C $(KDIR) M=$(PWD) help
>
>   modules_install:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules_install
>
>   endif
> diff --git a/testcases/kernel/device-drivers/v4l/kernel_space/Makefile b/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
> index 56e255b04..549c37d5c 100644
> --- a/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
> +++ b/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
> @@ -9,16 +9,16 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   modules:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
>
>   clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> +	$(MAKE) -C $(KDIR) M=$(PWD) clean
>   	rm -f modules.order
>
>   help:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) help
> +	$(MAKE) -C $(KDIR) M=$(PWD) help
>
>   modules_install:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules_install
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules_install
>
>   endif
> diff --git a/testcases/kernel/fs/scsi/ltpfs/Makefile b/testcases/kernel/fs/scsi/ltpfs/Makefile
> index 7c46a4c4d..5f4030661 100644
> --- a/testcases/kernel/fs/scsi/ltpfs/Makefile
> +++ b/testcases/kernel/fs/scsi/ltpfs/Makefile
> @@ -14,9 +14,9 @@ KDIR	:= /lib/modules/$(shell uname -r)/build
>   PWD	:= $(shell pwd)
>
>   default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> +	$(MAKE) -C $(KDIR) M=$(PWD) modules
>   	${CC}  $(CFLAGS) -o ltpfstest -lm  main.c
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> +#	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
>   endif
>
>   clean:
