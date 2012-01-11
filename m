Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RkxVA-0001FZ-5B
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 12:42:00 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkxV4-0001Od-9f
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 12:42:00 +0000
Date: Wed, 11 Jan 2012 07:41:47 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <974e6f10-853c-4e38-98ba-4bd6bdb6ac98@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4F0BB312.5070009@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
	duplicated output
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkNhc3BhciBaaGFuZyIgPGNh
c3BhckBjYXNwYXJ6aGFuZy5jb20+Cj4gVG86ICJMVFAgTGlzdCIgPGx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldD4KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDEwLCAyMDEyIDQ6NDA6MDIg
QU0KPiBTdWJqZWN0OiBSZTogW0xUUF0gW1BBVENIXSBzeXNjYWxscy9nZXRydXNhZ2UwMzogZmx1
c2ggc3Rkb3V0IHRvIGF2b2lkIGR1cGxpY2F0ZWQgb3V0cHV0Cj4gCj4gT24gMjAxMuW5tDAx5pyI
MTDml6UgMTE6MzgsIENhc3BhciBaaGFuZyB3cm90ZToKPiA+IAo+ID4gd2hlbiBleGVjdXRpbmcg
d2l0aCBgJEJJTi9ydW5sdHBgIGNvbW1hbmQsIGdldHJ1c2FnZTAzIHB1dHMgb3V0Cj4gPiBkdXBs
aWNhdGVkIGluZm9ybWF0aW9uIGR1ZSB0byBidWZmZXJlZCBzdGRvdXQuIFVzaW5nIGZmbHVzaChz
dGRvdXQpCj4gPiB0bwo+ID4gc29sdmUgdGhpcyBpc3N1ZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1i
eTogQ2FzcGFyIFpoYW5nIDxjYXNwYXJAY2FzcGFyemhhbmcuY29tPgo+ID4gLS0tCj4gPiAgdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuYyAgfCAgICA3ICsr
KysrKysKPiA+ICAuLi4va2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwM19jaGls
ZC5jICB8ICAgIDEgKwo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQo+ID4gCj4gCj4gTm90IHN1cmUgaWYgd2UgaGF2ZSBhbnkgYmV0dGVyIHNvbHV0
aW9uIHRvIGF2b2lkIHN1Y2ggYnVmZmVyZWQgSS9PCj4gaXNzdWUuCgpIb3cgYWJvdXQgInNldHZi
dWYoc3Rkb3V0LCBOVUxMLCBfSU9MQkYsIDApOyI/CgpSZWdhcmRzLApKYW4KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpSaWRpY3Vsb3VzbHkgZWFzeSBWREkuIFdpdGggQ2l0cml4IFZESS1pbi1hLUJv
eCwgeW91IGRvbid0IG5lZWQgYSBjb21wbGV4CmluZnJhc3RydWN0dXJlIG9yIHZhc3QgSVQgcmVz
b3VyY2VzIHRvIGRlbGl2ZXIgc2VhbWxlc3MsIHNlY3VyZSBhY2Nlc3MgdG8KdmlydHVhbCBkZXNr
dG9wcy4gV2l0aCB0aGlzIGFsbC1pbi1vbmUgc29sdXRpb24sIGVhc2lseSBkZXBsb3kgdmlydHVh
bCAKZGVza3RvcHMgZm9yIGxlc3MgdGhhbiB0aGUgY29zdCBvZiBQQ3MgYW5kIHNhdmUgNjAlIG9u
IFZESSBpbmZyYXN0cnVjdHVyZSAKY29zdHMuIFRyeSBpdCBmcmVlISBodHRwOi8vcC5zZi5uZXQv
c2Z1L0NpdHJpeC1WRElpbmFib3gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAt
bGlzdAo=
