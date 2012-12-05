Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Tg7HI-0001tb-Oq
	for ltp-list@lists.sourceforge.net; Wed, 05 Dec 2012 05:12:12 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tg7H4-0006Bx-Mv
	for ltp-list@lists.sourceforge.net; Wed, 05 Dec 2012 05:12:12 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa10so3096902pad.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Dec 2012 21:11:52 -0800 (PST)
Message-ID: <50BED022.4000805@casparzhang.com>
Date: Wed, 05 Dec 2012 12:40:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
	<1354605716-4747-3-git-send-email-penght@cn.fujitsu.com>
	<50BDA8C3.4070802@casparzhang.com>
	<50BDBFC3.1010702@cn.fujitsu.com>
In-Reply-To: <50BDBFC3.1010702@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/4] at_allow01: Use lib to restart atd service
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

T24gMTIvMDQvMjAxMiAwNToxNyBQTSwgUGVuZyBIYWl0YW8gd3JvdGU6Cj4KPiBPbiAxMi8wNC8y
MDEyIDAzOjM5IFBNLCBDYXNwYXIgWmhhbmcgd3JvdGU6Cj4+IE9uIDEyLzA0LzIwMTIgMDM6MjEg
UE0sIFBlbmcgSGFpdGFvIHdyb3RlOgo+Pj4gKyA4NMK7IC7Ct2NtZGxpYi5zaAo+Pgo+PiBQYXRj
aCBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSBleGNlcHQgdGhpcy4KPj4KPj4gc291cmNpbmcgYSBs
aWIgaW5zaWRlIGEgZnVuY3Rpb24gc2VlbXMgbm90IHNvIGdvb2QuIFlldCBJIGRvbid0IHNlZSBh
bnkgY29kZSBzdHlsZSBydWxlcyB0ZWxsaW5nIHdoaWNoIGlzIHRoZSBjb3JyZWN0IHBsYWNlIHRv
IHB1dCBhIHNoZWxsIGxpYiBzb3VyY2UgKGNvbW1vbmx5IEkgdGhpbmsgaXQgd291bGQgYmUgdGhl
IHRvcCBpbiB0aGUgZmlsZSkKPj4KPiAJCj4gWWVhaC4gSSB0aGluayBzbywgdG9vLgo+IElmIHNv
dXJjaW5nIGEgbGliIGluIHRoZSB0b3Agb2YgdGhlIGZpbGUsIHRoZSBjYXNlIHdpbGwgZmFpbC4K
PiBCZWNhdXNlIHRoZSBjYXNlIHdpbGwgdXNlIHN1IHh4eCAtbGMgdG8gZXhlY3V0ZSBpdHNlbGYg
aW4geHh4J3MgaG9tZSBkaXJlY3RvcnkuCj4gQnV0IGNtZGxpYi5zaCBpcyBpbiAvb3B0L2x0cC90
ZXN0Y2FzZXMvYmluLywgbm90IGluIHh4eCdzIGhvbWUgZGlyZWN0b3J5Lgo+Cj4KPiBUaGlzIGhh
cyBhbm90aGVyIG1ldGhvZCwgYWRkIHRoZSBmb2xsb3dpbmcgY29udGVudCBpbiB0b3Agb2YgdGhl
IGZpbGU6Cj4KPiBpZiBbICIkKGlkIC1ydSkiID0gMCBdOyB0aGVuCj4gICAgICAgICAgLiBjbWRs
aWIuc2gKPiBmaQo+Cj4gSSB0aGluayBhZGQgaW5zaWRlIGEgZnVuY3Rpb24gaXMgc2ltcGxlOikK
PiBJZiB5b3UgdGhpbmsgYWRkIGluIHRvcCBvZiB0aGUgZmlsZSB3aWxsIGJldHRlciwgSSB3aWxs
IHJlc2VuZCBpdC4KPiBUaGFua3MuCj4KSSdtIE9LIGlmIHRoZSBzaW1wbGVyIHdheSB3b24ndCBj
YXVzZSBjb25mdXNpb24gOikKCkNhc3BhcgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxvZ01lSW4g
UmVzY3VlOiBBbnl3aGVyZSwgQW55dGltZSBSZW1vdGUgc3VwcG9ydCBmb3IgSVQuIEZyZWUgVHJp
YWwKUmVtb3RlbHkgYWNjZXNzIFBDcyBhbmQgbW9iaWxlIGRldmljZXMgYW5kIHByb3ZpZGUgaW5z
dGFudCBzdXBwb3J0CkltcHJvdmUgeW91ciBlZmZpY2llbmN5LCBhbmQgZm9jdXMgb24gZGVsaXZl
cmluZyBtb3JlIHZhbHVlLWFkZCBzZXJ2aWNlcwpEaXNjb3ZlciB3aGF0IElUIFByb2Zlc3Npb25h
bHMgS25vdy4gUmVzY3VlIGRlbGl2ZXJzCmh0dHA6Ly9wLnNmLm5ldC9zZnUvbG9nbWVpbl8xMjMy
OWQyZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAt
bGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
