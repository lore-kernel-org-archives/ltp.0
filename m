Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gong.chen@linux.intel.com>) id 1SAHgg-0006zd-1y
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 09:18:34 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAHgb-000788-Ur
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 09:18:33 +0000
Message-ID: <4F699CDD.606@linux.intel.com>
Date: Wed, 21 Mar 2012 17:18:21 +0800
From: Chen Gong <gong.chen@linux.intel.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
In-Reply-To: <20120316143522.GB19604@alboin.amr.corp.intel.com>
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
To: Caspar Zhang <caspar@casparzhang.com>, gaowanlong@cn.fujitsu.com, Garrett Cooper <yanegomi@gmail.com>
Cc: Andi Kleen <andi.kleen@intel.com>, LTP list <ltp-list@lists.sourceforge.net>, ying.huang@intel.com

5LqOIDIwMTIvMy8xNiAyMjozNSwgQW5kaSBLbGVlbiDlhpnpgZM6Cj4gT24gRnJpLCBNYXIgMTYs
IDIwMTIgYXQgMDM6Mjc6NDRQTSArMDgwMCwgQ2FzcGFyIFpoYW5nIHdyb3RlOgo+PiBIaSBhbGws
IEknbGwgbWVyZ2UgdGhpcyBjaGFuZ2UgdG8gbWFzdGVyIGlmIEkgZG9uJ3QgaGVhciBhbnkgb2Jq
ZWN0aW9ucwo+PiBmcm9tIHlvdSBieSB0b2RheS4KPiBGaW5lIGZvciBtZS4gQ29weWluZyBHb25n
IENoZW4gd2hvIGRpZCBtb3N0IG9mIHRoZSBtY2UtdGVzdCB3b3JrIHJlY2VudGx5Cj4gdG9vLgo+
Cj4gLUFuZGkKPgo+Pgo+PiBPbiAwMy8wOS8yMDEyIDA4OjI1IEFNLCBXYW5sb25nIEdhbyB3cm90
ZToKPj4+IE9uIDAzLzA5LzIwMTIgMTI6NTAgQU0sIENhc3BhciBaaGFuZyB3cm90ZToKPj4+Cj4+
Pj4gSGkgR2FycmV0dCwgQW5kaSwgYW5kIGFsbDoKPj4+Pgo+Pj4+IFdoZW4gSSBsb29rZWQgaW50
byBjdXJyZW50IExUUCB0cmVlLCBJIGZvdW5kIGl0IGEgbGl0dGxlIG1lc3N5IGR1ZSB0bwo+Pj4+
IHNvbWUgbWNlLXRlc3Qgc3R1ZmYsIHN1Y2ggYXMKPj4+Pgo+Pj4+ICAgIC0gbWNlLXRlc3QgZG9j
cyBnb2VzIHRvICRUT1BESVIvUkVBRE1FLCBhbmQKPj4+PiAgICAtIHNvbWUgbWNlLXRlc3QgZmls
ZXMgc3RpbGwgbHlpbmcgdW5kZXIgdGVzdGNhc2UvbWNlLXRlc3QvLgo+Pj4+Cj4+Pj4gSSB0aGlu
ayB3ZSBuZWVkIGEgY2xlYW51cCBmb3IgaXQuCj4+Pgo+Pj4geWVzLCBJIHRoaW5rIHNvLgo+Pj4K
Pj4+PiBBbHNvIGFuIGlkZWEgY29tZXMgdG8gbXkgbWluZCwgdGhhdCB3ZSBjYW4gdHJ5IHRvIG1h
a2UgbWNlLXRlc3QgYQo+Pj4+IHN1Ym1vZHVsZSBvZiBMVFAuCj4+Pgo+Pj4gTm90IGEgYmFkIGlk
ZWEuCj4+Pgo+Pj4+IEkgYW0gYWxzbyB0aGlua2luZyBhYm91dCB0aGUgcHJvcyBhbmQgY29uczoK
Pj4+Pgo+Pj4+IHBybyhzKToKPj4+PiAgICAtIGVhc2llciBmb3IgY29kZSBtYWludGVuYW5jZSwg
bm8gbmVlZCB0byBzeW5jIHBlcmlvZGljYWxseSBmcm9tCj4+Pj4gbWFpbnRhaW5lciBzaWRlCj4+
Pj4KPj4+PiBjb24ocyk6Cj4+Pj4gICAgLSB0d28gZXh0cmEgc3RlcHMgYWRkZWQgZm9yIExUUCB1
c2VycywgdGhleSBoYXZlIHRvIGRvOgo+Pj4+ICAgICAgJCBnaXQgc3VibW9kdWxlIGluaXQKPj4+
PiAgICAgICQgZ2l0IHN1Ym1vZHVsZSB1cGRhdGUKPj4+PiB0byBlbmFibGUgdXNpbmcgbWNlLXRl
c3QuCj4+Pj4KPj4+PiBtY2UtdGVzdCBjb3VsZCBubyBsb25nZXIgYmUgZm91bmQgYXQga2VybmVs
Lm9yZywgc28gSSBjbG9uZWQgaXQgZnJvbQo+Pj4+IEFuZGkncyBnaXRodWIgcmVwbywgbm90IHN1
cmUgaWYgaXQgaXMgdGhlIHJpZ2h0IHBsYWNlOgo+Pj4+Cj4+Pj4gICAgICBnaXQ6Ly9naXRodWIu
Y29tL2FuZGlrbGVlbi9tY2UtdGVzdC5naXQKPj4+Cj4+PiBUaGUgdHJlZSBzZWVtcyBqdXN0IGEg
ZmV3IHVwZGF0ZSBldmVyeSBtb250aCBub3csIEkgd29uZGVyIHdoeSBpbnRlbCBndXlzCj4+PiBk
aWRuJ3Qgc3luYyB0aGUgY29tbWl0cyB0byBMVFAgPwo+Pj4KPj4+PiBJIGhhdmUgbWFkZSB0aGlz
IGNoYW5nZSB0byBteSBwZXJzb25hbCBMVFAgZm9yaywgeW91IGNhbiByZXZpZXcgaXQgaGVyZToK
Pj4+Pgo+Pj4+ICAgICAgaHR0cHM6Ly9naXRodWIuY29tL2Nhc3BhcmFudC9sdHAvY29tbWl0LzVj
Y2ExN2Y2MzMKPj4+Cj4+PiBUaGUgcGF0Y2ggbG9vb2tzIGdvb2QuCj4+IFdhbmxvbmcsIHRoYW5r
cyBmb3IgcmV2aWV3Lgo+Pgo+PiBUaGFua3MsCj4+IENhc3Bhcgo+Pgo+Pgo+PgpPaCwgeWVzLiBS
ZWNlbnRseSBJIG1ha2UgYSBiaWcgY2hhbmdlIG9uIG1jZS10ZXN0IHByb2plY3QgYW5kIG9sZCAK
c3RydWN0dXJlIHdpbGwgYmUgcmVvcmdhbml6ZWQuCkFuZCBJIGV2ZXIgbG9va2VkIHRocm91Z2gg
dGhlIG1jZS10ZXN0IHBhcnQgaW4gTFRQLiBVbmZvcnR1bmF0ZWx5IGl0IGlzIAp2ZXJ5IG9sZCBh
bmQgY2FuJ3QgcnVuIG9uCm5ld2VyIGtlcm5lbC4gSSBob3BlIHlvdSBjYW4ga2VlcCBjdXJyZW50
IGRpc2FibGVkIHN0YXR1cyBpbiBMVFAgYW5kIAp3YWl0IG15IG5ldyB3b3JrIGlzIG1lcmdlZC4K
V2UgY2FuIHRhbGsgYXQgdGhhdCB0aW1lLiBJcyBpdCBPSyB0byB5b3U/CgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KVGhpcyBTRiBlbWFpbCBpcyBzcG9uc29zcmVkIGJ5OgpUcnkgV2luZG93cyBBenVy
ZSBmcmVlIGZvciA5MCBkYXlzIENsaWNrIEhlcmUgCmh0dHA6Ly9wLnNmLm5ldC9zZnUvc2ZkMmQt
bXNhenVyZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
dHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
