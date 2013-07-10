Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UwjYq-0001Le-ID
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 01:51:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwjYo-00085P-Dt
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 01:51:16 +0000
Message-ID: <51DCBE0F.4030109@cn.fujitsu.com>
Date: Wed, 10 Jul 2013 09:51:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1373388942-27853-1-git-send-email-vlee@freedesktop.org>
In-Reply-To: <1373388942-27853-1-git-send-email-vlee@freedesktop.org>
Subject: Re: [LTP] [PATCH] mount/mount05.c: Add mode argument to open call.
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
To: Vinson Lee <vlee@freedesktop.org>
Cc: ltp-list@lists.sourceforge.net

T24gMDcvMTAvMjAxMyAxMjo1NSBBTSwgVmluc29uIExlZSB3cm90ZToKPiBGcm9tOiBWaW5zb24g
TGVlIDx2bGVlQHR3aXR0ZXIuY29tPgo+IAo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBidWlsZCBl
cnJvciBvbiBVYnVudHUgaW50cm9kdWNlZCB3aXRoIGNvbW1pdAo+IDkxNDZkODNkNDEwZGMwNjAx
MjQzNDRmY2JjZGJmNDYyODBiNjc0YTIuCj4gCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3Iv
aW5jbHVkZS9mY250bC5oOjI3OTowLAo+ICAgICAgICAgICAgICAgICAgZnJvbSBtb3VudDA1LmM6
MzE6Cj4gSW4gZnVuY3Rpb24g4oCYb3BlbuKAmSwKPiAgICAgaW5saW5lZCBmcm9tIOKAmG1haW7i
gJkgYXQgbW91bnQwNS5jOjk0OjEyOgo+IC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2Jp
dHMvZmNudGwyLmg6NTA6MjQ6IGVycm9yOiBjYWxsIHRvIOKAmF9fb3Blbl9taXNzaW5nX21vZGXi
gJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IG9wZW4gd2l0aCBPX0NSRUFUIGluIHNl
Y29uZCBhcmd1bWVudCBuZWVkcyAzIGFyZ3VtZW50cwo+IAo+IFNpZ25lZC1vZmYtYnk6IFZpbnNv
biBMZWUgPHZsZWVAdHdpdHRlci5jb20+CgpBcHBsaWVkLCB0aGFuayB5b3UuCgpXYW5sb25nIEdh
bwoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTZWUgZXZlcnl0aGluZyBmcm9tIHRoZSBicm93c2Vy
IHRvIHRoZSBkYXRhYmFzZSB3aXRoIEFwcER5bmFtaWNzCkdldCBlbmQtdG8tZW5kIHZpc2liaWxp
dHkgd2l0aCBhcHBsaWNhdGlvbiBtb25pdG9yaW5nIGZyb20gQXBwRHluYW1pY3MKSXNvbGF0ZSBi
b3R0bGVuZWNrcyBhbmQgZGlhZ25vc2Ugcm9vdCBjYXVzZSBpbiBzZWNvbmRzLgpTdGFydCB5b3Vy
IGZyZWUgdHJpYWwgb2YgQXBwRHluYW1pY3MgUHJvIHRvZGF5IQpodHRwOi8vcHViYWRzLmcuZG91
YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9NDg4MDg4MzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3Qg
bWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
