Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RkSdK-0001x0-Ft
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:44:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkSdI-00011R-V0
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:44:22 +0000
Message-ID: <4F0BB3D1.30701@cn.fujitsu.com>
Date: Tue, 10 Jan 2012 11:43:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
	<4F0BB312.5070009@casparzhang.com>
In-Reply-To: <4F0BB312.5070009@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

T24gMDEvMTAvMjAxMiAxMTo0MCBBTSwgQ2FzcGFyIFpoYW5nIHdyb3RlOgoKPiBPbiAyMDEy5bm0
MDHmnIgxMOaXpSAxMTozOCwgQ2FzcGFyIFpoYW5nIHdyb3RlOgo+Pgo+PiB3aGVuIGV4ZWN1dGlu
ZyB3aXRoIGAkQklOL3J1bmx0cGAgY29tbWFuZCwgZ2V0cnVzYWdlMDMgcHV0cyBvdXQKPj4gZHVw
bGljYXRlZCBpbmZvcm1hdGlvbiBkdWUgdG8gYnVmZmVyZWQgc3Rkb3V0LiBVc2luZyBmZmx1c2go
c3Rkb3V0KSB0bwo+PiBzb2x2ZSB0aGlzIGlzc3VlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDYXNw
YXIgWmhhbmcgPGNhc3BhckBjYXNwYXJ6aGFuZy5jb20+Cj4+IC0tLQo+PiAgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuYyAgfCAgICA3ICsrKysrKysKPj4g
IC4uLi9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzX2NoaWxkLmMgIHwgICAg
MSArCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
Pj4KPiAKPiBOb3Qgc3VyZSBpZiB3ZSBoYXZlIGFueSBiZXR0ZXIgc29sdXRpb24gdG8gYXZvaWQg
c3VjaCBidWZmZXJlZCBJL08gaXNzdWUuCgoKSSB0aGluayBpdCdzIE9LLgoKUmV2aWV3ZWQtYnk6
IFdhbmxvbmcgR2FvIDxnYW93YW5sb25nQGNuLmZ1aml0c3UuY29tPgoKVGhhbmtzCi1XYW5sb25n
IEdhbwoKPiAKPiBDYXNwYXIKPiAKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCldyaXRlIG9uY2Uu
IFBvcnQgdG8gbWFueS4KR2V0IHRoZSBTREsgYW5kIHRvb2xzIHRvIHNpbXBsaWZ5IGNyb3NzLXBs
YXRmb3JtIGFwcCBkZXZlbG9wbWVudC4gQ3JlYXRlIApuZXcgb3IgcG9ydCBleGlzdGluZyBhcHBz
IHRvIHNlbGwgdG8gY29uc3VtZXJzIHdvcmxkd2lkZS4gRXhwbG9yZSB0aGUgCkludGVsIEFwcFVw
U00gcHJvZ3JhbSBkZXZlbG9wZXIgb3Bwb3J0dW5pdHkuIGFwcGRldmVsb3Blci5pbnRlbC5jb20v
am9pbgpodHRwOi8vcC5zZi5uZXQvc2Z1L2ludGVsLWFwcGRldgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxp
c3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
