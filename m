Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sx6v5-0003nl-VT
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 01:43:15 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sx6v4-00052Q-KG
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 01:43:15 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q731h8jg005779
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 2 Aug 2012 18:43:08 -0700 (PDT)
Message-ID: <501B2CB3.6000501@windriver.com>
Date: Fri, 3 Aug 2012 09:43:15 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1343269349-24981-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1343269349-24981-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] aio_suspend/3-1: cancel the aio_write operations
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

T24gMjAxMuW5tDA35pyIMjbml6UgMTA6MjIsIEthbmcgS2FpIHdyb3RlOgo+IEFmdGVyIGFpb19z
dXNwZW5kLCBjYWxsIGFpb19jYW5jZWwgdG8gY2FuY2VsIG90aGVyIGFpb193cml0ZSBvcGVyYXRp
b25zCj4gdGhlbiB3YWl0IHRoZW0gdG8gY2FuY2VsZCBvciBjb21wbGV0ZS4KPgo+IElmIGRvbid0
IGRvIHRoYXQsIGl0IGZhaWxzIHdpdGggIlNlZ21lbnRhdGlvbiBmYXVsdCIgb24gcm91dGVyc3Rh
dGlvbihtaXBzKQo+IGJvYXJkIHJhbmRvbWx5IGFib3V0IGluIDEwMDAgY29udGludW91cyB0ZXN0
LiBUaGUgcmVhc29uIG1heSBiZSBzb21lCj4gYWlvX3dyaXRlcyBkb24ndCBjb21wbGV0ZSBiZWZv
cmUgY2xvc2UgdGhlIGZpbGUsIHRoYXQgY2F1c2Ugc29tZSByZXNvdXNlCj4gZG9uJ3QgYmUgcmVs
ZWFzZWQgYW5kIGZpbmFsbHkgY2F1c2Ugc2VnbWVudCBmYXVsdC4KCkhpLAoKV291bGQgYW55Ym9k
eSBsaWtlIHRvIHJldmlldyB0aGlzIHBhdGNoIGZvciBtZT8KClRoYW5rcywKCkthaQo+IFNpZ25l
ZC1vZmYtYnk6IEthbmcgS2FpPGthaS5rYW5nQHdpbmRyaXZlci5jb20+Cj4gLS0tCj4gICAuLi4v
Y29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fc3VzcGVuZC8zLTEuYyAgICAgICB8ICAgMTUgKysr
KysrKysrKysrKysrCj4gICAxIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX3N1c3BlbmQvMy0xLmMgYi90ZXN0Y2FzZXMvb3Bl
bl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fc3VzcGVuZC8zLTEu
Ywo+IGluZGV4IDE1MTIwZTEuLjQ5ZDIwNGEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX3N1c3BlbmQvMy0xLmMK
PiArKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJm
YWNlcy9haW9fc3VzcGVuZC8zLTEuYwo+IEBAIC04Nyw2ICs4NywyMSBAQCBpbnQgbWFpbigpCj4g
ICAJCWV4aXQoUFRTX0ZBSUwpOwo+ICAgCX0KPgo+ICsJaWYgKGFpb19jYW5jZWwoZmQsIE5VTEwp
ID09IC0xKSB7Cj4gKwkJcHJpbnRmKFROQU1FICIgRXJyb3IgYXQgYWlvX2NhbmNlbCgpOiAlc1xu
Iiwgc3RyZXJyb3IoZXJybm8pKTsKPiArCQlleGl0KFBUU19GQUlMKTsKPiArCX0KPiArCj4gKwo+
ICsJd2hpbGUgKDEpIHsKPiArCQlmb3IgKGkgPSAwOyBpPCAgTkFJT0NCOyArK2kpIHsKPiArCQkJ
aWYgKGFpb19lcnJvcigmYWlvY2JbaV0pID09IEVJTlBST0dSRVNTKQo+ICsJCQkJYnJlYWs7Cj4g
KwkJfQo+ICsJCWlmIChpID09IE5BSU9DQikKPiArCQkJYnJlYWs7Cj4gKwl9Cj4gKwo+ICAgCWNs
b3NlKGZkKTsKPiAgIAlwcmludGYoIlRlc3QgUEFTU0VEXG4iKTsKPiAgIAlyZXR1cm4gUFRTX1BB
U1M7CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkgVmlydHVhbCBDb25mZXJl
bmNlCkV4Y2x1c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3YXlzIHRvZGF5J3Mg
c2VjdXJpdHkgYW5kIAp0aHJlYXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFuZCBob3cgSVQgbWFu
YWdlcnMgY2FuIHJlc3BvbmQuIERpc2N1c3Npb25zIAp3aWxsIGluY2x1ZGUgZW5kcG9pbnQgc2Vj
dXJpdHksIG1vYmlsZSBzZWN1cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3YXJlIAp0aHJlYXRz
LiBodHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJubDA0MjQyMDEyLzExNC81MDEyMjI2
My8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxp
c3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
