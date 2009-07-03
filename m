Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXIJ-00072l-GR
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:27 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXIE-0008Qj-72
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:27 +0000
Received: by yxe33 with SMTP id 33so1894640yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:10:21 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:44:55 -0700
Message-ID: <364299f40907021744i498536afwb71c8d6820cdecc5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e64f918e0d61e9046dc27703
Subject: [LTP] [PATCH 5/10] config.mk not required for clean
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

--0016e64f918e0d61e9046dc27703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016e64f918e0d61e9046dc27703
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.5.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.5.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6o8d90

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvZnMvcHJvYy9NYWtlZmlsZQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3Rlc3RjYXNlcy9rZXJuZWwvZnMvcHJvYy9NYWtlZmlsZSx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS41CmRpZmYgLXUgLXIxLjUgTWFrZWZpbGUKLS0tIHRlc3Rj
YXNlcy9rZXJuZWwvZnMvcHJvYy9NYWtlZmlsZQk1IEZlYiAyMDA5IDExOjE4OjU4IC0wMDAwCTEu
NQorKysgdGVzdGNhc2VzL2tlcm5lbC9mcy9wcm9jL01ha2VmaWxlCTMgSnVsIDIwMDkgMDA6Mzk6
NTkgLTAwMDAKQEAgLTE2LDEzICsxNiwxNyBAQAogIyAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVt
cGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKICMKIAotaW5j
bHVkZSAuLi8uLi8uLi8uLi9jb25maWcubWsKK3NyY2RpcgkJCT89IC4uLy4uLy4uLy4uCiAKLUNG
TEFHUys9CS1JLi4vLi4vLi4vLi4vaW5jbHVkZQotTERMSUJTKz0JLUwuLi8uLi8uLi8uLi9saWIg
LWxsdHAgJChTRUxJTlVYX0xJQlMpCitpZm5lcSAoJChNQUtFQ01ER09BTFMpLGNsZWFuKQoraW5j
bHVkZSAkKHNyY2RpcikvY29uZmlnLm1rCitlbmRpZgogCi1TUkNTPSQod2lsZGNhcmQgKi5jKQot
VEFSR0VUUz0kKHBhdHN1YnN0ICUuYywlLCQoU1JDUykpCitDRkxBR1MJCQkrPSAtSSQoc3JjZGly
KS9pbmNsdWRlCitMREZMQUdTCQkJKz0gLUwkKHNyY2RpcikvbGliIAorTERMSUJTCQkJKz0gLWxs
dHAgJChTRUxJTlVYX0xJQlMpCisKK1RBUkdFVFMJCQk6PSAkKHBhdHN1YnN0ICUuYywlLCQod2ls
ZGNhcmQgKi5jKSkKIAogYWxsOiAkKFRBUkdFVFMpCiAK
--0016e64f918e0d61e9046dc27703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e64f918e0d61e9046dc27703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e64f918e0d61e9046dc27703--

