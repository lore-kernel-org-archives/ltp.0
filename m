Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mmoyj-0004vZ-9v
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:18:53 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mmoyc-0000GX-8h
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:18:53 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8DDBieJ004159
	for <ltp-list@lists.sourceforge.net>; Sun, 13 Sep 2009 09:11:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8DDIcII149456
	for <ltp-list@lists.sourceforge.net>; Sun, 13 Sep 2009 09:18:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8DDFTL4021099
	for <ltp-list@lists.sourceforge.net>; Sun, 13 Sep 2009 09:15:30 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <50FD90C65C53FB45BADEEBCD84FF07F201B17791@ATCPCS06.andestech.com>
References: <50FD90C65C53FB45BADEEBCD84FF07F201B17791@ATCPCS06.andestech.com>
Date: Sun, 13 Sep 2009 18:47:04 +0530
Message-Id: <1252847826.5357.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] pselect01: Fixed the checking logic to
	also	consider some variation.
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
To: nobuhiro@andestech.com
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

T24gU2F0LCAyMDA5LTA5LTEyIGF0IDE3OjA5ICswODAwLCBub2J1aGlyb0BhbmRlc3RlY2guY29t
IHdyb3RlOiAKPiBIaSBNaWtlLAo+IAo+IFRoYW5rcyBmb3IgaWRlbnRpZnlpbmcgdGhhdC4KPiBG
aXhlZCBwYXRjaCBhdHRhY2hlZC4KClRoYW5rcy4KClJlZ2FyZHMtLQpTdWJyYXRhCgo+IAo+IC1O
b2J1aGlybyBMaW4KPiAKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1pa2Ug
RnJ5c2luZ2VyIFttYWlsdG86dmFwaWVyQGdlbnRvby5vcmddIAo+IFNlbnQ6IFNhdHVyZGF5LCBT
ZXB0ZW1iZXIgMTIsIDIwMDkgMTA6MjggQU0KPiBUbzogbHRwLWxpc3RAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cj4gQ2M6IFNoYXduIEhzaW4tSHVuZyBMaW4o5p6X5L+h5a6PKQo+IFN1YmplY3Q6IFJl
OiBbTFRQXSBbUEFUQ0hdIHBzZWxlY3QwMTogRml4ZWQgdGhlIGNoZWNraW5nIGxvZ2ljIHRvIGFs
c28gY29uc2lkZXIgc29tZSB2YXJpYXRpb24uCj4gCj4gT24gRnJpZGF5IDExIFNlcHRlbWJlciAy
MDA5IDA5OjIwOjMzIE5vYnVoaXJvIExpbiB3cm90ZToKPiA+IC0JCWlmICh0b3RhbF9zZWMgPj0g
KGVuZCAtIHN0YXJ0KSkKPiA+ICsJCWlmKCgoZW5kIC0gc3RhcnQpID49IHRvdGFsX3NlYykgJiYg
KChlbmQgLSBzdGFydCkgPD0gdG90YWxfc2VjICsgCj4gPiArMSkpCj4gCj4gcGxlYXNlIGZpeCB5
b3VyIHN0eWxlLiAgc2tpbXBpbmcgb24gd2hpdGVzcGFjZSBkb2VzbnQgbWFrZSBmb3Igc21hbGxl
ciBjb2RlLgo+IAo+IHRoYXQgc2FpZCwgeW91ciB0ZXN0IGJvaWxzIGRvd24gdG8gIj09IHRvdGFs
X3NlYyIgb3IgIj09IHRvdGFsX3NlYyArIDEiLiAgCj4gbWlnaHQgYXMgd2VsbCB1c2UgdGhhdCBy
YXRoZXIgdGhhbiBjb25mdXNpbmcgZ3JlYXRlci9sZXNzIHRoYW4gY29tcGFyaXNvbnMuCj4gLW1p
a2UKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0
aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCj4gdHJpYWwu
IFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1lbnQg
LSBhbmQgZm9jdXMgb24gCj4gd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2Rp
bmcuIERpc2NvdmVyIHdoYXQncyBuZXcgd2l0aCAKPiBDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0
cDovL3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXyBMdHAtbGlzdCBtYWlsaW5nIGxpc3QgTHRwLWxpc3RAbGlzdHMu
c291cmNlZm9yZ2UubmV0IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2x0cC1saXN0CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMg
aGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAK
dHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxv
eW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24g
Y29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGggCkNyeXN0YWwgUmVwb3J0cyBub3cuICBo
dHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2x0cC1saXN0Cg==
