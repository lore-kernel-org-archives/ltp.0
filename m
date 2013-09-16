Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLYSH-00076k-NS
	for ltp-list@lists.sourceforge.net; Mon, 16 Sep 2013 13:03:05 +0000
Date: Mon, 16 Sep 2013 15:03:18 +0200
From: chrubis@suse.cz
Message-ID: <20130916130318.GA19644@rei.suse.cz>
References: <1378895508-28703-1-git-send-email-alexey.kodanev@oracle.com>
	<1378895508-28703-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1378895508-28703-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2 2/2] device-drivers: block: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5703652611171109692=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============5703652611171109692==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/Mak=
efile b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
> index 10f33a7..891568d 100644
> --- a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
> @@ -1,24 +1,40 @@
> -
> -EXTRA_CFLAGS +=3D -Wall -W -Wno-unused-parameter
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved=
.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> =20
>  ifneq ($(KERNELRELEASE),)
> =20
> -obj-m	:=3D test_block.o test_genhd.o
> +obj-m		:=3D ltp_block_dev.o
> +
>  else
> -KDIR	:=3D /lib/modules/$(shell uname -r)/build
> -PWD	:=3D $(shell pwd)
> =20
> -modules:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
> +top_srcdir	?=3D ../../../../..
> +include $(top_srcdir)/include/mk/testcases.mk
> =20
> -clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) clean
> -	rm -f modules.order
> +MAKE_TARGETS	:=3D ltp_block_dev.ko
> =20
> -help:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) help
> +# Ignoring the exit status of commands is done to be forward compatibl=
e with
> +# kernel internal API changes. The user-space test will return TCONF, =
if it
> +# doesn't find the module (i.e. it wasn't built either due to kernel-d=
evel
> +# missing or module build failure).
> +%.ko: %.c
> +	-$(MAKE) -C $(LINUX_DIR) M=3D$(abs_srcdir)
> +	-mv $@ $@~
> +	-$(MAKE) -C $(LINUX_DIR) M=3D$(abs_srcdir) clean
> +	-mv $@~ $@

Now that we have more uses of this Make recipe I would love to see it
moved to a file under include/mk/ to avoid duplication.

> -modules_install:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules_install
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> =20
>  endif
> diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp=
_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp=
_block_dev.c
> index 3048e09..83ff212 100644
> --- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_=
dev.c
> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_=
dev.c
> @@ -1,17 +1,28 @@
> -
>  /*
> - * Module under test: linux/block/genhd.c
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserve=
d.
>   *
> - * Only those functions are tested here which are declared in <linux/f=
s.h>
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation=
,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
> - * Usage:
> - *   1. make
> - *   2. su
> - *   3. insmod ./test_block.ko
> - *   4. Check the test results in "dmesg"
> - *   5. rmmod test_block
> + * Only those functions are tested here which are declared in <linux/f=
s.h>
>   *
>   * Changes:
> + *    Sep 2013  0.3  Changed test-case behavior: major number greater
> + *                   than 255 is valid, empty device name is valid.
> + *                   Added test-case result.
> + *                   Added test-case: unregister_blkdev() with NULL na=
me.
> + *                   Added command line parameter 'a': run all test-ca=
ses.

Please do not add any more changelogs into sources, use git commit
message instead.

>   * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
>   * 11 Jan 2009  0.1  First release
>   */
> @@ -19,18 +30,25 @@
>  #include <linux/module.h>
>  #include <linux/fs.h>
> =20
> -static unsigned int __initdata tc;
> -module_param_named(tc, tc, int, 0);
> -MODULE_PARM_DESC(tc,
> -		 "Test Case to run. Default is 0 which means that run all tests.");
> +static int tc;
> +module_param(tc, int, 0444);
> +MODULE_PARM_DESC(tc, "Test Case to run. Default is 0 - run all tests."=
);
> =20
>  MODULE_AUTHOR("M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>");
>  MODULE_DESCRIPTION("Test block drivers");
>  MODULE_LICENSE("GPL");
> =20
> -#define BLK_DEV_NAME		"test_block"
> +#define BLK_DEV_NAME		"ltp_block_dev"
>  #define MAX_MAJOR		255
> =20
> +#define prk_err(fmt, ...) \
> +	pr_err(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
> +#define prk_info(fmt, ...) \
> +	pr_info(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
> +#define prk_debug(fmt, ...) \
> +	pr_debug(BLK_DEV_NAME ": " fmt, ##__VA_ARGS__)
> +
> +
>  /*
>   * Analysis of "int register_blkdev(unsigned int major, const char *na=
me)"
>   *
> @@ -42,268 +60,305 @@ MODULE_LICENSE("GPL");
>   *             |--------------------------+---------+-------------
>   *             | [1..255]                 | valid   | tc05
>   *             |--------------------------+---------+-------------
> - *             | [256..UINT_MAX]          | invalid | tc03, tc04
> + *             | [256..UINT_MAX]          | valid   | tc03, tc04
>   *  -----------+--------------------------+---------+-------------
>   *  name       | [valid pointer to a zero |         |
>   *             |  terminated string]      | valid   | tc01, tc02
>   *             |--------------------------+---------+-------------
>   *             | [valid pointer to a zero |         |
> - *             |  length zero terminated  | invalid | tc06
> + *             |  length zero terminated  | valid   | tc06
>   *             |  string]                 |         |
>   *             |--------------------------+---------+-------------
> - *             | [NULL]                   | invalid | tc07
> + *             | [NULL]                   | invalid | tc07, tc08
>   *  -----------+--------------------------+---------+-------------
>   *
>   */
> =20
> -static void tc01(void)
> +#define result_str(err) ((err =3D=3D 0) ? ("PASS") : ("FAIL"))
> +
> +static int tc01(void)
>  {
> -	int major1;
> -	int major2;
> +	int major1, major2;
> +	int err =3D 0;
> =20
> -	printk(KERN_INFO
> -	       "Test Case 1: register_blkdev() with auto allocating major num=
bers (major=3D0)\n");
> +	prk_info("Test Case 1: register_blkdev() with auto allocating "
> +		"major numbers (major=3D0)\n");
> =20
>  	major1 =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major1 =3D %i\n", major1);
> +	prk_debug("major1 =3D %i\n", major1);
> =20
>  	major2 =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major2 =3D %i\n", major2);
> +	prk_debug("major2 =3D %i\n", major2);
> =20
> -	if (0 < major1) {
> +	if (major1 >=3D 0)
>  		unregister_blkdev(major1, BLK_DEV_NAME);
> -	} else {
> -		printk(KERN_DEBUG
> -		       "first call to register_blkdev() failed with error %i\n",
> -		       major1);
> +	else {
> +		err =3D 1;
> +		prk_debug("1st call to register_blkdev() failed, error %i\n",
> +			major1);
>  	}
> =20
> -	if (0 < major2) {
> +	if (major2 >=3D 0)
>  		unregister_blkdev(major2, BLK_DEV_NAME);
> -	} else {
> -		printk(KERN_DEBUG
> -		       "second call to register_blkdev() failed with error %i\n",
> -		       major2);
> +	else {
> +		err =3D 1;
> +		prk_debug("2nd call to register_blkdev() failed, error %i\n",
> +			major2);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc02(void)
> +static int tc02(void)
>  {
>  	int major[MAX_MAJOR + 1];
> -	int i;
> +	int i, err =3D 0;
> =20
> -	/* Try to allocate block devices until all major number are used. Aft=
er this
> -	 * register_blkdev() should return -EBUSY
> +	/* Try to allocate block devices until all major numbers are used.
> +	 * After this register_blkdev() should return -EBUSY
>  	 */
> =20
> -	printk(KERN_INFO
> -	       "Test Case 2: stress test of register_blkdev() with auto alloc=
ating major numbers (major=3D0)\n");
> +	prk_info("Test Case 2: stress test of register_blkdev() "
> +		"with auto allocating major numbers (major=3D0)\n");
> =20
>  	memset(major, 0, sizeof(major));
> =20
> -	for (i =3D 0; i < sizeof(major) / sizeof(*major); i++) {
> +	for (i =3D 0; i < sizeof(major) / sizeof(*major); ++i) {
>  		major[i] =3D register_blkdev(0, BLK_DEV_NAME);
> -		printk(KERN_DEBUG "major[%i] =3D %i\n", i, major[i]);
> -		if (major[i] <=3D 0 && major[i] !=3D -EBUSY) {
> -			printk(KERN_INFO
> -			       "unexpected return value from register_blkdev(): %i\n",
> -			       major[i]);
> -		}
> -		if (major[i] < 0) {
> -			printk(KERN_DEBUG
> -			       "register_blkdev() failed with error %i\n",
> -			       major[i]);
> +		prk_debug("major[%i] =3D %i\n", i, major[i]);
> +
> +		if (major[i] =3D=3D -EBUSY) {
> +			prk_info("device is busy, register_blkdev() ret %i\n",
> +				major[i]);
> +		} else if (major[i] < 0) {
> +			prk_debug("register_blkdev() failed with error %i\n",
> +				major[i]);
> +			err =3D 1;
>  		}
>  	}
> =20
> -	for (i =3D 0; i < sizeof(major) / sizeof(*major); i++) {
> -		if (0 < major[i]) {
> +	for (i =3D 0; i < sizeof(major) / sizeof(*major); ++i) {
> +		if (major[i] >=3D 0)
>  			unregister_blkdev(major[i], BLK_DEV_NAME);
> -			major[i] =3D 0;
> -		}
>  	}
> =20
> -	printk(KERN_INFO "Test Case 2: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc03(void)
> +static int tc03(void)
>  {
> -	int major;
> +	int major, err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 3: register_blkdev() with major=3D256\n")=
;
> +	prk_info("Test Case 3: register_blkdev() with major=3D256\n");
> =20
>  	major =3D register_blkdev(256, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> -		unregister_blkdev(major, BLK_DEV_NAME);
> +	if (major =3D=3D 0) {
> +		unregister_blkdev(256, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		err =3D 1;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc04(void)
> +static int tc04(void)
>  {
> -	int major;
> +	int major, err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 4: register_blkdev() with major=3D%u\n",
> -	       UINT_MAX);
> +	prk_info("Test Case 4: register_blkdev() with major=3D%u\n", UINT_MAX=
);
> =20
>  	major =3D register_blkdev(UINT_MAX, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> -
> -	if (0 < major) {
> -		unregister_blkdev(major, BLK_DEV_NAME);
> -	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +	prk_debug("major =3D %i\n", major);
> +
> +	if (major =3D=3D 0)
> +		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
> +	else {
> +		prk_debug("reg blkdev with major %d failed with error %i\n",
> +			UINT_MAX, major);
> +		err =3D 1;
>  	}
> =20
> -	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc05(void)
> +static int tc05(void)
>  {
> -	int major;
> -	int major2;
> -	int major3;
> +	int major, major2, major3;
> +	int err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 5: register_blkdev() with major !=3D 0\n"=
);
> +	prk_info("Test Case 5: register_blkdev() with major !=3D 0\n");
> =20
>  	/* autosearch for a free major number */
>  	major =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> +	if (major > 0) {
>  		unregister_blkdev(major, BLK_DEV_NAME);
> =20
> +		/* expected to return 0 */
>  		major2 =3D register_blkdev(major, BLK_DEV_NAME);
> +
> +		/* this call has to fail with EBUSY return value */
>  		major3 =3D register_blkdev(major, BLK_DEV_NAME);
> =20
> -		if (0 < major2) {
> -			unregister_blkdev(major2, BLK_DEV_NAME);
> -		} else {
> -			printk(KERN_DEBUG
> -			       "first call to register_blkdev() with major=3D%i failed with=
 error %i\n",
> -			       major, major2);
> +		if (major2 =3D=3D 0)
> +			unregister_blkdev(major, BLK_DEV_NAME);
> +		else {
> +			err =3D 1;
> +			prk_debug("1st call to register_blkdev() with major=3D%i "
> +				"failed with error %i\n", major, major2);
>  		}
> =20
> -		if (0 < major3) {
> -			unregister_blkdev(major3, BLK_DEV_NAME);
> +		if (major3 =3D=3D 0) {
> +			unregister_blkdev(major, BLK_DEV_NAME);
> +			err =3D 1;
>  		} else {
> -			printk(KERN_DEBUG
> -			       "second call to register_blkdev() with major=3D%i failed wit=
h error %i\n",
> -			       major, major3);
> +			if (major3 !=3D -EBUSY)
> +				err =3D 1;
> +			prk_debug("2nd call to register_blkdev() with major=3D%i "
> +				"failed with error %i\n", major, major3);
>  		}
> =20
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		err =3D 1;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc06(void)
> +static int tc06(void)
>  {
> -	int major;
> +	int major, err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 6: register_blkdev() with name=3D\"\"\n")=
;
> +	prk_info("Test Case 6: register_blkdev() with name=3D\"\"\n");
> =20
>  	major =3D register_blkdev(0, "");
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> +	if (major >=3D 0)
>  		unregister_blkdev(major, "");
> -	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +	else {
> +		err =3D 1;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc07(void)
> +static int tc07(void)
>  {
> -	int major;
> +	int major, err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 7: register_blkdev() with name=3DNULL\n")=
;
> +	prk_info("Test Case 7: register_blkdev() with name=3DNULL\n");
> =20
> +	/* should fail with -EINVAL */
>  	major =3D register_blkdev(0, NULL);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> +	if (major >=3D 0) {
>  		unregister_blkdev(major, NULL);
> +		err =3D 1;
> +	} else
> +		prk_debug("register_blkdev() failed with error %i\n", major);
> +
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
> +}
> +
> +static int tc08(void)
> +{
> +	int major, err =3D 0;
> +
> +	prk_info("Test Case 8: unregister_blkdev() with name=3DNULL\n");
> +
> +	major =3D register_blkdev(0, BLK_DEV_NAME);
> +	prk_debug("major =3D %i\n", major);
> +
> +	if (major >=3D 0) {
> +		/* kernel should silently ignore this */
> +		unregister_blkdev(major, NULL);
> +		unregister_blkdev(major, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		err =3D 1;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
> -static void tc10(void)
> +static int tc10(void)
>  {
> -	int major;
> +	int major, err =3D 0;
> =20
> -	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=3D0\n"=
);
> +	prk_info("Test Case 10: unregister_blkdev() with major=3D0\n");
> =20
>  	major =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> -		printk(KERN_DEBUG "calling unregister_blkdev() with major=3D0\n");
> +	if (major >=3D 0) {
> +		prk_debug("calling unregister_blkdev() with major=3D0\n");
>  		unregister_blkdev(0, BLK_DEV_NAME);
> -		printk(KERN_DEBUG "calling unregister_blkdev() with major=3D%i\n",
> -		       major);
> +		prk_debug("calling unregister_blkdev() with major=3D%i\n", major);
>  		unregister_blkdev(major, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		err =3D 1;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(err));
> +	return err;
>  }
> =20
>  static int test_init_module(void)
>  {
> -	printk(KERN_INFO "Starting test_block module\n");
> +	int err =3D 0;
> +	prk_info("Starting module\n");
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 1)
> -		tc01();
> +		err |=3D tc01();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 2)
> -		tc02();
> +		err |=3D tc02();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 3)
> -		tc03();
> +		err |=3D tc03();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 4)
> -		tc04();
> +		err |=3D tc04();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 5)
> -		tc05();
> +		err |=3D tc05();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 6)
> -		tc06();
> +		err |=3D tc06();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 7)
> -		tc07();
> +		err |=3D tc07();
> +
> +	if (tc =3D=3D 0 || tc =3D=3D 8)
> +		err |=3D tc08();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 10)
> -		tc10();
> +		err |=3D tc10();
> +
> =20
> -	return 0;
> +	return -err;
>  }
> =20
>  static void test_exit_module(void)
>  {
> -	printk(KERN_DEBUG "Unloading test_block module\n");
> +	prk_debug("Unloading module\n");
>  }
> =20
>  module_init(test_init_module);
> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/.giti=
gnore b/testcases/kernel/device-drivers/block/block_dev_user/.gitignore
> new file mode 100644
> index 0000000..4034ce5
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/block/block_dev_user/.gitignore
> @@ -0,0 +1 @@
> +/block_dev
> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/Makef=
ile b/testcases/kernel/device-drivers/block/block_dev_user/Makefile
> new file mode 100644
> index 0000000..6ba3465
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/block/block_dev_user/Makefile
> @@ -0,0 +1,20 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved=
.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +top_srcdir		?=3D ../../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block=
_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> new file mode 100644
> index 0000000..8e813bd
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserve=
d.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation=
,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * Test checks block device kernel API.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "tst_module.h"
> +
> +char *TCID =3D "block_dev";
> +int TST_TOTAL =3D 9;
> +
> +static const char module_name[]	=3D "ltp_block_dev.ko";
> +static int module_loaded;
> +
> +static int run_all_testcases;
> +static const option_t options[] =3D {
> +	{"a", &run_all_testcases, NULL},
> +	{NULL, NULL, NULL}
> +};
> +
> +static void cleanup(void)
> +{
> +	if (module_loaded)
> +		tst_module_unload(NULL, module_name);
> +
> +	TEST_CLEANUP;
> +}
> +
> +static void help(void)
> +{
> +	printf("  -a      Run all test-cases (can crash the kernel)\n");
> +}
> +
> +void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg =3D parse_opts(argc, argv, options, help);
> +	if (msg !=3D NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(2, 6, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"Test must be run with kernel 2.6 or newer");
> +	}
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +}
> +
> +static int curr_test_case;
> +
> +static void test_fail()

Missing void in the parameters.

> +{
> +	tst_resm(TFAIL, "Test Case %d failed", curr_test_case);

Hmm, wouldn't this print FAIL and the SUCCESS in case the test failed?
(as the main loop prints SUCCESS unconditionally)

Shouldn't we rather set a flag here (reset it before each test) and
print PASS/FALL accordingly?

How do we distinguish missing module (due to possible compilation
failure) and test failure?

> +}
> +
> +static void test_run(void)
> +{
> +	int off =3D 0;
> +	int test_case[] =3D { 1, 2, 5, 3, 4, 10, 6, 7, 8 };

What a strange sequence. Is this order of testcases required? Why we
have testcase 10 but not testcase 9?

> +	/*
> +	 * test-cases #7 and #8 can crash the kernel.
> +	 * We have to wait for kernel fix where register_blkdev() &
> +	 * unregister_blkdev() checks the input device name parameter
> +	 * against NULL pointer.
> +	 */
> +	if (!run_all_testcases)
> +		off =3D 2;

Are you working on fix with kernel devs?

> +	char *tc_param =3D NULL;
> +	int i;
> +	for (i =3D 0; i < TST_TOTAL - off; ++i) {
> +		curr_test_case =3D test_case[i];
> +		SAFE_ASPRINTF(cleanup, &tc_param, "tc=3D%d", curr_test_case);

No need to allocate the tc_param over and over, you know that the size
is <=3D 6 in all cases, static buffer should do.

> +		char *const mod_params[2] =3D { tc_param, NULL };
> +		tst_module_load(test_fail, module_name, mod_params);
> +		module_loaded =3D 1;
> +		tst_module_unload(NULL, module_name);
> +		module_loaded =3D 0;
> +		tst_resm(TPASS, "Test Case %d passed", curr_test_case);
> +		free(tc_param);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	setup(argc, argv);
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}

--=20
Cyril Hrubis
chrubis@suse.cz


--===============5703652611171109692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
--===============5703652611171109692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5703652611171109692==--
