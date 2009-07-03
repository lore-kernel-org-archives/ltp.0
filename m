Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMX0c-0003JZ-8e
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:52:10 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMX0W-00081b-H3
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:52:09 +0000
Received: by yxe33 with SMTP id 33so1881809yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 17:51:12 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:46:05 -0700
Message-ID: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e644cefa3f1ba8046dc27b0f
Subject: [LTP] [PATCH 8/10] config.mk not required for clean
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

--0016e644cefa3f1ba8046dc27b0f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016e644cefa3f1ba8046dc27b0f
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.8.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.8.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6pqic0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZ2V0ZXZlbnRzL01ha2VmaWxlCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9pb19nZXRldmVudHMvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMwpkaWZm
IC11IC1yMS4zIE1ha2VmaWxlCi0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX2dldGV2
ZW50cy9NYWtlZmlsZQkyMCBKYW4gMjAwOSAxMDo0ODo0MSAtMDAwMAkxLjMKKysrIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaW9fZ2V0ZXZlbnRzL01ha2VmaWxlCTMgSnVsIDIwMDkgMDA6NDA6
MDUgLTAwMDAKQEAgLTIwLDE1ICsyMCwxNyBAQAogIyAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJh
bmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAxICBVU0EKICMKIAor
c3JjZGlyCQkJPz0gLi4vLi4vLi4vLi4vLi4KIAotaW5jbHVkZSAuLi8uLi8uLi8uLi9jb25maWcu
bWsKK2lmbmVxICgkKE1BS0VDTURHT0FMUyksY2xlYW4pCitpbmNsdWRlICQoc3JjZGlyKS9jb25m
aWcubWsKK2VuZGlmCiAKK0NGTEFHUyAJCQkrPSAtSSQoc3JjZGlyKS9pbmNsdWRlIC1XYWxsCitM
REZMQUdTCQkJKz0gJChBSU9fTElCUykgLUwkKHNyY2RpcikvbGliCitMRExJQlMJCQkrPSAtbGx0
cAogCi1TUkNTICAgID0gJCh3aWxkY2FyZCAqLmMpCi1UQVJHRVRTID0gJChwYXRzdWJzdCAlLmMs
JSwkKFNSQ1MpKQotCi1DRkxBR1MgKz0gLUkuLi8uLi8uLi8uLi9pbmNsdWRlIC1XYWxsCi1MRExJ
QlMgKz0gJChBSU9fTElCUykgLUwuLi8uLi8uLi8uLi9saWIgLWxsdHAKK1RBUkdFVFMgCQk6PSAk
KHBhdHN1YnN0ICUuYywlLCQod2lsZGNhcmQgKi5jKSkKIAogYWxsOiAkKFRBUkdFVFMpCiAK
--0016e644cefa3f1ba8046dc27b0f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e644cefa3f1ba8046dc27b0f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e644cefa3f1ba8046dc27b0f--

