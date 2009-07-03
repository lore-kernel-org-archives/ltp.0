Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXAx-0007P5-Sq
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:02:51 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXAs-0001yY-89
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:02:51 +0000
Received: by gxk20 with SMTP id 20so1853686gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:02:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:41:59 -0700
Message-ID: <364299f40907021741x5d6c34bducb532eb87647b273@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e1c318f5f04046dc26cf7
Subject: [LTP] [PATCH 3/10] config.mk not required for clean
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

--0016368e1c318f5f04046dc26cf7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016368e1c318f5f04046dc26cf7
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.3.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.3.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6kcqc0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvaW8vYWlvL2FpbzAxL01ha2VmaWxlCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9pby9haW8vYWlvMDEv
TWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMgpkaWZmIC11IC1yMS4yIE1ha2VmaWxl
Ci0tLSB0ZXN0Y2FzZXMva2VybmVsL2lvL2Fpby9haW8wMS9NYWtlZmlsZQkyOCBKYW4gMjAwOSAw
Njo0MzowOSAtMDAwMAkxLjIKKysrIHRlc3RjYXNlcy9rZXJuZWwvaW8vYWlvL2FpbzAxL01ha2Vm
aWxlCTMgSnVsIDIwMDkgMDA6Mzk6NTUgLTAwMDAKQEAgLTIwLDEzICsyMCwxOCBAQAogIyBuYW1l
IG9mIGZpbGUJOiBNYWtlZmlsZQkJCQkJCSAgIwogIyBkZXNjcmlwdGlvbgk6IG1ha2UoMSkgZGVz
Y3JpcHRpb24gZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIwogIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjCi1pbmNsdWRlIC4uLy4uLy4uLy4uLy4uL2NvbmZpZy5tawogCi1DRkxBR1MrPQkt
SS4uLy4uLy4uLy4uLy4uL2luY2x1ZGUgLVdhbGwKLUxPQURMSUJFUys9CSQoQUlPX0xJQlMpIC1M
Li4vLi4vLi4vLi4vLi4vbGliIC1sbHRwCitzcmNkaXIJCQk/PSAuLi8uLi8uLi8uLi8uLgogCi1T
UkNTPSQod2lsZGNhcmQgKi5jKQotVEFSR0VUUz0kKHBhdHN1YnN0ICUuYywlLCQoU1JDUykpCitp
Zm5lcSAoJChNQUtFQ01ER09BTFMpLGNsZWFuKQoraW5jbHVkZSAkKHNyY2RpcikvY29uZmlnLm1r
CitlbmRpZgorCitDRkxBR1MJCQkrPSAtSSQoc3JjZGlyKS9pbmNsdWRlIC1XYWxsCitMREZMQUdT
CQkJKz0gLUwkKHNyY2RpcikvbGliCitMRExJQlMJCQkrPSAkKEFJT19MSUJTKSAtbGx0cAorCitU
QVJHRVRTCQkJOj0gJChwYXRzdWJzdCAlLmMsJSwkKHdpbGRjYXJkICouYykpCiAKIGFsbDogJChU
QVJHRVRTKQogCkBAIC0zNSw1ICs0MCwzIEBACiAKIGNsZWFuOgogCXJtIC1mICQoVEFSR0VUUykK
LQotCg==
--0016368e1c318f5f04046dc26cf7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016368e1c318f5f04046dc26cf7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e1c318f5f04046dc26cf7--

