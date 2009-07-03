Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXJQ-0007uF-47
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:11:36 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXJL-0000B1-W6
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:11:36 +0000
Received: by yxe33 with SMTP id 33so1895556yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:11:31 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:45:18 -0700
Message-ID: <364299f40907021745y7f3c90fbu3ed9a31a882d77d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e1ee8745b98046dc27886
Subject: [LTP] [PATCH 6/10] config.mk not required for clean
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
To: LTP list <ltp-list@lists.sourceforge.net>

--0016368e1ee8745b98046dc27886
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016368e1ee8745b98046dc27886
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.6.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.6.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6oqfl0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fY2FuY2VsL01ha2VmaWxlCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pb19jYW5jZWwvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNApkaWZmIC11IC1y
MS40IE1ha2VmaWxlCi0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX2NhbmNlbC9NYWtl
ZmlsZQkyMCBKYW4gMjAwOSAxMDo0ODo0MSAtMDAwMAkxLjQKKysrIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvaW9fY2FuY2VsL01ha2VmaWxlCTMgSnVsIDIwMDkgMDA6NDA6MDEgLTAwMDAKQEAg
LTIwLDE0ICsyMCwxNyBAQAogIyAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZp
ZnRoIEZsb29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAxICBVU0EKICMKIAorc3JjZGlyCQkJPz0g
Li4vLi4vLi4vLi4vLi4KIAotaW5jbHVkZSAuLi8uLi8uLi8uLi9jb25maWcubWsKK2lmbmVxICgk
KE1BS0VDTURHT0FMUyksY2xlYW4pCitpbmNsdWRlICQoc3JjZGlyKS9jb25maWcubWsKK2VuZGlm
CiAKLVNSQ1MgICAgPSAkKHdpbGRjYXJkICouYykKLVRBUkdFVFMgPSAkKHBhdHN1YnN0ICUuYywl
LCQoU1JDUykpCitDRkxBR1MgCQkJKz0gLUkkKHNyY2RpcikvaW5jbHVkZSAtV2FsbAorTERGTEFH
UwkJCSs9ICQoQUlPX0xJQlMpIC1MJChzcmNkaXIpL2xpYgorTERMSUJTCQkJKz0gLWxsdHAKIAot
Q0ZMQUdTICs9IC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAtV2FsbAotTERMSUJTICs9ICQoQUlPX0xJ
QlMpIC1MLi4vLi4vLi4vLi4vbGliIC1sbHRwCitUQVJHRVRTIAkJOj0gJChwYXRzdWJzdCAlLmMs
JSwkKHdpbGRjYXJkICouYykpCiAKIGFsbDogJChUQVJHRVRTKQogCg==
--0016368e1ee8745b98046dc27886
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016368e1ee8745b98046dc27886
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e1ee8745b98046dc27886--

