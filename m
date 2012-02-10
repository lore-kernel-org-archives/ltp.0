Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RvfFR-0004CO-LF
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 01:26:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RvfFQ-0008Ft-Sj
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 01:26:01 +0000
Message-ID: <4F3471EB.6060604@cn.fujitsu.com>
Date: Fri, 10 Feb 2012 09:24:59 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328828750-11079-1-git-send-email-vlee@twitter.com>
In-Reply-To: <1328828750-11079-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] safe_macros: Include errno.h.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

T24gMDIvMTAvMjAxMiAwNzowNSBBTSwgVmluc29uIExlZSB3cm90ZToKCj4gRml4IGJ1aWxkIHJl
Z3Jlc3Npb24gaW50cm9kdWNlZCBieSBjb21taXQKPiBkNmExZjI1MTM3YjBhYzg3MDRiZDA4Y2M0
YmM4YWYwMWNjZWFjYTBlLgo+IAo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBidWlsZCBlcnJvciBv
biBVYnVudHUgMTEuMTAuCj4gc2FmZV9tYWNyb3MuYzogSW4gZnVuY3Rpb24g4oCYc2FmZV9zdHJ0
b2zigJk6Cj4gc2FmZV9tYWNyb3MuYzozNDk6MjogZXJyb3I6IOKAmGVycm5v4oCZIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzCj4gZnVuY3Rpb24pCj4gc2FmZV9tYWNyb3MuYzozNDk6Mjog
bm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seQo+IG9uY2Ug
Zm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+IHNhZmVfbWFjcm9zLmM6MzUxOjE2OiBl
cnJvcjog4oCYRVJBTkdF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzCj4gZnVuY3Rp
b24pCj4gCj4gU2lnbmVkLW9mZi1ieTogVmluc29uIExlZSA8dmxlZUB0d2l0dGVyLmNvbT4KPiAt
LS0KPiAgbGliL3NhZmVfbWFjcm9zLmMgfCAgICAxICsKPiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21h
Y3Jvcy5jIGIvbGliL3NhZmVfbWFjcm9zLmMKPiBpbmRleCA0YzhjYmI3Li4zMWRmMGZkIDEwMDY0
NAo+IC0tLSBhL2xpYi9zYWZlX21hY3Jvcy5jCj4gKysrIGIvbGliL3NhZmVfbWFjcm9zLmMKPiBA
QCAtMiw2ICsyLDcgQEAKPiAgI2luY2x1ZGUgPHN5cy9tbWFuLmg+Cj4gICNpbmNsdWRlIDxzeXMv
cmVzb3VyY2UuaD4KPiAgI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4gKyNpbmNsdWRlIDxlcnJuby5o
Pgo+ICAjaW5jbHVkZSA8ZmNudGwuaD4KPiAgI2luY2x1ZGUgPGxpYmdlbi5oPgo+ICAjaW5jbHVk
ZSA8bGltaXRzLmg+CgoKQUNLIHRoaXMuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVmlydHVhbGl6
YXRpb24gJiBDbG91ZCBNYW5hZ2VtZW50IFVzaW5nIENhcGFjaXR5IFBsYW5uaW5nCkNsb3VkIGNv
bXB1dGluZyBtYWtlcyB1c2Ugb2YgdmlydHVhbGl6YXRpb24gLSBidXQgY2xvdWQgY29tcHV0aW5n
IAphbHNvIGZvY3VzZXMgb24gYWxsb3dpbmcgY29tcHV0aW5nIHRvIGJlIGRlbGl2ZXJlZCBhcyBh
IHNlcnZpY2UuCmh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3NmbmwvMTE0LzUxNTIxMjIz
LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlz
dCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
