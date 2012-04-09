Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SH5pf-0000AU-FZ
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 04:03:59 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SH5pc-0003J3-LQ
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 04:03:59 +0000
Received: by pbcum15 with SMTP id um15so4452165pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 08 Apr 2012 21:03:50 -0700 (PDT)
Message-ID: <4F825F9D.3020608@casparzhang.com>
Date: Mon, 09 Apr 2012 12:03:41 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com> <4F7EFED0.4040405@casparzhang.com>
	<4F825325.3030308@linux.intel.com>
In-Reply-To: <4F825325.3030308@linux.intel.com>
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

T24gMDQvMDkvMjAxMiAxMToxMCBBTSwgQ2hlbiBHb25nIHdyb3RlOgo+IOS6jiAyMDEyLzQvNiAy
MjozMywgQ2FzcGFyIFpoYW5nIOWGmemBkzoKPj4gT24gMDMvMjEvMjAxMiAwNToxOCBQTSwgQ2hl
biBHb25nIHdyb3RlOgo+Pj4g5LqOIDIwMTIvMy8xNiAyMjozNSwgQW5kaSBLbGVlbiDlhpnpgZM6
Cj4+Pj4gT24gRnJpLCBNYXIgMTYsIDIwMTIgYXQgMDM6Mjc6NDRQTSArMDgwMCwgQ2FzcGFyIFpo
YW5nIHdyb3RlOgo+Pj4+PiBIaSBhbGwsIEknbGwgbWVyZ2UgdGhpcyBjaGFuZ2UgdG8gbWFzdGVy
IGlmIEkgZG9uJ3QgaGVhciBhbnkgb2JqZWN0aW9ucwo+Pj4+PiBmcm9tIHlvdSBieSB0b2RheS4K
Pj4+PiBGaW5lIGZvciBtZS4gQ29weWluZyBHb25nIENoZW4gd2hvIGRpZCBtb3N0IG9mIHRoZSBt
Y2UtdGVzdCB3b3JrIHJlY2VudGx5Cj4+Pj4gdG9vLgo+Pj4+Cj4+Pj4gLUFuZGkKPj4+IE9oLCB5
ZXMuIFJlY2VudGx5IEkgbWFrZSBhIGJpZyBjaGFuZ2Ugb24gbWNlLXRlc3QgcHJvamVjdCBhbmQg
b2xkCj4+PiBzdHJ1Y3R1cmUgd2lsbCBiZSByZW9yZ2FuaXplZC4KPj4+IEFuZCBJIGV2ZXIgbG9v
a2VkIHRocm91Z2ggdGhlIG1jZS10ZXN0IHBhcnQgaW4gTFRQLiBVbmZvcnR1bmF0ZWx5IGl0IGlz
Cj4+PiB2ZXJ5IG9sZCBhbmQgY2FuJ3QgcnVuIG9uCj4+PiBuZXdlciBrZXJuZWwuIEkgaG9wZSB5
b3UgY2FuIGtlZXAgY3VycmVudCBkaXNhYmxlZCBzdGF0dXMgaW4gTFRQIGFuZAo+Pj4gd2FpdCBt
eSBuZXcgd29yayBpcyBtZXJnZWQuCj4+PiBXZSBjYW4gdGFsayBhdCB0aGF0IHRpbWUuIElzIGl0
IE9LIHRvIHlvdT8KPj4gSGkgQ2hlbiBHb25nLCBzb3JyeSBmb3IgbGF0ZSByZXBseSwgd2UncmUg
cGxhbm5pbmcgdG8gcmVtb3ZlIG9sZCBzdGF0aWMKPj4gY29kZWQgbWNlLXRlc3QgZnJvbSBMVFAs
IGFuZCB1c2UgaXQgYXMgYSBzdWJtb2R1bGUsIHdoaWNoIG1lYW5zLAo+PiBtY2UtdGVzdCB3b24n
dCBiZSBzdGF0aWMtY29kZWQgYW55IG1vcmUsIGl0J3MgYWx3YXlzIHN5bmNlZCB1cCB3aXRoIHlv
dXIKPj4gdXBzdHJlYW0gdmVyc2lvbiwgd2UganVzdCBuZWVkIHRvIGRvIHNvbWUgbWFudWFsIGBg
c3VibW9kdWxlIHVwZGF0ZWBgCj4+IG9wZXJhdGlvbnMgdG8gY2hlY2tvdXQgeW91ciB2ZXJzaW9u
IHdoZW4gZG9pbmcgYSBMVFAgcmVsZWFzZS4gU28gSSdsbAo+PiBtZXJnZSB0aGlzIHBhdGNoIGlu
LCByZW1vdmUgYWxsIGN1cnJlbnQgb3V0LW9mLWRhdGUgY29kZXMsIGFuZCB3YWl0IGZvcgo+PiB5
b3VyIG5vdGljZSBvZiBtY2UtdGVzdCdzIG5leHQgdmVyc2lvbiwgc28gdGhhdCB3ZSBjYW4gaW5j
bHVkZSBpdCBpbiBvdXIKPj4gbmV4dCBMVFAgc3RhYmxlIHJlbGVhc2UuCj4+Cj4+IFRoYW5rcywK
Pj4gQ2FzcGFyCj4+Cj4gSXQncyBmaW5lIHRvIG1lLiBTbyBkbyB5b3Ugd2FudCB0byBnZXQgYSBu
b3RpY2UgZnJvbSBtZSBhZnRlciB0aGUgY29kZXMgCj4gYXJlIG1lcmdlZCBvciB5b3UKPiBtb25p
dG9yIHRoZSB1cHN0cmVhbSBzdGF0dXMgYnkgeW91cnNlbGY/CgpJJ2QgYXBwcmVjaWF0ZSBpdCBp
ZiB5b3UgY2FuIHNlbmQgbWUgYSBtYWlsIHdoZW4gdGhlIGNvZGVzIGdldCBtZXJnZWQsCmJ1dCBJ
J2xsIGNoZWNrIHVwc3RyZWFtIHN0YXR1cyBhcyB3ZWxsIGZyb20gdGltZSB0byB0aW1lLgoKVGhh
bmtzLApDYXNwYXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpGb3IgRGV2ZWxvcGVycywgQSBMb3Qg
Q2FuIEhhcHBlbiBJbiBBIFNlY29uZC4KQm91bmRhcnkgaXMgdGhlIGZpcnN0IHRvIEtub3cuLi5h
bmQgVGVsbCBZb3UuCk1vbml0b3IgWW91ciBBcHBsaWNhdGlvbnMgaW4gVWx0cmEtRmluZSBSZXNv
bHV0aW9uLiBUcnkgaXQgRlJFRSEKaHR0cDovL3Auc2YubmV0L3NmdS9Cb3VuZGFyeS1kMmR2czIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3Qg
bWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
