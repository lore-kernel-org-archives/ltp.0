Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MksiO-00074X-Bn
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 04:54:00 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MksiI-0001cD-3M
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 04:54:00 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n884nbOX025253
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 22:49:37 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n884rmPv248754
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 22:53:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n884rltW013285
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 22:53:48 -0600
Date: Mon, 7 Sep 2009 23:53:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090908045343.GA28650@us.ibm.com>
References: <20090902141027.GA13905@us.ibm.com>
	<200909021613.39566.vapier@gentoo.org>
	<1252323640.4922.28.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1252323640.4922.28.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 1/1] Containers: Pass a valid stack address
	to	clone
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Nathan T Lynch <natlynch@us.ibm.com>, Mike Frysinger <vapier@gentoo.org>

UXVvdGluZyBTdWJyYXRhIE1vZGFrIChzdWJyYXRhQGxpbnV4LnZuZXQuaWJtLmNvbSk6Cj4gT24g
V2VkLCAyMDA5LTA5LTAyIGF0IDE2OjEzIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZTogCj4g
PiBPbiBXZWRuZXNkYXkgMDIgU2VwdGVtYmVyIDIwMDkgMTA6MTA6MjcgU2VyZ2UgRS4gSGFsbHlu
IHdyb3RlOgo+ID4gPiBBbHNvIGZpeCB0aGUgbGlibmV0bnMgaGVscGVyIHRvLCBsaWtlIHRoZSBs
aWJjbG9uZSBvbmUsIHNwZWNpYWwtY2FzZQo+ID4gPiBocHBhIGFuZCBwYXNzIHRoZSBib3R0b20g
b2YgdGhlIHN0YWNrIHRvIGNsb25lMiBmb3IgX19pYTY0X18gKGFzIHBlcgo+ID4gPiB0aGUgbGli
Y2xvbmUgZXhhbXBsZSBhbmQgdGhlIGNsb25lMiBtYW5wYWdlKS4gIEkgZG9uJ3Qga25vdyBhbmQg
Y2FuJ3QKPiA+ID4gdGVzdCB3aGV0aGVyIGl0J3MgcmlnaHQsIGJ1dCBoYXZlIHRvIGFzc3VtZSB0
aGF0IG9uZSBvZiB0aGUgb3RoZXIgd2FzCj4gPiA+IHdyb25nLgo+ID4gCj4gPiBwbGVhc2UsIGxl
dCdzIHN0b3Agc2NyZXdpbmcgYXJvdW5kIHdpdGggdGhpcyBhbmQgY29weWluZyAmIHBhc3Rpbmcg
aXQgCj4gPiBldmVyeXdoZXJlLiAgY3JlYXRlIGEgbmV3IGRlZGljYXRlICJsdHBfY2xvbmUiIG9y
IHNpbWlsYXIgZnVuY3Rpb24gYW5kIHN0aWNrIAo+ID4gdGhlIGFyY2gtc3BlY2lmaWMgbG9naWMg
dGhlcmUuCj4gPiBpbnQgbHRwX2Nsb25lKGZ1bmMgcHRyLCBzdGFjayBiYXNlLCBzdGFjayBzaXpl
LCBjbG9uZSBmbGFncywgZnVuYyBhcmdzLi4uKQo+ID4gLW1pa2UKPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gCj4gU2VyZ2UsCj4gCj4gRGlkIHlvdSBwb3N0IGFueSBuZXcgcGF0Y2hlcyBh
ZnRlciBNaWtlxZsgY29tbWVudHMgPwoKTm8gSSBoYXZlbid0LiAgSSBhZ3JlZSB3aXRoIGhpbSwg
YW5kIHNlZSBvdGhlciBjYXNlcyB3aGljaCBjb3VsZApzdGFuZCBjb25zb2xpZGF0aW9uIHVuZGVy
IHN5c2NhbGxzL2Nsb25lLCBmcy9mc19iaW5kL25zY2xvbmUsCmNvbnRyb2xsZXJzL2Nncm91cCwg
c2VjdXJpdHkvdG9tb3lvLCBzZWN1cml0eS9zZWxpbnV4LXRlc3RzdWl0ZSwKYXVkaXQtdGVzdCwg
YW5kIG1pc2MvY3Jhc2guCgotc2VyZ2UKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3Rh
bCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAw
OCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9u
IGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFw
cGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoIApDcnlzdGFsIFJlcG9y
dHMgbm93LiAgaHR0cDovL3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1s
aXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
