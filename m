Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gong.chen@linux.intel.com>) id 1SH7gN-0006lT-AV
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 06:02:31 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SH7gI-0003pm-KN
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 06:02:31 +0000
Message-ID: <4F827B6A.3020204@linux.intel.com>
Date: Mon, 09 Apr 2012 14:02:18 +0800
From: Chen Gong <gong.chen@linux.intel.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com> <4F7EFED0.4040405@casparzhang.com>
	<4F825325.3030308@linux.intel.com>
	<4F825F9D.3020608@casparzhang.com>
In-Reply-To: <4F825F9D.3020608@casparzhang.com>
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

5LqOIDIwMTIvNC85IDEyOjAzLCBDYXNwYXIgWmhhbmcg5YaZ6YGTOgo+IE9uIDA0LzA5LzIwMTIg
MTE6MTAgQU0sIENoZW4gR29uZyB3cm90ZToKPj4g5LqOIDIwMTIvNC82IDIyOjMzLCBDYXNwYXIg
Wmhhbmcg5YaZ6YGTOgo+Pj4gT24gMDMvMjEvMjAxMiAwNToxOCBQTSwgQ2hlbiBHb25nIHdyb3Rl
Ogo+Pj4+IOS6jiAyMDEyLzMvMTYgMjI6MzUsIEFuZGkgS2xlZW4g5YaZ6YGTOgo+Pj4+PiBPbiBG
cmksIE1hciAxNiwgMjAxMiBhdCAwMzoyNzo0NFBNICswODAwLCBDYXNwYXIgWmhhbmcgd3JvdGU6
Cj4+Pj4+PiBIaSBhbGwsIEknbGwgbWVyZ2UgdGhpcyBjaGFuZ2UgdG8gbWFzdGVyIGlmIEkgZG9u
J3QgaGVhciBhbnkgb2JqZWN0aW9ucwo+Pj4+Pj4gZnJvbSB5b3UgYnkgdG9kYXkuCj4+Pj4+IEZp
bmUgZm9yIG1lLiBDb3B5aW5nIEdvbmcgQ2hlbiB3aG8gZGlkIG1vc3Qgb2YgdGhlIG1jZS10ZXN0
IHdvcmsgcmVjZW50bHkKPj4+Pj4gdG9vLgo+Pj4+Pgo+Pj4+PiAtQW5kaQo+Pj4+IE9oLCB5ZXMu
IFJlY2VudGx5IEkgbWFrZSBhIGJpZyBjaGFuZ2Ugb24gbWNlLXRlc3QgcHJvamVjdCBhbmQgb2xk
Cj4+Pj4gc3RydWN0dXJlIHdpbGwgYmUgcmVvcmdhbml6ZWQuCj4+Pj4gQW5kIEkgZXZlciBsb29r
ZWQgdGhyb3VnaCB0aGUgbWNlLXRlc3QgcGFydCBpbiBMVFAuIFVuZm9ydHVuYXRlbHkgaXQgaXMK
Pj4+PiB2ZXJ5IG9sZCBhbmQgY2FuJ3QgcnVuIG9uCj4+Pj4gbmV3ZXIga2VybmVsLiBJIGhvcGUg
eW91IGNhbiBrZWVwIGN1cnJlbnQgZGlzYWJsZWQgc3RhdHVzIGluIExUUCBhbmQKPj4+PiB3YWl0
IG15IG5ldyB3b3JrIGlzIG1lcmdlZC4KPj4+PiBXZSBjYW4gdGFsayBhdCB0aGF0IHRpbWUuIElz
IGl0IE9LIHRvIHlvdT8KPj4+IEhpIENoZW4gR29uZywgc29ycnkgZm9yIGxhdGUgcmVwbHksIHdl
J3JlIHBsYW5uaW5nIHRvIHJlbW92ZSBvbGQgc3RhdGljCj4+PiBjb2RlZCBtY2UtdGVzdCBmcm9t
IExUUCwgYW5kIHVzZSBpdCBhcyBhIHN1Ym1vZHVsZSwgd2hpY2ggbWVhbnMsCj4+PiBtY2UtdGVz
dCB3b24ndCBiZSBzdGF0aWMtY29kZWQgYW55IG1vcmUsIGl0J3MgYWx3YXlzIHN5bmNlZCB1cCB3
aXRoIHlvdXIKPj4+IHVwc3RyZWFtIHZlcnNpb24sIHdlIGp1c3QgbmVlZCB0byBkbyBzb21lIG1h
bnVhbCBgYHN1Ym1vZHVsZSB1cGRhdGVgYAo+Pj4gb3BlcmF0aW9ucyB0byBjaGVja291dCB5b3Vy
IHZlcnNpb24gd2hlbiBkb2luZyBhIExUUCByZWxlYXNlLiBTbyBJJ2xsCj4+PiBtZXJnZSB0aGlz
IHBhdGNoIGluLCByZW1vdmUgYWxsIGN1cnJlbnQgb3V0LW9mLWRhdGUgY29kZXMsIGFuZCB3YWl0
IGZvcgo+Pj4geW91ciBub3RpY2Ugb2YgbWNlLXRlc3QncyBuZXh0IHZlcnNpb24sIHNvIHRoYXQg
d2UgY2FuIGluY2x1ZGUgaXQgaW4gb3VyCj4+PiBuZXh0IExUUCBzdGFibGUgcmVsZWFzZS4KPj4+
Cj4+PiBUaGFua3MsCj4+PiBDYXNwYXIKPj4+Cj4+IEl0J3MgZmluZSB0byBtZS4gU28gZG8geW91
IHdhbnQgdG8gZ2V0IGEgbm90aWNlIGZyb20gbWUgYWZ0ZXIgdGhlIGNvZGVzCj4+IGFyZSBtZXJn
ZWQgb3IgeW91Cj4+IG1vbml0b3IgdGhlIHVwc3RyZWFtIHN0YXR1cyBieSB5b3Vyc2VsZj8KPiBJ
J2QgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgY2FuIHNlbmQgbWUgYSBtYWlsIHdoZW4gdGhlIGNvZGVz
IGdldCBtZXJnZWQsCj4gYnV0IEknbGwgY2hlY2sgdXBzdHJlYW0gc3RhdHVzIGFzIHdlbGwgZnJv
bSB0aW1lIHRvIHRpbWUuCj4KPiBUaGFua3MsCj4gQ2FzcGFyCj4KT0ssIEkgd2lsbC4gTm93IHBh
dGNoIGlzIGluIHRoZSByZXZpZXcgc3RhdHVzLCBzbyBJIHdpbGwgdGVsbCB5b3UgQVNBUCAKYWZ0
ZXIgbWVyZ2VkLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZvciBEZXZlbG9wZXJzLCBBIExvdCBD
YW4gSGFwcGVuIEluIEEgU2Vjb25kLgpCb3VuZGFyeSBpcyB0aGUgZmlyc3QgdG8gS25vdy4uLmFu
ZCBUZWxsIFlvdS4KTW9uaXRvciBZb3VyIEFwcGxpY2F0aW9ucyBpbiBVbHRyYS1GaW5lIFJlc29s
dXRpb24uIFRyeSBpdCBGUkVFIQpodHRwOi8vcC5zZi5uZXQvc2Z1L0JvdW5kYXJ5LWQyZHZzMgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBt
YWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
