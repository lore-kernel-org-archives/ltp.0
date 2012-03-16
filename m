Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bounces@nabble.com>) id 1S8Tw4-0004jB-Sl
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 09:59:00 +0000
Received: from sam.nabble.com ([216.139.236.26])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S8Tw3-0006fV-Vz
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 09:59:00 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1S8Tvy-0008JD-K4
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 02:58:54 -0700
Message-ID: <33516012.post@talk.nabble.com>
Date: Fri, 16 Mar 2012 02:58:54 -0700 (PDT)
From: Gopal Kalita <gopal.kalita@gmail.com>
In-Reply-To: <1328793121-20852-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328793121-20852-1-git-send-email-caspar@casparzhang.com>
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
To: ltp-list@lists.sourceforge.net

CkluIHRoZSBmaWxlIC0tIGxpYi9zYWZlX21hY3Jvcy5jICwgdGhlIGhlYWRlciBmaWxlIGVycm5v
LmggbmVlZHMgdG8gYmUKaW5jbHVkZWQuCiNpbmNsdWRlIDxlcnJuby5oPgoKT3RoZXJ3aXNlLCBp
dCBnaXZlcyB0aGUgRm9sbG93aW5nIGVycm9yICAod2hpbGUgY29tcGlsaW5nKS0tCnNhZmVfbWFj
cm9zLmM6IEluIGZ1bmN0aW9uIOKAmHNhZmVfc3RydG9s4oCZOgpzYWZlX21hY3Jvcy5jOjM1MDog
ZXJyb3I6IOKAmGVycm5v4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQpzYWZlX21hY3Jvcy5jOjM1MDogZXJyb3I6IChFYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBp
cyByZXBvcnRlZCBvbmx5IG9uY2UKc2FmZV9tYWNyb3MuYzozNTA6IGVycm9yOiBmb3IgZWFjaCBm
dW5jdGlvbiBpdCBhcHBlYXJzIGluLikKc2FmZV9tYWNyb3MuYzozNTI6IGVycm9yOiDigJhFUkFO
R0XigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCgotLSAKVmlldyB0
aGlzIG1lc3NhZ2UgaW4gY29udGV4dDogaHR0cDovL29sZC5uYWJibGUuY29tLy1MVFAtLS1QQVRD
SC0tc2FmZV9tYWNyb3MlM0EtYWRkLVNBRkVfU1RSVE9MLXRwMzMyOTE1MjlwMzM1MTYwMTIuaHRt
bApTZW50IGZyb20gdGhlIGx0cC1saXN0IG1haWxpbmcgbGlzdCBhcmNoaXZlIGF0IE5hYmJsZS5j
b20uCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YgZW1haWwgaXMgc3BvbnNvc3JlZCBi
eToKVHJ5IFdpbmRvd3MgQXp1cmUgZnJlZSBmb3IgOTAgZGF5cyBDbGljayBIZXJlIApodHRwOi8v
cC5zZi5uZXQvc2Z1L3NmZDJkLW1zYXp1cmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo=
