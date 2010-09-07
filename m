Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Oszs4-00034g-Ig
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 15:14:04 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oszs3-0007wR-Ii
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 15:14:04 +0000
Date: Tue, 7 Sep 2010 11:13:56 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <471750147.260021283872436687.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTikGbs8NvSSvt6WabaS9=QsPsj1rDXmBuiT8EP-6@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] buffered I/O causes testcases/network/nfs/nfsstress
 failure
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Ci0tLS0tICJHYXJyZXR0IENvb3BlciIgPHlhbmVnb21pQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IE9u
IFR1ZSwgU2VwIDcsIDIwMTAgYXQgNToxOCBBTSwgQ2FzcGFyIFpoYW5nIDxjemhhbmdAcmVkaGF0
LmNvbT4KPiB3cm90ZToKPiA+IEhpIGFsbCwKPiA+IMKgV2hlbiBJIHJ1biB0ZXN0Y2FzZXMvbmV0
d29yay9uZnMvbmZzc3RyZXNzLyB0ZXN0LCBJIGZvdW5kIHNvbWV0aW1lcwo+IHRoZQo+ID4gdGVz
dCBmYWlsZWQgZHVlIHRvIGJ1ZmZlcmVkIEkvTywgaW4gZGV0YWlsLCBmb3IgZXhhbXBsZSwgdGhl
cmUgYXJlCj4gdGhlIGZvbGxvd2luZwo+ID4gbGluZXMgaW4gbWFrZV90cmVlLmMgOgo+ID4KPiA+
IDU0NCDCoCDCoCBudW1jaGFyWzBdID0gc3ByaW50Zihwcm9nX2J1ZiwKPiA+IDU0NSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAibWFpbigpXG57XG5cdCBwcmludGYoXCJoZWxsbyB3b3JsZFwiKTtc
bn1cbiIpOwo+ID4KPiA+IHNvbWV0aW1lcyB0aGUgZ2VuZXJhdGVkIC5jIGZpbGUgd2lsbCBiZToK
PiA+IF5AYWluKCkgLy8gPC0gc3RyYW5nZSBBU0NJSSBjaGFyICdeQCcgYXBwZWFycyBpbnN0ZWFk
IG9mICdtJwo+ID4gewo+ID4gwqAgwqAgwqAgwqBwcmludGYoImhlbGxvIHdvcmxkIik7Cj4gPiB9
Cj4gPgo+ID4gQW5kIHJ1bm5pbmcgd2l0aCB0aGlzIC5jIGZpbGUgd2lsbCBjYXVzZSBlcnJvci4K
PiA+Cj4gPiBUaGF0IGlzIHRvIHNheSwgc3RyaW5nICdwcm9nX2J1ZicgZ2V0cyBhIG1pc3Rha2Ug
ZHVyaW5nIHNwcmludGYuIEFuZAo+IHRoZXJlJ3JlCj4gPiBzb21ld2hlcmUgZWxzZSB1c2luZyBi
dWZmZXJlZCBJL08gaW4gdGhpcyB0ZXN0IGFzIHdlbGwuIERvIHdlIGhhdmUKPiBhbgo+ID4gdW5i
dWZmZXJlZCBzb2x1dGlvbiB0byB0aGlzIHRlc3Q/Cj4gCj4gVGhhdCBzZWVtcyBhIGJpdCBvZGQu
IElzIHRoZSBORlMgbW91bnQvc2VydmVyIFRDUCBvciBVRFA/CgpIaSBHYXJyZXR0LCBpdCdzIFVE
UC4KClRoYW5rcywKQ2FzcGFyCgotLSAKUXVhbGl0eSBBc3N1cmFuY2UgQXNzb2NpYXRlIChLZXJu
ZWwpIGluClJlZCBIYXQgSW5jLiAoQmVpamluZyBSJkQgQnJhbmNoKQoKVEVMOiArODYtMTAtNjI2
MDgxNTAKV2ViOiBodHRwOi8vd3d3LnJlZGhhdC5jb20vCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
VGhpcyBTRi5uZXQgRGV2MkRldiBlbWFpbCBpcyBzcG9uc29yZWQgYnk6CgpTaG93IG9mZiB5b3Vy
IHBhcmFsbGVsIHByb2dyYW1taW5nIHNraWxscy4KRW50ZXIgdGhlIEludGVsKFIpIFRocmVhZGlu
ZyBDaGFsbGVuZ2UgMjAxMC4KaHR0cDovL3Auc2YubmV0L3NmdS9pbnRlbC10aHJlYWQtc2ZkCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1h
aWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
