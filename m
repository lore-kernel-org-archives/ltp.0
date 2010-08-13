Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Yingang.Fu@windriver.com>) id 1OjnLU-00006C-W0
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:02:24 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OjnLR-0000EK-I1
	for ltp-list@lists.sourceforge.net; Fri, 13 Aug 2010 06:02:24 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB3AAD.126BF39A"
Date: Fri, 13 Aug 2010 08:02:09 +0200
Message-ID: <52CF90264091A14888078A031D780F4306444AA6@ism-mail03.corp.ad.wrs.com>
From: "Fu, Yingang" <Yingang.Fu@windriver.com>
Subject: [LTP]  rt_sigsuspend01 caused segment fault on x86
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB3AAD.126BF39A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB3AAD.126BF39A"


------_=_NextPart_002_01CB3AAD.126BF39A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi, Garrett
=20
Following are test log on x86:
----------------------------------------------------------
=20
root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01 Segmentation
fault
=20
and messages of rt_sigsuspend01 when dmesg:
=20
root@d610-2:/opt/ltp-full/testcases/bin> dmesg | tail
=20
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing unused kernel memory: 344k freed
intel_rng: FWH not detected
ip_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 10
SCTP: Hash tables configured (established 16384 bind 32768)
eth0: no IPv6 routers present
=20
***rt_sigsuspend01[865] general protection ip:bfa8b780 sp:bfa8b120
error:0
=20
=20
After apply the patch:
=20
root@d610-2:/opt/ltp-full/testcases/bin> ./rt_sigsuspend01
rt_sigsuspend01    1  TPASS  :  rt_sigsuspend PASSED

=20
Thanks
Yingang

------_=_NextPart_002_01CB3AAD.126BF39A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.5969" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D930445305-13082010>hi,=20
Garrett</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D930445305-13082010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D930445305-13082010>Following are test=20
log on x86:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D930445305-13082010>----------------------------------------------=
------------</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D930445305-13082010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:root@d610-2:/opt/ltp-full/testcases/bin">root@d610-2:/opt/=
ltp-full/testcases/bin</A>&gt;=20
./rt_sigsuspend01 Segmentation fault</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and messages of rt_sigsuspend01 when=20
dmesg:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:root@d610-2:/opt/ltp-full/testcases/bin">root@d610-2:/opt/=
ltp-full/testcases/bin</A>&gt;=20
dmesg | tail</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>VFS: Mounted root (nfs filesystem) on =
device=20
0:13.<BR>Freeing unused kernel memory: 344k freed<BR>intel_rng: FWH not=20
detected<BR>ip_tables: (C) 2000-2006 Netfilter Core Team<BR>NET: =
Registered=20
protocol family 10<BR>SCTP: Hash tables configured (established 16384 =
bind=20
32768)<BR>eth0: no IPv6 routers present</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>***rt_sigsuspend01[865] general =
protection=20
ip:bfa8b780 sp:bfa8b120 error:0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial size=3D2>After =
apply the=20
patch:</FONT></SPAN></DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial size=3D2><A=20
href=3D"mailto:root@d610-2:/opt/ltp-full/testcases/bin">root@d610-2:/opt/=
ltp-full/testcases/bin</A>&gt;=20
./rt_sigsuspend01<BR>rt_sigsuspend01&nbsp;&nbsp;&nbsp; 1&nbsp; =
TPASS&nbsp;=20
:&nbsp; rt_sigsuspend PASSED<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D930445305-13082010><FONT face=3DArial=20
size=3D2>Yingang</DIV></FONT></SPAN></BODY></HTML>

------_=_NextPart_002_01CB3AAD.126BF39A--

------_=_NextPart_001_01CB3AAD.126BF39A
Content-Type: application/octet-stream;
	name="rt_sigsuspend01.patch"
Content-Transfer-Encoding: base64
Content-Description: rt_sigsuspend01.patch
Content-Disposition: attachment;
	filename="rt_sigsuspend01.patch"

LS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3N1c3BlbmQvcnRfc2lnc3VzcGVu
ZDAxLmMgfCAgICA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCi0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnc3VzcGVuZC9ydF9zaWdzdXNwZW5kMDEu
YworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3N1c3BlbmQvcnRfc2lnc3Vz
cGVuZDAxLmMKQEAgLTEzOCwxMSArMTM4LDE1IEBAIGludCBtYWluKGludCBhYywgY2hhciAqKmF2
KSB7CiAjaWZkZWYgX194ODZfNjRfXwogCQlzdHJ1Y3Qga2VybmVsX3NpZ2FjdGlvbiBhY3QsIG9h
Y3Q7CiAJCXNpZ19pbml0aWFsKFNJR0FMUk0pOworCQltZW1zZXQoJmFjdCwwLHNpemVvZihhY3Qp
KTsKKwkJbWVtc2V0KCZvYWN0LDAsc2l6ZW9mKG9hY3QpKTsKIAkJYWN0LnNhX2ZsYWdzIHw9IFNB
X1JFU1RPUkVSOwogCQlhY3Quc2FfcmVzdG9yZXIgPSByZXN0b3JlX3J0OwogCQlhY3Qua19zYV9o
YW5kbGVyID0gc2lnX2hhbmRsZXI7CiAjZWxzZQogCQlzdHJ1Y3Qgc2lnYWN0aW9uIGFjdCwgb2Fj
dDsKKwkJbWVtc2V0KCZhY3QsMCxzaXplb2YoYWN0KSk7CisJCW1lbXNldCgmb2FjdCwwLHNpemVv
ZihvYWN0KSk7CiAJCWFjdC5zYV9oYW5kbGVyID0gc2lnX2hhbmRsZXI7CiAjZW5kaWYKIAo=

------_=_NextPart_001_01CB3AAD.126BF39A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
------_=_NextPart_001_01CB3AAD.126BF39A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB3AAD.126BF39A--

