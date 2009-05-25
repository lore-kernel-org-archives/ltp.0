Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M8Yk5-00040x-15
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 11:53:21 +0000
Received: from mail-ew0-f168.google.com ([209.85.219.168])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M8Yk3-0006Cw-AT
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 11:53:21 +0000
MIME-Version: 1.0
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95DD01ED4@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95DD01ED4@insardxms01.ap.sony.com>
Date: Mon, 25 May 2009 17:23:17 +0530
Message-ID: <d51f89b0905250453q62395300la1dfddc20bdb0af5@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=0016e6de016c7dfae0046abb4103
Subject: [LTP] patch for timer_create04 and clock_gettime03 issue.
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
To: ltp-list@lists.sf.net, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>, CAI Qian <caiqian@cclom.cn>

--0016e6de016c7dfae0046abb4103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

In reference to the issue with=A0timer_create04 and clock_gettime03 for
the kernel version 2.6.29 which was reported in the link:

http://www.nabble.com/timer_create-p22376043.html, PFA the patch for
fixing the issue.

Detail on the issue: A new clockid 'CLOCK_MONOTONIC_RAW' was added
since the kernel 2.6.28
(http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.28). This
addition caused the above testcases to fail. Now, 5 clock ID's are
present in kernel ver 2.6.28 and later.

Please check the same....

Regards,
Rohit

--0016e6de016c7dfae0046abb4103
Content-Type: text/plain; charset=US-ASCII; name="timers_patch.txt"
Content-Disposition: attachment; filename="timers_patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: 0.1

UGF0Y2ggdG8gZml4IHRpbWVyX2NyZWF0ZTA0IGFuZCBjbG9ja19nZXR0aW1lMDMuIE5ldyBjbG9j
a2lkIENMT0NLX01PTk9UT05JQ19SQVcgd2FzIGFkZGVkIHNpbmNlIGxpbnV4IDIuNi4yOC4KU2ln
bmVkLW9mZi1ieTogcm9oaXQgdmVybWEgKHJvaGl0LjE3MDMwOUBnbWFpbC5jb20pCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KZGlmZiAtcnVOQiBsdHAtZnVsbC0yMDA5MDQzMF9vcmln
L3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5oIGx0cC1mdWxs
LTIwMDkwNDMwL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5o
Ci0tLSBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1
ZGUvY29tbW9uX3RpbWVycy5oCTIwMDgtMDItMjYgMTY6NDQ6NDUuMDAwMDAwMDAwICswNTMwCisr
KyBsdHAtZnVsbC0yMDA5MDQzMC90ZXN0Y2FzZXMva2VybmVsL3RpbWVycy9pbmNsdWRlL2NvbW1v
bl90aW1lcnMuaAkyMDA5LTA1LTI1IDE2OjA3OjExLjAwMDAwMDAwMCArMDUzMApAQCAtMjIsMTEg
KzIyLDE1IEBACiAjaWZuZGVmIENMT0NLX1RIUkVBRF9DUFVUSU1FX0lECiAjZGVmaW5lIENMT0NL
X1RIUkVBRF9DUFVUSU1FX0lEIDMKICNlbmRpZgorI2lmbmRlZiBDTE9DS19NT05PVE9OSUNfUkFX
CisjZGVmaW5lIENMT0NLX01PTk9UT05JQ19SQVcgNAorI2VuZGlmCiBjbG9ja190IGNsb2NrX2xp
c3RbXSA9IHsKIAlDTE9DS19SRUFMVElNRSwKIAlDTE9DS19NT05PVE9OSUMsCiAJQ0xPQ0tfUFJP
Q0VTU19DUFVUSU1FX0lELAotCUNMT0NLX1RIUkVBRF9DUFVUSU1FX0lECisJQ0xPQ0tfVEhSRUFE
X0NQVVRJTUVfSUQsCisJQ0xPQ0tfTU9OT1RPTklDX1JBVywKIH07CiAjZGVmaW5lIE1BWF9DTE9D
S1MgKHNpemVvZihjbG9ja19saXN0KSAvIHNpemVvZigqY2xvY2tfbGlzdCkpCiAKQEAgLTM3LDYg
KzQxLDcgQEAKIAkJY2FzZSBDTE9DS19NT05PVE9OSUM6ICAgICAgICAgIHJldHVybiAiQ0xPQ0tf
TU9OT1RPTklDIjsKIAkJY2FzZSBDTE9DS19QUk9DRVNTX0NQVVRJTUVfSUQ6IHJldHVybiAiQ0xP
Q0tfUFJPQ0VTU19DUFVUSU1FX0lEIjsKIAkJY2FzZSBDTE9DS19USFJFQURfQ1BVVElNRV9JRDog
IHJldHVybiAiQ0xPQ0tfVEhSRUFEX0NQVVRJTUVfSUQiOworCQljYXNlIENMT0NLX01PTk9UT05J
Q19SQVc6ICAgICAgcmV0dXJuICJDTE9DS19NT05PVE9OSUNfUkFXIjsKIAkJZGVmYXVsdDogICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAiQ0xPQ0tfIT8hPyE/IjsKIAl9CiB9CmRpZmYgLXJ1
TkIgbHRwLWZ1bGwtMjAwOTA0MzBfb3JpZy90ZXN0Y2FzZXMva2VybmVsL3RpbWVycy90aW1lcl9j
cmVhdGUvdGltZXJfY3JlYXRlMDIuYyBsdHAtZnVsbC0yMDA5MDQzMC90ZXN0Y2FzZXMva2VybmVs
L3RpbWVycy90aW1lcl9jcmVhdGUvdGltZXJfY3JlYXRlMDIuYwotLS0gbHRwLWZ1bGwtMjAwOTA0
MzBfb3JpZy90ZXN0Y2FzZXMva2VybmVsL3RpbWVycy90aW1lcl9jcmVhdGUvdGltZXJfY3JlYXRl
MDIuYwkyMDA4LTAyLTI2IDE2OjQ0OjQ1LjAwMDAwMDAwMCArMDUzMAorKysgbHRwLWZ1bGwtMjAw
OTA0MzAvdGVzdGNhc2VzL2tlcm5lbC90aW1lcnMvdGltZXJfY3JlYXRlL3RpbWVyX2NyZWF0ZTAy
LmMJMjAwOS0wNS0yNSAxNjo0MToxNC4wMDAwMDAwMDAgKzA1MzAKQEAgLTkzLDYgKzkzLDcgQEAK
IAkJIk5VTEwiLAogCQkiU0lHRVZfTk9ORSIKIAl9OworCWNvbnN0IGNoYXIgKm1yc3RyID0gIk1P
Tk9UT05JQ19SQVciOwogCiAJLyogcGFyc2Ugc3RhbmRhcmQgb3B0aW9ucyAqLwogCWlmICgobXNn
ID0gcGFyc2Vfb3B0cyhhYywgYXYsIChvcHRpb25fdCAqKSBOVUxMLCBOVUxMKSkgIT0KQEAgLTEy
Miw2ICsxMjMsOSBAQAogCQkJCQkJY29udGludWU7CiAJCQkJCX0KIAkJCQl9CisJCQkJaWYgKHN0
cnN0cihnZXRfY2xvY2tfc3RyKGNsb2NrX2xpc3Rbal0pLCBtcnN0cikpCisJCQkJCWNvbnRpbnVl
OworCiAJCQkJVEVTVCh0aW1lcl9jcmVhdGUoY2xvY2tfbGlzdFtqXSwgZXZwX3B0ciwKIAkJCQkJ
CQkmY3JlYXRlZF90aW1lcl9pZCkpOwogCg==
--0016e6de016c7dfae0046abb4103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
--0016e6de016c7dfae0046abb4103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e6de016c7dfae0046abb4103--

