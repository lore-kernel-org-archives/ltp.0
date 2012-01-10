Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RkSPS-0001J9-NN
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:30:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkSPR-00086e-IQ
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:30:02 +0000
Message-ID: <4F0BB076.50605@cn.fujitsu.com>
Date: Tue, 10 Jan 2012 11:28:54 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F0A8E2D.8030305@cn.fujitsu.com>
	<201201091220.17521.vapier@gentoo.org>
	<4F0B9824.1080801@cn.fujitsu.com> <4F0BAFA9.50704@casparzhang.com>
In-Reply-To: <4F0BAFA9.50704@casparzhang.com>
Subject: Re: [LTP] [PATCH] fix getxattr02 case with errno EPERM
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
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

T24gMDEvMTAvMjAxMiAxMToyNSBBTSwgQ2FzcGFyIFpoYW5nIHdyb3RlOgoKPiBPbiAyMDEy5bm0
MDHmnIgxMOaXpSAwOTo0NSwgUGVuZyBIYWl0YW8gd3JvdGU6Cj4+ICsgOTXCuyDCuyAvKsK3QmVm
b3JlwrdrZXJuZWzCtzMuMC4wLMK3Z2V0eGF0dHIoMinCt3dpbGzCt3NldMK3ZXJybm/Ct3dpdGjC
tydFUEVSTScKPj4gKyA5NsK7IMK7IMK3KsK3d2hlbsK3dGhlwrdmaWxlwrdpc8K3bm90wrdhwrdy
ZWd1bGFywrdmaWxlwrdhbmTCt2RpcmVjdG9yeSzCt3JlZmVywrd0bwo+PiArIDk3wrsgwrsgwrcq
wrdjb21taXRpZMK3NTViMjNiZAo+PiArIDk4wrsgwrsgwrcqLwo+IAo+IEZvciBtdWx0aXBsZS1s
aW5lIGNvbW1lbnRzLCB3b3VsZCBpdCBiZSBiZXR0ZXIgdG8gYmU6Cj4gCj4gLyoKPiAgKiB4eHgK
PiAgKiB4eHgKPiAgKi8KCgpTdXJlLCB5b3UgYXJlIHJpZ2h0LgoKPiAKPiBDYXNwYXIKPiAKCgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCldyaXRlIG9uY2UuIFBvcnQgdG8gbWFueS4KR2V0IHRoZSBT
REsgYW5kIHRvb2xzIHRvIHNpbXBsaWZ5IGNyb3NzLXBsYXRmb3JtIGFwcCBkZXZlbG9wbWVudC4g
Q3JlYXRlIApuZXcgb3IgcG9ydCBleGlzdGluZyBhcHBzIHRvIHNlbGwgdG8gY29uc3VtZXJzIHdv
cmxkd2lkZS4gRXhwbG9yZSB0aGUgCkludGVsIEFwcFVwU00gcHJvZ3JhbSBkZXZlbG9wZXIgb3Bw
b3J0dW5pdHkuIGFwcGRldmVsb3Blci5pbnRlbC5jb20vam9pbgpodHRwOi8vcC5zZi5uZXQvc2Z1
L2ludGVsLWFwcGRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
