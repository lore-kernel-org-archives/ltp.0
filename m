Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1Mc1gj-0005bF-5L
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 18:39:41 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mc1ga-00078c-PD
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 18:39:41 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 14 Aug 2009 11:39:19 -0700
Message-ID: <8368651DACC1964480F951191B94A078010C5F65@svexch01.mvista.com>
In-Reply-To: <d51f89b0908132355o21fa22f6occ62279279cb64b3@mail.gmail.com>
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>
	<1249387637.15587.29.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
	<4A7A9DFB.7050305@petalogix.com>
	<8368651DACC1964480F951191B94A078F8A312@svexch01.mvista.com>
	<364299f40908061921i39ad3e51q4aeffc666166c496@mail.gmail.com>
	<1249648916.4851.45.camel@subratamodak.linux.ibm.com>
	<d51f89b0908132355o21fa22f6occ62279279cb64b3@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH] Issue with rt_sigqueueinfo testcase in LTP.
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
To: rohit verma <rohit.170309@gmail.com>, subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHJvaGl0IHZlcm1hIFttYWlsdG86cm9o
aXQuMTcwMzA5QGdtYWlsLmNvbV0gDQpTZW50OiBUaHVyc2RheSwgQXVndXN0IDEzLCAyMDA5IDEx
OjU2IFBNDQpUbzogc3VicmF0YUBsaW51eC52bmV0LmlibS5jb20NCkNjOiBHYXJyZXR0IENvb3Bl
cjsgSGVucnkgWWVpOyBsdHAtbGlzdA0KU3ViamVjdDogUmU6IFtMVFBdIFtQQVRDSF0gSXNzdWUg
d2l0aCBydF9zaWdxdWV1ZWluZm8gdGVzdGNhc2UgaW4gTFRQLg0KDQpIaSwNCg0KPkkgaGF2ZSBj
aGVja2VkIEhlbnJ5xZsgcGF0Y2ggZm9yIHJ0X3NpZ3F1ZXVlaW5mbyBvbiBteSBzeXN0ZW0gKExp
bnV4LTIuNi4yOS4xKSwgSXQgc2VlbXMgdG8gYmUgPndvcmtpbmcgZmluZS4NCj5JJ20gbm90IHN1
cmUgYWJvdXQgdGhlIHBhcmVudC0gY2hpbGQgc3luY3Jvbml6YXRpb24gdGhhdCBHYXJyZXR0IGlz
IHRhbGtpbmcgYWJvdXQsIGhhdmVuJ3QgY2hlY2tlZCA+aXQgdGhvcm91Z2hseS4NCg0KRnlpLCBt
eSBwYXRjaCBtYXkgaGF2ZSBicm9rZW4gc29tZSBzdGFuZGFyZCBMVFAgZnVuY3Rpb25hbGl0eSwg
bGlrZSBydW5uaW5nIG11bHRpcGxlIGNvcGllcyAoLW4pLg0KDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlz
dGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNp
Z24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBk
byBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRo
IApDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDovL3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFp
bGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
