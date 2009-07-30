Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaOX-0005jQ-KO
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:25 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaOW-0005hR-Qf
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:25 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIXx8j003689
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:33:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIUJ6n255304
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UIUIBq011393
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:19 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A713E40.2010000@cn.fujitsu.com>
References: <4A70F86E.50608@cn.fujitsu.com>
	<364299f40907292019r494348dt1e895f0c180f3f58@mail.gmail.com>
	<4A713E40.2010000@cn.fujitsu.com>
Date: Thu, 30 Jul 2009 23:59:59 +0530
Message-Id: <1248978600.5788.70.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix failure of the utimensat01 test
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
To: Wang Yong <wangyong2009@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

T24gVGh1LCAyMDA5LTA3LTMwIGF0IDE0OjMxICswODAwLCBXYW5nIFlvbmcgd3JvdGU6IAo+IEdh
cnJldHQgQ29vcGVyIHdyb3RlIGFzOgo+ID4gT24gV2VkLCBKdWwgMjksIDIwMDkgYXQgNjozMyBQ
TSwgV2FuZyBZb25nPHdhbmd5b25nMjAwOUBjbi5mdWppdHN1LmNvbT4gd3JvdGU6Cj4gPiAgIAo+
ID4+IFRoZSBlcnJvciBoYW5kbGluZyBmb3IgIlJXIiBvcHQgb2YgcnVuX3Rlc3QgYnJvdWdodCBh
Ym91dCBlcnJvciByZXN1bHRzLgo+ID4+IFRoaXMgcGF0Y2ggZml4ZWQgdGhhdC4KPiA+Pgo+ID4+
IFNpZ25lZC1vZmYtYnk6IFdhbmdZb25nIDx3YW5neW9uZzIwMDlAY24uZnVqaXRzdS5jb20+Cj4g
Pj4KPiA+PiBkaWZmIC1OdXJwIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZW5zYXQv
dXRpbWVuc2F0X3Rlc3RzLnNoCj4gPj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1l
bnNhdC91dGltZW5zYXRfdGVzdHMuc2gKPiA+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3V0aW1lbnNhdC91dGltZW5zYXRfdGVzdHMuc2ggICAgMjAwOS0wNy0yOCAxNjoyMzozOS4w
MDAwMDAwMDAgKzA4MDAKPiA+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1l
bnNhdC91dGltZW5zYXRfdGVzdHMuc2ggICAgMjAwOS0wNy0yOCAxNzozMjoyNi4wMDAwMDAwMDAg
KzA4MDAKPiA+PiBAQCAtMjYwLDIyICsyNjAsMjIgQEAgZWNobyAiVGVzdGluZyByZWFkLW9ubHkg
ZmlsZSwgb3duZWQgYnkgcwo+ID4+ICBlY2hvCj4gPj4gICAgIAo+ID4KPiA+IFsuLi5dCj4gPgo+
ID4gRG9uJ3QgdGhlc2UgY2hhbmdlcyBhY3R1YWxseSBjb25mbGljdCB3aXRoIHRoZSB0ZXN0Y2Fz
ZSdzIHB1cnBvc2UsCj4gPiBnaXZlbiB0aGUgbWVzc2FnZXMgZWNob2VkIHBsYWNlZCBkaXJlY3Rs
eSBhYm92ZSB0aGUgY29tbWFuZHM/Cj4gPiBUaGFua3MsCj4gPiAtR2FycmV0dAo+ID4KPiA+ICAg
Cj4gSGkgR2FycmV0dCwKPiAKPiBUaGlzIHBhdGNoIGRvZXNuJ3QgY2hhbmdlIHRoZSB0ZXN0Y2Fz
ZSdzIHB1cnBvc2UuCj4gQW5kIHRoZSB0ZXN0IHJlc3VsdHMgcHJvdmUgaXQuCgpIb3dldmVyLCBh
IG11Y2ggYnJvYWRlciBleHBsYW5hdGlvbiBvZiB0aGUgUGF0Y2ggYW5kIGl0xZsgcHVycG9zZSB3
b3VsZAppbmRlZWQgaGVscCBhIGdyZWF0IGRlYWwuCgpSZWdhcmRzLS0KU3VicmF0YQoKPiAKPiBC
ZXN0IHJlZ2FyZHMsCj4gV2FuZyBZb25nCj4gCj4gPgo+ID4gICAKPiAKPiAKPiAKPiAKPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiBMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0
aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCj4gdHJpYWwuIFNpbXBsaWZ5
IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1lbnQgLSBhbmQgZm9j
dXMgb24gCj4gd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2RpbmcuIERpc2Nv
dmVyIHdoYXQncyBuZXcgd2l0aCAKPiBDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDovL3Auc2Yu
bmV0L3NmdS9ib2JqLWp1bHkKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+IEx0cC1saXN0QGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2x0cC1saXN0CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMgaGFu
ZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKdHJp
YWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1l
bnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29k
aW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGggCkNyeXN0YWwgUmVwb3J0cyBub3cuICBodHRw
Oi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2x0cC1saXN0Cg==
