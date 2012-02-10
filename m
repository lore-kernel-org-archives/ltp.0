Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Rvh9J-00007K-QD
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 03:27:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rvh9H-00057K-Vb
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 03:27:49 +0000
Message-ID: <4F348E73.9020101@cn.fujitsu.com>
Date: Fri, 10 Feb 2012 11:26:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328836130-8775-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328836130-8775-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F3481F2.9000009@casparzhang.com>
	<4F348A4F.2010907@cn.fujitsu.com>
In-Reply-To: <4F348A4F.2010907@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] hugemmap: use SAFE_STRTOL instead
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

T24gMDIvMTAvMjAxMiAxMTowOSBBTSwgV2FubG9uZyBHYW8gd3JvdGU6Cgo+IE9uIDAyLzEwLzIw
MTIgMTA6MzMgQU0sIENhc3BhciBaaGFuZyB3cm90ZToKPiAKPj4gT24gMDIvMTAvMjAxMiAwOTow
OCBBTSwgV2FubG9uZyBHYW8gd3JvdGU6Cj4+PiArMTA5wrsgwrsgaHVnZXBhZ2Vzwrc9wrdTQUZF
X1NUUlRPTChOVUxMLMK3bnJfb3B0LMK3TE9OR19NSU4swrdMT05HX01BWCk7Cj4+Cj4+IHdvdWxk
IGl0IGJldHRlciBpZiBgcy9MT05HX01JTi8wYCA/IFNpbmNlIG5yX2h1Z2VwYWdlcyB3b24ndCBk
byBlcnJvcgo+PiBjaGVjayBpZiBlY2hvaW5nIG5lZ2F0aXZlIHZhbHVlIHRvIGl0IChBRkFJSyku
CgoKQWgsIG5vLCBuZWdhdGl2ZSB3aWxsIG5vdCB3cml0ZSB0byBucl9odWdlcGFnZXMgYXQgYWxs
LgpJZiBzbywgaXQncyBtdXN0IGJlIGEga2VybmVsIGJ1Zy4KClRoYW5rcwotV2FubG9uZyBHYW8K
Cj4gCj4gCj4gbWFrZSBzZW5zZSwgdGhhbmtzIDspCj4gCj4+Cj4+IFRoYW5rcywKPj4gQ2FzcGFy
Cj4+Cj4gCj4gCj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gVmlydHVhbGl6YXRpb24gJiBD
bG91ZCBNYW5hZ2VtZW50IFVzaW5nIENhcGFjaXR5IFBsYW5uaW5nCj4gQ2xvdWQgY29tcHV0aW5n
IG1ha2VzIHVzZSBvZiB2aXJ0dWFsaXphdGlvbiAtIGJ1dCBjbG91ZCBjb21wdXRpbmcgCj4gYWxz
byBmb2N1c2VzIG9uIGFsbG93aW5nIGNvbXB1dGluZyB0byBiZSBkZWxpdmVyZWQgYXMgYSBzZXJ2
aWNlLgo+IGh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3NmbmwvMTE0LzUxNTIxMjIzLwo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRwLWxp
c3QgbWFpbGluZyBsaXN0Cj4gTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QKCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tClZpcnR1YWxpemF0aW9uICYgQ2xvdWQgTWFuYWdlbWVudCBVc2luZyBD
YXBhY2l0eSBQbGFubmluZwpDbG91ZCBjb21wdXRpbmcgbWFrZXMgdXNlIG9mIHZpcnR1YWxpemF0
aW9uIC0gYnV0IGNsb3VkIGNvbXB1dGluZyAKYWxzbyBmb2N1c2VzIG9uIGFsbG93aW5nIGNvbXB1
dGluZyB0byBiZSBkZWxpdmVyZWQgYXMgYSBzZXJ2aWNlLgpodHRwOi8vd3d3LmFjY2VsYWNvbW0u
Y29tL2phdy9zZm5sLzExNC81MTUyMTIyMy8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo=
