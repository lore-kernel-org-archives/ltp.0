Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VHWPb-0007MR-OA
	for ltp-list@lists.sourceforge.net; Thu, 05 Sep 2013 10:03:39 +0000
Date: Thu, 5 Sep 2013 12:03:52 +0200
From: chrubis@suse.cz
Message-ID: <20130905100351.GB2770@rei>
References: <1378318684-29558-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1378318684-29558-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: acpi: update for Linux kernel
 2.6.37+
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6569336309380390913=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============6569336309380390913==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> +int LTPMAJOR;
>  // define the ioctl cmds
>  #define LTPDEV_CMD       _IOR( LTPMAJOR, LTP_IOCTL_NUMBER, ltpdev_cmd_=
t **)
> -
> diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c b/testc=
ases/kernel/device-drivers/acpi/LtpAcpiCmds.c
> index 26fcc15..1e85242 100644
> --- a/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
> +++ b/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c
> @@ -28,6 +28,8 @@
>   *  01/03/2009 M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
>   *   - Updated for Linux kernel 2.6.28
>   *
> + *  09/2013 Alexey Kodanev <alexey.kodanev@oracle.com>
> + *   - Updated for Linux kernel 2.6.37
>   */

Linux-2.6.37 is quite old, does it compile with Linux-3.10?

Ideally it should work with broad range of kernels but that would likely
require great number of ifdefs...


> diff --git a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c b/testc=
ases/kernel/device-drivers/acpi/LtpAcpiMain.c
> index c3e9c91..ed90784 100644
> --- a/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
> +++ b/testcases/kernel/device-drivers/acpi/LtpAcpiMain.c
> @@ -42,6 +42,10 @@
> =20
>  #include "LtpAcpi.h"
> =20
> +#include "test.h"
> +
> +char *TCID =3D "LTP_ACPI";
> +
>  int LTP_acpi_open_block_device(void);
> =20
>  int ltp_block_dev_handle =3D 0;	/* handle to LTP Test block device */
> @@ -66,7 +70,6 @@ int main(int argc, char **argv)
>  			     LTP_ACPI_DEVICE_NAME, ltp_block_dev_handle, errno);
>  		} else {
>  			rc =3D ioctl(ltp_block_dev_handle, LTPDEV_CMD, &cmd);
> -
>  			printf("return from ioctl %d \n", rc);
>  		}
> =20
> @@ -81,7 +84,7 @@ int LTP_acpi_open_block_device()
>  {
>  	dev_t devt;
>  	struct stat statbuf;
> -	int rc;
> +	int rc =3D -1;
> =20
>  	if (ltp_block_dev_handle =3D=3D 0) {
> =20
> @@ -90,6 +93,11 @@ int LTP_acpi_open_block_device()
>  		 * If devfs is running and mounted on /dev, these checks will all pa=
ss,
>  		 * so a new node will not be created.
>  		 */
> +
> +		SAFE_FILE_SCANF(NULL, "/sys/devices/virtual/block/"
> +			LTP_ACPI_DEV_NAME"/dev",
> +			"%d:0", &LTPMAJOR);
> +
>  		devt =3D makedev(LTPMAJOR, 0);
> =20
>  		rc =3D stat(LTP_ACPI_DEV_NODE_PATH, &statbuf);

It would be better to convert this code to full LTP test so we can drop
the ltpapci.sh script.

Also there doesn't seem to be any success/failure logic. It looks like
the program just opens the device and does some ioctls(). Do you have an
idea what is the purpose of this test?

--=20
Cyril Hrubis
chrubis@suse.cz


--===============6569336309380390913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
--===============6569336309380390913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6569336309380390913==--
