Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Rk6P3-0002Rd-6r
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 04:00:09 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rk6P0-0005kC-UD
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 04:00:09 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q091wcTo017603
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Sun, 8 Jan 2012 17:58:38 -0800 (PST)
Message-ID: <4F0A49CD.1010604@windriver.com>
Date: Mon, 9 Jan 2012 09:58:37 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1325302366-375-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1325302366-375-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] mq_timedsend/5-1: make parent has chance to sleep
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
Cc: ltp-list@lists.sourceforge.net

T24gMjAxMeW5tDEy5pyIMzHml6UgMTE6MzIsIEthbmcgS2FpIHdyb3RlOgo+IENoaWxkIHByb2Nl
c3Mgc2VuZHMgdGhlIGxhc3Qgc2lnbmFsIGJlZm9yZSBwYXJlbnQgcHJvY2VzcyBlbnRlciB0aGUK
PiBmaW5hbCBzbGVlcCBzb21ldGltZXMsIHNvIHNsZWVwIGluIHBhcmVudCB3aWxsIG5vdCBiZSBp
bnRlcnJ1cHRlZCB0aGVuCj4gdGhlIGNhc2UgZmFpbHMuCj4gU2xlZXAgMSBzZWNvbmQgYmVmb3Jl
IHNlbmQgdGhlIGxhc3Qgc2lnbmFsIGluIGNoaWxkIHRvIG1ha2Ugc3VyZSBwYXJlbnQKPiBlbnRl
ciB0aGUgZmluYWwgc2xlZXAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBLYW5nIEthaTxrYWkua2FuZ0B3
aW5kcml2ZXIuY29tPgo+IC0tLQo+ICAgLi4uL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfdGlt
ZWRzZW5kLzUtMS5jICAgICAgfCAgICA1ICsrKystCj4gICAxIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvb3Bl
bl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV90aW1lZHNlbmQvNS0x
LmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9tcV90aW1lZHNlbmQvNS0xLmMKPiBpbmRleCA5NmRhZjcyLi4zNzk5M2M4IDEwMDY0NAo+IC0t
LSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2Vz
L21xX3RpbWVkc2VuZC81LTEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0
ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21xX3RpbWVkc2VuZC81LTEuYwo+IEBAIC04Miw2ICs4
Miw5IEBAIGludCBtYWluKCkKPiAgIAkJc2xlZXAoMSk7ICAvLyBnaXZlIHBhcmVudCB0aW1lIHRv
IHNldCB1cCBoYW5kbGVyCj4gICAJCWZvciAoaT0wOyBpPE1BWE1TRysxOyBpKyspIHsKPiAgICAg
ICAgICAgCQltcV90aW1lZHNlbmQoZ3F1ZXVlLCBtc2dwdHIsIHN0cmxlbihtc2dwdHIpLCAxLCZ0
cyk7Cj4gKyAgICAgICAgICAgIC8qIG1ha2Ugc3VyZSBwYXJlbnQgZW50ZXIgdGhlIGZpbmFsIHNs
ZWVwICovCj4gKwkJCWlmIChpID09IE1BWE1TRykKPiArICAgICAgICAgICAgICAgIHNsZWVwKDEp
Owo+ICAgCQkJLyogc2VuZCBzaWduYWwgdG8gcGFyZW50IGVhY2ggdGltZSBtZXNzYWdlIGlzIHNl
bnQgKi8KPiAgIAkJCWtpbGwoZ2V0cHBpZCgpLCBTSUdBQlJUKTsKPiAgIAkJfQo+IEBAIC0xMzgs
NCArMTQxLDQgQEAgaW50IG1haW4oKQo+ICAgCX0KPgo+ICAgCXJldHVybiBQVFNfVU5SRVNPTFZF
RDsKPiAtfQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQo+ICt9CgpDb3VsZCBhbnlvbmUg
Z2l2ZSBzb21lIGNvbW1lbnRzIGFib3V0IHRoaXMgcGF0Y2g/ClRoYW5rcyBhIGxvdCEKClJlZ2Fy
ZHMsCkthaQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJpZGljdWxvdXNseSBlYXN5IFZESS4gV2l0
aCBDaXRyaXggVkRJLWluLWEtQm94LCB5b3UgZG9uJ3QgbmVlZCBhIGNvbXBsZXgKaW5mcmFzdHJ1
Y3R1cmUgb3IgdmFzdCBJVCByZXNvdXJjZXMgdG8gZGVsaXZlciBzZWFtbGVzcywgc2VjdXJlIGFj
Y2VzcyB0bwp2aXJ0dWFsIGRlc2t0b3BzLiBXaXRoIHRoaXMgYWxsLWluLW9uZSBzb2x1dGlvbiwg
ZWFzaWx5IGRlcGxveSB2aXJ0dWFsIApkZXNrdG9wcyBmb3IgbGVzcyB0aGFuIHRoZSBjb3N0IG9m
IFBDcyBhbmQgc2F2ZSA2MCUgb24gVkRJIGluZnJhc3RydWN0dXJlIApjb3N0cy4gVHJ5IGl0IGZy
ZWUhIGh0dHA6Ly9wLnNmLm5ldC9zZnUvQ2l0cml4LVZESWluYWJveApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRw
LWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
