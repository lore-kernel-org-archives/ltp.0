Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXEW-0006qs-JN
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:06:32 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXEQ-0002Xg-6j
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:06:32 +0000
Received: by yxe33 with SMTP id 33so1892050yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:06:25 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:44:33 -0700
Message-ID: <364299f40907021744q70e6c11p540d7e2e10cf90cb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e1c31be861b046dc27536
Subject: [LTP] [PATCH 4/10] config.mk not required for clean
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

--0016368e1c31be861b046dc27536
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016368e1c31be861b046dc27536
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.4.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.4.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6nrpq0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvaW8vYWlvL2FpbzAyL01ha2VmaWxlCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9pby9haW8vYWlvMDIv
TWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNgpkaWZmIC11IC1yMS42IE1ha2VmaWxl
Ci0tLSB0ZXN0Y2FzZXMva2VybmVsL2lvL2Fpby9haW8wMi9NYWtlZmlsZQkxOCBKdW4gMjAwOSAx
NzowNjo1OSAtMDAwMAkxLjYKKysrIHRlc3RjYXNlcy9rZXJuZWwvaW8vYWlvL2FpbzAyL01ha2Vm
aWxlCTMgSnVsIDIwMDkgMDA6Mzk6NTcgLTAwMDAKQEAgLTEsMTIgKzEsNDMgQEAKLWluY2x1ZGUg
Li4vLi4vLi4vLi4vLi4vY29uZmlnLm1rCisjCisjICAgIE1ha2VmaWxlIGZvcjoga2VybmVsL2lv
L2Fpby9haW8yIHRlc3RjYXNlLgorIworIyAgICBDb3B5cmlnaHQgKEMpIDIwMDksIENpc2NvIFN5
c3RlbXMgSW5jLgorIworIyAgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorIyAgICBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorIyAgICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorIyAgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorIworIyAg
ICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCwKKyMgICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhl
IGltcGxpZWQgd2FycmFudHkgb2YKKyMgICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9S
IEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorIyAgICBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAgICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2
ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZworIyAgICB3
aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLCBJbmMuLAorIyAgICA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0
b24sIE1BIDAyMTEwLTEzMDEgVVNBLgorIworIyBHYXJyZXR0IENvb3BlciwgSnVseSAyMDA5Cisj
CisjIENvcHlyaWdodCAoYykgMjAwOSBieSBDaXNjbyBTeXN0ZW1zLCBJbmMuCisjIEFsbCByaWdo
dHMgcmVzZXJ2ZWQKKyMKKworc3JjZGlyCQkJPz0gLi4vLi4vLi4vLi4vLi4KKworaWZuZXEgKCQo
TUFLRUNNREdPQUxTKSxjbGVhbikKK2luY2x1ZGUgJChzcmNkaXIpL2NvbmZpZy5taworZW5kaWYK
KworQ0ZMQUdTCQkJKz0gLVdhbGwgLWcgLU8gLUkkKHNyY2RpcikvaW5jbHVkZSAtV2FsbAorTERG
TEFHUwkJCSs9IC1MJChzcmNkaXIpL2xpYgorTERMSUJTCQkJKz0gLWxsdHAgJChBSU9fTElCUykK
KwogIyBmb28uCi1URVNUX1NSQ1M6PSQoc2hlbGwgZmluZCBjYXNlcy8gLW5hbWUgXCouYyB8IHNv
cnQgLW4gLXQvIC1rMikKLVBST0dTOj0kKHBhdHN1YnN0ICUuYywlLCQoVEVTVF9TUkNTKSkKLUhB
Uk5FU1NfU1JDUzo9bWFpbi5jCitQUk9HUwkJCTo9ICQocGF0c3Vic3QgJS5jLCUsJCh3aWxkY2Fy
ZCBjYXNlcy8qLmMpKQorSEFSTkVTU19TUkNTCQk6PSBtYWluLmMKICMgaW9fcXVldWUuYwogCi1D
RkxBR1MrPS1XYWxsICAtZyAtTyAtSS4uLy4uLy4uLy4uLy4uL2luY2x1ZGUgLVdhbGwKLUxERkxB
R1MrPS1MLi4vLi4vLi4vLi4vLi4vbGliIC1sbHRwICQoQUlPX0xJQlMpCiAjLWxwdGhyZWFkIC1s
cnQKIGFsbDogJChQUk9HUykKIApAQCAtMTYsNSArNDcsNSBAQAogY2xlYW46CiAJcm0gLWYgJChQ
Uk9HUykgKi5vIHJ1bnRlc3RzLm91dCByb2ZpbGUgd29maWxlIHJ3ZmlsZQogCi1pbnN0YWxsOgor
aW5zdGFsbDogOwogCg==
--0016368e1c31be861b046dc27536
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016368e1c31be861b046dc27536
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e1c31be861b046dc27536--

