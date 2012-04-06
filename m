Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SGAEu-0005Jx-Gm
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 14:34:12 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SGAEq-0003S0-3y
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 14:34:12 +0000
Received: by pbcum15 with SMTP id um15so2708750pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Apr 2012 07:34:02 -0700 (PDT)
Message-ID: <4F7EFED0.4040405@casparzhang.com>
Date: Fri, 06 Apr 2012 22:33:52 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com>
In-Reply-To: <4F699CDD.606@linux.intel.com>
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
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>, LTP list <ltp-list@lists.sourceforge.net>

T24gMDMvMjEvMjAxMiAwNToxOCBQTSwgQ2hlbiBHb25nIHdyb3RlOgo+IOS6jiAyMDEyLzMvMTYg
MjI6MzUsIEFuZGkgS2xlZW4g5YaZ6YGTOgo+PiBPbiBGcmksIE1hciAxNiwgMjAxMiBhdCAwMzoy
Nzo0NFBNICswODAwLCBDYXNwYXIgWmhhbmcgd3JvdGU6Cj4+PiBIaSBhbGwsIEknbGwgbWVyZ2Ug
dGhpcyBjaGFuZ2UgdG8gbWFzdGVyIGlmIEkgZG9uJ3QgaGVhciBhbnkgb2JqZWN0aW9ucwo+Pj4g
ZnJvbSB5b3UgYnkgdG9kYXkuCj4+IEZpbmUgZm9yIG1lLiBDb3B5aW5nIEdvbmcgQ2hlbiB3aG8g
ZGlkIG1vc3Qgb2YgdGhlIG1jZS10ZXN0IHdvcmsgcmVjZW50bHkKPj4gdG9vLgo+Pgo+PiAtQW5k
aQo+IE9oLCB5ZXMuIFJlY2VudGx5IEkgbWFrZSBhIGJpZyBjaGFuZ2Ugb24gbWNlLXRlc3QgcHJv
amVjdCBhbmQgb2xkIAo+IHN0cnVjdHVyZSB3aWxsIGJlIHJlb3JnYW5pemVkLgo+IEFuZCBJIGV2
ZXIgbG9va2VkIHRocm91Z2ggdGhlIG1jZS10ZXN0IHBhcnQgaW4gTFRQLiBVbmZvcnR1bmF0ZWx5
IGl0IGlzIAo+IHZlcnkgb2xkIGFuZCBjYW4ndCBydW4gb24KPiBuZXdlciBrZXJuZWwuIEkgaG9w
ZSB5b3UgY2FuIGtlZXAgY3VycmVudCBkaXNhYmxlZCBzdGF0dXMgaW4gTFRQIGFuZCAKPiB3YWl0
IG15IG5ldyB3b3JrIGlzIG1lcmdlZC4KPiBXZSBjYW4gdGFsayBhdCB0aGF0IHRpbWUuIElzIGl0
IE9LIHRvIHlvdT8KCkhpIENoZW4gR29uZywgc29ycnkgZm9yIGxhdGUgcmVwbHksIHdlJ3JlIHBs
YW5uaW5nIHRvIHJlbW92ZSBvbGQgc3RhdGljCmNvZGVkIG1jZS10ZXN0IGZyb20gTFRQLCBhbmQg
dXNlIGl0IGFzIGEgc3VibW9kdWxlLCB3aGljaCBtZWFucywKbWNlLXRlc3Qgd29uJ3QgYmUgc3Rh
dGljLWNvZGVkIGFueSBtb3JlLCBpdCdzIGFsd2F5cyBzeW5jZWQgdXAgd2l0aCB5b3VyCnVwc3Ry
ZWFtIHZlcnNpb24sIHdlIGp1c3QgbmVlZCB0byBkbyBzb21lIG1hbnVhbCBgYHN1Ym1vZHVsZSB1
cGRhdGVgYApvcGVyYXRpb25zIHRvIGNoZWNrb3V0IHlvdXIgdmVyc2lvbiB3aGVuIGRvaW5nIGEg
TFRQIHJlbGVhc2UuIFNvIEknbGwKbWVyZ2UgdGhpcyBwYXRjaCBpbiwgcmVtb3ZlIGFsbCBjdXJy
ZW50IG91dC1vZi1kYXRlIGNvZGVzLCBhbmQgd2FpdCBmb3IKeW91ciBub3RpY2Ugb2YgbWNlLXRl
c3QncyBuZXh0IHZlcnNpb24sIHNvIHRoYXQgd2UgY2FuIGluY2x1ZGUgaXQgaW4gb3VyCm5leHQg
TFRQIHN0YWJsZSByZWxlYXNlLgoKVGhhbmtzLApDYXNwYXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpGb3IgRGV2ZWxvcGVycywgQSBMb3QgQ2FuIEhhcHBlbiBJbiBBIFNlY29uZC4KQm91bmRhcnkg
aXMgdGhlIGZpcnN0IHRvIEtub3cuLi5hbmQgVGVsbCBZb3UuCk1vbml0b3IgWW91ciBBcHBsaWNh
dGlvbnMgaW4gVWx0cmEtRmluZSBSZXNvbHV0aW9uLiBUcnkgaXQgRlJFRSEKaHR0cDovL3Auc2Yu
bmV0L3NmdS9Cb3VuZGFyeS1kMmR2czIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
dHAtbGlzdAo=
