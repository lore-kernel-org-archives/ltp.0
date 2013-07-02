Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Uu7Xa-0003oL-BO
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 20:51:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uu7XZ-0005ZO-35
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 20:51:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 2 Jul 2013 16:50:55 -0400
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201307021650.56483.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v6] fw_load: new test of device firmware loading
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7411261733657141051=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============7411261733657141051==
Content-Type: multipart/signed; boundary="nextPart2358167.8ehLdt0WVV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2358167.8ehLdt0WVV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 02 July 2013 07:43:41 Alexey Kodanev wrote:
> --- /dev/null
> +++ b/testcases/kernel/firmware/Makefile
>
> +ifeq ($(WITH_MODULES),yes)
> +PROCEED ?=3D $(shell expr $(LINUX_VERSION_MAJOR) '>' $(REQ_VERSION_MAJOR=
))

use `test` rather than `expr`.  people are more familiar with that.

	test $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR)

> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
>
> +MAKE_TARGETS	:=3D ltp_fw_load.ko
> +ltp_fw_load.ko: ltp_fw_load.c
> +	-$(MAKE) -C $(LINUX_DIR) M=3D$(abs_srcdir)
> +	-mv ltp_fw_load.ko ltp_fw_load.ko~
> +	-$(MAKE) -C $(LINUX_DIR) M=3D$(abs_srcdir) clean
> +	-mv ltp_fw_load.ko~ ltp_fw_load.ko

what's with ignoring the exit status of all these ?  and why clean when you=
're=20
done ?  doesn't seem like you'd want to do either of these.

> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c

> +/* read and print firmware data */
> +static int fw_read(const u8 *data, size_t size);
> +
> +static void device_release(struct device *dev);
> +
> +static struct device tdev =3D {
> +	.init_name	=3D TCID,
> +	.release	=3D device_release,
> +};
> +
> +static int try_request_fw(const char *name);
> +
> +/* print test result to sysfs file */
> +static ssize_t sys_result(struct device *dev,
> +	struct device_attribute *attr, char *buf);
> +static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
> +
> +/*
> + * get the number of firmware files and
> + * perform firmware requests
> + */
> +static ssize_t sys_fwnum(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count);
> +static DEVICE_ATTR(fwnum, S_IWUSR, NULL, sys_fwnum);

generally it's preferable to organize the code such that forward decls aren=
't=20
even necessary.  seems like it'd be trivial to reorganize this file as such.

> +static int test_init(void)
> +{
> +	int err;
> +
> +	err =3D device_register(&tdev);
> +	if (err) {
> +		pr_err(TCID ": Unable to register device\n");

define pr_fmt at the top of the file rather than manually inserting TCID in=
=20
every call point

> +	err =3D device_create_file(&tdev, &dev_attr_result);
> +	if (err !=3D 0)

typically it's better to just do:
	if (err)

> +		pr_info(TCID ": Can't create sysfs file 'result'\n");

pr_err

> +	err =3D device_create_file(&tdev, &dev_attr_fwnum);
> +	if (err !=3D 0)
> +		pr_info(TCID ": Can't create sysfs file 'fwnum'\n");

if 'result' failed but 'fwnum' passed, this func incorrectly returns 0

you should have this code return immediately, and if fwnum fails, have it c=
all=20
device_remove_file on 'result'

> +static ssize_t sys_fwnum(struct device *dev,
> +	struct device_attribute *attr,  const char *buf, size_t count)
> +{
> +	int err, fw_num =3D 0;
> +
> +	sscanf(buf, "%d", &fw_num);
> +	if (fw_num <=3D 0) {
> +		pr_err(TCID ": Unexpected number of firmwares '%d'", fw_num);
> +		return count;
> +	}
> +	for (fw =3D 0; fw < fw_num; ++fw) {
> +		char name[max_name];
> +		snprintf(name, max_name, "n%d_%s", fw, fw_name);
> +		err =3D try_request_fw(name);
> +		test_result |=3D (err =3D=3D 0) << fw;

mmm and what if fw_num > sizeof(test_result) ?

> +static int fw_read(const u8 *data, size_t size)
> +{
> +	size_t i;
> +	pr_info(TCID ": Firmware has size '%d'\n", (unsigned int) size);

don't cast.  use a proper format string: %zu.

> +module_init(test_init);
> +module_exit(test_exit);

i'd move those to below the respective func rather than at the bottom of th=
e=20
file
=2Dmike

--nextPart2358167.8ehLdt0WVV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJR0z0wAAoJEEFjO5/oN/WByQwQAIoIXh4iQOKOxoXX8IbNj5At
oB/n/glH4ppZw3M9vmp5cIZCNC9l3ofilXW+tNxpVGRGU7ciXQ78Gyw4n/lagT57
lEAyv4MVWyln8TAiUIA50i3kQvxgxvuA6ktaSuR5JNujjVL+g+RA9hxTdD5X/fq0
fAjo02pQ8NiGcU/pB4wlhpgynaMC6v6WS/2yX3y0EWeVHVfUAl90eYuZGF9OXb/u
6c5MNH7eTqJSGBB4xfmnRkby0iZesWDNAiJ3tcYtIwLXveMmaQr9C0CHpebunwo2
yfuJ/jD1fbtDIqNCvAW/19BSisDyeL9nF0XUZ4097q+graN6aUPzRhLGtLKls8nW
cuh/Xc4eHBxXcBJJyktCb4cjKGdYv38AiryLKlbSskDiXTgPwrX9iHXLnOfmpWO/
w3yGO/ERFr5y10WhjlGbypWYHdi8ZFpZtm6d0xYIE2v9qwu3EkNKffce1U1oymXk
Pqr1TxaqMrbTiIVDp+TAy49fZcQvwVGsAIfHIfDIlU7P4TkxQFAEWHI3xRvtDd3l
+qNosGgPZKrYfz4t+skscZFlkhNL/v4K+B3RR3GnKG3dT7Ey/Pxy1IRAB2XEoV+9
wcX9HEfNrk6xoYrzxauw1NEqzoffWSSz8LK3mWDWzN//MF9ejCswNixBkDU1dDzR
kHZu33uhZhLRnTvnelpe
=nWLB
-----END PGP SIGNATURE-----

--nextPart2358167.8ehLdt0WVV--


--===============7411261733657141051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============7411261733657141051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7411261733657141051==--

