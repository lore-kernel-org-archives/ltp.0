Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1S5YjW-00014n-Ix
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 08:29:58 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S5YjS-0004KI-9m
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 08:29:58 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q288Tmi0020726
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 8 Mar 2012 00:29:48 -0800 (PST)
Message-ID: <4F586DF8.1030008@windriver.com>
Date: Thu, 8 Mar 2012 16:29:44 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <4F584AF1.3010909@windriver.com>
In-Reply-To: <4F584AF1.3010909@windriver.com>
Subject: Re: [LTP] aio_read/8-1.c fails
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
To: ltp-list@lists.sourceforge.net

T24gMjAxMuW5tDAz5pyIMDjml6UgMTQ6MDAsIEthbmcgS2FpIHdyb3RlOgo+IEhpIEFsbCwKPgo+
IGFpb19yZWFkLzgtMS5jICJmaWxscyBpbiBhbiBhaW9jYiB3aXRoIGEgTlVMTCBhaW9fYnVmIiBh
bmQgdGhlbiBleHBlY3QKPiB0aGF0IHRoZSBvcGVyYXRpb24gaXMgbm90IHN1Y2Nlc2Z1bGx5IHF1
ZXVlZC4KPiBJdCBmYWlscyB0aGF0IGFpb19yZWFkKCkgYWx3YXlzIHJldHVybiAwLiBBbmQgSSBj
aGVja2VkIHRoZSBwb3NpeCBzcGVjCj4gYW5kIGRpZG4ndCBmaW5kIHRoYXQgYW4gYWlvY2Igd2l0
aCBOVUxMIGFpb19idWYgd2lsbCBjYXVzZSBlbnF1ZXVlIGZhaWxzLgo+IFNvIGlzIHRoaXMgY2Fz
ZSB2YWxpZD8KU28gZG9lcyB0aGUgY2FzZSBhaW9fd3JpdGUvNi0xLmMuCgo+Cj4gVGhhbmtzLAo+
IEthaQo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gVmlydHVhbGl6YXRpb24mICBDbG91ZCBN
YW5hZ2VtZW50IFVzaW5nIENhcGFjaXR5IFBsYW5uaW5nCj4gQ2xvdWQgY29tcHV0aW5nIG1ha2Vz
IHVzZSBvZiB2aXJ0dWFsaXphdGlvbiAtIGJ1dCBjbG91ZCBjb21wdXRpbmcKPiBhbHNvIGZvY3Vz
ZXMgb24gYWxsb3dpbmcgY29tcHV0aW5nIHRvIGJlIGRlbGl2ZXJlZCBhcyBhIHNlcnZpY2UuCj4g
aHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2ZubC8xMTQvNTE1MjEyMjMvCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMdHAtbGlzdCBtYWls
aW5nIGxpc3QKPiBMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpWaXJ0dWFsaXphdGlvbiAmIENsb3VkIE1hbmFnZW1lbnQgVXNpbmcgQ2FwYWNpdHkg
UGxhbm5pbmcKQ2xvdWQgY29tcHV0aW5nIG1ha2VzIHVzZSBvZiB2aXJ0dWFsaXphdGlvbiAtIGJ1
dCBjbG91ZCBjb21wdXRpbmcgCmFsc28gZm9jdXNlcyBvbiBhbGxvd2luZyBjb21wdXRpbmcgdG8g
YmUgZGVsaXZlcmVkIGFzIGEgc2VydmljZS4KaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcv
c2ZubC8xMTQvNTE1MjEyMjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxp
c3QK
