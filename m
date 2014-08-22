Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XKjrX-0002rl-Ih
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 08:06:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKjrW-0004qP-Cl
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 08:06:19 +0000
Message-ID: <53F6F9BC.3040504@cn.fujitsu.com>
Date: Fri, 22 Aug 2014 16:05:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <77268e159df98c56fa62012617a7c3f3b918f6b7.1408689882.git.jstancek@redhat.com>
In-Reply-To: <77268e159df98c56fa62012617a7c3f3b918f6b7.1408689882.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mmap15: don't fail if mmap returns EINVAL
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
Cc: ltp-list@lists.sourceforge.net

T24gMDgvMjIvMjAxNCAwMjo0NSBQTSwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gT2xkZXIga2VybmVs
cyAoMi42LjMyKSBvbiBwcGM2NCByZXR1cm4gRUlOVkFMIGluc3RlYWQgb2YgRU5PTUVNLgo+IAo+
IE1hbiBwYWdlIHNheXM6Cj4gIkVJTlZBTCBXZSBkb27igJl0IGxpa2UgYWRkciwgbGVuZ3RoLCBv
ciBvZmZzZXQgKGUuZy4sIHRoZXkgYXJlIHRvbyBsYXJnZSwKPiBvciBub3QgYWxpZ25lZCBvbiBh
IHBhZ2UgYm91bmRhcnkpLiIsIHdoaWNoIHN1Z2dlc3RzIHRoYXQgYm90aAo+IEVOT01FTSBhbmQg
RUlOVkFMIHNob3VsZCBiZSBjb25zaWRlcmVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEphbiBTdGFu
Y2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKQWNrZWQtYnk6IFdhbmxvbmcgR2FvIDxnYW93YW5s
b25nQGNuLmZ1aml0c3UuY29tPgoKPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
bWFwL21tYXAxNS5jIHwgICAgNCArKy0tCj4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21tYXAvbW1hcDE1LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1h
cDE1LmMKPiBpbmRleCA0OWRiYmE0Li5mMWZjMjY3IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTUuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW1hcC9tbWFwMTUuYwo+IEBAIC04MCwxMCArODAsMTAgQEAgaW50IG1haW4oaW50IGFj
LCBjaGFyICoqYXYpCj4gIAkJCWNvbnRpbnVlOwo+ICAJCX0KPiAgCj4gLQkJaWYgKGVycm5vICE9
IEVOT01FTSkgewo+ICsJCWlmIChlcnJubyAhPSBFTk9NRU0gJiYgZXJybm8gIT0gRUlOVkFMKSB7
Cj4gIAkJCXRzdF9yZXNtKFRGQUlMIHwgVEVSUk5PLCAibW1hcCBpbnRvIGhpZ2ggcmVnaW9uICIK
PiAgCQkJCSAiZmFpbGVkIHVuZXhwZWN0ZWRseSAtIGV4cGVjdCAiCj4gLQkJCQkgImVycm5vPUVO
T01FTSwgZ290Iik7Cj4gKwkJCQkgImVycm5vPUVOT01FTS9FSU5WQUwsIGdvdCIpOwo+ICAJCX0g
ZWxzZSB7Cj4gIAkJCXRzdF9yZXNtKFRQQVNTIHwgVEVSUk5PLCAibW1hcCBpbnRvIGhpZ2ggcmVn
aW9uICIKPiAgCQkJCSAiZmFpbGVkIGFzIGV4cGVjdGVkIik7Cj4gCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClNsYXNoZG90IFRWLiAgClZpZGVvIGZvciBOZXJkcy4gIFN0dWZmIHRoYXQgbWF0dGVy
cy4KaHR0cDovL3R2LnNsYXNoZG90Lm9yZy8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo=
