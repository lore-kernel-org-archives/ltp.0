Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S9umx-0007xQ-OX
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:51:31 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S9ums-0005mV-71
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:51:31 +0000
Received: by dado14 with SMTP id o14so12313668dad.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Mar 2012 01:51:20 -0700 (PDT)
Message-ID: <4F6844B0.2090605@casparzhang.com>
Date: Tue, 20 Mar 2012 16:49:52 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328793121-20852-1-git-send-email-caspar@casparzhang.com>
	<33516012.post@talk.nabble.com>
In-Reply-To: <33516012.post@talk.nabble.com>
Subject: Re: [LTP] [PATCH v4] safe_macros: add SAFE_STRTOL
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
To: Gopal Kalita <gopal.kalita@gmail.com>
Cc: ltp-list@lists.sourceforge.net

T24gMDMvMTYvMjAxMiAwNTo1OCBQTSwgR29wYWwgS2FsaXRhIHdyb3RlOgo+IAo+IEluIHRoZSBm
aWxlIC0tIGxpYi9zYWZlX21hY3Jvcy5jICwgdGhlIGhlYWRlciBmaWxlIGVycm5vLmggbmVlZHMg
dG8gYmUKPiBpbmNsdWRlZC4KPiAjaW5jbHVkZSA8ZXJybm8uaD4KPiAKPiBPdGhlcndpc2UsIGl0
IGdpdmVzIHRoZSBGb2xsb3dpbmcgZXJyb3IgICh3aGlsZSBjb21waWxpbmcpLS0KPiBzYWZlX21h
Y3Jvcy5jOiBJbiBmdW5jdGlvbiDigJhzYWZlX3N0cnRvbOKAmToKPiBzYWZlX21hY3Jvcy5jOjM1
MDogZXJyb3I6IOKAmGVycm5v4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKQo+IHNhZmVfbWFjcm9zLmM6MzUwOiBlcnJvcjogKEVhY2ggdW5kZWNsYXJlZCBpZGVudGlm
aWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZQo+IHNhZmVfbWFjcm9zLmM6MzUwOiBlcnJvcjogZm9y
IGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCj4gc2FmZV9tYWNyb3MuYzozNTI6IGVycm9y
OiDigJhFUkFOR0XigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4g
CgpIaSwgdGhpcyBzaG91bGQgaGF2ZSBiZWVuIGZpeGVkIGluIGNvbW1pdCA5YWYwYmQ3YgoKVGhh
bmtzLApDYXNwYXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGIGVtYWlsIGlzIHNwb25z
b3NyZWQgYnk6ClRyeSBXaW5kb3dzIEF6dXJlIGZyZWUgZm9yIDkwIGRheXMgQ2xpY2sgSGVyZSAK
aHR0cDovL3Auc2YubmV0L3NmdS9zZmQyZC1tc2F6dXJlCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbHRwLWxpc3QK
