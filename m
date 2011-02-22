Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PrjHP-0005mJ-8E
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 03:51:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrjHO-0002LX-2V
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 03:51:15 +0000
Date: Tue, 22 Feb 2011 11:55:02 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110222035502.GB2883@hpt.nay.redhat.com>
References: <20110210072315.GA7909@hpt.nay.redhat.com>
	<4D6217CB.1040506@cn.fujitsu.com>
	<20110222015814.GA2883@hpt.nay.redhat.com>
	<4D631A92.8000904@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D631A92.8000904@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Fix disable set_ftrace_pid in
	ftrace_set_ftrace_pid.sh
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

T24gVHVlLCBGZWIgMjIsIDIwMTEgYXQgMTA6MDg6MThBTSArMDgwMCwgTGkgWmVmYW4gd3JvdGU6
Cj4g5LqOIDIwMTHlubQwMuaciDIy5pelIDA5OjU4LCBIYW4gUGluZ3RpYW4g5YaZ6YGTOgo+ID4g
T24gTW9uLCBGZWIgMjEsIDIwMTEgYXQgMDM6NDQ6MTFQTSArMDgwMCwgTGkgWmVmYW4gd3JvdGU6
Cj4gPj4gSGFuIFBpbmd0aWFuIHdyb3RlOgo+ID4+PiBJdCBzZWVtcyB3ZSBuZWVkIGVjaG8gLTEg
dG8gc2V0X2Z0cmFjZV9waWQgdG8gZGlzYWJsZSBpbi4gT3Igd2UnbGwgZ2V0Cj4gPj4+IHRoZXNl
IGVycm9yIG1lc3NhZ2Ugd2hlbiBydW5uaW5nIGZ0cmFjZV9zdHJlc3M6Cj4gPj4+Cj4gPj4KPiA+
PiBrZXJuZWwgdmVyc2lvbj8KPiA+IDIuNi4zMi0xMTQuMC4xLmVsNi54ODZfNjQgLCBSSEVMNi4x
Lgo+ID4+Cj4gPj4gVGhpcyBpcyB0aGUgcmVzdWx0IGZyb20gbGF0ZXN0IGtlcm5lbDoKPiA+Pgo+
ID4+ICMgZWNobyA+IHNldF9mdHJhY2VfcGlkCj4gPj4gIyBlY2hvIC0xID4gc2V0X2Z0cmFjZV9w
aWQKPiA+PiBiYXNoOiBlY2hvOiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudAo+ID4+Cj4g
PiBMb29rcyBsaWtlIGxhdGVzdCBrZXJuZWwgY2hhbmdlZCB0aGUgYmVoYXZpb3VyLiBCdXQgdGhl
Cj4gCj4gVGhlIGNoYW5nZSBjYW1lIGZyb20gY29tbWl0IDc1NmQxN2VlN2VlNGZiYzgyMzhiZGY5
NzEwMGFmNjNlNmFjNDQxZWYKPiAKPiBTbyB3ZSBoYXZlIHRvIGNoZWNrIHRoZSBrZXJuZWwgdmVy
c2lvbiwgb3IgdHJ5IGJvdGggImVjaG8gPiAuLi4iIGFuZAo+ICJlY2hvIC0xID4gLi4uIi4KSSBi
ZWxpZXZlIHRoZSBzZWNvbmQgbWV0aG9kIGlzIGJldHRlci4KPiAKPiA+IERvY3VtZW50YXRpb24v
dHJhY2UvZnRyYWNlLnR4dCBoYXNuJ3QgYmVlbiB1cGRhdGVkOgo+ID4gCj4gPiAgICAgIHl1bS11
cGRhdGVzZC0zMTExICBbMDAzXSAgMTYzNy4yNTQ2ODM6IGxvY2tfaHJ0aW1lcl9iYXNlIDwtaHJ0
aW1lcl90cnlfdG9fY2FuY2VsCj4gPiAgICAgIHl1bS11cGRhdGVzZC0zMTExICBbMDAzXSAgMTYz
Ny4yNTQ2ODU6IGZnZXRfbGlnaHQgPC1kb19zeXNfcG9sbAo+ID4gICAgICB5dW0tdXBkYXRlc2Qt
MzExMSAgWzAwM10gIDE2MzcuMjU0Njg2OiBwaXBlX3BvbGwgPC1kb19zeXNfcG9sbAo+ID4gIyBl
Y2hvIC0xID4gc2V0X2Z0cmFjZV9waWQKPiA+ICMgY2F0IHRyYWNlIHxoZWFkCj4gPiAgIyB0cmFj
ZXI6IGZ1bmN0aW9uCj4gPiAgIwo+ID4gICMgICAgICAgICAgIFRBU0stUElEICAgIENQVSMgICAg
VElNRVNUQU1QICBGVU5DVElPTgoKLS0gCkhhbiBQaW5ndGlhbgpRdWFsaXR5IEVuZ2luZWVyCmhw
dCBAICNrZXJuZWwtcWUKUmVkIEhhdCwgSW5jCkZyZWVkb20gLi4uIGNvdXJhZ2UgLi4uIENvbW1p
dG1lbnQgLi4uIEFDQ09VTlRBQklMSVRZCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW5kZXgsIFNl
YXJjaCAmIEFuYWx5emUgTG9ncyBhbmQgb3RoZXIgSVQgZGF0YSBpbiBSZWFsLVRpbWUgd2l0aCBT
cGx1bmsgCkNvbGxlY3QsIGluZGV4IGFuZCBoYXJuZXNzIGFsbCB0aGUgZmFzdCBtb3ZpbmcgSVQg
ZGF0YSBnZW5lcmF0ZWQgYnkgeW91ciAKYXBwbGljYXRpb25zLCBzZXJ2ZXJzIGFuZCBkZXZpY2Vz
IHdoZXRoZXIgcGh5c2ljYWwsIHZpcnR1YWwgb3IgaW4gdGhlIGNsb3VkLgpEZWxpdmVyIGNvbXBs
aWFuY2UgYXQgbG93ZXIgY29zdCBhbmQgZ2FpbiBuZXcgYnVzaW5lc3MgaW5zaWdodHMuIApGcmVl
IFNvZnR3YXJlIERvd25sb2FkOiBodHRwOi8vcC5zZi5uZXQvc2Z1L3NwbHVuay1kZXYyZGV2Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1h
aWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
