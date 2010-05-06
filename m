Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1OA5IO-0003wE-R8
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:55:36 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OA5IL-0007bE-GE
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:55:36 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o46Hm7gP017587
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 11:48:07 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o46HtHfB015402
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 11:55:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o46HtDRY021555
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 11:55:14 -0600
Date: Thu, 6 May 2010 12:55:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100506175512.GA25514@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
	<j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
Subject: Re: [LTP] [04/12 FAILURE] LTP? sysctl03 test fails
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Michael Kerrisk <mtk.manpages@gmail.com>

UXVvdGluZyBHYXJyZXR0IENvb3BlciAoeWFuZWdvbWlAZ21haWwuY29tKToKPiBPbiBUaHUsIE1h
eSA2LCAyMDEwIGF0IDY6NTMgQU0sIFNlcmdlIEUuIEhhbGx5biA8c2VydWVAdXMuaWJtLmNvbT4g
d3JvdGU6Cj4gPiBRdW90aW5nIEdhcnJldHQgQ29vcGVyICh5YW5lZ29taUBnbWFpbC5jb20pOgo+
ID4+IE9uIE1heSA1LCAyMDEwLCBhdCAxMTo1NiBQTSwgU3VicmF0YSBNb2RhayB3cm90ZToKPiA+
Pgo+ID4+ID4gU3ViamVjdDogTFRQxZsgc3lzY3RsMDMgdGVzdCBmYWlscwo+ID4+ID4KPiA+PiA+
IElzc3VlcyBEZXNjcmlwdGlvbiBCZWxvdzoKPiA+PiA+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KPiA+PiA+ICMgLi9ydW5sdHAgLXMgc3lzY3RsMDMKPiA+PiA+IDw8PHRl
c3Rfb3V0cHV0Pj4+Cj4gPj4gPiBzeXNjdGwwMyDCoCDCoDEgwqBURkFJTCDCoDogwqBFeHBlY3Rl
ZCBFUEVSTSAoMSksIGdvdCAxMzogUGVybWlzc2lvbiBkZW5pZWQKPiA+PiA+IHN5c2N0bDAzIMKg
IMKgMiDCoFRGQUlMIMKgOiDCoEV4cGVjdGVkIEVQRVJNLCBnb3QgMTMKPiA+PiA+IHN5c2N0bDAz
IMKgIMKgMSDCoFRGQUlMIMKgOiDCoEV4cGVjdGVkIEVQRVJNICgxKSwgZ290IDEzOiBQZXJtaXNz
aW9uIGRlbmllZAo+ID4+ID4gPDw8ZXhlY3V0aW9uX3N0YXR1cz4+Pgo+ID4+ID4gaW5pdGlhdGlv
bl9zdGF0dXM9Im9rIgo+ID4+ID4gZHVyYXRpb249MCB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0
ZXJtaW5hdGlvbl9pZD0xIGNvcmVmaWxlPW5vCj4gPj4gPiBjdXRpbWU9MCBjc3RpbWU9MAo+ID4+
ID4gPDw8dGVzdF9lbmQ+Pj4KPiA+Pgo+ID4+IMKgIMKgIMKgIEFscmVhZHkga25vd24gYW5kIHJl
Y2VudGx5IGRpc2N1c3NlZC4KPiA+Cj4gPiBOb3Qgb25seSBjYW4gdGhpbmdzIG1vdmUgZ2xhY2lh
bGx5IGluIGtlcm5lbC1sYW5kLCBidXQgZGVjaXNpb25zIG5vdAo+ID4geWV0IGltcGxlbWVudGVk
IGNhbiBiZSBjaGFuZ2VkLgo+ID4KPiA+IEluIHRoZSBtZWFudGltZSwgdGhlIHN5c2N0bCdzIHNp
dCB0aGVyZSBhcyBhIHBvdGVudGlhbCBzdWJqZWN0IGZvcgo+ID4gZXhwbG9pdGF0aW9uLgo+ID4K
PiA+IFNvIG5vdCBtZWFuaW5nIHRvIGJlIGFyZ3VtZW50YXRpdmUgZm9yIGl0cyBvd24gc2FrZSwg
SSBuZXZlcnRoZWxlc3MKPiA+IHRoaW5rIGl0J3MgYmV0dGVyIHRvIGZpeCB0aGUgdGVzdCB0aGFu
IGVpdGhlciB0byBpZ25vcmUgb3IgcmVtb3ZlCj4gPiBpdC4gwqBUd28gdW50ZXN0ZWQgcGF0Y2hl
cyBiZWxvdyAtIHRoZSBvbmUganVzdCByZXBsYWNlcyBFUEVSTSB3aXRoCj4gPiBFQUNDRVNTLiDC
oFRoZSBvdGhlciByZW1vdmVzIHRoZSAoaW1vIG1pc3VpZGVkKSBub3Rpb24gdGhhdCB3ZSBjYW4K
PiA+IGd1ZXNzIGF0IHRoZSBmYWlsaW5nIGVycm5vLgo+IAo+IEV4Y2VwdCB0aGF0IHRoZSBkb2N1
bWVudGF0aW9uIChtYW5wYWdlcykgc2hvdWxkIGV4cGxpY2l0bHkgc3RhdGUgd2hhdAo+IHRoZSBm
YWlsaW5nIGNvbmRpdGlvbnMgYXJlIGZvciBhbnkgZ2l2ZW4gbGliY2FsbCBhbmQgc3lzY2FsbC4g
SWYgbm90LAo+IHRoZSBMaW51eCBrZXJuZWwgZGV2cyBhbmQgZG9jdW1lbnRhdGlvbiB0ZWFtIGhh
dmUgZmFpbGVkIHRvIGRvIHRoZWlyCj4gam9iLgoKU28gc2luY2Ugd2UncmUgYWxsIG1lbWJlciBv
ZiB0aGUgZG9jIHRlYW0sIHNlbmQgYSBwYXRjaCBmb3Igc3lzY3RsKDIpCm1hbnBhZ2UgRVJST1JT
IHNlY3Rpb24gOikKCihtdGsgY2M6ZCBhcyB0aGlzIGlzIHByb2JhYmx5IG5ld3MgdG8gaGltKQoK
PiA+IEFuIExTTSBjb3VsZCBjaG9vc2UgdG8gcmV0dXJuIC1FUEVSTQo+ID4gYWZ0ZXIgYWxsLCBv
ciBwZXJoYXBzIGV2ZW4gc29tZXRoaW5nIGRpZmZlcmVudC4gwqBUaGUgdGhpbmcgdGhhdAo+ID4g
c2hvdWxkIHNjYXJlIHVzIGlzIGlmIHRoZSBjYWxsIHN1Y2NlZWRzLiDCoElmIHdlIGdpdmUgYW55
IGZhbHNlCj4gPiBwb3NpdGl2ZXMsIHRoZW4gdHJ1ZSBwb3NpdGl2ZXMgd2lsbCBzZWVtIGxlc3Mg
c2NhcnkuCj4gCj4gVGhpcyB3aWxsIGZhaWwgb24gb2xkZXIga2VybmVscyBhcyBzeXNjdGwoMikg
YWx3YXlzIHJldHVybmVkIEVQRVJNIGR1ZQoKU29ycnkgLSB3aGF0IHdpbGwgZmFpbD8KCkkgdGhp
bmsgeW91J3JlIHNheWluZyB0aGUgZmlyc3QgcGF0Y2ggd2lsbCwgYW5kIEkgYWdyZWUsIHdoaWNo
IGlzIHdoeQpJIGFkdm9jYXRlIHRoZSBzZWNvbmQgb25lIGkgcGFzdGVkIGluLgoKPiB0byB0aGUg
d2F5IGl0IHdhcyBpbXByb3Blcmx5IGRlc2lnbmVkLiBQbGVhc2Ugc2VlIHRoZSBwcmV2aW91cyB0
aHJlYWQKPiBmb3IgbW9yZSBpbmZvOiBodHRwOi8vbGttbC5vcmcvbGttbC8yMDEwLzMvNC8zNTQK
PiAKPiBUaGFua3MsCj4gLUdhcnJldHQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxp
c3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
