Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgHoP-0001Q2-3R
	for ltp-list@lists.sourceforge.net; Tue, 12 Nov 2013 17:31:37 +0000
Date: Tue, 12 Nov 2013 18:31:19 +0100
From: chrubis@suse.cz
Message-ID: <20131112173119.GC27040@rei>
References: <1383734526-29412-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1383734526-29412-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] device-drivers: acpi: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5862055760313822766=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============5862055760313822766==
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
>  testcases/kernel/device-drivers/acpi/LtpAcpi.h     |  120 +--
>  testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c |  922 +++++++++---=
--------

Can you get rid of the MixedCase filenames as well?

Ideally in a follow up patch (and use git mv).

> --- a/testcases/kernel/device-drivers/acpi/LtpAcpi.h
> +++ b/testcases/kernel/device-drivers/acpi/LtpAcpi.h
> @@ -1,97 +1,35 @@
>  /*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserve=
d.
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or mo=
dify
> - *   it under the terms of the GNU General Public License as published=
 by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA
> - */
> -
> -/*
> - *  FILE        : LtpAcpi.h
> - *  DESCRIPTION :
> - *  HISTORY:
> - *    06/09/2003 Initial creation mridge@us.ibm.com
> - *      -Ported
> - *  updated - 01/09/2005 Updates from Intel to add functionality
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation=
,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
> =20
> -#define ACPI_LTP_TEST_COMPONENT	        	0x00020999
> -#define ACPI_LTP_TEST_CLASS		        	"ltp_test"
> -#define ACPI_LTP_TEST_HID 		        	"ACPI0999"
> -#define ACPI_LTP_TEST_DRIVER_NAME		    "ACPI LTP Test Driver"
> -#define ACPI_LTP_TEST_DEVICE_NAME	    	"LTP Test"
> -#define ACPI_LTP_TEST_FILE_STATE    		"state"
> -#define ACPI_LTP_TEST_NOTIFY_STATUS		    0x80
> -#define ACPI_LTP_TEST_STATUS_OFFLINE		0x00
> -#define ACPI_LTP_TEST_STATUS_ONLINE	    	0x01
> -#define ACPI_LTP_TEST_STATUS_UNKNOWN		0xFF
> -#define _COMPONENT		ACPI_LTP_TEST_COMPONENT
> -#define ACPI_TLP_TEST_MODULE_NAME		("acpi_ltp_test")
> -#define ACPI_NS_SYSTEM_BUS          "_SB_"
> -#define ACPI_BATTERY_FORMAT_BIF	"NNNNNNNNNSSSS"
> -#define ACPI_BATTERY_FORMAT_BST	"NNNN"
> -
> -
> -#define ACPI_TYPE_ANY                   0x00
> -#define ACPI_TYPE_INTEGER               0x01  /* Byte/Word/Dword/Zero/=
One/Ones */
> -#define ACPI_TYPE_STRING                0x02
> -#define ACPI_TYPE_BUFFER                0x03
> -#define ACPI_TYPE_PACKAGE               0x04  /* byte_const, multiple =
data_term/Constant/super_name */
> -#define ACPI_TYPE_FIELD_UNIT            0x05
> -#define ACPI_TYPE_DEVICE                0x06  /* Name, multiple Node *=
/
> -#define ACPI_TYPE_EVENT                 0x07
> -#define ACPI_TYPE_METHOD                0x08  /* Name, byte_const, mul=
tiple Code */
> -#define ACPI_TYPE_MUTEX                 0x09
> -#define ACPI_TYPE_REGION                0x0A
> -#define ACPI_TYPE_POWER                 0x0B  /* Name,byte_const,word_=
const,multi Node */
> -#define ACPI_TYPE_PROCESSOR             0x0C  /* Name,byte_const,Dword=
_const,byte_const,multi nm_o */
> -#define ACPI_TYPE_THERMAL               0x0D  /* Name, multiple Node *=
/
> -#define ACPI_TYPE_BUFFER_FIELD          0x0E
> -#define ACPI_TYPE_DDB_HANDLE            0x0F
> -#define ACPI_TYPE_DEBUG_OBJECT          0x10
> -
> -#define ACPI_TYPE_EXTERNAL_MAX          0x10
> -#define LTPMAJOR                        252
> -
> -/* Use 'k' as magic number */
> -#define LTPACPI_IOC_MAGIC  'k'
> -#define TOMINOR(x) ((x & 3) | ((x & 4) << 5))
> -
> -
> -#define DEV_PATH                            "/dev"
> -#define LTP_ACPI_DIR_NAME                   ""
> -#define LTP_ACPI_DEV_NAME                   "LTP"
> -#define LTP_ACPI_DEV_NODE_PATH              DEV_PATH "/"
> -#define LTP_ACPI_DEVICE_NAME                DEV_PATH "/"  LTP_ACPI_DEV=
_NAME
> -#define MINOR_SHIFT_BITS 3
> -#define MAX_PARTITIONS 8                    /* partition 0 + 7 more po=
ssible due to 3 bit partition number field */
> -#define	MAX_NUM_DISKS 3                   /* number of real devices */
> -
> -#define MPDEV_FLAG_CLEAR 0
> -#define MPDEV_FLAG_SET   1
> -
> -typedef struct _ltpdev_cmd {
> -    u_int32_t     cmd;           // input - 0=3D=3Drecover, 1=3D=3Dfai=
l
> -    u_int32_t     status;        // ouput - 0=3D=3Dsuccess
> -} ltpdev_cmd_t;
> -
> -typedef enum ltpdev_ioctl_cmds_s {
> -	/* version commands */
> -	LTP_IOCTL_NUMBER =3D 0x5500
> -} ltpdev_ioctl_cmds_t;
> -
> -// define the ioctl cmds
> -#define LTPDEV_CMD       _IOR( LTPMAJOR, LTP_IOCTL_NUMBER, ltpdev_cmd_=
t **)
> -
> +#define ACPI_TEST_NAME		"ltp_acpi_test"
> +
> +enum ACPI_TEST_CASES {
> +	ACPI_INIT =3D 0,
> +	ACPI_TRAVERSE,
> +	/* must be triggered after ACPI_TRAVERSE test-case */
> +	ACPI_GET_STR_METHOD,
> +	ACPI_NOTIFY_HANDLER,
> +	ACPI_EVENT_HANDLER,
> +	ACPI_GLOBAL_LOCK,
> +	ACPI_TEST_BUS,
> +	ACPI_TEST_RESOURCES,
> +	ACPI_SLEEP_TEST,
> +	ACPI_TEST_REGISTER,
> +	ACPI_TEST_DEV_CALLBACK,
> +	ACPI_TC_NUM
> +};
> diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c b/testc=
ases/kernel/device-drivers/acpi/LtpAcpiCmds.c
> index 26fcc15..b03f2ae 100644
> --- a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
> +++ b/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
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
> @@ -40,477 +39,390 @@
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
> +#include <linux/dmi.h>
> +#include <linux/nls.h>
> =20
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
> -
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
> +#include "LtpAcpi.h"
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
> +static int acpi_failure(acpi_status status, int *err, const char *name=
)
>  {
> -	printk(KERN_ALERT "ltpdev_open \n");
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, name));
> +		*err =3D 1;
> +		return 1;
> +	}
>  	return 0;
>  }


Hmm, I don't like that the status is both returned and set to the err
variable. It forces you to add dummy variables into the code of the
caller, acpi_traverse_from_root() for example.

What is wrong with:

	err |=3D acpi_error(status, "err msg");
	if (err)
		return err;

or with:

	return acpi_error(status, "err msg");

Or use acpi_error() only to print errors and use status directly...

> -static int ltpdev_release(struct gendisk *disk, fmode_t mode)
> +static int acpi_get_info(acpi_handle h, int *type, char name[])
>  {
> +	int err =3D 0;
> +	struct acpi_device_info *dev_info;
> +	acpi_status status;
> +	status =3D acpi_get_object_info(h, &dev_info);
> =20
> -	printk(KERN_ALERT "ltpdev_release \n");
> -	return 0;
> -}
> +	if (acpi_failure(status, &err, "acpi_object_info failed"))
> +		return err;
> =20
> -static u32 ltp_test_power_button_ev_handler(void *context)
> -{
> -	printk(KERN_ALERT "ltp_test_power_button_ev_handler \n");
> -	return 1;
> -}
> +	*type =3D dev_info->type;
> =20
> -static u32 ltp_test_sleep_button_ev_handler(void *context)
> -{
> -	printk(KERN_ALERT "ltp_test_sleep_button_ev_handler \n");
> -	return 1;
> +	sprintf(name, "%4.4s", (char *)&dev_info->name);

It would be easier just to return the dev_info and free it later in the
caller, that would save us the need to copy the data. Given that both
the functions that use this one have just one return on the codepath
after this function is called all that would be needed is just one free
before the return.

	dev_info =3D acpi_get_info(handle);
	if (!dev_info)
		return error;

	kfree(dev_info);
	return success;

> +	kfree(dev_info);
> +	return err;
>  }
> =20
> -static int ltpdev_ioctl(struct block_device *bdev, fmode_t mode, unsig=
ned cmd,
> -			unsigned long arg)
> +static int level;
> +static char ind[64];
> +
> +static void set_indent(void)
>  {
> -	acpi_status status;
> -//      acpi_handle        sys_bus_handle;
> -	acpi_handle start_handle =3D 0;
> -	acpi_handle parent_handle;
> -	acpi_handle child_handle;
> -	acpi_handle next_child_handle;
> -	acpi_status level;
> -	struct acpi_ec *ec;
> -	struct acpi_device *device;
> -	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	memset(ind, 0x20, sizeof(ind));
> +	ind[level * 4] =3D '\0';
> +}

Are you sure that the maximal level in the ACPI structure is <=3D 15?

What about sanity check for a level value in the acpi_traverse() before
you call it recursively?

Hmm and you don't have to do memset on each set_indent(), if you create
a static ind array full of spaces with terminating null and use pointer
to a string to point inside of the array.

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
> +/* points to the string of the first found object _STR */
> +static char *str_obj_result;
> =20
> -	u32 i, bm_status;
> -	u8 type_a, type_b;
> -	u32 global_lock =3D 0;
> -	int state =3D 0;
> +/* first found device with _CRS */
> +static acpi_handle res_handle;
> =20
> -    /*****************************************************************=
************/
> +static int acpi_traverse(acpi_handle parent, acpi_handle child)
> +{
> +	int err =3D 0, type, res =3D 0;
> +	acpi_status status;
> +	acpi_handle temp =3D 0;
> +	acpi_handle new_start =3D 0, next_child =3D 0;
> +	union acpi_object *str_obj;
> +	char name[5], *buf =3D NULL;
> +	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +	status =3D acpi_get_next_object(ACPI_TYPE_DEVICE,
> +		parent, child, &next_child);
> +
> +	if (status !=3D 0) {
> +		--level;
> +		set_indent();
> +		return 0;
> +	}
> =20
> -	printk(KERN_ALERT "ltpdev_ioctl \n");
> -	switch (cmd) {
> -	case LTPDEV_CMD:
> +	err |=3D acpi_get_info(next_child, &type, name);
> +	set_indent();
> =20
> -		parent_handle =3D start_handle;
> -		child_handle =3D 0;
> -		level =3D 1;
> -		test_iteration++;
> +	if (!res_handle) {
> +		status =3D acpi_get_handle(next_child, METHOD_NAME__CRS, &temp);
> +		if (ACPI_SUCCESS(status))
> +			res_handle =3D next_child;
> +	}
> =20
> -		printk(KERN_ALERT
> -		       "-- IOCTL called to start ACPI tests -- Iteration:%d\n",
> -		       test_iteration);
> +	status =3D acpi_get_handle(next_child, "_STR", &temp);
> +	if (ACPI_SUCCESS(status) && !acpi_evaluate_object(next_child,
> +		"_STR", NULL, &buffer)) {
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_handle \n");
> +		str_obj =3D buffer.pointer;
> =20
> -		status =3D acpi_get_handle(0, ACPI_NS_SYSTEM_BUS, &parent_handle);
> +		buf =3D kmalloc(str_obj->buffer.length / 2, GFP_KERNEL);

Check for kmalloc() failure?

> +		res =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> +			str_obj->buffer.length, UTF16_LITTLE_ENDIAN, buf,
> +			str_obj->buffer.length / 2);
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_object_info \n");
> +		buf[res] =3D '\0';
> +		prk_info("%s%s: type %d has '_STR': buf: '%s'",
> +			ind, name, type, buf);
> =20
> -		status =3D acpi_get_object_info(parent_handle, &buffer);
> +		if (!str_obj_result)
> +			str_obj_result =3D buf;
> +		else
> +			kfree(buf);
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_next_object \n");
> +		kfree(str_obj);
> =20
> -		status =3D acpi_get_next_object(ACPI_TYPE_ANY, parent_handle,
> -					      child_handle, &next_child_handle);
> +	} else {
> +		prk_info("%s%s: type %d", ind, name, type);
> +	}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_parent \n");
> +	++level;
> +	err |=3D acpi_traverse(next_child, new_start);
> =20
> -		status =3D acpi_get_parent(parent_handle, &parent_handle);
> +	child =3D next_child;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_evaluate_object \n");
> +	return acpi_traverse(parent, child);
> +}
> =20
> -		status =3D acpi_evaluate_object(parent_handle, "_ON", NULL, NULL);
> +static int acpi_traverse_from_root(void)
> +{
> +	int err, type;
> +	char name[5];
> +	acpi_status status;
> +	acpi_handle parent =3D 0, child =3D 0;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_table \n");
> +	status =3D acpi_get_handle(NULL, ACPI_NS_ROOT_PATH, &parent);
> =20
> -//        status =3D acpi_get_table(ACPI_TABLE_RSDP, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_FADT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_FACS, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_PSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_SSDT, 1, &dsdt);
> -//        status =3D acpi_get_table(ACPI_TABLE_XSDT, 1, &dsdt);
> +	if (acpi_failure(status, &err, "acpi_get_handle"))
> +		return 1;
> =20
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_get_firmware_table \n");
> +	if (acpi_get_info(parent, &type, name))
> +		return 1;
> =20
> -		status =3D
> -		    acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
> -					    (struct acpi_table_header **)&dsdt);
> -#endif
> +	prk_info("start from %s", name);
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
> +	return acpi_traverse(parent, child);
> +}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_bus_get_power \n");
> -		status =3D acpi_bus_get_power(next_child_handle, &state);
> -		if (status)
> -			printk(KERN_ALERT "Error reading power state \n");
> +/* first found device with _STR */
> +static acpi_handle dev_handle;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_driver_data \n");
> +static int acpi_init(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> +	acpi_handle parent_handle;
> =20
> -		ec =3D acpi_driver_data(device);
> +	struct acpi_device_info *dev_info;
> =20
> -		if (!ec) {
> -			printk(KERN_ALERT "Failure getting device data \n");
> -		} else {
> +	prk_alert("TEST -- acpi_get_handle ");
> +	status =3D acpi_get_handle(NULL, "\\_SB", &parent_handle);
> +	acpi_failure(status, &err, "acpi_get_handle");
> =20
> -			printk(KERN_ALERT
> -			       "TEST -- acpi_install_gpe_handler \n");
> -			ec->status_addr =3D ec->command_addr;
> -			status =3D
> -			    acpi_install_gpe_handler(device, ec->gpe_bit,
> -						     ACPI_GPE_EDGE_TRIGGERED,
> -						     &acpi_ec_gpe_handler, ec);
> -/*
> -            status =3D acpi_install_address_space_handler (ACPI_ROOT_O=
BJECT,
> -                    ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
> -                    &acpi_ec_space_setup, ec);
> -
> -            if (status) {
> -                printk(KERN_ALERT "Failed installing address space han=
dler \n");
> -            }
> -
> -            acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
> -                ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
> -*/
> -			printk(KERN_ALERT "TEST -- acpi_remove_gpe_handler \n");
> -			acpi_remove_gpe_handler(device, ec->gpe_bit,
> -						&acpi_ec_gpe_handler);
> -		}
> +	/* get first device on SYS bus, it will be used in other tests */
> +	while (acpi_get_next_object(ACPI_TYPE_DEVICE,
> +		parent_handle, 0, &dev_handle) =3D=3D 0) {
> +		parent_handle =3D dev_handle;
> +	}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_current_resources \n");
> -		status =3D acpi_get_current_resources(next_child_handle, &buffer);
> +	status =3D acpi_get_object_info(dev_handle, &dev_info);
> +	if (!acpi_failure(status, &err, "acpi_object_info failed")) {
> +		prk_alert("ACPI object name %4.4s, type %d",
> +			(char *)&dev_info->name,
> +			dev_info->type);
> +		kfree(dev_info);
> +	}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_current_resources %d\n",
> -			       status);
> -		}
> -#ifdef ACPI_FUTURE_USAGE
> -		printk(KERN_ALERT "TEST -- acpi_get_possible_resources \n");
> -		status =3D
> -		    acpi_get_possible_resources(next_child_handle, &buffer);
> +	prk_alert("TEST -- acpi_get_parent ");
> +	status =3D acpi_get_parent(dev_handle, &parent_handle);
> +	acpi_failure(status, &err, "acpi_get_parent failed");
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_possible_resources %d\n",
> -			       status);
> -		}
> -#endif
> +	return err;
> +}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_walk_resources \n");
> -		status =3D acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
> -					     acpi_ec_io_ports, ec);
> +/*
> + * acpi_bus_notify
> + * ---------------
> + * Callback for all 'system-level' device notifications (values 0x00-0=
x7F).
> + */
> +static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> +{
> +	prk_alert("Register ACPI Bus Notify callback function");
> +}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed walk_resources %d\n", status);
> -		}
> +static int acpi_test_notify_handler(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> =20
> -		printk(KERN_ALERT "TEST -- acpi_evaluate_integer \n");
> -		status =3D
> -		    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
> -					  &ec->gpe_bit);
> -		if (status)
> -			printk(KERN_ALERT
> -			       "Error obtaining GPE bit assignment\n");
> -
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_get_timer \n");
> -		status =3D acpi_get_timer(&total_ticks);
> -
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_timer %d\n", status);
> -		} else {
> -			printk(KERN_ALERT "get_timer -- total_ticks %d\n",
> -			       total_ticks);
> -		}
> +	prk_alert("TEST -- acpi_install_notify_handler");
> =20
> -		start_ticks =3D 20;
> -		stop_ticks =3D 30;
> +	status =3D acpi_install_notify_handler(dev_handle,
> +		ACPI_SYSTEM_NOTIFY, &acpi_bus_notify, NULL);
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_timer_duration \n");
> -		status =3D
> -		    acpi_get_timer_duration(start_ticks, stop_ticks,
> -					    &total_ticks);
> +	if (ACPI_SUCCESS(status)) {
> +		prk_alert("TEST -- acpi_remove_notify_handler");
> +		status =3D acpi_remove_notify_handler(dev_handle,
> +			ACPI_SYSTEM_NOTIFY, &acpi_bus_notify);
> +		acpi_failure(status, &err, "acpi_remove_notify_handler");
> +	} else if (status !=3D AE_ALREADY_EXISTS) {
> +		acpi_failure(status, &err, "acpi_install_notify_handler");
> +	}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_timer_duration %d\n",
> -			       status);
> -		} else {
> -			printk(KERN_ALERT "get_timer_duration total_ticks %d\n",
> -			       total_ticks);
> -		}
> -#endif
> +	return err;
> +}
> =20
> -		for (i =3D 0; i < ACPI_S_STATE_COUNT; i++) {
> -			printk(KERN_ALERT
> -			       "TEST -- acpi_get_sleep_type_data \n");
> -			status =3D acpi_get_sleep_type_data(i, &type_a, &type_b);
> -
> -			if (status) {
> -				printk(KERN_ALERT
> -				       "Failed get_sleep_type_data %d\n",
> -				       status);
> -			} else {
> -				printk(KERN_ALERT
> -				       "get_sleep_type_data [%d] type_a:%d type_b:%d\n",
> -				       i, type_a, type_b);
> -			}
> -		}
> +static u32 ltp_test_power_button_ev_handler(void *context)
> +{
> +	prk_alert("ltp_test_power_button_ev_handler");
> +	return 1;
> +}
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_register \n");
> +static u32 ltp_test_sleep_button_ev_handler(void *context)
> +{
> +	prk_alert("ltp_test_sleep_button_ev_handler");
> +	return 1;
> +}
> =20
> -/*
> - * ACPICA: Remove obsolete Flags parameter.
> - * http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3Dd8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
> - *
> - */
> -		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
> +static int acpi_test_event_handler(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> =20
> -		if (!bm_status) {
> -			printk(KERN_ALERT "Failed get_register [%d]\n",
> -			       bm_status);
> -		} else {
> -			printk(KERN_ALERT "get_register [%d] \n", bm_status);
> -		}
> +	prk_alert("TEST -- acpi_install_fixed_event_handler");
> +	status =3D acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +		ltp_test_power_button_ev_handler, NULL);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		prk_alert("TEST -- acpi_remove_fixed_event_handler");
> +		status =3D acpi_remove_fixed_event_handler(
> +			ACPI_EVENT_POWER_BUTTON,
> +			ltp_test_power_button_ev_handler);
> +		acpi_failure(status, &err, "remove fixed event handler");
> +	} else if (status !=3D AE_ALREADY_EXISTS) {
> +		acpi_failure(status, &err, "install fixed event handler");
> +	}
> =20
> -//        Puts system to sleep, permenately !!!
> -//        status =3D acpi_enter_sleep_state(ACPI_STATE_S1);
> +	prk_alert("TEST -- acpi_install_fixed_event_handler");
> +	status =3D acpi_install_fixed_event_handler(ACPI_EVENT_RTC,
> +		ltp_test_sleep_button_ev_handler, NULL);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		prk_alert("TEST -- acpi_remove_fixed_event_handler");
> +		status =3D acpi_remove_fixed_event_handler(
> +			ACPI_EVENT_RTC,
> +			ltp_test_sleep_button_ev_handler);
> +		acpi_failure(status, &err, "remove fixed event handler");
> +	} else if (status !=3D AE_ALREADY_EXISTS) {
> +		acpi_failure(status, &err, "install fixed event handler");
> +	}
> =20
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
> -		status =3D acpi_get_system_info(&buffer);
> +	return err;
> +}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_system_info %d\n",
> -			       status);
> -		} else {
> -			printk(KERN_ALERT
> -			       "get_system_info buffer.length:%d buffer.pointer:%p\n",
> -			       buffer.length, buffer.pointer);
> +#ifndef ACPI_EC_UDELAY_GLK
> +#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
> +#endif
> =20
> -			acpi_os_printf("os_printf OK %d\n", status);
> +static int acpi_global_lock(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> +	u32 global_lock =3D 0;
> =20
> -			if (buffer.pointer) {
> -				acpi_os_free(buffer.pointer);
> -			}
> -		}
> -#endif
> +	prk_alert("TEST -- acpi_acquire_global_lock ");
> +	status =3D acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock)=
;
> +	acpi_failure(status, &err, "acpi_acquire_global_lock");
> =20
> -		printk(KERN_ALERT "TEST -- acpi_get_devices \n");
> -		status =3D
> -		    acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001",
> -				     NULL);
> +	prk_alert("TEST -- acpi_release_global_lock ");
> +	status =3D acpi_release_global_lock(global_lock);
> +	acpi_failure(status, &err, "acpi_release_global_lock");
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_devices %d\n", status);
> -		}
> -//        status =3D acpi_os_create_semaphore(1, 1, &tmp_handle);
> +	return err;
> +}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed os_create_semaphore %d\n",
> -			       status);
> -		} else {
> -			printk(KERN_ALERT
> -			       "os_create_semaphore OK, no deleteing %d\n",
> -			       status);
> -//            acpi_os_delete_semaphore(tmp_handle);
> +static int acpi_test_bus(void)
> +{
> +	int state =3D 0, err =3D 0;
> +	acpi_status status;
> +	acpi_handle bus_handle;
> +	struct acpi_device *device;
> =20
> -		}
> +	status =3D acpi_get_handle(NULL, "\\_SB", &bus_handle);
> +	acpi_failure(status, &err, "acpi_get_handle");
> =20
> -#if 0
> -		printk(KERN_ALERT "TEST -- acpi_get_system_info \n");
> -		status =3D acpi_get_system_info(&batt_buffer);
> +	prk_alert("TEST -- acpi_bus_get_device");
> +	status =3D acpi_bus_get_device(bus_handle, &device);
> +	if (!acpi_failure(status, &err, "acpi_bus_get_device")) {
> +		prk_alert("TEST -- acpi_bus_update_power ");
> +		status =3D acpi_bus_update_power(device->handle, &state);
> +		if (!acpi_failure(status, &err, "error reading power state"))
> +			prk_info("acpi bus power state is %d", state);
> +	}
> =20
> -		if (status) {
> -			printk(KERN_ALERT "Failed get_system_info %d\n",
> -			       status);
> -		} else {
> -			printk(KERN_ALERT
> -			       "get_system_info buffer.length:%d buffer.pointer:%p\n",
> -			       buffer.length, buffer.pointer);
> +	return err;
> +}
> =20
> -			package =3D (union acpi_object *)batt_buffer.pointer;
> +static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
> +	void *context)
> +{
> +	return 0;
> +}
> =20
> -			/* Extract Package Data */
> +static int acpi_test_resources(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> =20
> -			printk(KERN_ALERT "TEST -- acpi_extract_package \n");
> -			status =3D acpi_extract_package(package, &format, &data);
> +	/* skip if we don't find device with _CRC */
> +	if (res_handle =3D=3D 0)
> +		return 0;
> =20
> -			data.pointer =3D kmalloc(data.length, GFP_KERNEL);
> +	prk_alert("TEST -- acpi_get_current_resources");
> +	status =3D acpi_get_current_resources(res_handle, &buffer);
> +	acpi_failure(status, &err, "failed get_current_resources");
> =20
> -			if (!data.pointer) {
> -				printk(KERN_ALERT
> -				       "Failed getting memory kalloc \n");
> -			} else {
> -				memset(data.pointer, 0, data.length);
> +#ifdef ACPI_FUTURE_USAGE
> +	prk_alert("TEST -- acpi_get_possible_resources");
> +	status =3D acpi_get_possible_resources(res_handle, &buffer);
> +	acpi_failure(status, &err, "get_possible_resources"));
                                                            ^
                    This closing parenthesis was not opened.
> +#endif
> =20
> -				printk(KERN_ALERT
> -				       "TEST -- acpi_extract_package \n");
> -				status =3D
> -				    acpi_extract_package(package, &format,
> -							 &data);
> +	prk_alert("TEST -- acpi_walk_resources ");
> +	status =3D acpi_walk_resources(res_handle, METHOD_NAME__CRS,
> +		acpi_ec_io_ports, NULL);
> +	acpi_failure(status, &err, "Failed walk_resources");
> =20
> -				kfree(data.pointer);
> -			}
> +	return err;
> +}
> =20
> -//            acpi_os_free(buffer.pointer);
> +static int acpi_sleep_test(void)
> +{
> +	int err =3D 0;
> +	acpi_status status;
> +	u32 i;
> +	u8 type_a, type_b;
> +	prk_alert("TEST -- acpi_get_sleep_type_data ");
> +
> +	for (i =3D 0; i < ACPI_S_STATE_COUNT; ++i) {
> +		status =3D acpi_get_sleep_type_data(i, &type_a, &type_b);
> +		if (ACPI_SUCCESS(status)) {
> +			prk_info("get_sleep_type_data S%d a:%d b:%d",
> +				i, type_a, type_b);
> +		} else if (status !=3D AE_NOT_FOUND) {
> +			err |=3D 1;
>  		}
> -#endif
> +	}
> +
> +	return err;
> +}
> =20
> -		printk(KERN_ALERT
> -		       "-- IOCTL ACPI tests Complete -- Iteration:%d\n",
> -		       test_iteration);
> +static int acpi_test_register(void)
> +{
> +	int i, err =3D 0;
> +	u32 val;
> +	acpi_status status;
> =20
> -		break;
> +	prk_alert("TEST -- acpi_read_bit_register");
> +	/*
> +	 * ACPICA: Remove obsolete Flags parameter.
> +	 * http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git=
;
> +	 * a=3Dcommitdiff;h=3Dd8c71b6d3b21cf21ad775e1cf6da95bf87bd5ad4
> +	 *
> +	 * ACPICA: Rename ACPI bit register access functions
> +	 * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> +	 * commit/?id=3D50ffba1bd3120b069617455545bc27bcf3cf7579
> +	 */
> +	for (i =3D 0; i < ACPI_NUM_BITREG; ++i) {
> +		status =3D acpi_read_bit_register(i, &val);
> +		if (!acpi_failure(status, &err, "acpi_read_bit_register"))
> +			prk_alert("get register: %02x val: %04x", i, val);
>  	}
> =20
> -	return 0;
> +	return err;
>  }
> =20
>  static acpi_status ltp_get_dev_callback(acpi_handle obj, u32 depth,
> -					void *context, void **ret)
> +	void *context, void **ret)
>  {
>  	char *name =3D context;
>  	char fullname[20];
> @@ -521,154 +433,136 @@ static acpi_status ltp_get_dev_callback(acpi_ha=
ndle obj, u32 depth,
>  	 * separately in PCI space.
>  	 */
>  	sprintf(fullname, "%s SBA", name);
> -	printk(KERN_ALERT "get_dev_callback SBA name %s \n", fullname);
> +	prk_info("get_dev_callback SBA name %s", fullname);
>  	sprintf(fullname, "%s IOC", name);
> -	printk(KERN_ALERT "get_dev_callback IOC name %s \n", fullname);
> +	prk_info("get_dev_callback IOC name %s", fullname);
> =20
>  	return 0;
>  }
> =20
> -/**
> - * acpi_bus_notify
> - * ---------------
> - * Callback for all 'system-level' device notifications (values 0x00-0=
x7F).
> - */
> -static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> +static int acpi_test_dev_callback(void)
>  {
> +	int err =3D 0;
> +	acpi_status status;
> =20
> -	printk(KERN_ALERT "Register ACPI Bus Notify callback function \n");
> +	prk_alert("TEST -- acpi_get_devices ");
> +	status =3D acpi_get_devices(NULL, ltp_get_dev_callback, "LTP0001", NU=
LL);
> +	acpi_failure(status, &err, "acpi_get_devices");
> =20
> +	return err;
>  }
> =20
> -static u32 acpi_ec_gpe_handler(void *context)
> -{
> -	printk(KERN_ALERT "Register ACPI ec_gpe_handler callback function \n"=
);
> -	return 1;
> -}
> +static int current_test_case;
> +static int test_result;
> =20
> -static acpi_status acpi_ec_io_ports(struct acpi_resource *resource,
> -				    void *context)
> +static void device_release(struct device *dev)
>  {
> -	return 0;
> +	prk_info("device released");
>  }
> =20
> -#if 0
> -static acpi_status acpi_ec_space_handler(u32 function,
> -					 acpi_physical_address address,
> -					 u32 bit_width,
> -					 acpi_integer * value,
> -					 void *handler_context,
> -					 void *region_context)
> -{
> -	int result =3D 0;
> -	struct acpi_ec *ec =3D NULL;
> -	u32 temp =3D 0;
> -
> -	ACPI_FUNCTION_TRACE("acpi_ec_space_handler");
> -
> -	if ((address > 0xFF) || (bit_width !=3D 8) || !value || !handler_cont=
ext)
> -		return_VALUE(AE_BAD_PARAMETER);
> -
> -	ec =3D (struct acpi_ec *)handler_context;
> -
> -	switch (function) {
> -	case ACPI_READ:
> -		result =3D 0;
> -		*value =3D (acpi_integer) temp;
> -		break;
> -	case ACPI_WRITE:
> -		result =3D 0;
> -		break;
> -	default:
> -		result =3D -EINVAL;
> -		break;
> -	}
> +static struct device tdev =3D {
> +	.init_name	=3D ACPI_TEST_NAME,
> +	.release	=3D device_release,
> +};
> =20
> -	switch (result) {
> -	case -EINVAL:
> -		return_VALUE(AE_BAD_PARAMETER);
> -		break;
> -	case -ENODEV:
> -		return_VALUE(AE_NOT_FOUND);
> -		break;
> -	case -ETIME:
> -		return_VALUE(AE_TIME);
> -		break;
> +/* print test result to sysfs file */
> +static ssize_t sys_result(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	switch (current_test_case) {
> +	case ACPI_GET_STR_METHOD:
> +		return scnprintf(buf, PAGE_SIZE, "%s",
> +			(!str_obj_result) ? "null" : str_obj_result);

Why not str_obj_result ? str_obj_result : "null" ;)

>  	default:
> -		return_VALUE(AE_OK);
> +		return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
>  	}
> -
>  }
> +static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
> =20
> -static acpi_status acpi_ec_space_setup(acpi_handle region_handle,
> -				       u32 function,
> -				       void *handler_context,
> -				       void **return_context)
> +static ssize_t sys_tcase(struct device *dev,
> +	struct device_attribute *attr,  const char *buf, size_t count)
>  {
> -	/*
> -	 * The EC object is in the handler context and is needed
> -	 * when calling the acpi_ec_space_handler.
> -	 */
> -	*return_context =3D handler_context;
> +	sscanf(buf, "%d", &current_test_case);
> +	prk_info("test-case %d", current_test_case);
> +
> +	switch (current_test_case) {
> +	case ACPI_INIT:
> +		test_result =3D acpi_init();
> +	break;
> +	case ACPI_TRAVERSE:
> +		test_result =3D acpi_traverse_from_root();
> +	break;
> +	case ACPI_NOTIFY_HANDLER:
> +		test_result =3D acpi_test_notify_handler();
> +	break;
> +	case ACPI_EVENT_HANDLER:
> +		test_result =3D acpi_test_event_handler();
> +	break;
> +	case ACPI_GLOBAL_LOCK:
> +		test_result =3D acpi_global_lock();
> +	break;
> +	case ACPI_TEST_BUS:
> +		test_result =3D acpi_test_bus();
> +	break;
> +	case ACPI_TEST_RESOURCES:
> +		test_result =3D acpi_test_resources();
> +	break;
> +	case ACPI_SLEEP_TEST:
> +		test_result =3D acpi_sleep_test();
> +	break;
> +	case ACPI_TEST_REGISTER:
> +		test_result =3D acpi_test_register();
> +	break;
> +	case ACPI_TEST_DEV_CALLBACK:
> +		test_result =3D acpi_test_dev_callback();
> +	break;
> +	}
> =20
> -	return AE_OK;
> +	return count;
>  }
> -#endif
> +static DEVICE_ATTR(tcase, S_IWUSR, NULL, sys_tcase);
> =20
>  int init_module(void)
>  {
> -	int result;
> -
> -	printk(KERN_ALERT "ltpdev_init_module \n");
> -
> -	result =3D register_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
> -
> -	printk(KERN_ALERT "LTP ACPI: register_blkdev result=3D%d major %d\n",
> -	       result, ltp_acpi_major);
> +	int err =3D 0;
> +	prk_info("Starting module");
> =20
> -	if (result < 0) {
> -		printk(KERN_ALERT "LTP ACPI: can't get major %d\n",
> -		       ltp_acpi_major);
> -		return result;
> +	err =3D device_register(&tdev);
> +	if (err) {
> +		prk_err("Unable to register device");
> +		goto err0;
>  	}
> -//    if (ltp_acpi_major =3D=3D 0)
> -//      ltp_acpi_major =3D result; /* dynamic */
> +	prk_info("device registered");
> =20
> -	gd_ptr =3D kmalloc(sizeof(struct gendisk *), GFP_KERNEL);
> -
> -	if (!gd_ptr) {
> -		printk(KERN_ALERT "ERROR getting memory !!!\n");
> -		return 0;
> +	err =3D device_create_file(&tdev, &dev_attr_result);
> +	if (err) {
> +		prk_err("Can't create sysfs file 'result'");
> +		goto err1;
>  	}
> =20
> -	gd_ptr =3D alloc_disk(1);
> -
> -	printk(KERN_ALERT "gd_ptr after alloc =3D %p \n", gd_ptr);
> -
> -	gd_ptr->major =3D ltp_acpi_major;
> -	gd_ptr->first_minor =3D 0;
> -	gd_ptr->fops =3D &blkops;
> -//    gd_ptr->minor_shift =3D MINOR_SHIFT_BITS;
> -	gd_ptr->driverfs_dev =3D NULL;
> -//    gd_ptr->disk_de =3D NULL;
> -	gd_ptr->flags =3D genhd_flags;
> -
> -	sprintf(gd_ptr->disk_name, LTP_ACPI_DEV_NAME);
> -
> -	add_disk(gd_ptr);
> +	err =3D device_create_file(&tdev, &dev_attr_tcase);
> +	if (err) {
> +		prk_err(": Can't create sysfs file 'tc'");
> +		goto err2;
> +	}
> =20
>  	return 0;
> +
> +err2:
> +	device_remove_file(&tdev, &dev_attr_result);
> +err1:
> +	device_unregister(&tdev);
> +err0:
> +	return err;
>  }
> =20
>  void cleanup_module(void)
>  {
> +	prk_info("Unloading module\n");
> =20
> -	printk(KERN_ALERT "Exiting module and cleaning up \n");
> -
> -	put_disk(gd_ptr);
> -
> -	del_gendisk(gd_ptr);
> -
> -	unregister_blkdev(ltp_acpi_major, LTP_ACPI_DEV_NAME);
> +	kfree(str_obj_result);
> =20
> +	device_remove_file(&tdev, &dev_attr_result);
> +	device_remove_file(&tdev, &dev_attr_tcase);
> +	device_unregister(&tdev);
>  }
> diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c b/testc=
ases/kernel/device-drivers/acpi/LtpAcpiMain.c
> deleted file mode 100644
> index c3e9c91..0000000
> --- a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
> +++ /dev/null
> @@ -1,159 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or mo=
dify
> - *   it under the terms of the GNU General Public License as published=
 by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA
> - */
> -
> -/*
> - *  FILE        : LtpAcpiMain.c
> - *  DESCRIPTION :
> - *  HISTORY:
> - *    06/09/2003 Initial creation mridge@us.ibm.com
> - *      -Ported
> - *  updated - 01/09/2005 Updates from Intel to add functionality
> - *
> - */
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <string.h>
> -#include <ctype.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <sys/ioctl.h>
> -#include <linux/kd.h>
> -#include <linux/errno.h>
> -
> -#include "LtpAcpi.h"
> -
> -int LTP_acpi_open_block_device(void);
> -
> -int ltp_block_dev_handle =3D 0;	/* handle to LTP Test block device */
> -
> -int main(int argc, char **argv)
> -{
> -
> -	ltpdev_cmd_t cmd =3D { 0, 0 };
> -	int rc;
> -
> -	printf("[%s] - Running test program\n", argv[0]);
> -
> -	rc =3D LTP_acpi_open_block_device();
> -
> -	if (!rc) {
> -
> -		ltp_block_dev_handle =3D open(LTP_ACPI_DEVICE_NAME, O_RDWR);
> -
> -		if (ltp_block_dev_handle < 0) {
> -			printf
> -			    ("ERROR: Open of device %s failed %d errno =3D %d\n",
> -			     LTP_ACPI_DEVICE_NAME, ltp_block_dev_handle, errno);
> -		} else {
> -			rc =3D ioctl(ltp_block_dev_handle, LTPDEV_CMD, &cmd);
> -
> -			printf("return from ioctl %d \n", rc);
> -		}
> -
> -	} else {
> -		printf("ERROR: Create/open block device failed\n");
> -	}
> -
> -	return 0;
> -}
> -
> -int LTP_acpi_open_block_device()
> -{
> -	dev_t devt;
> -	struct stat statbuf;
> -	int rc;
> -
> -	if (ltp_block_dev_handle =3D=3D 0) {
> -
> -		/* check for the /dev/LTPACPITest subdir, and create if it does not =
exist.
> -		 *
> -		 * If devfs is running and mounted on /dev, these checks will all pa=
ss,
> -		 * so a new node will not be created.
> -		 */
> -		devt =3D makedev(LTPMAJOR, 0);
> -
> -		rc =3D stat(LTP_ACPI_DEV_NODE_PATH, &statbuf);
> -
> -		if (rc) {
> -			if (errno =3D=3D ENOENT) {
> -				/* dev node does not exist. */
> -				rc =3D mkdir(LTP_ACPI_DEV_NODE_PATH,
> -					   (S_IFDIR | S_IRWXU | S_IRGRP |
> -					    S_IXGRP | S_IROTH | S_IXOTH));
> -			} else {
> -				printf
> -				    ("ERROR: Problem with LTP ACPI dev directory.  Error code from=
 stat() is %d\n\n",
> -				     errno);
> -			}
> -
> -		} else {
> -			if (!(statbuf.st_mode & S_IFDIR)) {
> -				rc =3D unlink(LTP_ACPI_DEV_NODE_PATH);
> -				if (!rc) {
> -					rc =3D mkdir(LTP_ACPI_DEV_NODE_PATH,
> -						   (S_IFDIR | S_IRWXU | S_IRGRP
> -						    | S_IXGRP | S_IROTH |
> -						    S_IXOTH));
> -				}
> -			}
> -		}
> -
> -		/*
> -		 * Check for the /dev/ltp-acpi/block_device node, and create if it d=
oes not
> -		 * exist.
> -		 */
> -		rc =3D stat(LTP_ACPI_DEVICE_NAME, &statbuf);
> -		if (rc) {
> -			if (errno =3D=3D ENOENT) {
> -				/* dev node does not exist */
> -				rc =3D mknod(LTP_ACPI_DEVICE_NAME,
> -					   (S_IFBLK | S_IRUSR | S_IWUSR |
> -					    S_IRGRP | S_IWGRP), devt);
> -			} else {
> -				printf
> -				    ("ERROR:Problem with LTP ACPI block device node directory.  Er=
ror code form stat() is %d\n\n",
> -				     errno);
> -			}
> -
> -		} else {
> -			/*
> -			 * /dev/ltp-acpi/block_device exists.  Check to make sure it is for=
 a
> -			 * block device and that it has the right major and minor.
> -			 */
> -			if ((!(statbuf.st_mode & S_IFBLK)) ||
> -			    (statbuf.st_rdev !=3D devt)) {
> -
> -				/* Recreate the dev node. */
> -				rc =3D unlink(LTP_ACPI_DEVICE_NAME);
> -				if (!rc) {
> -					rc =3D mknod(LTP_ACPI_DEVICE_NAME,
> -						   (S_IFBLK | S_IRUSR | S_IWUSR
> -						    | S_IRGRP | S_IWGRP), devt);
> -				}
> -			}
> -		}
> -
> -	}
> -
> -	return rc;
> -}
> diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/=
kernel/device-drivers/acpi/Makefile
> index afec680..b62eb0b 100644
> --- a/testcases/kernel/device-drivers/acpi/Makefile
> +++ b/testcases/kernel/device-drivers/acpi/Makefile
> @@ -1,34 +1,33 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved=
.
>  #
> -# Makefile for GCOV profiling kernel module
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> -#  1 Mar 2009 M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
> -#   - Updated for Linux kernel 2.6.28
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
>  #
> -
> -#KERNELDIR :=3D /usr/src/linux-2.5.64-gcov
> -EXTRA_CFLAGS :=3D -Wall -g -W -Wno-unused-parameter
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> =20
>  ifneq ($(KERNELRELEASE),)
> =20
> -obj-m	:=3D LtpAcpiCmds.o
> -obj-p   :=3D Test
> -else
> -KDIR	:=3D /lib/modules/$(shell uname -r)/build
> -PWD	:=3D $(shell pwd)
> +obj-m :=3D LtpAcpiCmds.o
> =20
> -modules:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
> -	${CC}  $(CFLAGS) -o LtpAcpiMain  LtpAcpiMain.c
> +else
> =20
> -clean:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) clean
> -	rm -f modules.order
> -	rm -f LtpAcpiMain
> +top_srcdir	?=3D ../../../..
> +include $(top_srcdir)/include/mk/testcases.mk
> =20
> -help:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) help
> +REQ_VERSION_MAJOR	:=3D 2
> +REQ_VERSION_PATCH	:=3D 6
> +MAKE_TARGETS		:=3D ltp_acpi LtpAcpiCmds.ko
> =20
> -modules_install:
> -	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules_install
> +include $(top_srcdir)/include/mk/module.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> =20
>  endif
> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcase=
s/kernel/device-drivers/acpi/ltp_acpi.c
> new file mode 100644
> index 0000000..244e320
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
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
> +#include "LtpAcpi.h"
> +
> +char *TCID =3D "ltp_acpi";
> +int TST_TOTAL =3D ACPI_TC_NUM;
> +
> +static const char dev_result[]	=3D "/sys/devices/" ACPI_TEST_NAME "/re=
sult";
> +static const char dev_tcase[]	=3D "/sys/devices/" ACPI_TEST_NAME "/tca=
se";
> +static const char module_name[]	=3D "LtpAcpiCmds.ko";
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
> +static void check_acpi_str_result(void)
> +{
> +	/* new sysfs interface to export device description
> +	 * implemented since Linux 3.7
> +	 */
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_resm(TCONF,
> +			"ACPI_GET_STR_METHOD test-case required Linux 3.7+");
> +		return;
> +	}
> +
> +	/*
> +	 * if some devices has _STR object, we should get
> +	 * a valid string from test-case result and then can
> +	 * find it in sysfs.
> +	 */
> +	char buf[4096] =3D {0};
> +	FILE *f =3D SAFE_FOPEN(cleanup, dev_result, "r");
> +	char c, *b =3D buf, *end =3D buf + 4095;
> +	while ((c =3D fgetc(f)) !=3D EOF && b !=3D end)
> +		*b++ =3D c;
> +	SAFE_FCLOSE(cleanup, f);

What about fgets()? Or even better simple read(fd, buf, sizeof(buf))
that should fill the buffer with the data at once.

> +	if (!strcmp(buf, "null")) {
> +		tst_resm(TCONF, "None of devices has _STR");
> +		return;
> +	}
> +
> +	char *cmd;
> +	SAFE_ASPRINTF(cleanup, &cmd,
> +		"find /sys/devices -name description "
> +		"| xargs grep '%s' > /dev/null 2>&1", buf);
> +
> +	int res =3D system(cmd);
> +	free(cmd);

Hmm, if I understand this right we have _STR attribute from first device
that has this attribute and we are trying to assert that it exists in
the sysfs tree.

What about asserting that all _STR attributes are there?

I.e. change the module to write next _STR attribute each time the sysfs
file si read (we would need to emulate the recursion stack in an array).

And build a table of all _STR attributes in the userspace and check that
each attribute read from the module is in the table?

> +	tst_resm((res) ? TFAIL : TPASS, "%s sysfs file description: %s",
> +		(res) ? "didn't find" : "found", buf);
> +}
> +
> +static void test_run(void)
> +{
> +	int i, res;
> +	for (i =3D 0; i < TST_TOTAL; ++i) {
> +		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> +
> +		if (i =3D=3D ACPI_GET_STR_METHOD) {
> +			check_acpi_str_result();
> +		} else {
> +			SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> +			tst_resm(res, "Test-case '%d'", i);
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{

You miss the option parsing function here. I'ts important even if there
are no additional parameters (it prints error message if parameters are
passed instead of ignoring them silently).

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


--=20
Cyril Hrubis
chrubis@suse.cz


--===============5862055760313822766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
--===============5862055760313822766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5862055760313822766==--
