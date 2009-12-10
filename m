Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NIhn4-0005aN-4j
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 12:06:38 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NIhmx-0001uV-H0
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 12:06:38 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBAC3lgK032138
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Dec 2009 07:03:47 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBAC6FSW130734
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Dec 2009 07:06:15 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBAC6Fec027188
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Dec 2009 07:06:15 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1515718228.139261260411127991.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1515718228.139261260411127991.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Thu, 10 Dec 2009 17:36:11 +0530
Message-Id: <1260446771.7501.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]fix compile error on ppc64 in RHEL5
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

SGkgQ2FzcGFyLAoKSSBqdXN0IGhhdmUgMSBxdWVzdGlvbiBiZWxvdzoKCk9uIFdlZCwgMjAwOS0x
Mi0wOSBhdCAyMToxMiAtMDUwMCwgQ2FzcGFyIFpoYW5nIHdyb3RlOgo+IEhpIGFsbCwKPiAgCj4g
V2hlbiBJIGNvbXBpbGUgbHRwLWZ1bGwtMjAwOTExMzAgb24gcHBjNjQgbWFjaGluZSB3aGljaCBz
eXN0ZW0gaXMKPiBSSEVMNShrZXJuZWwgMi42LjE4KSwgSSBtZXQgY29tcGlsZSBlcnJvciBhcyBm
b2xsb3dzOgo+IAo+IFsuLi5dCj4gcHRyYWNlMDQuYzogSW4gZnVuY3Rpb24g4oCYY29tcGFyZV9y
ZWdpc3RlcnPigJk6Cj4gcHRyYWNlMDQuYzo1OTogZXJyb3I6IOKAmFBUUkFDRV9HRVRSRUdT4oCZ
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzCj4gZnVuY3Rpb24pCj4gcHRyYWNlMDQuYzo1
OTogZXJyb3I6IChFYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5Cj4g
b25jZQo+IHB0cmFjZTA0LmM6NTk6IGVycm9yOiBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJz
IGluLikKPiBtYWtlWzVdOiAqKiogW3B0cmFjZTA0XSBFcnJvciAxCj4gWy4uLl0KPiAKPiBJdCBz
ZWVtcyBsaWtlIHRoZXJlJ3Mgbm8gUFRSQUNFX0dFVFJFR1MgaW4gL3Vzci9pbmNsdWRlL2FzbS9w
dHJhY2UuaAo+IGluIG9sZCBrZXJuZWxzLCBzbyBJIGNvcHkgdGhlIGRlZmluaXRpb25zIGZyb20g
bmV3IHZlcnNpb24gb2YgdGhlCj4gaGVhZCBmaWxlIGFuZCBteSBsdHAgb24gcHBjNjQsIFJIRUw1
IHdvcmtzLgoKQXJlIHRoZXNlIG5vcy4gc2ltaWxhciBhY3Jvc3MgYWxsIGFyY2hzID8gSWYgdGhl
eSBhcmUgc3BlY2lmaWMgb25seSB0bwpQUEMsIHlvdSBjYW4gdGhlbiBhZGQgdGhlIGZvbGxvd2lu
ZyAyIG1vcmUgbGluZXMgdG8geW91ciBwYXRjaDoKCj4gCj4gVGhhbmtzLAo+IENhc3BhciAKPiAK
PiAKPiAKPiAKPiAKPiAKPiBkaWZmZXJlbmNlcwo+IGJldHdlZW4gZmlsZXMKPiBhdHRhY2htZW50
Cj4gKHJoZWw1LXBwYy1QVFJBQ0VfR0VUUkVHUy1jb21waWxlLWVyci5wYXRjaCkKPiAKPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlLmgKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFjZS5oCj4gaW5kZXggYTBkMjcwOC4u
ZTNmY2JiMiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9w
dHJhY2UuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFjZS5o
Cj4gQEAgLTM3LDQgKzM3LDI3IEBAIHR5cGVkZWYgc3RydWN0IHVzZXJfcmVnc19zdHJ1Y3QgcHRy
YWNlX3JlZ3M7Cj4gICN1bmRlZiBIQVZFX1NUUlVDVF9QVFJBQ0VfUkVHUwo+ICAjZW5kaWYKPiAK
PiArLyogb2xkIGtlcm5lbCBkb2Vzbid0IGhhdmUgUFRSQUNFX0dFVFJFR1Mgb24gcHBjNjQgKi8K
PiArLyogKG5ldykgUFRSQUNFIHJlcXVlc3RzIHVzaW5nIHRoZSBzYW1lIG51bWJlcnMgYXMgeDg2
IGFuZCB0aGUgc2FtZQo+ICsgKiBhcmd1bWVudCBvcmRlcmluZy4gQWRkaXRpb25hbGx5LCB0aGV5
IHN1cHBvcnQgbW9yZSByZWdpc3RlcnMgdG9vCj4gKyAqLwoKI2lmIGRlZmluZWQocG93ZXJwYykg
fHwgZGVmaW5lZChfX3Bvd2VycGNfXykgfHwgZGVmaW5lZChfX3BwY19fKSB8fApkZWZpbmVkIChf
X1BQQ19fKQo+ICsjaWZuZGVmIFBUUkFDRV9HRVRSRUdTCj4gKyMgZGVmaW5lIFBUUkFDRV9HRVRS
RUdTICAgICAgICAgICAgMTIKPiArI2VuZGlmCj4gKyNpZm5kZWYgUFRSQUNFX1NFVFJFR1MKPiAr
IyBkZWZpbmUgUFRSQUNFX1NFVFJFR1MgICAgICAgICAgICAxMwo+ICsjZW5kaWYKPiArI2lmbmRl
ZiBQVFJBQ0VfR0VURlBSRUdTCj4gKyMgZGVmaW5lIFBUUkFDRV9HRVRGUFJFR1MgICAgICAgICAg
MTQKPiArI2VuZGlmCj4gKyNpZm5kZWYgUFRSQUNFX1NFVEZQUkVHUwo+ICsjIGRlZmluZSBQVFJB
Q0VfU0VURlBSRUdTICAgICAgICAgIDE1Cj4gKyNlbmRpZgo+ICsjaWZuZGVmIFBUUkFDRV9HRVRS
RUdTNjQKPiArIyBkZWZpbmUgUFRSQUNFX0dFVFJFR1M2NCAgICAgICAgICAyMgo+ICsjZW5kaWYK
PiArI2lmbmRlZiBQVFJBQ0VfU0VUUkVHUzY0Cj4gKyMgZGVmaW5lIFBUUkFDRV9TRVRSRUdTNjQg
ICAgICAgICAgMjMKPiArI2VuZGlmCj4gKwo+ICAjZW5kaWYKCiNlbmRpZgoKUmVnYXJkcy0tClN1
YnJhdGEKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJldHVybiBvbiBJbmZvcm1hdGlvbjoKR29v
Z2xlIEVudGVycHJpc2UgU2VhcmNoIHBheXMgeW91IGJhY2sKR2V0IHRoZSBmYWN0cy4KaHR0cDov
L3Auc2YubmV0L3NmdS9nb29nbGUtZGV2MmRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2x0cC1saXN0Cg==
