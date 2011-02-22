Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <lizf@cn.fujitsu.com>) id 1PrheW-0002Gu-RS
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 02:07:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrheQ-0001u1-JU
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 02:07:00 +0000
Message-ID: <4D631A92.8000904@cn.fujitsu.com>
Date: Tue, 22 Feb 2011 10:08:18 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <20110210072315.GA7909@hpt.nay.redhat.com>
	<4D6217CB.1040506@cn.fujitsu.com>
	<20110222015814.GA2883@hpt.nay.redhat.com>
In-Reply-To: <20110222015814.GA2883@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH] Fix disable set_ftrace_pid in
	ftrace_set_ftrace_pid.sh
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
To: "phan@redhat.com >> Han Pingtian" <phan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

5LqOIDIwMTHlubQwMuaciDIy5pelIDA5OjU4LCBIYW4gUGluZ3RpYW4g5YaZ6YGTOgo+IE9uIE1v
biwgRmViIDIxLCAyMDExIGF0IDAzOjQ0OjExUE0gKzA4MDAsIExpIFplZmFuIHdyb3RlOgo+PiBI
YW4gUGluZ3RpYW4gd3JvdGU6Cj4+PiBJdCBzZWVtcyB3ZSBuZWVkIGVjaG8gLTEgdG8gc2V0X2Z0
cmFjZV9waWQgdG8gZGlzYWJsZSBpbi4gT3Igd2UnbGwgZ2V0Cj4+PiB0aGVzZSBlcnJvciBtZXNz
YWdlIHdoZW4gcnVubmluZyBmdHJhY2Vfc3RyZXNzOgo+Pj4KPj4KPj4ga2VybmVsIHZlcnNpb24/
Cj4gMi42LjMyLTExNC4wLjEuZWw2Lng4Nl82NCAsIFJIRUw2LjEuCj4+Cj4+IFRoaXMgaXMgdGhl
IHJlc3VsdCBmcm9tIGxhdGVzdCBrZXJuZWw6Cj4+Cj4+ICMgZWNobyA+IHNldF9mdHJhY2VfcGlk
Cj4+ICMgZWNobyAtMSA+IHNldF9mdHJhY2VfcGlkCj4+IGJhc2g6IGVjaG86IHdyaXRlIGVycm9y
OiBJbnZhbGlkIGFyZ3VtZW50Cj4+Cj4gTG9va3MgbGlrZSBsYXRlc3Qga2VybmVsIGNoYW5nZWQg
dGhlIGJlaGF2aW91ci4gQnV0IHRoZQoKVGhlIGNoYW5nZSBjYW1lIGZyb20gY29tbWl0IDc1NmQx
N2VlN2VlNGZiYzgyMzhiZGY5NzEwMGFmNjNlNmFjNDQxZWYKClNvIHdlIGhhdmUgdG8gY2hlY2sg
dGhlIGtlcm5lbCB2ZXJzaW9uLCBvciB0cnkgYm90aCAiZWNobyA+IC4uLiIgYW5kCiJlY2hvIC0x
ID4gLi4uIi4KCj4gRG9jdW1lbnRhdGlvbi90cmFjZS9mdHJhY2UudHh0IGhhc24ndCBiZWVuIHVw
ZGF0ZWQ6Cj4gCj4gICAgICB5dW0tdXBkYXRlc2QtMzExMSAgWzAwM10gIDE2MzcuMjU0NjgzOiBs
b2NrX2hydGltZXJfYmFzZSA8LWhydGltZXJfdHJ5X3RvX2NhbmNlbAo+ICAgICAgeXVtLXVwZGF0
ZXNkLTMxMTEgIFswMDNdICAxNjM3LjI1NDY4NTogZmdldF9saWdodCA8LWRvX3N5c19wb2xsCj4g
ICAgICB5dW0tdXBkYXRlc2QtMzExMSAgWzAwM10gIDE2MzcuMjU0Njg2OiBwaXBlX3BvbGwgPC1k
b19zeXNfcG9sbAo+ICMgZWNobyAtMSA+IHNldF9mdHJhY2VfcGlkCj4gIyBjYXQgdHJhY2UgfGhl
YWQKPiAgIyB0cmFjZXI6IGZ1bmN0aW9uCj4gICMKPiAgIyAgICAgICAgICAgVEFTSy1QSUQgICAg
Q1BVIyAgICBUSU1FU1RBTVAgIEZVTkNUSU9OCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW5kZXgs
IFNlYXJjaCAmIEFuYWx5emUgTG9ncyBhbmQgb3RoZXIgSVQgZGF0YSBpbiBSZWFsLVRpbWUgd2l0
aCBTcGx1bmsgCkNvbGxlY3QsIGluZGV4IGFuZCBoYXJuZXNzIGFsbCB0aGUgZmFzdCBtb3Zpbmcg
SVQgZGF0YSBnZW5lcmF0ZWQgYnkgeW91ciAKYXBwbGljYXRpb25zLCBzZXJ2ZXJzIGFuZCBkZXZp
Y2VzIHdoZXRoZXIgcGh5c2ljYWwsIHZpcnR1YWwgb3IgaW4gdGhlIGNsb3VkLgpEZWxpdmVyIGNv
bXBsaWFuY2UgYXQgbG93ZXIgY29zdCBhbmQgZ2FpbiBuZXcgYnVzaW5lc3MgaW5zaWdodHMuIApG
cmVlIFNvZnR3YXJlIERvd25sb2FkOiBodHRwOi8vcC5zZi5uZXQvc2Z1L3NwbHVuay1kZXYyZGV2
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0
IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
