Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXI6-0007jj-Ra
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:14 +0000
Received: from an-out-0708.google.com ([209.85.132.243])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXHh-0002yu-6S
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:14 +0000
Received: by an-out-0708.google.com with SMTP id c38so873113ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:09:48 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:46:24 -0700
Message-ID: <364299f40907021746k7c5f40a1u40c7859fa3a39718@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e208b60904f046dc27c10
Subject: [LTP] [PATCH 9/10] config.mk not required for clean
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

--0016368e208b60904f046dc27c10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016368e208b60904f046dc27c10
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.9.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.9.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6q4ev0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fc2V0dXAvTWFrZWZpbGUKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2lvX3NldHVwL01ha2VmaWxlLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjMKZGlmZiAtdSAtcjEu
MyBNYWtlZmlsZQotLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb19zZXR1cC9NYWtlZmls
ZQkyMCBKYW4gMjAwOSAxMDo0ODo0MiAtMDAwMAkxLjMKKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaW9fc2V0dXAvTWFrZWZpbGUJMyBKdWwgMjAwOSAwMDo0MDowNiAtMDAwMApAQCAtMjAs
MTUgKzIwLDE3IEBACiAjICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGgg
Rmxvb3IsIEJvc3RvbiwgTUEgIDAyMTEwLTEzMDEgIFVTQQogIwogCitzcmNkaXIJCQk/PSAuLi8u
Li8uLi8uLi8uLgogCi1pbmNsdWRlIC4uLy4uLy4uLy4uL2NvbmZpZy5taworaWZuZXEgKCQoTUFL
RUNNREdPQUxTKSxjbGVhbikKK2luY2x1ZGUgJChzcmNkaXIpL2NvbmZpZy5taworZW5kaWYKIAor
Q0ZMQUdTIAkJCSs9IC1JJChzcmNkaXIpL2luY2x1ZGUgLVdhbGwKK0xERkxBR1MJCQkrPSAkKEFJ
T19MSUJTKSAtTCQoc3JjZGlyKS9saWIKK0xETElCUwkJCSs9IC1sbHRwCiAKLVNSQ1MgICAgPSAk
KHdpbGRjYXJkICouYykKLVRBUkdFVFMgPSAkKHBhdHN1YnN0ICUuYywlLCQoU1JDUykpCi0KLUNG
TEFHUyArPSAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLVdhbGwKLUxETElCUyArPSAkKEFJT19MSUJT
KSAtTC4uLy4uLy4uLy4uL2xpYiAtbGx0cAorVEFSR0VUUyAJCTo9ICQocGF0c3Vic3QgJS5jLCUs
JCh3aWxkY2FyZCAqLmMpKQogCiBhbGw6ICQoVEFSR0VUUykKIAo=
--0016368e208b60904f046dc27c10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016368e208b60904f046dc27c10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e208b60904f046dc27c10--

