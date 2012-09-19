Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TE8pn-00082c-Ju
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 01:12:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TE8pl-0007nC-AP
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 01:12:11 +0000
Message-ID: <50591BB1.8030406@cn.fujitsu.com>
Date: Wed, 19 Sep 2012 09:11:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <9261c230876e6a3ab96b3e927c6d4b32eea0b56e.1346750103.git.jstancek@redhat.com>
	<50581E82.7080008@cn.fujitsu.com> <50583A1A.4060800@windriver.com>
In-Reply-To: <50583A1A.4060800@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_detach: avoid threads sharing stack
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

T24gMDkvMTgvMjAxMiAwNTowOCBQTSwgS2FuZyBLYWkgd3JvdGU6Cj4gT24gMjAxMuW5tDA55pyI
MTjml6UgMTU6MTAsIFdhbmxvbmcgR2FvIHdyb3RlOgo+PiBIaSBLYW5nLAo+Pgo+Pj4gVGhpcyB0
ZXN0Y2FzZSB3YXMgb2JzZXJ2ZWQgdG8gY3Jhc2ggd2l0aCBzZWdtZW50YXRpb24gZmF1bHQ6Cj4+
PiBodHRwOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L21zZzE0NjkyLmh0bWwKPiAKPiBIaSBXYW5sb25nLAo+IAo+PiBIYXZlIHlvdSB0ZXN0ZWQg
dGhpcyBwYXRjaCBmcm9tIEphbiBvbiB5b3VyIHN5c3RlbT8KPiAKPiBJdCBvcmlnaW5hbGx5IGZh
aWxzIG9uIHJvdXRlcnN0YXRpb24obWlwcykgYW5kIHRlc3QgSmFuJ3MgcGF0Y2ggMTAwIHRpbWVz
IGFuZCBwYXNzLgo+IFRoZSBwYXRjaCBhbHNvIHBhc3NlcyBvbiB4ODYgd2l0aCBZb2N0byBsaW51
eCBhbmQgeDg2XzY0IHdpdGggVWJ1bnR1IDExLjEwLgoKT0ssIHNvLCBKYW4sIGNhbiB5b3Ugd29y
ayBvdXQgYSBjbGVhbiBwYXRjaCB3aXRob3V0IGNvZGluZyBzdHlsZSBjaGFuZ2U/IEkgbWVhbiBq
dXN0CmNoYW5nZSB0aGUgY29kZSByZWxhdGVkIHlvdXIgdGhlb3J5LCBpdCdsbCBtYWtlIHRoZSBw
YXRjaCBsb29rcyBtb3JlIGNsZWFybHkuCgpPUiwgc3R5bGUgY2xlYW51cCBjYW4gZ28gZmlyc3Rs
eSBiZWZvcmUgdGhlIHRoZW9yeSBjaGFuZ2Ugd2l0aGluIHNlcGFyYXRlIHBhdGNoZXMuCgpUaGFu
a3MsCldhbmxvbmcgR2FvCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMaXZlIFNlY3VyaXR5IFZp
cnR1YWwgQ29uZmVyZW5jZQpFeGNsdXNpdmUgbGl2ZSBldmVudCB3aWxsIGNvdmVyIGFsbCB0aGUg
d2F5cyB0b2RheSdzIHNlY3VyaXR5IGFuZCAKdGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hhbmdlZCBh
bmQgaG93IElUIG1hbmFnZXJzIGNhbiByZXNwb25kLiBEaXNjdXNzaW9ucyAKd2lsbCBpbmNsdWRl
IGVuZHBvaW50IHNlY3VyaXR5LCBtb2JpbGUgc2VjdXJpdHkgYW5kIHRoZSBsYXRlc3QgaW4gbWFs
d2FyZSAKdGhyZWF0cy4gaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2ZybmwwNDI0MjAx
Mi8xMTQvNTAxMjIyNjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
