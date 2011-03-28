Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <prvs=061d09fc1=tijotj@tataelxsi.co.in>)
	id 1Q44uK-0006ia-KZ
	for ltp-list@lists.sourceforge.net; Mon, 28 Mar 2011 05:22:28 +0000
Received: from smtpout3.vsnlxchange.com ([59.163.96.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q44uG-0006yG-DS
	for ltp-list@lists.sourceforge.net; Mon, 28 Mar 2011 05:22:26 +0000
Message-ID: <4D901425.2020803@tataelxsi.co.in>
Date: Mon, 28 Mar 2011 10:22:53 +0530
From: Tijo <tijotj@tataelxsi.co.in>
MIME-Version: 1.0
Subject: [LTP] Error with Device driver tests in LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5287574009689477797=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============5287574009689477797==
Content-Type: multipart/alternative;
	boundary="------------080309000207040409050402"

This is a multi-part message in MIME format.
--------------080309000207040409050402
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"

Hello,
  I'm new to the LTP mailing list and I'm facing a problem while running=20
the device driver tests in LTP. When I try to make the acpi driver in=20
LTP, I'm getting an error as

make -C /lib/modules/2.6.32.TEL-0.7-default/build=20
SUBDIRS=3D/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-dri=
vers/acpi=20
modules
make[1]: Entering directory `/usr/src/linux-2.6.32.12-0.7'
  CC [M] =20
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.o
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:=20
In function ltpdev_ioctl:
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:188:=20
warning: passing argument 2 of acpi_get_object_info from incompatible=20
pointer type
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:369:=20
*error: implicit declaration of function acpi_get_register*
make[2]: ***=20
[/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi=
/LtpAcpiCmds.o]=20
Error 1
make[1]: ***=20
[_module_/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-driv=
ers/acpi]=20
Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.32.12-0.7'
make: *** [default] Error 2

please help on how to solve this problem

--=20
yours truly,

Tijo Thomas John
Engineer MMS
TATA ELXSI LTD



--------------080309000207040409050402
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Hello,<br>
&nbsp; I'm new to the LTP mailing list and I'm facing a problem while
running the device driver tests in LTP. When I try to make the acpi
driver in LTP, I'm getting an error as<br>
<br>
make -C /lib/modules/2.6.32.TEL-0.7-default/build
SUBDIRS=3D/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-dri=
vers/acpi
modules<br>
make[1]: Entering directory `/usr/src/linux-2.6.32.12-0.7'<br>
&nbsp; CC [M]&nbsp;
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.o<br>
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:
In function ltpdev_ioctl:<br>
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:188:
warning: passing argument 2 of acpi_get_object_info from incompatible
pointer type<br>
/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/=
LtpAcpiCmds.c:369:
<b>error: implicit declaration of function acpi_get_register</b><br>
make[2]: ***
[/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi=
/LtpAcpiCmds.o]
Error 1<br>
make[1]: ***
[_module_/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-driv=
ers/acpi]
Error 2<br>
make[1]: Leaving directory `/usr/src/linux-2.6.32.12-0.7'<br>
make: *** [default] Error 2<br>
<br>
please help on how to solve this problem<br>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
yours truly,

Tijo Thomas John
Engineer MMS
TATA ELXSI LTD</pre>
<font face=3D"monospace"></font></body>
</html>

--------------080309000207040409050402--



--===============5287574009689477797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
--===============5287574009689477797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5287574009689477797==--


