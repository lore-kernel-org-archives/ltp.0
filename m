Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SH7k0-0003kH-4m
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 06:06:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SH7jz-0003vO-0N
	for ltp-list@lists.sourceforge.net; Mon, 09 Apr 2012 06:06:16 +0000
Message-ID: <4F827C0C.9060405@cn.fujitsu.com>
Date: Mon, 09 Apr 2012 14:05:00 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<20120316143522.GB19604@alboin.amr.corp.intel.com>
	<4F699CDD.606@linux.intel.com> <4F7EFED0.4040405@casparzhang.com>
	<4F825325.3030308@linux.intel.com>
	<4F825F9D.3020608@casparzhang.com>
	<4F827B6A.3020204@linux.intel.com>
In-Reply-To: <4F827B6A.3020204@linux.intel.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
To: Chen Gong <gong.chen@linux.intel.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Andi Kleen <andi.kleen@intel.com>

T24gMDQvMDkvMjAxMiAwMjowMiBQTSwgQ2hlbiBHb25nIHdyb3RlOgoKPiDkuo4gMjAxMi80Lzkg
MTI6MDMsIENhc3BhciBaaGFuZyDlhpnpgZM6Cj4+IE9uIDA0LzA5LzIwMTIgMTE6MTAgQU0sIENo
ZW4gR29uZyB3cm90ZToKPj4+IOS6jiAyMDEyLzQvNiAyMjozMywgQ2FzcGFyIFpoYW5nIOWGmemB
kzoKPj4+PiBPbiAwMy8yMS8yMDEyIDA1OjE4IFBNLCBDaGVuIEdvbmcgd3JvdGU6Cj4+Pj4+IOS6
jiAyMDEyLzMvMTYgMjI6MzUsIEFuZGkgS2xlZW4g5YaZ6YGTOgo+Pj4+Pj4gT24gRnJpLCBNYXIg
MTYsIDIwMTIgYXQgMDM6Mjc6NDRQTSArMDgwMCwgQ2FzcGFyIFpoYW5nIHdyb3RlOgo+Pj4+Pj4+
IEhpIGFsbCwgSSdsbCBtZXJnZSB0aGlzIGNoYW5nZSB0byBtYXN0ZXIgaWYgSSBkb24ndCBoZWFy
IGFueSBvYmplY3Rpb25zCj4+Pj4+Pj4gZnJvbSB5b3UgYnkgdG9kYXkuCj4+Pj4+PiBGaW5lIGZv
ciBtZS4gQ29weWluZyBHb25nIENoZW4gd2hvIGRpZCBtb3N0IG9mIHRoZSBtY2UtdGVzdCB3b3Jr
IHJlY2VudGx5Cj4+Pj4+PiB0b28uCj4+Pj4+Pgo+Pj4+Pj4gLUFuZGkKPj4+Pj4gT2gsIHllcy4g
UmVjZW50bHkgSSBtYWtlIGEgYmlnIGNoYW5nZSBvbiBtY2UtdGVzdCBwcm9qZWN0IGFuZCBvbGQK
Pj4+Pj4gc3RydWN0dXJlIHdpbGwgYmUgcmVvcmdhbml6ZWQuCj4+Pj4+IEFuZCBJIGV2ZXIgbG9v
a2VkIHRocm91Z2ggdGhlIG1jZS10ZXN0IHBhcnQgaW4gTFRQLiBVbmZvcnR1bmF0ZWx5IGl0IGlz
Cj4+Pj4+IHZlcnkgb2xkIGFuZCBjYW4ndCBydW4gb24KPj4+Pj4gbmV3ZXIga2VybmVsLiBJIGhv
cGUgeW91IGNhbiBrZWVwIGN1cnJlbnQgZGlzYWJsZWQgc3RhdHVzIGluIExUUCBhbmQKPj4+Pj4g
d2FpdCBteSBuZXcgd29yayBpcyBtZXJnZWQuCj4+Pj4+IFdlIGNhbiB0YWxrIGF0IHRoYXQgdGlt
ZS4gSXMgaXQgT0sgdG8geW91Pwo+Pj4+IEhpIENoZW4gR29uZywgc29ycnkgZm9yIGxhdGUgcmVw
bHksIHdlJ3JlIHBsYW5uaW5nIHRvIHJlbW92ZSBvbGQgc3RhdGljCj4+Pj4gY29kZWQgbWNlLXRl
c3QgZnJvbSBMVFAsIGFuZCB1c2UgaXQgYXMgYSBzdWJtb2R1bGUsIHdoaWNoIG1lYW5zLAo+Pj4+
IG1jZS10ZXN0IHdvbid0IGJlIHN0YXRpYy1jb2RlZCBhbnkgbW9yZSwgaXQncyBhbHdheXMgc3lu
Y2VkIHVwIHdpdGggeW91cgo+Pj4+IHVwc3RyZWFtIHZlcnNpb24sIHdlIGp1c3QgbmVlZCB0byBk
byBzb21lIG1hbnVhbCBgYHN1Ym1vZHVsZSB1cGRhdGVgYAo+Pj4+IG9wZXJhdGlvbnMgdG8gY2hl
Y2tvdXQgeW91ciB2ZXJzaW9uIHdoZW4gZG9pbmcgYSBMVFAgcmVsZWFzZS4gU28gSSdsbAo+Pj4+
IG1lcmdlIHRoaXMgcGF0Y2ggaW4sIHJlbW92ZSBhbGwgY3VycmVudCBvdXQtb2YtZGF0ZSBjb2Rl
cywgYW5kIHdhaXQgZm9yCj4+Pj4geW91ciBub3RpY2Ugb2YgbWNlLXRlc3QncyBuZXh0IHZlcnNp
b24sIHNvIHRoYXQgd2UgY2FuIGluY2x1ZGUgaXQgaW4gb3VyCj4+Pj4gbmV4dCBMVFAgc3RhYmxl
IHJlbGVhc2UuCj4+Pj4KPj4+PiBUaGFua3MsCj4+Pj4gQ2FzcGFyCj4+Pj4KPj4+IEl0J3MgZmlu
ZSB0byBtZS4gU28gZG8geW91IHdhbnQgdG8gZ2V0IGEgbm90aWNlIGZyb20gbWUgYWZ0ZXIgdGhl
IGNvZGVzCj4+PiBhcmUgbWVyZ2VkIG9yIHlvdQo+Pj4gbW9uaXRvciB0aGUgdXBzdHJlYW0gc3Rh
dHVzIGJ5IHlvdXJzZWxmPwo+PiBJJ2QgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgY2FuIHNlbmQgbWUg
YSBtYWlsIHdoZW4gdGhlIGNvZGVzIGdldCBtZXJnZWQsCj4+IGJ1dCBJJ2xsIGNoZWNrIHVwc3Ry
ZWFtIHN0YXR1cyBhcyB3ZWxsIGZyb20gdGltZSB0byB0aW1lLgo+Pgo+PiBUaGFua3MsCj4+IENh
c3Bhcgo+Pgo+IE9LLCBJIHdpbGwuIE5vdyBwYXRjaCBpcyBpbiB0aGUgcmV2aWV3IHN0YXR1cywg
c28gSSB3aWxsIHRlbGwgeW91IEFTQVAgYWZ0ZXIgbWVyZ2VkLgoKCkdyZWF0LCB0aGFua3MgQ2hl
biwKCldhbmxvbmcgR2FvCgo+IAoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRm9yIERldmVsb3Bl
cnMsIEEgTG90IENhbiBIYXBwZW4gSW4gQSBTZWNvbmQuCkJvdW5kYXJ5IGlzIHRoZSBmaXJzdCB0
byBLbm93Li4uYW5kIFRlbGwgWW91LgpNb25pdG9yIFlvdXIgQXBwbGljYXRpb25zIGluIFVsdHJh
LUZpbmUgUmVzb2x1dGlvbi4gVHJ5IGl0IEZSRUUhCmh0dHA6Ly9wLnNmLm5ldC9zZnUvQm91bmRh
cnktZDJkdnMyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
