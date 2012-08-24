Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T4jIF-00069N-Hx
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 02:06:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4jIE-0005Kb-2W
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 02:06:39 +0000
Message-ID: <5036E139.6060603@cn.fujitsu.com>
Date: Fri, 24 Aug 2012 10:04:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <0b20ceed0020e979ec36629e552f77acf96467cc.1345704746.git.jstancek@redhat.com>
	<5035E6EF.2060808@windriver.com>
In-Reply-To: <5035E6EF.2060808@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_cond_signal: don't count
	pthread_cond_signals
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

T24gMDgvMjMvMjAxMiAwNDoxNiBQTSwgS2FuZyBLYWkgd3JvdGU6Cj4gT24gMjAxMuW5tDA45pyI
MjPml6UgMTQ6NTUsIEphbiBTdGFuY2VrIHdyb3RlOgo+PiA+IERvbid0IGNvdW50IGhvdyBtYW55
IHB0aHJlYWRfY29uZF9zaWduYWxzIGl0IHRvb2ssCj4+ID4gaWYgYW55IGZhaWxzIFNJR0FMUk0g
d2lsbCB0cmlnZ2VyIHRlc3RjYXNlIGZhaWx1cmUuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW4gU3RhbmNlazxqc3RhbmNla0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEthbmcgS2Fp
IDxrYWkua2FuZ0B3aW5kcml2ZXIuY29tPgo+IAoKUHVzaGVkLCB0aGFuayB5b3UuCgpXYW5sb25n
IEdhbwoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMaXZlIFNlY3VyaXR5IFZpcnR1YWwgQ29uZmVy
ZW5jZQpFeGNsdXNpdmUgbGl2ZSBldmVudCB3aWxsIGNvdmVyIGFsbCB0aGUgd2F5cyB0b2RheSdz
IHNlY3VyaXR5IGFuZCAKdGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hhbmdlZCBhbmQgaG93IElUIG1h
bmFnZXJzIGNhbiByZXNwb25kLiBEaXNjdXNzaW9ucyAKd2lsbCBpbmNsdWRlIGVuZHBvaW50IHNl
Y3VyaXR5LCBtb2JpbGUgc2VjdXJpdHkgYW5kIHRoZSBsYXRlc3QgaW4gbWFsd2FyZSAKdGhyZWF0
cy4gaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2ZybmwwNDI0MjAxMi8xMTQvNTAxMjIy
NjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1s
aXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
