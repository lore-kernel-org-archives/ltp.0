Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMX3M-0006OM-6k
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:55:00 +0000
Received: from an-out-0708.google.com ([209.85.132.247])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMX3H-0006Ya-OE
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:55:00 +0000
Received: by an-out-0708.google.com with SMTP id c38so870144ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 17:53:34 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:46:52 -0700
Message-ID: <364299f40907021746s11b0d21cree70f4794c2151e9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016369201d011849b046dc27e31
Subject: [LTP] [PATCH 10/10] config.mk not required for clean
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

--0016369201d011849b046dc27e31
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016369201d011849b046dc27e31
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.10.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.10.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6qr550

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fc3VibWl0L01ha2VmaWxlCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pb19zdWJtaXQvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMwpkaWZmIC11IC1y
MS4zIE1ha2VmaWxlCi0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3N1Ym1pdC9NYWtl
ZmlsZQkyMCBKYW4gMjAwOSAxMDo0ODo0MiAtMDAwMAkxLjMKKysrIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvaW9fc3VibWl0L01ha2VmaWxlCTMgSnVsIDIwMDkgMDA6NDA6MDggLTAwMDAKQEAg
LTIwLDE2ICsyMCwxNyBAQAogIyAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZp
ZnRoIEZsb29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAxICBVU0EKICMKIAorc3JjZGlyCQkJPz0g
Li4vLi4vLi4vLi4vLi4KIAotaW5jbHVkZSAuLi8uLi8uLi8uLi9jb25maWcubWsKK2lmbmVxICgk
KE1BS0VDTURHT0FMUyksY2xlYW4pCitpbmNsdWRlICQoc3JjZGlyKS9jb25maWcubWsKK2VuZGlm
CiAKK0NGTEFHUyAJCQkrPSAtSSQoc3JjZGlyKS9pbmNsdWRlIC1XYWxsCitMREZMQUdTCQkJKz0g
JChBSU9fTElCUykgLUwkKHNyY2RpcikvbGliCitMRExJQlMJCQkrPSAtbGx0cAogCi1TUkNTICAg
ID0gJCh3aWxkY2FyZCAqLmMpCi1UQVJHRVRTID0gJChwYXRzdWJzdCAlLmMsJSwkKFNSQ1MpKQot
U1lTQ0FMTCA9IGlvX3N1Ym1pdAotCi1DRkxBR1MgKz0gLUkuLi8uLi8uLi8uLi9pbmNsdWRlIC1X
YWxsCi1MRExJQlMgKz0gJChBSU9fTElCUykgLUwuLi8uLi8uLi8uLi9saWIgLWxsdHAKK1RBUkdF
VFMgCQk6PSAkKHBhdHN1YnN0ICUuYywlLCQod2lsZGNhcmQgKi5jKSkKIAogYWxsOiAkKFRBUkdF
VFMpCiAK
--0016369201d011849b046dc27e31
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016369201d011849b046dc27e31
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016369201d011849b046dc27e31--

