Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MgIwg-0002F7-QK
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:53:50 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgIwf-0003Yd-T4
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:53:50 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7QDiQxk018704
	for <Ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 07:44:26 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7QDrUkh089290
	for <Ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 07:53:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7QDrTri025992
	for <Ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 07:53:29 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908261524310.17269@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908261443220.25669@vixen.sonytel.be>
	<20090826130717.GA50086@medusa.sis.pasteur.fr>
	<alpine.LRH.2.00.0908261524310.17269@vixen.sonytel.be>
Date: Wed, 26 Aug 2009 19:23:19 +0530
Message-Id: <1251294799.19240.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] undefined macro: _m4_divert_diversion
Reply-To: subrata@linux.vnet.ibm.com
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Nicolas Joly <njoly@pasteur.fr>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

Ck9uIFdlZCwgMjAwOS0wOC0yNiBhdCAxNToyNSArMDIwMCwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOgo+IE9uIFdlZCwgMjYgQXVnIDIwMDksIE5pY29sYXMgSm9seSB3cm90ZToKPiA+IE9uIFdl
ZCwgQXVnIDI2LCAyMDA5IGF0IDAyOjU3OjEwUE0gKzAyMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3
cm90ZToKPiA+ID4gV2hlbiB0cnlpbmcgdG8gYXV0b2NvbmZpZ3VyZSBjdXJyZW50IExUUCBvbiBZ
REwsIEkgZ2V0Ogo+ID4gPiAKPiA+ID4gICAgICMgbWFrZSBhdXRvdG9vbHMgCj4gPiA+ICAgICB0
b3VjaCBjb25maWcubWsKPiA+ID4gICAgIGFjbG9jYWwgLUkgbTQKPiA+ID4gICAgIG00L2x0cC11
bnNoYXJlLm00OjI6IGVycm9yOiBtNF9kZWZuOiB1bmRlZmluZWQgbWFjcm86IF9tNF9kaXZlcnRf
ZGl2ZXJzaW9uCj4gPiA+ICAgICBtNC9sdHAtdW5zaGFyZS5tNDoyOiB0aGUgdG9wIGxldmVsCj4g
PiA+ICAgICBhdXRvbTR0ZTogL3Vzci9sb2NhbC9iaW4vbTQgZmFpbGVkIHdpdGggZXhpdCBzdGF0
dXM6IDEKPiA+ID4gICAgIGFjbG9jYWw6IGF1dG9tNHRlIGZhaWxlZCB3aXRoIGV4aXQgc3RhdHVz
OiAxCj4gPiA+ICAgICBtYWtlOiAqKiogW2FjbG9jYWwubTRdIEVycm9yIDEKPiA+ID4gICAgICMK
PiA+IFsuLi5dCj4gPiAKPiA+IFRoaXMgaXMgYSBxdW90aW5nIHByb2JsZW0gLi4uIFRoZSBmb2xs
b3dpbmcgcGF0Y2ggc2hvdWxkIGZpeCBpdC4KPiAKPiBUaGFua3MsIG5vdyBpdCB3b3JrcyEKPiAK
PiA+IEluZGV4OiBtNC9sdHAtdW5zaGFyZS5tNAo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4gUkNTIGZpbGU6
IC9jdnNyb290L2x0cC9sdHAvbTQvbHRwLXVuc2hhcmUubTQsdgo+ID4gcmV0cmlldmluZyByZXZp
c2lvbiAxLjEKPiA+IGRpZmYgLXUgLXAgLXIxLjEgbHRwLXVuc2hhcmUubTQKPiA+IC0tLSBtNC9s
dHAtdW5zaGFyZS5tNAkyNSBBdWcgMjAwOSAwNzozNzo0NiAtMDAwMAkxLjEKPiA+ICsrKyBtNC9s
dHAtdW5zaGFyZS5tNAkyNiBBdWcgMjAwOSAxMzowNDowMyAtMDAwMAo+ID4gQEAgLTEsMiArMSwy
IEBACj4gPiAgQUNfREVGVU4oW0xUUF9DSEVDS19TWVNDQUxMX1VOU0hBUkVdLAo+ID4gLUFDX0NI
RUNLX0ZVTkNTX09OQ0UodW5zaGFyZSkpCj4gPiArW0FDX0NIRUNLX0ZVTkNTX09OQ0UoW3Vuc2hh
cmVdKV0pCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgSm9seSA8bmpvbHlAcGFzdGV1
ci5mcj4KCkdyZWF0LiBJdCBzaG91bGQgYmUgbWFkZSBhdmFpbGFibGUgaW4gdGhlIGNvbWluZyBy
ZWxlYXNlIGZvciBhbGwgZ29vZApyZWFzb25zLgoKUmVnYXJkcy0tClN1YnJhdGEKCj4gCj4gVGVz
dGVkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPEdlZXJ0LlV5dHRlcmhvZXZlbkBzb255Y29tLmNv
bT4KPiAKPiBXaXRoIGtpbmQgcmVnYXJkcywKPiAKPiBHZWVydCBVeXR0ZXJob2V2ZW4KPiBTb2Z0
d2FyZSBBcmNoaXRlY3QKPiBUZWNoc29mdCBDZW50cmUKPiAKPiBUZWNobm9sb2d5IGFuZCBTb2Z0
d2FyZSBDZW50cmUgRXVyb3BlCj4gVGhlIENvcnBvcmF0ZSBWaWxsYWdlIMK3IERhIFZpbmNpbGFh
biA3LUQxIMK3IEItMTkzNSBaYXZlbnRlbSDCtyBCZWxnaXVtCj4gCj4gUGhvbmU6ICAgICszMiAo
MCkyIDcwMCA4NDUzCj4gRmF4OiAgICAgICszMiAoMCkyIDcwMCA4NjIyCj4gRS1tYWlsOiAgIEdl
ZXJ0LlV5dHRlcmhvZXZlbkBzb255Y29tLmNvbQo+IEludGVybmV0OiBodHRwOi8vd3d3LnNvbnkt
ZXVyb3BlLmNvbS8KPiAKPiBBIGRpdmlzaW9uIG9mIFNvbnkgRXVyb3BlIChCZWxnaXVtKSBOLlYu
Cj4gVkFUIEJFIDA0MTMuODI1LjE2MCDCtyBSUFIgQnJ1c3NlbHMKPiBGb3J0aXMgwrcgQklDIEdF
QkFCRUJCIMK3IElCQU4gQkU0MTI5MzAzNzY4MDAxMAo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IExldCBDcnlzdGFsIFJlcG9ydHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0
YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKPiB0cmlhbC4gU2ltcGxpZnkgeW91ciByZXBvcnQgZGVz
aWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95bWVudCAtIGFuZCBmb2N1cyBvbiAKPiB3aGF0IHlv
dSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3
aXRoIAo+IENyeXN0YWwgUmVwb3J0cyBub3cuICBodHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVs
eQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRw
LWxpc3QgbWFpbGluZyBsaXN0Cj4gTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QKCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KTGV0IENyeXN0YWwgUmVwb3J0cyBoYW5kbGUgdGhlIHJlcG9ydGlu
ZyAtIEZyZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAtRGF5IAp0cmlhbC4gU2ltcGxpZnkgeW91
ciByZXBvcnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95bWVudCAtIGFuZCBmb2N1cyBv
biAKd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2RpbmcuIERpc2NvdmVyIHdo
YXQncyBuZXcgd2l0aCAKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUv
Ym9iai1qdWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
