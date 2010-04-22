Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O4p4d-0006Cq-Mf
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 05:35:39 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4p4c-0006fv-Kn
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 05:35:39 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3M5Ptd0020164
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 01:25:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3M5ZWUM2060542
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 01:35:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3M5ZWLJ028970
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 02:35:32 -0300
Received: from [9.77.121.81] ([9.77.121.81])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3M5ZUPo028948
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 02:35:31 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100421120550.13534.21836.sendpatchset@subratamodak.linux.ibm.com>
References: <20100421120550.13534.21836.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 22 Apr 2010 11:05:26 +0530
Message-Id: <1271914527.5122.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix Location Of GENHTML Inside RUNLTP
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

T24gV2VkLCAyMDEwLTA0LTIxIGF0IDE3OjM1ICswNTMwLCBTdWJyYXRhIE1vZGFrIHdyb3RlOgo+
IFRoZXJlIGFyZSBzb21lIGJpdHMgYW5kIHBpZWNlcyBvZiByZXN0cnVjdHVyaW5nIHN0aWxsIGxl
ZnQgdG8gYmUgZG9uZS4KPiBydW5sdHAgaXMgbm90IGFibGUgdG8gY2FsbCBnZW5odG1sIHByb3Bl
cmx5IGR1ZSB0byBjaGFuZ2UgaW4gbG9jYXRpb24KPiBvZiB0aGUgc2FtZSBzY3JpcHQuIFRoZSBm
b2xsb3dpbmcgZXJyb3Igd2lsbCBvY2N1cjoKPiAKPiAuLi4KPiBHZW5lcmF0aW5nIEhUTUwgT3V0
cHV0Li4uLi4hIQo+IENhbid0IG9wZW4gcGVybCBzY3JpcHQgIi9vcHQvbHRwL3Rvb2xzL2dlbmh0
bWwucGwiOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Cj4gLi4uCj4gCj4gRm9sbG93aW5nIHBh
dGNoIGZpeGVzIHRoZSBzYW1lLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFN1YnJhdGEgTW9kYWsgPHN1
YnJhdGFAbGludXgudm5ldC5pYm0uY29tPgo+IC0tLQoKRmlyc3Qgb2YgYWxsLCBkb2VzIHRoaXMg
cGF0Y2ggc29sdmUgdGhlIGlzc3VlIGF0IGFueWJvZHnFmyBzaWRlID8gSWYgeWVzLApjYW4gdGhp
cyBiZSBpbmNsdWRlZCBpbiBBcHJpbCAyMDEwIHJlbGVhc2UgPwoKUmVnYXJkcy0tClN1YnJhdGEK
Cj4gCj4gLS0tIGx0cC1kZXYvcnVubHRwLm9yaWcJMjAxMC0wNC0yMSAyMjo0ODo1OC4yMjM2NTE0
NDAgKzA1MzAKPiArKysgbHRwLWRldi9ydW5sdHAJMjAxMC0wNC0yMSAyMjo0OToxMC45MDE3ODM0
NDUgKzA1MzAKPiBAQCAtODQ2LDcgKzg0Niw3IEBAIG1haW4oKQo+ICAgICAgICAgZXhwb3J0IFRF
U1RfT1VUUFVUX0RJUkVDVE9SWT0iJExUUFJPT1Qvb3V0cHV0Igo+ICAgICAgICAgZXhwb3J0IFRF
U1RfTE9HU19ESVJFQ1RPUlk9JExPR1NfRElSRUNUT1JZCj4gICAgICAgICBlY2hvICJHZW5lcmF0
aW5nIEhUTUwgT3V0cHV0Li4uLi4hISIKPiAtICAgICAgICggcGVybCAkTFRQUk9PVC90b29scy9n
ZW5odG1sLnBsICRMVFBST09UL3Rvb2xzL2h0bWxfcmVwb3J0X2hlYWRlci50eHQgdGVzdF9zdGFy
dCB0ZXN0X2VuZCB0ZXN0X291dHB1dCBleGVjdXRpb25fc3RhdHVzICRPVVRQVVRfRElSRUNUT1JZ
ICA+ICRIVE1MRklMRTsgKSAgIAo+ICsgICAgICAgKCBwZXJsICRMVFBST09UL2Jpbi9nZW5odG1s
LnBsICRMVFBST09UL3Rvb2xzL2h0bWxfcmVwb3J0X2hlYWRlci50eHQgdGVzdF9zdGFydCB0ZXN0
X2VuZCB0ZXN0X291dHB1dCBleGVjdXRpb25fc3RhdHVzICRPVVRQVVRfRElSRUNUT1JZICA+ICRI
VE1MRklMRTsgKSAgIAo+ICAgICAgICAgZWNobyAiR2VuZXJhdGVkIEhUTUwgT3V0cHV0Li4uLi4h
ISIKPiAgICAgICAgIGVjaG8gIkxvY2F0aW9uOiAkSFRNTEZJTEUiOwo+IAo+IC0tLQo+IFJlZ2Fy
ZHMtLQo+IFN1YnJhdGEKPiAKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0
cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
