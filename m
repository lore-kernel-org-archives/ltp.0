Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T4Miv-0007Kj-Nk
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 02:00:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4Miu-0004xI-7c
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 02:00:41 +0000
Message-ID: <50358DFF.2000904@cn.fujitsu.com>
Date: Thu, 23 Aug 2012 09:57:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
	<1344508258-25054-2-git-send-email-kai.kang@windriver.com>
	<5024E0F0.3080406@redhat.com> <50286B90.90104@windriver.com>
In-Reply-To: <50286B90.90104@windriver.com>
Subject: Re: [LTP] [PATCH 1/3] pthread_cond_signal/1-1: use sched_yield to
 sync	threads
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

T24gMDgvMTMvMjAxMiAxMDo1MCBBTSwgS2FuZyBLYWkgd3JvdGU6Cj4gT24gMjAxMuW5tDA45pyI
MTDml6UgMTg6MjIsIEphbiBTdGFuY2VrIHdyb3RlOgo+PiA+IEhpLAo+IEhpIEphbiwKPiAKPiBU
aGFua3MgZm9yIHlvdXIgcmVwbHkuCj4+ID4gSGVyZSdzIGEgZGlmZmVyZW50IHByb3Bvc2FsOiBk
b24ndCBjb3VudCBob3cgbWFueSBwdGhyZWFkX2NvbmRfc2lnbmFscyBpdCB0b29rLAo+PiA+IGlm
IGFueSBmYWlscyBTSUdBTFJNIHdpbGwgdHJpZ2dlciB0ZXN0Y2FzZSBmYWlsdXJlLgo+IFRoYXQg
aXMgYSBtb3JlIHNpbXBsZSBzb2x1dGlvbiwgYW5kIEkgYWdyZWUgd2l0aCB5b3UuCgpTbywgSmFu
LCBjYW4geW91IHNlbmQgb3V0IGEgcGF0Y2g/CgpUaGFua3MsCldhbmxvbmcgR2FvCgo+IAo+IFJl
Z2FyZHMsCj4gS2FpCj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkgVmly
dHVhbCBDb25mZXJlbmNlCkV4Y2x1c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3
YXlzIHRvZGF5J3Mgc2VjdXJpdHkgYW5kIAp0aHJlYXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFu
ZCBob3cgSVQgbWFuYWdlcnMgY2FuIHJlc3BvbmQuIERpc2N1c3Npb25zIAp3aWxsIGluY2x1ZGUg
ZW5kcG9pbnQgc2VjdXJpdHksIG1vYmlsZSBzZWN1cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3
YXJlIAp0aHJlYXRzLiBodHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJubDA0MjQyMDEy
LzExNC81MDEyMjI2My8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
