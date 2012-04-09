Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gong.chen@linux.intel.com>) id 1SH502-0002ja-9d
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 03:10:38 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SH501-0006pq-8Y
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 03:10:38 +0000
Message-ID: <4F825325.3030308@linux.intel.com>
Date: Mon, 09 Apr 2012 11:10:29 +0800
From: Chen Gong <gong.chen@linux.intel.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com> <4F7EFED0.4040405@casparzhang.com>
In-Reply-To: <4F7EFED0.4040405@casparzhang.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
Cc: Andi Kleen <andi.kleen@intel.com>, LTP list <ltp-list@lists.sourceforge.net>

5LqOIDIwMTIvNC82IDIyOjMzLCBDYXNwYXIgWmhhbmcg5YaZ6YGTOgo+IE9uIDAzLzIxLzIwMTIg
MDU6MTggUE0sIENoZW4gR29uZyB3cm90ZToKPj4g5LqOIDIwMTIvMy8xNiAyMjozNSwgQW5kaSBL
bGVlbiDlhpnpgZM6Cj4+PiBPbiBGcmksIE1hciAxNiwgMjAxMiBhdCAwMzoyNzo0NFBNICswODAw
LCBDYXNwYXIgWmhhbmcgd3JvdGU6Cj4+Pj4gSGkgYWxsLCBJJ2xsIG1lcmdlIHRoaXMgY2hhbmdl
IHRvIG1hc3RlciBpZiBJIGRvbid0IGhlYXIgYW55IG9iamVjdGlvbnMKPj4+PiBmcm9tIHlvdSBi
eSB0b2RheS4KPj4+IEZpbmUgZm9yIG1lLiBDb3B5aW5nIEdvbmcgQ2hlbiB3aG8gZGlkIG1vc3Qg
b2YgdGhlIG1jZS10ZXN0IHdvcmsgcmVjZW50bHkKPj4+IHRvby4KPj4+Cj4+PiAtQW5kaQo+PiBP
aCwgeWVzLiBSZWNlbnRseSBJIG1ha2UgYSBiaWcgY2hhbmdlIG9uIG1jZS10ZXN0IHByb2plY3Qg
YW5kIG9sZAo+PiBzdHJ1Y3R1cmUgd2lsbCBiZSByZW9yZ2FuaXplZC4KPj4gQW5kIEkgZXZlciBs
b29rZWQgdGhyb3VnaCB0aGUgbWNlLXRlc3QgcGFydCBpbiBMVFAuIFVuZm9ydHVuYXRlbHkgaXQg
aXMKPj4gdmVyeSBvbGQgYW5kIGNhbid0IHJ1biBvbgo+PiBuZXdlciBrZXJuZWwuIEkgaG9wZSB5
b3UgY2FuIGtlZXAgY3VycmVudCBkaXNhYmxlZCBzdGF0dXMgaW4gTFRQIGFuZAo+PiB3YWl0IG15
IG5ldyB3b3JrIGlzIG1lcmdlZC4KPj4gV2UgY2FuIHRhbGsgYXQgdGhhdCB0aW1lLiBJcyBpdCBP
SyB0byB5b3U/Cj4gSGkgQ2hlbiBHb25nLCBzb3JyeSBmb3IgbGF0ZSByZXBseSwgd2UncmUgcGxh
bm5pbmcgdG8gcmVtb3ZlIG9sZCBzdGF0aWMKPiBjb2RlZCBtY2UtdGVzdCBmcm9tIExUUCwgYW5k
IHVzZSBpdCBhcyBhIHN1Ym1vZHVsZSwgd2hpY2ggbWVhbnMsCj4gbWNlLXRlc3Qgd29uJ3QgYmUg
c3RhdGljLWNvZGVkIGFueSBtb3JlLCBpdCdzIGFsd2F5cyBzeW5jZWQgdXAgd2l0aCB5b3VyCj4g
dXBzdHJlYW0gdmVyc2lvbiwgd2UganVzdCBuZWVkIHRvIGRvIHNvbWUgbWFudWFsIGBgc3VibW9k
dWxlIHVwZGF0ZWBgCj4gb3BlcmF0aW9ucyB0byBjaGVja291dCB5b3VyIHZlcnNpb24gd2hlbiBk
b2luZyBhIExUUCByZWxlYXNlLiBTbyBJJ2xsCj4gbWVyZ2UgdGhpcyBwYXRjaCBpbiwgcmVtb3Zl
IGFsbCBjdXJyZW50IG91dC1vZi1kYXRlIGNvZGVzLCBhbmQgd2FpdCBmb3IKPiB5b3VyIG5vdGlj
ZSBvZiBtY2UtdGVzdCdzIG5leHQgdmVyc2lvbiwgc28gdGhhdCB3ZSBjYW4gaW5jbHVkZSBpdCBp
biBvdXIKPiBuZXh0IExUUCBzdGFibGUgcmVsZWFzZS4KPgo+IFRoYW5rcywKPiBDYXNwYXIKPgpJ
dCdzIGZpbmUgdG8gbWUuIFNvIGRvIHlvdSB3YW50IHRvIGdldCBhIG5vdGljZSBmcm9tIG1lIGFm
dGVyIHRoZSBjb2RlcyAKYXJlIG1lcmdlZCBvciB5b3UKbW9uaXRvciB0aGUgdXBzdHJlYW0gc3Rh
dHVzIGJ5IHlvdXJzZWxmPwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZvciBEZXZlbG9wZXJzLCBB
IExvdCBDYW4gSGFwcGVuIEluIEEgU2Vjb25kLgpCb3VuZGFyeSBpcyB0aGUgZmlyc3QgdG8gS25v
dy4uLmFuZCBUZWxsIFlvdS4KTW9uaXRvciBZb3VyIEFwcGxpY2F0aW9ucyBpbiBVbHRyYS1GaW5l
IFJlc29sdXRpb24uIFRyeSBpdCBGUkVFIQpodHRwOi8vcC5zZi5uZXQvc2Z1L0JvdW5kYXJ5LWQy
ZHZzMgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAt
bGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
