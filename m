Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VljUG-00032a-Fo
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 18:05:20 +0000
Date: Wed, 27 Nov 2013 19:04:49 +0100
From: chrubis@suse.cz
Message-ID: <20131127180449.GA8163@rei>
References: <1384784307-28731-1-git-send-email-alexey.kodanev@oracle.com>
	<1384784307-28731-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1384784307-28731-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v4 2/2] device-drivers: acpi: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3168625033320716362=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============3168625033320716362==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> Obsolete code updated to the actual kernel ACPI API.
> Changed test-cases handling from ioctl to sysfs.
> User-space program rewritten.
> User-space program loads/unloads kernel module.
> Added new test-cases: traverse ACPI devices and sysfs support
> for device description.
>=20
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/kernel/device-drivers/acpi/.gitignore    |    8 +
>  testcases/kernel/device-drivers/acpi/Makefile      |   43 +-
>  testcases/kernel/device-drivers/acpi/ltp_acpi.c    |  166 ++++
>  testcases/kernel/device-drivers/acpi/ltp_acpi.h    |  123 +--
>  .../kernel/device-drivers/acpi/ltp_acpi_cmds.c     | 1000 ++++++++++--=
--------
>  5 files changed, 714 insertions(+), 626 deletions(-)
>  create mode 100644 testcases/kernel/device-drivers/acpi/.gitignore
>  create mode 100644 testcases/kernel/device-drivers/acpi/ltp_acpi.c
>=20
> diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcase=
s/kernel/device-drivers/acpi/.gitignore
> new file mode 100644
> index 0000000..76fbdc8
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/acpi/.gitignore
> @@ -0,0 +1,8 @@
> +/LtpAcpiCmds.ko

This is wrong and even if it wasn't the ltp_acpi_cmd.ko is covered by
the *.ko bellow.

> +/ltp_acpi
> +/*.mod.c
> +/modules.order
> +/.tmp_versions
> +/.*.ko
> +/.*.cmd
> +/Module.symvers

...

> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcase=
s/kernel/device-drivers/acpi/ltp_acpi.c
> new file mode 100644
> index 0000000..612c3d4
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
> @@ -0,0 +1,166 @@
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
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "tst_module.h"
> +#include "safe_macros.h"
> +#include "safe_stdio.h"
> +
> +#include "ltp_acpi.h"
> +
> +char *TCID =3D "ltp_acpi";
> +int TST_TOTAL =3D ACPI_TC_NUM;
> +
> +static const char dev_result[]	=3D "/sys/devices/" ACPI_TEST_NAME "/re=
sult";
> +static const char dev_path[]	=3D "/sys/devices/" ACPI_TEST_NAME "/path=
";
> +static const char dev_str[]	=3D "/sys/devices/" ACPI_TEST_NAME "/str";
> +static const char dev_tcase[]	=3D "/sys/devices/" ACPI_TEST_NAME "/tca=
se";
> +static const char module_name[]	=3D "ltp_acpi_cmds.ko";
> +static int module_loaded;
> +
> +static void cleanup(void)
> +{
> +	if (module_loaded)
> +		tst_module_unload(NULL, module_name);
> +
> +	TEST_CLEANUP;
> +}
> +
> +static int read_sysfs_file(const char *name, char *buf, int size)
> +{
> +	FILE *f =3D SAFE_FOPEN(cleanup, name, "r");
> +	if (!fgets(buf, size, f)) {
> +		tst_resm(TFAIL, "failed to read sysfs file '%s'", name);
> +		return 1;
> +	}
> +	SAFE_FCLOSE(cleanup, f);
> +	return 0;
> +}
> +
> +static int next_acpi_str(void)
> +{
> +	char descr[4096], sysfs_path[4096];
> +
> +	/*
> +	 * if device has _STR object, we should get
> +	 * a valid string from 'str' sysfs file and then can
> +	 * find it in sysfs.
> +	 */
> +	if (read_sysfs_file(dev_str, descr, 4096))
> +		return 0;
> +	if (!strcmp(descr, "null")) {
> +		tst_resm(TCONF, "None of left devices has _STR");
> +		return 0;
> +	}
> +	tst_resm(TINFO, "read description %s", descr);
> +
> +	/* device's sysfs path */
> +	strcpy(sysfs_path, "/sys");
> +	if (read_sysfs_file(dev_path, sysfs_path + 4, 4092))
> +		return 0;
> +	if (!strcmp(sysfs_path + 4, "null")) {
> +		tst_resm(TCONF, "device doesn't have sysfs entry");
> +		/* continue, because others might have it */
> +		return 1;
> +	}
> +	strcat(sysfs_path, "/description");
> +
> +	/*
> +	 * Find device description in sysfs.
> +	 *
> +	 * New sysfs interface to export device description
> +	 * implemented since Linux 3.7
> +	 */
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_resm(TCONF,
> +			"sysfs description check required Linux 3.7+");
> +		return 1;
> +	}
> +
> +	if (access(sysfs_path, R_OK)) {
> +		tst_resm(TFAIL, "can't find description file '%s'", sysfs_path);
> +		return 1;
> +	}
> +	tst_resm(TPASS, "found description file '%s'", sysfs_path);

You should not call tst_resm() with TPASS here, this way the test will
report more passed cases than is the maximal number of tests.

> +	char sysfs_descr[4096];
> +	if (read_sysfs_file(sysfs_path, sysfs_descr, 4096))
> +		return 1;
> +
> +	/*
> +	 * Compare sysfs file and description from test driver
> +	 */
> +	int res =3D strncmp(descr, sysfs_descr, strlen(descr));
> +
> +	tst_resm((res) ? TFAIL : TPASS, "check sysfs file");
> +
> +	return 1;
> +}
> +
> +static void test_run(void)
> +{
> +	int i =3D 0, res;
> +	while (i < TST_TOTAL) {
> +
> +		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> +		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> +
> +		tst_resm(res, "Test-case '%d'", i);
> +
> +		/*
> +		 * trigger ACPI_TRAVERSE test-case while we can
> +		 * get valid next device description.
> +		 */
> +		if (i =3D=3D ACPI_TRAVERSE && next_acpi_str())
> +			continue;

The same goes for the tst_resm() here.

I would write this part so that reading the sys_str file triggers
walking to next object with _STR argument, while writing to dev_tcase
will reset the walk to root and wrote a code as:

	SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);

	if (i =3D=3D ACPI_TRAVERSE)
		res =3D next_acpi_str();

	tst_resm(...);

And the next_acpi_str() would loop on reading the dev_str while "null"
is returned. Or even better make the read returns zero size at the end,
(should be mapped to EOF in case of FILE*).

Also I would be more carefull and rather sanitized the result value, i.e.

	tst_resm(ret ? TFAIL : TPASS, "...");

> +		++i;
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg =3D parse_opts(argc, argv, NULL, NULL);
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
> +
> +	tst_module_load(NULL, module_name, NULL);
> +	module_loaded =3D 1;
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}

...

> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/tes=
tcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
> index 26fcc15..ff89bc5 100644
> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
> @@ -1,20 +1,20 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserve=
d.
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modi=
fy
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or mo=
dify
> - *   it under the terms of the GNU General Public License as published=
 by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA
>   */
> =20
>  /*
> @@ -27,7 +27,6 @@
>   *
>   *  01/03/2009 M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
>   *   - Updated for Linux kernel 2.6.28
> - *
>   */
> =20
>  #include <linux/kernel.h>
> @@ -40,477 +39,443 @@
>  #include <linux/pm.h>
>  #include <linux/acpi.h>
>  #include <linux/genhd.h>
> -#include <asm/uaccess.h>
> -#include "LtpAcpi.h"
> -
> -#ifndef ACPI_EC_UDELAY_GLK
> -#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
> -#endif
> -
> -static int ltpdev_open(struct block_device *bdev, fmode_t mode);
> -static int ltpdev_release(struct gendisk *disk, fmode_t mode);
> -static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsig=
ned cmd,
> -			unsigned long arg);
> -
> -static u32 ltp_test_sleep_button_ev_handler(void *context);
> -static u32 ltp_test_power_button_ev_handler(void *context);
> -static u32 acpi_ec_gpe_handler(void *context);
> -
> -static void acpi_bus_notify(acpi_handle handle, u32 type, void *data);
> -static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
> -					void *context, void **ret);
> -static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
> -				    void *context);
> -#if 0
> -static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
> -				       u32 function,
> -				       void *handler_context,
> -				       void **return_context);
> -static acpi_status acpi_ec_space_handler(u32 function,
> -					 acpi_physical_address address,
> -					 u32 bit_width,
> -					 acpi_integer * value,
> -					 void *handler_context,
> -					 void *region_context);
> -#endif
> +#include <linux/dmi.h>
> +#include <linux/nls.h>
> =20
> -static struct block_device_operations blkops =3D {
> -open:	ltpdev_open,
> -release:ltpdev_release,
> -ioctl:	ltpdev_ioctl,
> -};
> -
> -int ltp_acpi_major =3D LTPMAJOR;
> -int test_iteration =3D 0;
> -
> -static char genhd_flags =3D 0;
> -static struct gendisk *gd_ptr;
> -
> -struct acpi_ec {
> -	acpi_handle handle;
> -	unsigned long uid;
> -	unsigned long long gpe_bit;
> -	struct acpi_generic_address status_addr;
> -	struct acpi_generic_address command_addr;
> -	struct acpi_generic_address data_addr;
> -	unsigned long global_lock;
> -	spinlock_t lock;
> -};
> +#include "ltp_acpi.h"
> =20
>  MODULE_AUTHOR("Martin Ridgeway <mridge@us.ibm.com>");
> -MODULE_DESCRIPTION(ACPI_LTP_TEST_DRIVER_NAME);
> +MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
> +MODULE_DESCRIPTION("ACPI LTP Test Driver");
>  MODULE_LICENSE("GPL");
> +ACPI_MODULE_NAME("LTP_ACPI")
> =20
> -/*
> - * Device operations for the virtual ACPI devices
> - */
> -
> -extern struct acpi_device *acpi_root;
> +#define prk_err(fmt, ...) \
> +	pr_err(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
> +#define prk_alert(fmt, ...) \
> +	pr_alert(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
> +#define prk_info(fmt, ...) \
> +	pr_info(ACPI_TEST_NAME ": " fmt "\n", ##__VA_ARGS__)
> =20
> -static int ltpdev_open(struct block_device *dev, fmode_t mode)
> +static int acpi_failure(acpi_status status, const char *name)
>  {
> -	printk(KERN_ALERT "ltpdev_open \n");
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, name));
> +		return 1;
> +	}
>  	return 0;
>  }
> =20
> -static int ltpdev_release(struct gendisk *disk, fmode_t mode)
> -{
> -
> -	printk(KERN_ALERT "ltpdev_release \n");
> -	return 0;
> -}
> +/* points to the string of the last found object _STR */
> +static char *str_obj_result;
> =20
> -static u32 ltp_test_power_button_ev_handler(void *context)
> -{
> -	printk(KERN_ALERT "ltp_test_power_button_ev_handler \n");
> -	return 1;
> -}
> +/* sysfs device path of the last found device */
> +static char *sysfs_path;
> =20
> -static u32 ltp_test_sleep_button_ev_handler(void *context)
> -{
> -	printk(KERN_ALERT "ltp_test_sleep_button_ev_handler \n");
> -	return 1;
> -}
> +/* first found device with _CRS */
> +static acpi_handle res_handle;
> =20
> -static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsig=
ned cmd,
> -			unsigned long arg)
> +static acpi_status get_str_object(acpi_handle handle)
>  {
> +	int res;
>  	acpi_status status;
> -//      acpi_handle        sys_bus_handle;
> -	acpi_handle start_handle =3D 0;
> -	acpi_handle parent_handle;
> -	acpi_handle child_handle;
> -	acpi_handle next_child_handle;
> -	acpi_status level;
> -	struct acpi_ec *ec;
> -	struct acpi_device *device;
> -	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_handle temp =3D 0;
> +	union acpi_object *str_obj;
> +	char *buf =3D NULL;
> =20
> -#if 0
> -	acpi_handle tmp_handle;
> -	struct acpi_table_ecdt *ecdt_ptr;
> -	struct acpi_buffer dsdt =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_buffer batt_buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_buffer format =3D { sizeof(ACPI_BATTERY_FORMAT_BIF),
> -		ACPI_BATTERY_FORMAT_BIF
> -	};
> -	struct acpi_buffer data =3D { 0, NULL };
> -	union acpi_object *package =3D NULL;
> -	u32 start_ticks, stop_ticks, total_ticks;
> -#endif
> +	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> =20
> -	u32 i, bm_status;
> -	u8 type_a, type_b;
> -	u32 global_lock =3D 0;
> -	int state =3D 0;
> +	status =3D acpi_get_handle(handle, "_STR", &temp);
> =20
> -    /*****************************************************************=
************/
> +	if (ACPI_SUCCESS(status) && !acpi_evaluate_object(handle,
> +		"_STR", NULL, &buffer)) {

I would write it as:

	if (ACPI_SUCCESS(status) &&
	    !acpi_evaluate_object(handle, "_STR", NULL, &buffer)) {

It's a bit easier to read when the function call is not wrapped in the
middle of the agruments, but that is very minor.

> -	printk(KERN_ALERT "ltpdev_ioctl \n");
> -	switch (cmd) {
> -	case LTPDEV_CMD:
> +		str_obj =3D buffer.pointer;
> =20
> -		parent_handle =3D start_handle;
> -		child_handle =3D 0;
> -		level =3D 1;
> -		test_iteration++;
> +		buf =3D kmalloc(str_obj->buffer.length / 2, GFP_KERNEL);
> +		if (!buf) {
> +			kfree(str_obj);
> +			return AE_NO_MEMORY;
> +		}
> =20
> -		printk(KERN_ALERT
> -		       "-- IOCTL called to start ACPI tests -- Iteration:%d\n",
> -		       test_iteration);
> +		res =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> +			str_obj->buffer.length, UTF16_LITTLE_ENDIAN, buf,
> +			str_obj->buffer.length / 2);
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_handle \n");
> +		buf[res] =3D '\0';
> =20
> -		status =3D acpi_get_handle(0, ACPI_NS_SYSTEM_BUS, &parent_handle);
> +		kfree(str_obj_result);
> +		str_obj_result =3D buf;
> +		kfree(str_obj);
> +	}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_object_info \n");
> +	return status;
> +}
> =20
> -		status =3D acpi_get_object_info(parent_handle, &buffer);
> +static void get_crs_object(acpi_handle handle)
> +{
> +	acpi_status status;
> +	acpi_handle temp;
> +	if (!res_handle) {
> +		status =3D acpi_get_handle(handle, METHOD_NAME__CRS, &temp);
> +		if (ACPI_SUCCESS(status))
> +			res_handle =3D handle;
> +	}
> +}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_next_object \n");
> +static void get_sysfs_path(acpi_handle handle)
> +{
> +	acpi_status status;
> +	struct acpi_device *device;
> +	struct device *dev;
> +	struct kobject *kobj;
> =20
> -		status =3D acpi_get_next_object(ACPI_TYPE_ANY, parent_handle,
> -					      child_handle, &next_child_handle);
> +	kfree(sysfs_path);
> +	sysfs_path =3D NULL;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_parent \n");
> +	status =3D acpi_bus_get_device(handle, &device);
> +	if (ACPI_SUCCESS(status)) {
> +		dev =3D &device->dev;
> +		kobj =3D &dev->kobj;
                ^ this seems to be set but not used

> +		sysfs_path =3D kobject_get_path(&device->dev.kobj, GFP_KERNEL);
> +	}
> +}
> =20
> -		status =3D acpi_get_parent(parent_handle, &parent_handle);
> +/* acpi handle of the last visited device */
> +static acpi_handle start_parent;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_evaluate_object \n");
> +static int acpi_traverse(acpi_handle parent, acpi_handle child)
> +{
> +	static char indent[64];
> +	const char * const ind_end =3D indent + 63;
> +	static const char *ind =3D ind_end;
> +	acpi_status status;
> +	struct acpi_device_info *dev_info;
> +	acpi_handle new_child;
> =20
> -		status =3D acpi_evaluate_object(parent_handle, "_ON", NULL, NULL);
> +	if (!indent[0])
> +		memset(indent, 0x20, 63);
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_table \n");
> +	while (parent) {
> +		status =3D acpi_get_next_object(ACPI_TYPE_DEVICE,
> +			parent, child, &new_child);
> =20
> -//        status =3D acpi_get_table(ACPI_TABLE_RSDP, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_FADT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_FACS, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_PSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_SSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_XSDT, 1, &dsdt);
> +		if (ACPI_FAILURE(status)) {
> +			ind +=3D 4;
> =20
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_get_firmware_table \n");
> +			child =3D parent;
> +			status =3D acpi_get_parent(child, &parent);
> =20
> -		status =3D
> -		    acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
> -					    (struct acpi_table_header **)&dsdt);
> -#endif
> +			/* no more devices */
> +			if (ACPI_FAILURE(status)) {
> +				start_parent =3D 0;
> +				kfree(str_obj_result);
> +				str_obj_result =3D NULL;
> +				break;
                                ^
                                Having return 0; here would make it a
				bit more readable.

> +			}
> +			continue;
> +		}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_install_notify_handler \n");
> -
> -		status =3D
> -		    acpi_install_notify_handler(ACPI_ROOT_OBJECT,
> -						ACPI_SYSTEM_NOTIFY,
> -						&acpi_bus_notify, NULL);
> -
> -		printk(KERN_ALERT "TEST -- acpi_remove_notify_handler \n");
> -
> -		status =3D
> -		    acpi_remove_notify_handler(ACPI_ROOT_OBJECT,
> -					       ACPI_SYSTEM_NOTIFY,
> -					       &acpi_bus_notify);
> -
> -		printk(KERN_ALERT
> -		       "TEST -- acpi_install_fixed_event_handler \n");
> -		status =3D
> -		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> -						     ltp_test_power_button_ev_handler,
> -						     NULL);
> -		if (status)
> -			printk(KERN_ALERT
> -			       "Failed installing fixed event handler \n");
> -
> -		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
> -		status =3D
> -		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> -						    ltp_test_power_button_ev_handler);
> -		if (status)
> -			printk(KERN_ALERT
> -			       "Failed removing fixed event handler \n");
> -
> -		printk(KERN_ALERT
> -		       "TEST -- acpi_install_fixed_event_handler \n");
> -		status =3D
> -		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> -						     ltp_test_sleep_button_ev_handler,
> -						     NULL);
> -		if (status)
> -			printk(KERN_ALERT
> -			       "Failed installing fixed event handler \n");
> -
> -		printk(KERN_ALERT "TEST -- acpi_remove_fixed_event_handler \n");
> -		status =3D
> -		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> -						    ltp_test_sleep_button_ev_handler);
> -		if (status)
> -			printk(KERN_ALERT
> -			       "Failed removing fixed event handler \n");
> -
> -		printk(KERN_ALERT "TEST -- acpi_acquire_global_lock \n");
> -		status =3D
> -		    acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
> -
> -		printk(KERN_ALERT "TEST -- acpi_release_global_lock \n");
> -		status =3D acpi_release_global_lock(global_lock);
> -
> -		printk(KERN_ALERT "TEST -- acpi_bus_get_device \n");
> -
> -		status =3D acpi_bus_get_device(next_child_handle, &device);
> -
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_bus_find_driver \n");
> -		status =3D acpi_bus_find_driver(device);
> -#endif
> +		status =3D acpi_get_object_info(new_child, &dev_info);
> +		if (acpi_failure(status, "acpi_object_info failed"))
> +			return 1;
> +
> +		get_sysfs_path(new_child);
> +
> +		get_crs_object(new_child);
> +
> +		if (ind < indent)
> +			ind =3D indent;
> +		else if (ind > ind_end)
> +			ind =3D ind_end;
> +
> +		/*
> +		 * if we find _STR object we will stop here
> +		 * and save last visited child
> +		 */
> +		if (ACPI_SUCCESS(get_str_object(new_child))) {
> +			prk_info("%s%4.4s: has '_STR' '%s' path '%s'",
> +				ind, (char *)&dev_info->name, str_obj_result,
> +				(sysfs_path) ? sysfs_path : "no path");
> +			ind -=3D 4;
> +			start_parent =3D new_child;
> +			kfree(dev_info);
> +			break;
                        ^
                        Here as well

> +		}
> +		prk_info("%s%4.4s: path '%s'", ind, (char *)&dev_info->name,
> +			(sysfs_path) ? sysfs_path : "no path");
> =20
> -		printk(KERN_ALERT "TEST -- acpi_bus_get_power \n");
> -		status =3D acpi_bus_get_power(next_child_handle, &state);
> -		if (status)
> -			printk(KERN_ALERT "Error reading power state \n");
> +		ind -=3D 4;
> +		parent =3D new_child;
> +		child =3D 0;
> +		kfree(dev_info);
> +	}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_driver_data \n");
> +	return 0;
> +}
> =20

There is also wrong line with:

 *  FILE        : LtpAcpiCmds.c

left in the ltp_acpi_cmds.c. Please remove it as well.


The rest looks very good to me.

(Don't forget to send a patch to add it to build and runtest file with
 next version.)

--=20
Cyril Hrubis
chrubis@suse.cz


--===============3168625033320716362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
--===============3168625033320716362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3168625033320716362==--
