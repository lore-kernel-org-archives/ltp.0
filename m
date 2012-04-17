Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SJyJp-00026i-Ab
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 02:39:01 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SJyJo-0004Qe-By
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 02:39:01 +0000
Received: by pbcum15 with SMTP id um15so7367556pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Apr 2012 19:38:54 -0700 (PDT)
Message-ID: <4F8CD7AC.3050000@casparzhang.com>
Date: Tue, 17 Apr 2012 10:38:36 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com> <4F7EFED0.4040405@casparzhang.com>
	<4F825325.3030308@linux.intel.com>
	<4F825F9D.3020608@casparzhang.com>
	<4F827B6A.3020204@linux.intel.com>
	<4F8CCF86.2010409@linux.intel.com>
In-Reply-To: <4F8CCF86.2010409@linux.intel.com>
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

T24gMDQvMTcvMjAxMiAxMDowMyBBTSwgQ2hlbiBHb25nIHdyb3RlOgo+IOS6jiAyMDEyLzQvOSAx
NDowMiwgQ2hlbiBHb25nIOWGmemBkzoKPj4g5LqOIDIwMTIvNC85IDEyOjAzLCBDYXNwYXIgWmhh
bmcg5YaZ6YGTOgo+Pj4gT24gMDQvMDkvMjAxMiAxMToxMCBBTSwgQ2hlbiBHb25nIHdyb3RlOgo+
Pj4+IOS6jiAyMDEyLzQvNiAyMjozMywgQ2FzcGFyIFpoYW5nIOWGmemBkzoKPj4+Pj4gT24gMDMv
MjEvMjAxMiAwNToxOCBQTSwgQ2hlbiBHb25nIHdyb3RlOgo+Pj4+Pj4g5LqOIDIwMTIvMy8xNiAy
MjozNSwgQW5kaSBLbGVlbiDlhpnpgZM6Cj4+Pj4+Pj4gT24gRnJpLCBNYXIgMTYsIDIwMTIgYXQg
MDM6Mjc6NDRQTSArMDgwMCwgQ2FzcGFyIFpoYW5nIHdyb3RlOgo+Pj4+Pj4+PiBIaSBhbGwsIEkn
bGwgbWVyZ2UgdGhpcyBjaGFuZ2UgdG8gbWFzdGVyIGlmIEkgZG9uJ3QgaGVhciBhbnkgCj4+Pj4+
Pj4+IG9iamVjdGlvbnMKPj4+Pj4+Pj4gZnJvbSB5b3UgYnkgdG9kYXkuCj4+Pj4+Pj4gRmluZSBm
b3IgbWUuIENvcHlpbmcgR29uZyBDaGVuIHdobyBkaWQgbW9zdCBvZiB0aGUgbWNlLXRlc3Qgd29y
ayAKPj4+Pj4+PiByZWNlbnRseQo+Pj4+Pj4+IHRvby4KPj4+Pj4+Pgo+Pj4+Pj4+IC1BbmRpCj4+
Pj4+PiBPaCwgeWVzLiBSZWNlbnRseSBJIG1ha2UgYSBiaWcgY2hhbmdlIG9uIG1jZS10ZXN0IHBy
b2plY3QgYW5kIG9sZAo+Pj4+Pj4gc3RydWN0dXJlIHdpbGwgYmUgcmVvcmdhbml6ZWQuCj4+Pj4+
PiBBbmQgSSBldmVyIGxvb2tlZCB0aHJvdWdoIHRoZSBtY2UtdGVzdCBwYXJ0IGluIExUUC4gVW5m
b3J0dW5hdGVseSAKPj4+Pj4+IGl0IGlzCj4+Pj4+PiB2ZXJ5IG9sZCBhbmQgY2FuJ3QgcnVuIG9u
Cj4+Pj4+PiBuZXdlciBrZXJuZWwuIEkgaG9wZSB5b3UgY2FuIGtlZXAgY3VycmVudCBkaXNhYmxl
ZCBzdGF0dXMgaW4gTFRQIGFuZAo+Pj4+Pj4gd2FpdCBteSBuZXcgd29yayBpcyBtZXJnZWQuCj4+
Pj4+PiBXZSBjYW4gdGFsayBhdCB0aGF0IHRpbWUuIElzIGl0IE9LIHRvIHlvdT8KPj4+Pj4gSGkg
Q2hlbiBHb25nLCBzb3JyeSBmb3IgbGF0ZSByZXBseSwgd2UncmUgcGxhbm5pbmcgdG8gcmVtb3Zl
IG9sZCAKPj4+Pj4gc3RhdGljCj4+Pj4+IGNvZGVkIG1jZS10ZXN0IGZyb20gTFRQLCBhbmQgdXNl
IGl0IGFzIGEgc3VibW9kdWxlLCB3aGljaCBtZWFucywKPj4+Pj4gbWNlLXRlc3Qgd29uJ3QgYmUg
c3RhdGljLWNvZGVkIGFueSBtb3JlLCBpdCdzIGFsd2F5cyBzeW5jZWQgdXAgd2l0aCAKPj4+Pj4g
eW91cgo+Pj4+PiB1cHN0cmVhbSB2ZXJzaW9uLCB3ZSBqdXN0IG5lZWQgdG8gZG8gc29tZSBtYW51
YWwgYGBzdWJtb2R1bGUgdXBkYXRlYGAKPj4+Pj4gb3BlcmF0aW9ucyB0byBjaGVja291dCB5b3Vy
IHZlcnNpb24gd2hlbiBkb2luZyBhIExUUCByZWxlYXNlLiBTbyBJJ2xsCj4+Pj4+IG1lcmdlIHRo
aXMgcGF0Y2ggaW4sIHJlbW92ZSBhbGwgY3VycmVudCBvdXQtb2YtZGF0ZSBjb2RlcywgYW5kIHdh
aXQgCj4+Pj4+IGZvcgo+Pj4+PiB5b3VyIG5vdGljZSBvZiBtY2UtdGVzdCdzIG5leHQgdmVyc2lv
biwgc28gdGhhdCB3ZSBjYW4gaW5jbHVkZSBpdCAKPj4+Pj4gaW4gb3VyCj4+Pj4+IG5leHQgTFRQ
IHN0YWJsZSByZWxlYXNlLgo+Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+Pj4+IENhc3Bhcgo+Pj4+Pgo+
Pj4+IEl0J3MgZmluZSB0byBtZS4gU28gZG8geW91IHdhbnQgdG8gZ2V0IGEgbm90aWNlIGZyb20g
bWUgYWZ0ZXIgdGhlIGNvZGVzCj4+Pj4gYXJlIG1lcmdlZCBvciB5b3UKPj4+PiBtb25pdG9yIHRo
ZSB1cHN0cmVhbSBzdGF0dXMgYnkgeW91cnNlbGY/Cj4+PiBJJ2QgYXBwcmVjaWF0ZSBpdCBpZiB5
b3UgY2FuIHNlbmQgbWUgYSBtYWlsIHdoZW4gdGhlIGNvZGVzIGdldCBtZXJnZWQsCj4+PiBidXQg
SSdsbCBjaGVjayB1cHN0cmVhbSBzdGF0dXMgYXMgd2VsbCBmcm9tIHRpbWUgdG8gdGltZS4KPj4+
Cj4+PiBUaGFua3MsCj4+PiBDYXNwYXIKPj4+Cj4+IE9LLCBJIHdpbGwuIE5vdyBwYXRjaCBpcyBp
biB0aGUgcmV2aWV3IHN0YXR1cywgc28gSSB3aWxsIHRlbGwgeW91IEFTQVAgCj4+IGFmdGVyIG1l
cmdlZC4KPiBUaGUgbmV3IHBhdGNoIGZvciBtY2UtdGVzdCBoYXMgYmVlbiBtZXJnZWQsIGJ1dCBp
dCBsb29rcyBhIGxpdHRsZSBiaXQgd3JvbmcKPiBkdXJpbmcgdGhlIG1lcmdlIHByb2NlZHVyZSAo
YWxsIHNoZWxsIHNjcmlwdHMgZXhlY3V0aW9uIHJpZ2h0IGFyZSBtaXNzZWQpLgo+IEknbSBwdXNo
aW5nIEFuZGkgdG8gZml4IGl0LCBzbyBwbGVhc2UgZG9uJ3QgYWRkIG1jZS10ZXN0IGF0IGN1cnJl
bnQgc3RhZ2UuCj4gSSB3aWxsIHRlbGwgeW91IHdoZW4gaXQgaXMgcmVhZHkuCgpOb3RlZC4gVGhh
bmtzIGZvciB0aGUgdXBkYXRlLgoKVGhhbmtzLApDYXNwYXIKCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpCZXR0ZXIgdGhhbiBzZWM/IE5vdGhpbmcgaXMgYmV0dGVyIHRoYW4gc2VjIHdoZW4gaXQgY29t
ZXMgdG8KbW9uaXRvcmluZyBCaWcgRGF0YSBhcHBsaWNhdGlvbnMuIFRyeSBCb3VuZGFyeSBvbmUt
c2Vjb25kIApyZXNvbHV0aW9uIGFwcCBtb25pdG9yaW5nIHRvZGF5LiBGcmVlLgpodHRwOi8vcC5z
Zi5uZXQvc2Z1L0JvdW5kYXJ5LWRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo=
