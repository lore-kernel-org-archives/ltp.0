Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1Uujzj-0002Du-2Z
	for ltp-list@lists.sourceforge.net; Thu, 04 Jul 2013 13:54:47 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uujza-0008Gx-1O
	for ltp-list@lists.sourceforge.net; Thu, 04 Jul 2013 13:54:47 +0000
Received: from mail-pb0-f53.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id D7FE64CD
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Jul 2013 21:31:29 +0800 (CST)
Received: by mail-pb0-f53.google.com with SMTP id xb12so1229824pbc.26
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Jul 2013 06:31:38 -0700 (PDT)
MIME-Version: 1.0
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Thu, 4 Jul 2013 21:30:58 +0800
Message-ID: <CALGiYOH4uhAoPgEQ+-p889GbjTazpXkyXabXs021xdmOTbYkoA@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7b2ed9b30f04f804e0af99fd
Subject: [LTP] [PATCH]xinetd/xinetd_tests.sh:disable the IPV6 localhost
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

--047d7b2ed9b30f04f804e0af99fd
Content-Type: multipart/alternative; boundary=047d7b2ed9b30f04f504e0af99fb

--047d7b2ed9b30f04f504e0af99fb
Content-Type: text/plain; charset=ISO-8859-1

If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet 127.0.0.1
.
The first one makes the command output different from the expected result.


Thanks,
Lingyun Xie

--047d7b2ed9b30f04f504e0af99fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif"><span style=3D"color:rgb(34,34,34);font-size:14px">If IPV6 is enabled=
,</span><font color=3D"#000000" face=3D"simsun, serif" style=3D"color:rgb(0=
,0,0);font-size:14px">=A0telnet localhost becomes</font><span style=3D"colo=
r:rgb(34,34,34);font-size:14px">=A0telnet ::1 and telnet 127.0.0.1</span><s=
pan style=3D"font-size:14px"><font color=3D"#000000">.=A0</font></span></di=
v>

<div class=3D"gmail_default" style=3D"font-family:simsun,serif"><span style=
=3D"font-size:14px"><font color=3D"#000000">The first one makes the command=
 output different from the expected result.</font></span></div><br clear=3D=
"all">

<div><div dir=3D"ltr"><div><br></div><div>Thanks,<br><div class=3D"gmail_de=
fault" style=3D"font-family:simsun,serif;color:rgb(0,0,0)">Lingyun Xie</div=
></div></div></div>
</div>

--047d7b2ed9b30f04f504e0af99fb--

--047d7b2ed9b30f04f804e0af99fd
Content-Type: application/octet-stream; 
	name="0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch"
Content-Disposition: attachment; 
	filename="0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hipzq6ke0

RnJvbSA3NWM3OTcyMWMwOTVjY2UyNzU0OGU3NDI2MGMxZTQyNjgxZTFhMjY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtZWxsb253YW5kIDxtZWxsb253YW5kQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCA0IEp1bCAyMDEzIDE2OjQyOjQyICswODAwClN1YmplY3Q6IFtQQVRDSF0geGluZXRk
L3hpbmV0ZF90ZXN0cy5zaDpkaXNhYmxlIHRoZSBJUFY2IGxvY2FsaG9zdAoKSWYgSVBWNiBpcyBl
bmFibGVkLCB0ZWxuZXQgbG9jYWxob3N0IGJlY29tZXMgdGVsbmV0IDo6MSBhbmQgdGVsbmV0IDEy
Ny4wLjAuMS4gVGhlIGZpcnN0IG9uZSBtYWtlcyB0aGUgY29tbWFuZCdzIG91dHB1dCBkaWZmZXJl
bnQgZnJvbSB0aGUgZXhwZWN0ZWQgb3V0cHV0LgoKU2lnbmVkLW9mZi1ieTogWGllIExpbmd5dW4g
PGxpbmd5dW4ueGllQGJqLmNzMmMuY29tLmNuPgotLS0KIHRlc3RjYXNlcy9uZXR3b3JrL3hpbmV0
ZC94aW5ldGRfdGVzdHMuc2ggfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9uZXR3b3JrL3hpbmV0
ZC94aW5ldGRfdGVzdHMuc2ggYi90ZXN0Y2FzZXMvbmV0d29yay94aW5ldGQveGluZXRkX3Rlc3Rz
LnNoCmluZGV4IDgzZWI4YTcuLmQyYzg1MWQgMTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9uZXR3b3Jr
L3hpbmV0ZC94aW5ldGRfdGVzdHMuc2gKKysrIGIvdGVzdGNhc2VzL25ldHdvcmsveGluZXRkL3hp
bmV0ZF90ZXN0cy5zaApAQCAtMTI4LDYgKzEyOCw3IEBAIGluaXQoKQogCiAgICAgIyBDcmVhdGUg
ZXhwZWN0ZWQgZmlsZSB3aXRoIHRlbG5ldCBkaXNhYmxlZC4KICAgICBjYXQgPiAkTFRQVE1QL3Rz
dF94aW5ldGQuZXhwLjEgPDwtRU9GIHx8IFJDPSQ/CisJdGVsbmV0OiBjb25uZWN0IHRvIGFkZHJl
c3MgMTI3LjAuMC4xOiBDb25uZWN0aW9uIHJlZnVzZWQKIAl0ZWxuZXQ6IFVuYWJsZSB0byBjb25u
ZWN0IHRvIHJlbW90ZSBob3N0OiBDb25uZWN0aW9uIHJlZnVzZWQKIAlFT0YKIApAQCAtMjYzLDcg
KzI2NCw3IEBAIHRlc3QwMSgpCiAKIAkjIE5vdCBjaGVja2luZyBmb3IgZXhpdCBjb2RlIGZyb20g
dGVsbmV0IGNvbW1hbmQgYmVjYXVzZSB0ZWxuZXQgaXMKIAkjIG5vdCB0ZXJtaW5hdGVkIGJ5IHRo
ZSB0ZXN0IGdyYWNlZnVsbHkuCi0JZWNobyAiBCIgfCB0ZWxuZXQgbG9jYWxob3N0IDI+JExUUFRN
UC90c3RfeGluZXRkLm91dCAxPi9kZXYvbnVsbAorCWVjaG8gIgQiIHwgdGVsbmV0IDEyNy4wLjAu
MSAyPiRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQgMT4vZGV2L251bGwKIAlkaWZmIC1pd0IgJExUUFRN
UC90c3RfeGluZXRkLm91dCAgJExUUFRNUC90c3RfeGluZXRkLmV4cC4xIFwKIAkJPiAkTFRQVE1Q
L3RzdF94aW5ldGQuZXJyIDI+JjEgfHwgUkM9JD8KICAgICBpZiBbICRSQyAtbmUgMCBdCkBAIC0z
MTIsNyArMzEzLDcgQEAgdGVzdDAxKCkKIAogCSMgTm90IGNoZWNraW5nIGZvciBleGl0IGNvZGUg
ZnJvbSB0ZWxuZXQgY29tbWFuZCBiZWNhdXNlIHRlbG5ldCBpcwogCSMgbm90IHRlcm1pbmF0ZWQg
YnkgdGhlIHRlc3QgZ3JhY2VmdWxseS4KLQllY2hvICIEIiB8IHRlbG5ldCBsb2NhbGhvc3QgPiAk
TFRQVE1QL3RzdF94aW5ldGQub3V0IDI+JjEKKwllY2hvICIEIiB8IHRlbG5ldCAxMjcuMC4wLjEg
PiAkTFRQVE1QL3RzdF94aW5ldGQub3V0IDI+JjEKIAogCWRpZmYgLWl3QiAkTFRQVE1QL3RzdF94
aW5ldGQub3V0ICAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjIgXAogCQk+ICRMVFBUTVAvdHN0X3hp
bmV0ZC5lcnIgMj4mMSB8fCBSQz0kPwotLSAKMS44LjMuMQoK
--047d7b2ed9b30f04f804e0af99fd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--047d7b2ed9b30f04f804e0af99fd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--047d7b2ed9b30f04f804e0af99fd--

