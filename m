Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaP1-0005m5-Cy
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:55 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaOw-0005oN-DT
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:55 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIQOkv001812
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:26:24 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIUSGh096782
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:30:28 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UIURsn008020
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:30:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810907292318y75e43a83x4678c3acecf72a81@mail.gmail.com>
References: <f5a7b3810907290310h159a8fcby374e7d6b789a6d16@mail.gmail.com>
	<364299f40907292020g4c35caa4u12081032154f6301@mail.gmail.com>
	<f5a7b3810907292318y75e43a83x4678c3acecf72a81@mail.gmail.com>
Date: Fri, 31 Jul 2009 00:00:07 +0530
Message-Id: <1248978608.5788.71.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] open_posix_pthread_equal_2-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>

T24gVGh1LCAyMDA5LTA3LTMwIGF0IDExOjQ4ICswNTMwLCBuYXJlc2gga2FtYm9qdSB3cm90ZTog
Cj4gSGkgR2FycmV0dCwKPiAKPiBUaGVyZSB3ZXJlIG5vIGRpc2N1c3Npb25zIGZyb20gMjAwNSBp
biBwb3NpeCBjb21tdW5pdHkuCgpUcnVlLiBBbmQgd2UgZG8gbm90IHdhbnQgdG8gbG9vc2UgdGhp
cyBzdWIgdGVzdCBzdWl0ZSBvbmx5IGJlY2F1c2UgaXQgaXMKbm90IG1haW50YWluZWQgaW4gaXTF
myBvcmlnaW5hbCBwbGFjZS4gSXTFmyBub3cgdmVyeSB3ZWxsIHBhcnQgb2YgTFRQLgoKPiAKPiBS
ZWY6Cj4gCj4gaHR0cDovL3Bvc2l4dGVzdC5zb3VyY2Vmb3JnZS5uZXQvCj4gaHR0cDovL25wdGwu
YnVsbG9wZW5zb3VyY2Uub3JnLwo+IAo+IAo+IFNpbmNlIG9wZW5fcG9zaXhfdGVzdHN1aXRlIGlz
IHN1YiBtb2R1bGUgb2YgTFRQLAo+IEkgaGF2ZSBiZWVuIHJlcG9ydGluZyB0ZXN0IGNhc2VzIGJ1
Z3MgZnJvbSAyMDA4IGFuZCBwb3J0aW5nIGRpcmVjdGx5Cj4gdG8gb3BlbiBQb3NpeCB0ZXN0c3Vp
dGUgb2YgTFRQIGFmdGVyIExUUCBtZW1iZXJzIHJldmlldy4KPiAKPiBUaGVyZSBhcmUgcHJldHR5
IGdvb2QgTFRQIG1lbWJlcnMgd2hvIHJldmlldyBhbmQgd29ya3Mgb24gcG9zaXguCj4gCj4gQmVz
dCByZWdhcmRzLAo+IE5hcmVzaCBLYW1ib2p1Cj4gCj4gT24gVGh1LCBKdWwgMzAsIDIwMDkgYXQg
ODo1MCBBTSwgR2FycmV0dCBDb29wZXI8eWFuZWdvbWlAZ21haWwuY29tPiB3cm90ZToKPiA+IE9u
IFdlZCwgSnVsIDI5LCAyMDA5IGF0IDM6MTAgQU0sIG5hcmVzaCBrYW1ib2p1PG5hcmVzaC5rZXJu
ZWxAZ21haWwuY29tPiB3cm90ZToKPiA+PiBIaSwKPiA+Pgo+ID4+IEkgaGF2ZSBub3RpY2UgSFVO
RyBzdGF0dXMgZm9yIHB0aHJlYWRfZXF1YWwvMi0xLmMgdW5kZXIgcG9zaXggdGVzdCBzdWl0ZS4K
PiA+PiBjb25mb3JtYW5jZS9pbnRlcmZhY2VzL3B0aHJlYWRfZXF1YWwvMi0xLnRlc3Q6ZXhlY3V0
aW9uOkhVTkcKPiA+Pgo+ID4+IFRoaXMgYmVjYXVzZSBvZiB3aGlsZShkb19pdClsb29wIGlzIGJl
aGF2aW5nIGFzIHdoaWxlKDEpLgo+ID4+IGRvX2l0IHVwZGF0ZWQgdmFsdWUgZnJvbSBvbmUgdGhy
ZWFkIGlzIG5vdCByZWZsZWN0aW5nIGluIHRoZSBvdGhlcgo+ID4+IHRocmVhZCBiZWNhdXNlIHRo
ZSB0eXBlIGlzIG5vdCBwcm9wZXIuCj4gPj4gSSBoYXZlIGNoYW5nZWQgdGhlIHR5cGUgZnJvbSBj
aGFyIC0+IHZvbGF0aWxlIGludAo+ID4+Cj4gPj4gSSBoYXZlIHNoYXJlZCByZXN1bHRzIGJlZm9y
ZSBhbmQgYWZ0ZXIgdGhpcyBwYXRjaC4KPiA+Pgo+ID4+IEJlZm9yZSBQQVRDSDoKPiA+PiBjb25m
b3JtYW5jZS9pbnRlcmZhY2VzL3B0aHJlYWRfZXF1YWwvMi0xLnRlc3Q6ZXhlY3V0aW9uOkhVTkcK
PiA+Pgo+ID4+IEFmdGVyIFBBVENIOgo+ID4+IGNvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVh
ZF9lcXVhbC8yLTEudGVzdDpleGVjdXRpb246UEFTUwo+ID4+Cj4gPj4gSSBoYXZlIGF0dGFjaGVk
IHBhdGNoIGFuZCBiZWxvdy4KPiA+PiBQbGVhc2UgcmV2aWV3IHRoZSBzYW1lLgo+ID4+Cj4gPj4g
QmVzdCByZWdhcmRzLAo+ID4+IE5hcmVzaCBLYW1ib2p1Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBOYXJlc2ggS2FtYm9qdSA8IG5hcmVzaC5rZXJuZWxAZ21haWwuY29tID4KClRoYW5rcy4KClJl
Z2FyZHMtLQpTdWJyYXRhCgo+ID4+Cj4gPj4gZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX2VxdWFsLzItMS5j
Cj4gPj4gYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJm
YWNlcy9wdGhyZWFkX2VxdWFsLzItMS5jCj4gPj4gLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhf
dGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9lcXVhbC8yLTEuYyAyMDA1
LTA2LTAzCj4gPj4gMjI6MDE6NDcuMDAwMDAwMDAwICswNTMwCj4gPj4gKysrIGIvdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9lcXVh
bC8yLTEuYyAyMDA5LTA3LTI5Cj4gPj4gMTQ6Mjc6MDUuMDAwMDAwMDAwICswNTMwCj4gPj4gQEAg
LTgwLDcgKzgwLDcgQEAKPiA+PiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
ICAgIFRlc3QgY2FzZXMKPiA+PiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKi8KPiA+PiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwo+ID4+Cj4g
Pj4gLWNoYXIgZG9faXQ9MTsKPiA+PiArdm9sYXRpbGUgaW50IGRvX2l0PTE7Cj4gPj4gIHVuc2ln
bmVkIGxvbmcgY291bnRfb3BlPTA7Cj4gPj4gICNpZmRlZiBXSVRIX1NZTkNIUk8KPiA+PiAgc2Vt
X3Qgc2Vtc2lnMTsKPiA+Cj4gPiBOYXJlc2gsCj4gPiAgICBIYXZlIHlvdSBjb250cmlidXRlZCB0
aGlzIGJhY2sgdG8gb3BlbnBvc2l4LCBvciBhdCB0aGUgdmVyeSBsZWFzdAo+ID4gZmlsZWQgYSBi
dWcgYWJvdXQgdGhpcyB0aGF0IGNhbiBiZSByZWZlcmVuY2VkPwo+ID4gVGhhbmtzLAo+ID4gLUdh
cnJldHQKPiA+CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMgaGFu
ZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKdHJp
YWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1l
bnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29k
aW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGggCkNyeXN0YWwgUmVwb3J0cyBub3cuICBodHRw
Oi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2x0cC1saXN0Cg==
