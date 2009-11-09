Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YD0-0004rn-EJ
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:18 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YCv-0005a9-2n
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:18 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200911090749.10428.vapier@gentoo.org>
References: <1257765429.7677.23.camel@subratamodak.linux.ibm.com>
	<200911090749.10428.vapier@gentoo.org>
Date: Mon, 09 Nov 2009 23:09:01 +0530
Message-Id: <1257788341.7677.62.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Clone build fail with the latest CVS sanpshot
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list <ltp-list@lists.sf.net>

T24gTW9uLCAyMDA5LTExLTA5IGF0IDA3OjQ5IC0wNTAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZTog
Cj4gT24gTW9uZGF5IDA5IE5vdmVtYmVyIDIwMDkgMDY6MTc6MDkgU3VicmF0YSBNb2RhayB3cm90
ZToKPiA+IEkgZ2V0IHRoZSBmb2xsb3dpbmcgZmFpbHVyZSB3aXRoIHRvZGF5xZsgQ1ZTLiAuL2Nv
bmZpZ3VyZSBoYXMgYmVlbiBkb25lCj4gPiBiZWZvcmUgbWFrZToKPiA+IAo+ID4gZ2NjIC1nIC1P
MiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUgLVdhbGwKPiA+IC1JL2x0cC1pbnRl
cm1lZGlhdGUtMjAwOTExMDkvdGVzdGNhc2VzL2tlcm5lbC9pbmNsdWRlCj4gPiAtSS9sdHAtaW50
ZXJtZWRpYXRlLTIwMDkxMTA5L3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tcW5zLy4uL2xp
YmNsb25lCj4gPiAgLUkuLi8uLi8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAg
Cj4gPiAgLUwvbHRwLWludGVybWVkaWF0ZS0yMDA5MTEwOS90ZXN0Y2FzZXMva2VybmVsL2NvbnRh
aW5lcnMvbXFucy8uLi9saWJjbG9uZQo+ID4gIC1MLi4vLi4vLi4vLi4vbGliICBtcW5zXzAxLmMg
ICAtbGx0cCAtbGNsb25lIC1scHRocmVhZCAtbHJ0IC1vIG1xbnNfMDEKPiA+ICAvbHRwLWludGVy
bWVkaWF0ZS0yMDA5MTEwOS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy8uLi9saWJj
bG9uZS9saQo+ID4gYmNsb25lLmEobGliY2xvbmUubyk6IEluIGZ1bmN0aW9uIGBkb19jbG9uZV90
ZXN0cyc6Cj4gPiAgL2x0cC1pbnRlcm1lZGlhdGUtMjAwOTExMDkvdGVzdGNhc2VzL2tlcm5lbC9j
b250YWluZXJzL2xpYmNsb25lL2xpYmNsb25lLmMKPiA+IDoyNTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgbHRwX2Nsb25lX3F1aWNrJyBjb2xsZWN0MjogbGQgcmV0dXJuZWQgMSBleGl0Cj4gPiAg
c3RhdHVzCj4gCj4gc2hvdWxkIGJlIGZpeGVkIG5vdy4gIHN0YXRpYyBsaWIgbGlua2luZyBvcmRl
ciBpcyBwaWNreS4KClRoYW5rcyBNaWtlLiBidWlsZGluZyBmaW5lIG5vdy4KClJlZ2FyZHMtLQpT
dWJyYXRhCgo+IC1taWtlCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9y
dHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURh
eSAKdHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRl
cGxveW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRp
b24gY29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4g
IGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbHRwLWxpc3QK
