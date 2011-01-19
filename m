Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfaGJ-0006us-Cg
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 15:47:55 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfaGI-0004pf-0u
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 15:47:55 +0000
Date: Wed, 19 Jan 2011 10:47:46 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1186837298.70819.1295452066448.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <823965169.56383.1295425072957.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_70818_1877183367.1295452066448"
Subject: Re: [LTP] [PATCH] mbind: add a missing Makefile
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_70818_1877183367.1295452066448
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Garrett, this patch still need to merge.

Thanks.

CAI Qian

----- Original Message -----
> The patch is attached.
> ------------------------------------------------------------------------------
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand
> malware threats, the impact they can have on your business, and how
> you
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_70818_1877183367.1295452066448
Content-Type: text/x-patch; name=0001-mbind-add-a-missing-Makefile.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-mbind-add-a-missing-Makefile.patch

RnJvbSA4YjhjOTlhMDJlMDM4NGU2YWY3M2NlNTk2NjM4YzU0MzY0ODRmOGUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjU0OjE5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbWJpbmQ6IGFk
ZCBhIG1pc3NpbmcgTWFrZWZpbGUKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkBy
ZWRoYXQuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL21iaW5kL01ha2VmaWxlIHwgICAy
NSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5l
bC9tZW0vbWJpbmQvTWFrZWZpbGUKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9t
YmluZC9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL21iaW5kL01ha2VmaWxlCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmUyMDJhNmIKLS0tIC9kZXYvbnVsbAorKysg
Yi90ZXN0Y2FzZXMva2VybmVsL21lbS9tYmluZC9NYWtlZmlsZQpAQCAtMCwwICsxLDI1IEBACisj
CisjICBDb3B5cmlnaHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4KKyMKKyMgIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
CisjICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFzIHB1Ymxpc2hlZCBieQorIyAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0CisjICB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCisjCisjICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhv
cGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisjICBXSVRIT1VUIEFOWSBXQVJSQU5UWTsg
d2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjICBNRVJDSEFOVEFCSUxJVFkg
b3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorIyAgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAgWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyMg
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3
YXJlCisjICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29y
LCBCb3N0b24sIE1BCisjICAwMjExMC0xMzAxLCBVU0EuCisjCisKK3RvcF9zcmNkaXIgICAgICAg
ICAgICAgID89IC4uLy4uLy4uLy4uCisKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21r
L3Rlc3RjYXNlcy5taworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19s
ZWFmX3RhcmdldC5taworCitMRExJQlMgCQkJKz0gJChOVU1BX0xJQlMpClwgTm8gbmV3bGluZSBh
dCBlbmQgb2YgZmlsZQotLSAKMS43LjMuMgoK
------=_Part_70818_1877183367.1295452066448
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_70818_1877183367.1295452066448
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_70818_1877183367.1295452066448--

