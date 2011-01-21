Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PgDkf-0006SM-Js
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:57:53 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgDke-0002IR-DB
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:57:53 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0L9vkSA001516
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Jan 2011 04:57:46 -0500
Date: Fri, 21 Jan 2011 04:57:46 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <323415307.101341.1295603866637.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1435824546.101326.1295603761218.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_101340_68250115.1295603866636"
Subject: Re: [LTP] [PATCH] check two possible pathes for cpuset
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_101340_68250115.1295603866636
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is the correct patch attached.

----- Original Message -----
> It can be difficult to predict if cpuset files have prefix or not,
> so only to fail after checked both.
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/lib/mem.c | 20 ++++++++++++++++----
> 1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> index 297eedd..72cf319 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -90,15 +90,27 @@ void write_cpusets(void)
> tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
> 
> fd = open(CPATH_NEW "/mems", O_WRONLY);
> - if (fd == -1)
> - tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + if (fd == -1) {
> + if (errno == ENOENT) {
> + fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
> + if (fd == -1)
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + } else
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + }
> if (write(fd, "1", 1) != 1)
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> 
> fd = open(CPATH_NEW "/cpus", O_WRONLY);
> - if (fd == -1)
> - tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + if (fd == -1) {
> + if (errno == ENOENT) {
> + fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
> + if (fd == -1)
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + } else
> + tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> + }
> if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> --
> 1.7.3.2

------=_Part_101340_68250115.1295603866636
Content-Type: text/x-patch;
	name=0001-check-two-possible-pathes-for-cpuset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-check-two-possible-pathes-for-cpuset.patch

RnJvbSAwYzYxZTFmNGU4YzU5MDVmMmI1OTg3MGRhOTliZTU3MjBhOTBhMGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBG
cmksIDIxIEphbiAyMDExIDE3OjQ5OjI3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gY2hlY2sgdHdv
IHBvc3NpYmxlIHBhdGhlcyBmb3IgY3B1c2V0CgpJdCBjYW4gYmUgZGlmZmljdWx0IHRvIHByZWRp
Y3QgaWYgY3B1c2V0IGZpbGVzIGhhdmUgcHJlZml4IG9yIG5vdCwKc28gb25seSB0byBmYWlsIGFm
dGVyIGNoZWNrZWQgYm90aC4KClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhh
dC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jIHwgICAyMCArKysrKysr
KysrKysrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwppbmRleCAyOTdlZWRkLi43MmNmMzE5IDEwMDY0
NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9saWIvbWVtLmMKKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9tZW0vbGliL21lbS5jCkBAIC05MCwxNSArOTAsMjcgQEAgdm9pZCB3cml0ZV9jcHVzZXRz
KHZvaWQpCiAJdHN0X3Jlc20oVElORk8sICJDUFUgbGlzdCBmb3IgMm5kIG5vZGUgaXMgJXMuIiwg
Y3B1cyk7CiAKIAlmZCA9IG9wZW4oQ1BBVEhfTkVXICIvbWVtcyIsIE9fV1JPTkxZKTsKLQlpZiAo
ZmQgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBi
dWYpOworCWlmIChmZCA9PSAtMSkgeworCQlpZiAoZXJybm8gPT0gRU5PRU5UKSB7CisJCQlmZCA9
IG9wZW4oQ1BBVEhfTkVXICIvY3B1c2V0Lm1lbXMiLCBPX1dST05MWSk7CisJCQlpZiAoZmQgPT0g
LTEpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7
CisJCX0gZWxzZQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIs
IGJ1Zik7CisJfQogCWlmICh3cml0ZShmZCwgIjEiLCAxKSAhPSAxKQogCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7CiAJY2xvc2UoZmQpOwogCiAJZmQg
PSBvcGVuKENQQVRIX05FVyAiL2NwdXMiLCBPX1dST05MWSk7Ci0JaWYgKGZkID09IC0xKQotCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKKwlpZiAoZmQg
PT0gLTEpIHsKKwkJaWYgKGVycm5vID09IEVOT0VOVCkgeworCQkJZmQgPSBvcGVuKENQQVRIX05F
VyAiL2NwdXNldC5jcHVzIiwgT19XUk9OTFkpOworCQkJaWYgKGZkID09IC0xKQorCQkJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCQl9IGVsc2UKKwkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCX0KIAlp
ZiAod3JpdGUoZmQsIGNwdXMsIHN0cmxlbihjcHVzKSkgIT0gc3RybGVuKGNwdXMpKQogCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7CiAJY2xvc2UoZmQp
OwotLSAKMS43LjMuMgoK
------=_Part_101340_68250115.1295603866636
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
------=_Part_101340_68250115.1295603866636
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_101340_68250115.1295603866636--

