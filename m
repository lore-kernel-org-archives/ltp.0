Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gang.chen@asianux.com>) id 1TVKJo-0008UR-Hw
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 10:54:12 +0000
Received: from intranet.asianux.com ([58.214.24.6])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TVKJn-0004jn-Er
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 10:54:12 +0000
Received: from [10.1.0.143] (unknown [219.143.36.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranet.asianux.com (Postfix) with ESMTP id F06E8184032E
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 Nov 2012 18:53:59 +0800 (CST)
Message-ID: <50979B06.7030007@asianux.com>
Date: Mon, 05 Nov 2012 18:55:02 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <5097893B.7060105@asianux.com>
In-Reply-To: <5097893B.7060105@asianux.com>
Subject: Re: [LTP] [Issue Report] the stress test which includes nfs test
 with client and server under same machine
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Cm9oLCBJIGFtIHZlcnkgc29ycnk6CgogIHRoZSBvcmlnaW5hbCByZWZlcmVuY2UgbGluayB0byBS
ZWQgSGF0IEJ1Z3ppbGxhIGlzIG5vdCBjb3JyZWN0OwogIHRoZSBjb3JyZWN0IHJlZmVyZW5jZSBs
aW5rOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTgzNjA5NQoK
Z2NoZW4uCgoK09ogMjAxMsTqMTHUwjA1yNUgMTc6MzksIENoZW4gR2FuZyDQtLXAOgo+IEhlbGxv
IGx0cC1saXN0QGxpc3RzLnNvcmNlZm9yZ2UubmV0IAo+IAo+IDEpIEZpcnN0bHk6Cj4gCj4gICAg
QSkgTFRQIGlzIGEgdmVyeSB1c2VmdWwgdG9vbHMgZm9yIEFzaWFudXggdG8gdGVzdCBMaW51eCBr
ZXJuZWwuCj4gICAgQikgVGhhbmsgTFRQIHZlcnkgbXVjaC4KPiAgICBDKSBEdXJpbmcgdGVzdCwg
QXNpYW51eCBmaW5kIGFuIGlzc3VlIGFib3V0IExUUAo+ICAgICAgIEFzaWFudXggdGhpbmsgbWF5
YmUgaXQgd2lsbCBiZSBiZXR0ZXIgdG8gbGV0IExUUCBrbm93IGFib3V0IGl0Lgo+IAo+IAo+IDIp
IERlc2NyaXB0aW9uOgo+IAo+ICAgIEEpIHdpdGggZGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciAv
b3B0L2x0cC90ZXN0c2NyaXB0cy9sdHBzdHJlc3Muc2gKPiAgICBCKSBpdCB0ZXN0cyB0aGUgbmZz
IHdpdGggY2xpZW50IGFuZCBzZXJ2ZXIgdW5kZXIgdGhlIHNhbWUgbWFjaGluZQo+ICAgIEMpIGl0
IGlzIGFuIGtub3duIGlzc3VlIGFib3V0IGl0Lgo+IAo+IDMpIFJlZmVyZW5jZQo+IAo+ICAgIEEp
IFJlZCBIYXQgQnVnemlsbGE6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5j
Z2k/aWQ9ODU4OTc4Cj4gICAgQikgTEtWTSBNYWlsaW5nIGxpc3Q6IGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDEyLzEwLzE2LzEgIChhdCB0YWlsKQo+IAo+PiBSdW5uaW5nIHRoZSBjbGllbnQgYW5k
IHNlcnZlciBvbiB0aGUgc2FtZSBtYWNoaW5lIGlzIGxpa2VseSB0byBkZWFkbG9jawo+PiBkdWUg
dG8gbWVtb3J5IHByZXNzdXJlIGlzc3Vlcy4gVGhlIGNsaWVudCBuZWVkcyB0byBiZSBhYmxlIHRv
IF9pbmNyZWFzZV8KPj4gbWVtb3J5IHByZXNzdXJlIG9uIHRoZSBzZXJ2ZXIgaW4gb3JkZXIgdG8g
cmVkdWNlIGl0cyBvd24gcHJlc3N1cmUuIFRoYXQKPj4gZG9lc24ndCB3b3JrIHdlbGwgd2hlbiBj
bGllbnQgPT0gc2VydmVyLgo+IAo+IAo+IAo+ICAgQXQgbGFzdCwgaG9wZSB0aGVzZSBpbmZvcm1h
dGlvbiBhcmUgdXNlZnVsIGZvciBMVFAsICB0aGFua3MuCj4gCgoKLS0gCkNoZW4gR2FuZwoKQXNp
YW51eCBDb3Jwb3JhdGlvbgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxvZ01lSW4gQ2VudHJhbDog
SW5zdGFudCwgYW55d2hlcmUsIFJlbW90ZSBQQyBhY2Nlc3MgYW5kIG1hbmFnZW1lbnQuClN0YXkg
aW4gY29udHJvbCwgdXBkYXRlIHNvZnR3YXJlLCBhbmQgbWFuYWdlIFBDcyBmcm9tIG9uZSBjb21t
YW5kIGNlbnRlcgpEaWFnbm9zZSBwcm9ibGVtcyBhbmQgaW1wcm92ZSB2aXNpYmlsaXR5IGludG8g
ZW1lcmdpbmcgSVQgaXNzdWVzCkF1dG9tYXRlLCBtb25pdG9yIGFuZCBtYW5hZ2UuIERvIG1vcmUg
aW4gbGVzcyB0aW1lIHdpdGggQ2VudHJhbApodHRwOi8vcC5zZi5uZXQvc2Z1L2xvZ21laW4xMjMz
MV9kMmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRw
LWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
