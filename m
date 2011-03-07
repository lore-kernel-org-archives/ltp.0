Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PwcRA-0007ew-Cs
	for ltp-list@lists.sourceforge.net; Mon, 07 Mar 2011 15:33:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PwcR9-0005sg-Bf
	for ltp-list@lists.sourceforge.net; Mon, 07 Mar 2011 15:33:32 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p27FXP9S003304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Mar 2011 10:33:25 -0500
Message-ID: <4D74FAA1.4000105@redhat.com>
Date: Mon, 07 Mar 2011 23:32:49 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000203050601040409030700"
Subject: [LTP] mm: mtest01(w): fail to get EOF on some archs
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

This is a multi-part message in MIME format.
--------------000203050601040409030700
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

on some secondary archs (e.g. ppc64), mtest01(w) tests fails for
incorrect argument. Digged into the problem, we found this sentense:
  while ((c = getopt(argc, argv, "c:b:p:wvh")) != -1)
here 'c' is char type instead of int. It runs well on x86 systems, but
gets failed on ppc64, s/390x systems, since it returns 255 instead of -1
when 'c' is char type.
This failure was introduced in commit
8147b761b08eefde4f9b965fabb9ef614b3d5817, this patch fixes the issue.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c
b/testcases/kernel/mem/mtest01/mtest01.c
index b247dbf..dc960a8 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -59,7 +59,8 @@ void handler(int signo)

 int main(int argc, char* argv[])
 {
-	char c, *mem;
+	int c;
+	char *mem;
 	float percent;
 	unsigned int maxpercent = 0, dowrite = 0, verbose=0, j;
 	unsigned long bytecount, alloc_bytes, max_pids;
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------000203050601040409030700
Content-Type: text/plain;
	name="0002-mm-mtest01-w-fail-to-get-EOF-on-some-archs.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0002-mm-mtest01-w-fail-to-get-EOF-on-some-archs.patch"

bW06IG10ZXN0MDEodyk6IGZhaWwgdG8gZ2V0IEVPRiBvbiBzb21lIGFyY2hzCgpvbiBzb21l
IHNlY29uZGFyeSBhcmNocyAoZS5nLiBwcGM2NCksIG10ZXN0MDEodykgdGVzdHMgZmFpbHMg
Zm9yCmluY29ycmVjdCBhcmd1bWVudC4gRGlnZ2VkIGludG8gdGhlIHByb2JsZW0sIHdlIGZv
dW5kIHRoaXMgc2VudGVuc2U6CiAgd2hpbGUgKChjID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJj
OmI6cDp3dmgiKSkgIT0gLTEpCmhlcmUgJ2MnIGlzIGNoYXIgdHlwZSBpbnN0ZWFkIG9mIGlu
dC4gSXQgcnVucyB3ZWxsIG9uIHg4NiBzeXN0ZW1zLCBidXQKZ2V0cyBmYWlsZWQgb24gcHBj
NjQsIHMvMzkweCBzeXN0ZW1zLCBzaW5jZSBpdCByZXR1cm5zIDI1NSBpbnN0ZWFkIG9mIC0x
CndoZW4gJ2MnIGlzIGNoYXIgdHlwZS4KVGhpcyBmYWlsdXJlIHdhcyBpbnRyb2R1Y2VkIGlu
IGNvbW1pdAo4MTQ3Yjc2MWIwOGVlZmRlNGY5Yjk2NWZhYmI5ZWY2MTRiM2Q1ODE3LCB0aGlz
IHBhdGNoIGZpeGVzIHRoZSBpc3N1ZS4KClNpZ25lZC1vZmYtYnk6IENhc3BhciBaaGFuZyA8
Y3poYW5nQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3QwMS9t
dGVzdDAxLmMgfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRl
c3QwMS9tdGVzdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9tdGVzdDAxL210ZXN0MDEu
YwppbmRleCBiMjQ3ZGJmLi5kYzk2MGE4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9tdGVzdDAxL210ZXN0MDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9tdGVz
dDAxL210ZXN0MDEuYwpAQCAtNTksNyArNTksOCBAQCB2b2lkIGhhbmRsZXIoaW50IHNpZ25v
KQogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciogYXJndltdKQogewotCWNoYXIgYywgKm1l
bTsKKwlpbnQgYzsKKwljaGFyICptZW07CiAJZmxvYXQgcGVyY2VudDsKIAl1bnNpZ25lZCBp
bnQgbWF4cGVyY2VudCA9IDAsIGRvd3JpdGUgPSAwLCB2ZXJib3NlPTAsIGo7CiAJdW5zaWdu
ZWQgbG9uZyBieXRlY291bnQsIGFsbG9jX2J5dGVzLCBtYXhfcGlkczsKLS0gCjEuNy40LjEK
Cg==
--------------000203050601040409030700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--------------000203050601040409030700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000203050601040409030700--

