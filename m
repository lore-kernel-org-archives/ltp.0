Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXIR-0004ij-LZ
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:35 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXIM-0008Qj-CN
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:35 +0000
Received: by mail-yx0-f195.google.com with SMTP id 33so1894640yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:10:30 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:40:49 -0700
Message-ID: <364299f40907021740g4ab0692bp5c9d0b6197fc0b7a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e644d5e063e69b046dc2680c
Subject: [LTP] [1/10] config.mk not required for clean
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

--0016e644d5e063e69b046dc2680c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016e644d5e063e69b046dc2680c
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.1.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.1.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6ip7z1

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZC9NYWtlZmlsZQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZXZlbnRmZC9NYWtlZmlsZSx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42CmRpZmYgLXUgLXIxLjYg
TWFrZWZpbGUKLS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZC9NYWtlZmlsZQkx
NiBKYW4gMjAwOSAwOTowMzoxNCAtMDAwMAkxLjYKKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZXZlbnRmZC9NYWtlZmlsZQkzIEp1bCAyMDA5IDAwOjM5OjUyIC0wMDAwCkBAIC0xNiwxNSAr
MTYsMTcgQEAKICMgIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9v
ciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCiAjCiAKK3NyY2RpcgkJCT89IC4uLy4uLy4u
Ly4uLy4uCiAKLWluY2x1ZGUgLi4vLi4vLi4vLi4vY29uZmlnLm1rCitpZm5lcSAoJChNQUtFQ01E
R09BTFMpLGNsZWFuKQoraW5jbHVkZSAkKHNyY2RpcikvY29uZmlnLm1rCitlbmRpZgogCitDRkxB
R1MJCQkrPSAtSSQoc3JjZGlyKS9pbmNsdWRlIC1XYWxsCitMREZMQUdTCQkJKz0gLUwkKHNyY2Rp
cikvbGliCitMRExJQlMJCQk6PSAkKEFJT19MSUJTKSAtbGx0cAogCi1DRkxBR1MgKz0gLUkuLi8u
Li8uLi8uLi9pbmNsdWRlIC1XYWxsCi1MRExJQlMgKz0gLUwuLi8uLi8uLi8uLi9saWIgJChBSU9f
TElCUykgLWxsdHAKLQotU1JDUyAgICA9ICQod2lsZGNhcmQgKi5jKQotVEFSR0VUUyA9ICQocGF0
c3Vic3QgJS5jLCAlLCAkKHdpbGRjYXJkICouYykpCitUQVJHRVRTCQkJOj0gJChwYXRzdWJzdCAl
LmMsICUsICQod2lsZGNhcmQgKi5jKSkKIAogYWxsOiAkKFRBUkdFVFMpCiAK
--0016e644d5e063e69b046dc2680c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e644d5e063e69b046dc2680c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e644d5e063e69b046dc2680c--

