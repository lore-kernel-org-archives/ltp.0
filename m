Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lliubbo@gmail.com>) id 1QMEgU-0000Md-Rf
	for ltp-list@lists.sourceforge.net; Tue, 17 May 2011 07:27:14 +0000
Received: from mail-qw0-f46.google.com ([209.85.216.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QMEgS-00040P-JM
	for ltp-list@lists.sourceforge.net; Tue, 17 May 2011 07:27:14 +0000
MIME-Version: 1.0
In-Reply-To: <5004B0F2-AD73-437F-995E-71B88F329A8E@gmail.com>
References: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
	<5004B0F2-AD73-437F-995E-71B88F329A8E@gmail.com>
Date: Tue, 17 May 2011 15:27:06 +0800
Message-ID: <BANLkTik9irk3Yket8uK79H4d2X-5a8bYcg@mail.gmail.com>
From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscall: sockioctl: fix except return
	val
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sf.net

T24gVGh1LCBNYXkgMTIsIDIwMTEgYXQgNzoyOCBQTSwgR2FycmV0dCBDb29wZXIgPHlhbmVnb21p
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gTWF5IDEyLCAyMDExLCBhdCAyOjU5IEFNLCBCb2IgTGl1
IHdyb3RlOgo+Cj4gU2luY2UgbmV3IGtlcmVubCBjaGFuZ2UsIHNvY2tpb2N0bDAxIGFsd2F5cyBm
YWlsIGxpa2UgdGhpczoKPgo+IHNvY2tpb2N0bDAxIMKgwqDCoDQgwqBURkFJTCDCoDogwqBBVE1B
Uksgb24gVURQIDsgcmV0dXJuZWQgLTEgKGV4cGVjdGVkIC0xKSwgZXJybm8KPiAyNSAoZXhwZWN0
ZWQgMjIpCj4KPiBUaGlzIHBhdGNoIGZpeCB0aGUgZXhjZXB0IHJldHVybiB2YWwgZnJvbSBFSU5W
QUwgdG8gRU5PVFRZLgo+Cj4gU2lnbmVkLW9mZi1ieTogQm9iIExpdSA8bGxpdWJib0BnbWFpbC5j
b20+Cj4gLS0tCj4gc29ja2lvY3RsMDEuYyB8IMKgwqDCoDIgKy0KPiAxIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4gaW5kZXggYWE2NmJjMy4u
NmFkN2E0YSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NvY2tpb2N0
bC9zb2NraW9jdGwwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9j
dGwvc29ja2lvY3RsMDEuYwo+IEBAIC0xMDgsNyArMTA4LDcgQEAgc3RydWN0IHRlc3RfY2FzZV90
IHsgLyogdGVzdCBjYXNlIHN0cnVjdHVyZSAqLwo+IHsKPiBQRl9JTkVULCBTT0NLX0RHUkFNLCAw
LCBTSU9DQVRNQVJLLCAmb3B0dmFsLAo+IMKgwqDCoChzdHJ1Y3Qgc29ja2FkZHIgKikmZnNpbjEs
IHNpemVvZihmc2luMSksIC0xLAo+IC0gwqDCoMKgRUlOVkFMLCBzZXR1cDEsIGNsZWFudXAxLCAi
QVRNQVJLIG9uIFVEUCJ9Cj4gKyDCoMKgwqBFTk9UVFksIHNldHVwMSwgY2xlYW51cDEsICJBVE1B
Uksgb24gVURQIn0KPiAsIHsKPiBQRl9JTkVULCBTT0NLX0RHUkFNLCAwLCBTSU9DR0lGQ09ORiwg
JmlmYywKPiDCoMKgwqAoc3RydWN0IHNvY2thZGRyICopJmZzaW4xLCBzaXplb2YoZnNpbjEpLCAw
LAo+IC0tCj4gMS42LjMuMwo+Cj4gVGhpcyB3aWxsIGZpeCB0aGUgbGF0ZXIga2VybmVsLCBidXQg
YnJlYWsgZWFybGllciBvbmVzLiBDb3VsZCB5b3UgcGxlYXNlCj4gc3VibWl0IGEgcGF0Y2ggdGhh
dCBkb2VzIGEgY2hlY2sgZm9yIHRoZSBrZXJuZWwgdmVyc2lvbiwgYSBkYXRhIHN0cnVjdHVyZSwK
PiBldGMgYW5kIGFkanVzdHMgdGhlIGV4cGVjdGVkIHZhbHVlcyBhY2NvcmRpbmdseT8KCldoZXRo
ZXIgdXNpbmcgdHN0X2t2ZXJjbXAoKSBjYW4gYmUgYWNjZXB0ZWQgPwpUaGFua3MKCi0tIApSZWdh
cmRzLAotLUJvYgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFjaGlldmUgdW5wcmVjZWRlbnRlZCBh
cHAgcGVyZm9ybWFuY2UgYW5kIHJlbGlhYmlsaXR5CldoYXQgZXZlcnkgQy9DKysgYW5kIEZvcnRy
YW4gZGV2ZWxvcGVyIHNob3VsZCBrbm93LgpMZWFybiBob3cgSW50ZWwgaGFzIGV4dGVuZGVkIHRo
ZSByZWFjaCBvZiBpdHMgbmV4dC1nZW5lcmF0aW9uIHRvb2xzCnRvIGhlbHAgYm9vc3QgcGVyZm9y
bWFuY2UgYXBwbGljYXRpb25zIC0gaW5sY3VkaW5nIGNsdXN0ZXJzLgpodHRwOi8vcC5zZi5uZXQv
c2Z1L2ludGVsLWRldjJkZXZtYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAt
bGlzdAo=
