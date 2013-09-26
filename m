Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VPEVh-00029v-NC
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 16:33:49 +0000
Date: Thu, 26 Sep 2013 18:34:07 +0200
From: chrubis@suse.cz
Message-ID: <20130926163406.GB17388@rei.suse.cz>
References: <1380026850-7485-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1380026850-7485-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v4 2/2] device-drivers: block: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8246244055441815830=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============8246244055441815830==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> --- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_=
dev.c
> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_=
dev.c
> @@ -1,15 +1,21 @@
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
>   *
> - * Usage:
> - *   1. make
> - *   2. su
> - *   3. insmod ./test_block.ko
> - *   4. Check the test results in "dmesg"
> - *   5. rmmod test_block
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation=
,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Only those functions are tested here which are declared in <linux/f=
s.h>
>   *
>   * Changes:
>   * 16 Jan 2009  0.2  Added "tc" parameter to run test cases separately
> @@ -17,20 +23,24 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/device.h>
>  #include <linux/fs.h>
> =20
> -static unsigned int __initdata tc;
> -module_param_named(tc, tc, int, 0);
> -MODULE_PARM_DESC(tc,
> -		 "Test Case to run. Default is 0 which means that run all tests.");
> -
>  MODULE_AUTHOR("M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>");
> +MODULE_AUTHOR("Copyright (c) 2013 Oracle and/or its affiliates");
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
>  /*
>   * Analysis of "int register_blkdev(unsigned int major, const char *na=
me)"
>   *
> @@ -40,271 +50,373 @@ MODULE_LICENSE("GPL");
>   *  -----------+--------------------------+---------+-------------
>   *  major      | [0]                      | valid   | tc01, tc02
>   *             |--------------------------+---------+-------------
> - *             | [1..255]                 | valid   | tc05
> + *             | [1..255]                 | valid   | tc03
>   *             |--------------------------+---------+-------------
> - *             | [256..UINT_MAX]          | invalid | tc03, tc04
> + *             | [256..UINT_MAX]          | valid   | tc04, tc05
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
> + *             | [NULL]                   | invalid | tc08, tc09
>   *  -----------+--------------------------+---------+-------------
>   *
>   */
> =20
> -static void tc01(void)
> +#define result_str(pass) ((pass =3D=3D 0) ? ("FAIL") : ("PASS"))
> +
> +/*
> + * bit mask for each test-case,
> + * if test is passed, bit will be set to 1
> + */
> +static int test_result;
> +
> +static void device_release(struct device *dev)
>  {
> -	int major1;
> -	int major2;
> +	prk_info("device released\n");
> +}
> +
> +static struct device tdev =3D {
> +	.init_name	=3D BLK_DEV_NAME,
> +	.release	=3D device_release,
> +};
> =20
> -	printk(KERN_INFO
> -	       "Test Case 1: register_blkdev() with auto allocating major num=
bers (major=3D0)\n");
> +static int tc01(void)
> +{
> +	int major1, major2;
> +	int pass =3D 1;
> +
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
> +		pass =3D 0;
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
> +		pass =3D 0;
> +		prk_debug("2nd call to register_blkdev() failed, error %i\n",
> +			major2);
>  	}

This is not bug, but linux/Documentation/CodingStyle suggets that if
there are braces around one of the if then else blocks the should be
around the second one too.

> -	printk(KERN_INFO "Test Case 1: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc02(void)
> +static int tc02(void)
>  {
>  	int major[MAX_MAJOR + 1];
> -	int i;
> +	int i, pass =3D 2;
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
> +			pass =3D 0;
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
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc03(void)
> +static int tc03(void)
>  {
> -	int major;
> +	int major, major2, major3;
> +	int pass =3D 4;
> =20
> -	printk(KERN_INFO "Test Case 3: register_blkdev() with major=3D256\n")=
;
> +	prk_info("Test Case 3: register_blkdev() with major !=3D 0\n");
> =20
> -	major =3D register_blkdev(256, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	/* autosearch for a free major number */
> +	major =3D register_blkdev(0, BLK_DEV_NAME);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> +	if (major > 0) {
>  		unregister_blkdev(major, BLK_DEV_NAME);
> +
> +		/* expected to return 0 */
> +		major2 =3D register_blkdev(major, BLK_DEV_NAME);
> +
> +		/* this call has to fail with EBUSY return value */
> +		major3 =3D register_blkdev(major, BLK_DEV_NAME);
> +
> +		if (major2 =3D=3D 0)
> +			unregister_blkdev(major, BLK_DEV_NAME);
> +		else {
> +			pass =3D 0;
> +			prk_debug("1st call to register_blkdev() with major=3D%i "
> +				"failed with error %i\n", major, major2);
> +		}
> +
> +		if (major3 =3D=3D 0) {
> +			unregister_blkdev(major, BLK_DEV_NAME);
> +			pass =3D 0;
> +		} else {
> +			if (major3 !=3D -EBUSY)
> +				pass =3D 0;
> +			prk_debug("2nd call to register_blkdev() with major=3D%i "
> +				"failed with error %i\n", major, major3);
> +		}
> +
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		pass =3D 0;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 3: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc04(void)
> +static int tc04(void)
>  {
> -	int major;
> +	int major, pass =3D 8;
> =20
> -	printk(KERN_INFO "Test Case 4: register_blkdev() with major=3D%u\n",
> -	       UINT_MAX);
> +	prk_info("Test Case 4: register_blkdev() with major=3D256\n");
> =20
> -	major =3D register_blkdev(UINT_MAX, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	major =3D register_blkdev(256, BLK_DEV_NAME);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> -		unregister_blkdev(major, BLK_DEV_NAME);
> +	if (major =3D=3D 0) {
> +		unregister_blkdev(256, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		pass =3D 0;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 4: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc05(void)
> +static int tc05(void)
>  {
> -	int major;
> -	int major2;
> -	int major3;
> +	int major, pass =3D 16;
> =20
> -	printk(KERN_INFO "Test Case 5: register_blkdev() with major !=3D 0\n"=
);
> +	prk_info("Test Case 5: register_blkdev() with major=3D%u\n", UINT_MAX=
);
> =20
> -	/* autosearch for a free major number */
> -	major =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	major =3D register_blkdev(UINT_MAX, BLK_DEV_NAME);
> +	prk_debug("major =3D %i\n", major);
> +
> +	if (major =3D=3D 0)
> +		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
> +	else {
> +		prk_debug("reg blkdev with major %d failed with error %i\n",
> +			UINT_MAX, major);
> +		pass =3D 0;
> +	}
> =20
> -	if (0 < major) {
> -		unregister_blkdev(major, BLK_DEV_NAME);
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
> +}
> =20
> -		major2 =3D register_blkdev(major, BLK_DEV_NAME);
> -		major3 =3D register_blkdev(major, BLK_DEV_NAME);
> +static int tc06(void)
> +{
> +	int major, pass =3D 32;
> =20
> -		if (0 < major2) {
> -			unregister_blkdev(major2, BLK_DEV_NAME);
> -		} else {
> -			printk(KERN_DEBUG
> -			       "first call to register_blkdev() with major=3D%i failed with=
 error %i\n",
> -			       major, major2);
> -		}
> +	prk_info("Test Case 6: register_blkdev() with name=3D\"\"\n");
> =20
> -		if (0 < major3) {
> -			unregister_blkdev(major3, BLK_DEV_NAME);
> -		} else {
> -			printk(KERN_DEBUG
> -			       "second call to register_blkdev() with major=3D%i failed wit=
h error %i\n",
> -			       major, major3);
> -		}
> +	major =3D register_blkdev(0, "");
> +	prk_debug("major =3D %i\n", major);
> =20
> -	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +	if (major >=3D 0)
> +		unregister_blkdev(major, "");
> +	else {
> +		pass =3D 0;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 5: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc06(void)
> +static int tc07(void)
>  {
> -	int major;
> +	int major, pass =3D 64;
> =20
> -	printk(KERN_INFO "Test Case 6: register_blkdev() with name=3D\"\"\n")=
;
> +	prk_info("Test Case 7: unregister_blkdev() with major=3D0\n");
> =20
> -	major =3D register_blkdev(0, "");
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	major =3D register_blkdev(0, BLK_DEV_NAME);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> -		unregister_blkdev(major, "");
> +	if (major >=3D 0) {
> +		prk_debug("calling unregister_blkdev() with major=3D0\n");
> +		unregister_blkdev(0, BLK_DEV_NAME);
> +		prk_debug("calling unregister_blkdev() with major=3D%i\n", major);
> +		unregister_blkdev(major, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		pass =3D 0;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 6: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc07(void)
> +static int tc08(void)
>  {
> -	int major;
> +	int major, pass =3D 128;
> =20
> -	printk(KERN_INFO "Test Case 7: register_blkdev() with name=3DNULL\n")=
;
> +	prk_info("Test Case 8: register_blkdev() with name=3DNULL\n");
> =20
> +	/* should fail with -EINVAL */
>  	major =3D register_blkdev(0, NULL);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> +	if (major >=3D 0) {
>  		unregister_blkdev(major, NULL);
> -	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> -	}
> +		pass =3D 0;
> +	} else
> +		prk_debug("register_blkdev() failed with error %i\n", major);
> =20
> -	printk(KERN_INFO "Test Case 7: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static void tc10(void)
> +static int tc09(void)
>  {
> -	int major;
> +	int major, pass =3D 256;
> =20
> -	printk(KERN_INFO "Test Case 10: unregister_blkdev() with major=3D0\n"=
);
> +	prk_info("Test Case 9: unregister_blkdev() with name=3DNULL\n");
> =20
>  	major =3D register_blkdev(0, BLK_DEV_NAME);
> -	printk(KERN_DEBUG "major =3D %i\n", major);
> +	prk_debug("major =3D %i\n", major);
> =20
> -	if (0 < major) {
> -		printk(KERN_DEBUG "calling unregister_blkdev() with major=3D0\n");
> -		unregister_blkdev(0, BLK_DEV_NAME);
> -		printk(KERN_DEBUG "calling unregister_blkdev() with major=3D%i\n",
> -		       major);
> +	if (major >=3D 0) {
> +		/* kernel should silently ignore this */
> +		unregister_blkdev(major, NULL);
>  		unregister_blkdev(major, BLK_DEV_NAME);
>  	} else {
> -		printk(KERN_DEBUG "register_blkdev() failed with error %i\n",
> -		       major);
> +		pass =3D 0;
> +		prk_debug("register_blkdev() failed with error %i\n", major);
>  	}
> =20
> -	printk(KERN_INFO "Test Case 10: UNRESLOVED\n");
> +	prk_info("Test Case Result: %s\n", result_str(pass));
> +	return pass;
>  }
> =20
> -static int test_init_module(void)
> +/* print test result to sysfs file */
> +static ssize_t sys_result(struct device *dev,
> +	struct device_attribute *attr, char *buf)
>  {
> -	printk(KERN_INFO "Starting test_block module\n");
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
> +}
> +static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
> +
> +/*
> + * get test-case number and run it
> + */
> +static ssize_t sys_tcase(struct device *dev,
> +	struct device_attribute *attr,  const char *buf, size_t count)
> +{
> +	int tc =3D 0;
> +	sscanf(buf, "%d", &tc);
> +	if (tc < 0 || tc > 9) {
> +		prk_err(": Unexpected test-case number '%d'", tc);
> +		return count;
> +	}
> +
> +	test_result =3D 0;
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 1)
> -		tc01();
> +		test_result |=3D tc01();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 2)
> -		tc02();
> +		test_result |=3D tc02();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 3)
> -		tc03();
> +		test_result |=3D tc03();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 4)
> -		tc04();
> +		test_result |=3D tc04();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 5)
> -		tc05();
> +		test_result |=3D tc05();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 6)
> -		tc06();
> +		test_result |=3D tc06();
> =20
>  	if (tc =3D=3D 0 || tc =3D=3D 7)
> -		tc07();
> +		test_result |=3D tc07();
> =20
> -	if (tc =3D=3D 0 || tc =3D=3D 10)
> -		tc10();
> +	if (tc =3D=3D 0 || tc =3D=3D 8)
> +		test_result |=3D tc08();
> =20
> -	return 0;
> +	if (tc =3D=3D 0 || tc =3D=3D 9)
> +		test_result |=3D tc09();
> +
> +	return count;
>  }
> +static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
> =20
> -static void test_exit_module(void)
> +static int test_init_module(void)
>  {
> -	printk(KERN_DEBUG "Unloading test_block module\n");
> -}
> +	int err =3D 0;
> +	prk_info("Starting module\n");
> +
> +	err =3D device_register(&tdev);
> +	if (err) {
> +		prk_err("Unable to register device\n");
> +		return err;
> +	}
> +	prk_info("device registered\n");
> +
> +	err =3D device_create_file(&tdev, &dev_attr_result);
> +	if (err) {
> +		prk_err("Can't create sysfs file 'result'\n");
> +		device_unregister(&tdev);
> +		return err;
> +	}
> +
> +	err =3D device_create_file(&tdev, &dev_attr_tcase);
> +	if (err) {
> +		prk_err(": Can't create sysfs file 'tc'\n");
> +		device_remove_file(&tdev, &dev_attr_result);
> +		device_unregister(&tdev);
> +	}
> =20
> +	return err;

This part would probably be better done with the goto errX approach as:

	err =3D device_register(&tdev);
	if (err) {
		prk_err("Unable to register device\n");
		goto err0;
	}

	err =3D device_create_file(&tdev, &dev_attr_result);

	if (err) {
		prk_err("Can't create sysfs file 'result'\n");
		goto err1;
	}

	...

	return 0;

	err2:
		device_remove_file(&tdev, &dev_attr_result);
	err1:
		device_unregister(&tdev);
	err0:
		return err;

It's easier to maintain the error paths this way.

> +}
>  module_init(test_init_module);
> +
> +static void test_exit_module(void)
> +{
> +	prk_debug("Unloading module\n");
> +	device_remove_file(&tdev, &dev_attr_result);
> +	device_remove_file(&tdev, &dev_attr_tcase);
> +	device_unregister(&tdev);
> +}
>  module_exit(test_exit_module);

Otherwise it looks good.

--=20
Cyril Hrubis
chrubis@suse.cz


--===============8246244055441815830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
--===============8246244055441815830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8246244055441815830==--
