Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Yingang.Fu@windriver.com>) id 1Olgj5-00056J-7H
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 11:22:35 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Olgj0-0000Qq-MD
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 11:22:35 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB3EC7.9FD6C579"
Date: Wed, 18 Aug 2010 13:22:18 +0200
Message-ID: <52CF90264091A14888078A031D780F43064456F9@ism-mail03.corp.ad.wrs.com>
From: "Fu, Yingang" <Yingang.Fu@windriver.com>
Subject: [LTP] Rt_sigprocmask01 test case caused "segment fault" on x86
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

------_=_NextPart_001_01CB3EC7.9FD6C579
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB3EC7.9FD6C579"


------_=_NextPart_002_01CB3EC7.9FD6C579
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi, Garrett
=20
This is a similar problem as rt_sigsuspend01 which has been fix before.
=20
Failed log:

root@Congatec:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
Segmentation fault

After apply the patch:
root@Congatec:/opt/ltp-full> ./testcases/bin/rt_sigprocmask01
rt_sigprocmask01    1  TPASS  :  rt_sigprocmask functionality passed

Signed-off-by: Yingang Fu <yingang.fu@windriver.com>
=20
Thanks
Yingang

------_=_NextPart_002_01CB3EC7.9FD6C579
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
<DIV><FONT face=3DArial size=3D2><SPAN class=3D930445305-13082010>This =
is a similar=20
problem as rt_sigsuspend01 which has been fix =
before.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D930445305-13082010>&nbsp;</DIV>
<DIV>Failed log:</DIV>
<DIV><BR><A=20
href=3D"mailto:root@Congatec:/opt/ltp-full">root@Congatec:/opt/ltp-full</=
A>&gt;=20
./testcases/bin/rt_sigprocmask01<BR>Segmentation fault<BR></DIV>
<DIV>After apply the patch:</DIV>
<DIV><A=20
href=3D"mailto:root@Congatec:/opt/ltp-full">root@Congatec:/opt/ltp-full</=
A>&gt;=20
./testcases/bin/rt_sigprocmask01<BR>rt_sigprocmask01&nbsp;&nbsp;&nbsp; =
1&nbsp;=20
TPASS&nbsp; :&nbsp; rt_sigprocmask functionality passed<BR></DIV>
<DIV>Signed-off-by: Yingang Fu &lt;<A=20
href=3D"mailto:yingang.fu@windriver.com">yingang.fu@windriver.com</A>&gt;=
</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks</DIV>
<DIV>Yingang</DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_002_01CB3EC7.9FD6C579--

------_=_NextPart_001_01CB3EC7.9FD6C579
Content-Type: application/octet-stream;
	name="0001-sigaction-variables-must-be-initialized-before-using.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-sigaction-variables-must-be-initialized-before-using.patch
Content-Disposition: attachment;
	filename="0001-sigaction-variables-must-be-initialized-before-using.patch"

RnJvbSBlY2E1Yzg1ZTU5YmY5MmNiZDQ5MjcyYzNkYzBhYjI1ZDYzYmMxZThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZaW5nYW5nIEZ1IDx5aW5nYW5nLmZ1QHdpbmRyaXZlci5jb20+
CkRhdGU6IFdlZCwgMTggQXVnIDIwMTAgMTk6MDY6NTYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBz
aWdhY3Rpb24gdmFyaWFibGVzIG11c3QgYmUgaW5pdGlhbGl6ZWQgYmVmb3JlIHVzaW5nIHRoZW0u
IE90aGVyd2lzZSx3aWxsCiBjYXVzZSAic2VnbWVudCBmYXVsdCIgb24geDg2IHBsYXRmb3JtCgot
LS0KIC4uLi9zeXNjYWxscy9ydF9zaWdwcm9jbWFzay9ydF9zaWdwcm9jbWFzazAxLmMgICAgIHwg
ICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdwcm9jbWFzay9y
dF9zaWdwcm9jbWFzazAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2Nt
YXNrL3J0X3NpZ3Byb2NtYXNrMDEuYwppbmRleCBlMTAwNTYxLi4zMzIwMmYxIDEwMDY0NAotLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0X3NpZ3Byb2NtYXNr
MDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0X3Np
Z3Byb2NtYXNrMDEuYwpAQCAtMTQyLDYgKzE0Miw4IEBAIGludCBtYWluKGludCBhYywgY2hhciAq
KmF2KSB7CiAJYWN0Lmtfc2FfaGFuZGxlciA9IHNpZ19oYW5kbGVyOwogI2Vsc2UKIAlzdHJ1Y3Qg
c2lnYWN0aW9uIGFjdCwgb2FjdDsKKwltZW1zZXQoJmFjdCwwLHNpemVvZihhY3QpKTsKKwltZW1z
ZXQoJm9hY3QsMCxzaXplb2Yob2FjdCkpOwogCWFjdC5zYV9oYW5kbGVyID0gc2lnX2hhbmRsZXI7
CiAjZW5kaWYKIAlzaWdzZXRfdCBzZXQsIG9zZXQ7Ci0tIAoxLjcuMC41Cgo=

------_=_NextPart_001_01CB3EC7.9FD6C579
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
------_=_NextPart_001_01CB3EC7.9FD6C579
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB3EC7.9FD6C579--

