Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gong.chen@linux.intel.com>) id 1SZuml-0005SZ-CQ
	for ltp-list@lists.sourceforge.net; Thu, 31 May 2012 02:06:47 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZumk-0000XZ-9j
	for ltp-list@lists.sourceforge.net; Thu, 31 May 2012 02:06:47 +0000
Message-ID: <4FC6D22E.3040905@linux.intel.com>
Date: Thu, 31 May 2012 10:06:38 +0800
From: Chen Gong <gong.chen@linux.intel.com>
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
	<4F8CD7AC.3050000@casparzhang.com> <4FBC42F5.508@linux.intel.com>
	<4FC5EA65.4040709@linux.intel.com>
	<4FC5F5A6.5020606@casparzhang.com>
In-Reply-To: <4FC5F5A6.5020606@casparzhang.com>
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

5LqOIDIwMTIvNS8zMCAxODoyNSwgQ2FzcGFyIFpoYW5nIOWGmemBkzoKPiBPbiAwNS8zMC8yMDEy
IDA1OjM3IFBNLCBDaGVuIEdvbmcgd3JvdGU6Cj4+IGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvZ29uZy5jaGVuL21jZS10ZXN0LmdpdAo+Pj4+Cj4+IApodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9nb25nLmNoZW4vbWNl
LXRlc3QuZ2l0Cj4+Pj4gCj4+Pj4gVGhlIGN1cnJlbnQgc3RhdHVzIGlzIHJlYWR5IHRvIGJlIG1l
cmdlZC4KPj4+PiAKPj4gcGluZyBhZ2Fpbgo+PiAKPj4gCj4gU29ycnkgZm9yIGRlbGF5aW5nLiBU
aGFua3MgZm9yIHRoZSB1cGRhdGUhIEknbGwgdXBkYXRlIGdpdCBVUkwKPiBzb29uLgo+IAo+IEp1
c3QgYW4gRllJLCB3ZSB3b24ndCBtZXJnZSB0aGUgYWN0dWFsIGNvZGVzIHRvIG91ciBnaXQgcmVw
bywgd2UKPiB3aWxsIG9ubHkgZG8gb25lLXRpbWUgcHVsbCAmIHVwZGF0ZSB3aGVuIGRvIGEgTFRQ
IHJlbGVhc2UuCj4gCj4gVGhhbmtzLCBDYXNwYXIKPiAKT0ssIHRoeCBhIGxvdCEKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpMaXZlIFNlY3VyaXR5IFZpcnR1YWwgQ29uZmVyZW5jZQpFeGNsdXNpdmUg
bGl2ZSBldmVudCB3aWxsIGNvdmVyIGFsbCB0aGUgd2F5cyB0b2RheSdzIHNlY3VyaXR5IGFuZCAK
dGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hhbmdlZCBhbmQgaG93IElUIG1hbmFnZXJzIGNhbiByZXNw
b25kLiBEaXNjdXNzaW9ucyAKd2lsbCBpbmNsdWRlIGVuZHBvaW50IHNlY3VyaXR5LCBtb2JpbGUg
c2VjdXJpdHkgYW5kIHRoZSBsYXRlc3QgaW4gbWFsd2FyZSAKdGhyZWF0cy4gaHR0cDovL3d3dy5h
Y2NlbGFjb21tLmNvbS9qYXcvc2ZybmwwNDI0MjAxMi8xMTQvNTAxMjIyNjMvCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlz
dApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
