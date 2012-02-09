Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@twitter.com>) id 1Rve4W-0001tR-54
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 00:10:40 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rve4V-0008Uq-DU
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 00:10:40 +0000
Received: by daln34 with SMTP id n34so2042174dal.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Feb 2012 16:10:33 -0800 (PST)
From: Vinson Lee <vlee@twitter.com>
Date: Thu,  9 Feb 2012 15:05:50 -0800
Message-Id: <1328828750-11079-1-git-send-email-vlee@twitter.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] safe_macros: Include errno.h.
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
To: ltp-list@lists.sourceforge.net

Rml4IGJ1aWxkIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBieSBjb21taXQKZDZhMWYyNTEzN2IwYWM4
NzA0YmQwOGNjNGJjOGFmMDFjY2VhY2EwZS4KClRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBidWlsZCBl
cnJvciBvbiBVYnVudHUgMTEuMTAuCnNhZmVfbWFjcm9zLmM6IEluIGZ1bmN0aW9uIOKAmHNhZmVf
c3RydG9s4oCZOgpzYWZlX21hY3Jvcy5jOjM0OToyOiBlcnJvcjog4oCYZXJybm/igJkgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMKZnVuY3Rpb24pCnNhZmVfbWFjcm9zLmM6MzQ5OjI6IG5v
dGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkKb25jZSBmb3Ig
ZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnNhZmVfbWFjcm9zLmM6MzUxOjE2OiBlcnJvcjog
4oCYRVJBTkdF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzCmZ1bmN0aW9uKQoKU2ln
bmVkLW9mZi1ieTogVmluc29uIExlZSA8dmxlZUB0d2l0dGVyLmNvbT4KLS0tCiBsaWIvc2FmZV9t
YWNyb3MuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL3NhZmVfbWFjcm9zLmMgYi9saWIvc2FmZV9tYWNy
b3MuYwppbmRleCA0YzhjYmI3Li4zMWRmMGZkIDEwMDY0NAotLS0gYS9saWIvc2FmZV9tYWNyb3Mu
YworKysgYi9saWIvc2FmZV9tYWNyb3MuYwpAQCAtMiw2ICsyLDcgQEAKICNpbmNsdWRlIDxzeXMv
bW1hbi5oPgogI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPgogI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
CisjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDxmY250bC5oPgogI2luY2x1ZGUgPGxpYmdl
bi5oPgogI2luY2x1ZGUgPGxpbWl0cy5oPgotLSAKMS43LjUuNAoKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpWaXJ0dWFsaXphdGlvbiAmIENsb3VkIE1hbmFnZW1lbnQgVXNpbmcgQ2FwYWNpdHkgUGxh
bm5pbmcKQ2xvdWQgY29tcHV0aW5nIG1ha2VzIHVzZSBvZiB2aXJ0dWFsaXphdGlvbiAtIGJ1dCBj
bG91ZCBjb21wdXRpbmcgCmFsc28gZm9jdXNlcyBvbiBhbGxvd2luZyBjb21wdXRpbmcgdG8gYmUg
ZGVsaXZlcmVkIGFzIGEgc2VydmljZS4KaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2Zu
bC8xMTQvNTE1MjEyMjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
