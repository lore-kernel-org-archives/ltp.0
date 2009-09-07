Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mkcap-0000iu-2m
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:07 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mkcai-00088a-G1
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:07 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87Bcs7M013204
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:38:54 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87Bet6R247548
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87Bes4P016586
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:54 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909021613.39566.vapier@gentoo.org>
References: <20090902141027.GA13905@us.ibm.com>
	<200909021613.39566.vapier@gentoo.org>
Date: Mon, 07 Sep 2009 17:10:27 +0530
Message-Id: <1252323640.4922.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/1] Containers: Pass a valid stack
	address	to	clone
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Nathan T Lynch <natlynch@us.ibm.com>, Mike Frysinger <vapier@gentoo.org>

T24gV2VkLCAyMDA5LTA5LTAyIGF0IDE2OjEzIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZTog
Cj4gT24gV2VkbmVzZGF5IDAyIFNlcHRlbWJlciAyMDA5IDEwOjEwOjI3IFNlcmdlIEUuIEhhbGx5
biB3cm90ZToKPiA+IEFsc28gZml4IHRoZSBsaWJuZXRucyBoZWxwZXIgdG8sIGxpa2UgdGhlIGxp
YmNsb25lIG9uZSwgc3BlY2lhbC1jYXNlCj4gPiBocHBhIGFuZCBwYXNzIHRoZSBib3R0b20gb2Yg
dGhlIHN0YWNrIHRvIGNsb25lMiBmb3IgX19pYTY0X18gKGFzIHBlcgo+ID4gdGhlIGxpYmNsb25l
IGV4YW1wbGUgYW5kIHRoZSBjbG9uZTIgbWFucGFnZSkuICBJIGRvbid0IGtub3cgYW5kIGNhbid0
Cj4gPiB0ZXN0IHdoZXRoZXIgaXQncyByaWdodCwgYnV0IGhhdmUgdG8gYXNzdW1lIHRoYXQgb25l
IG9mIHRoZSBvdGhlciB3YXMKPiA+IHdyb25nLgo+IAo+IHBsZWFzZSwgbGV0J3Mgc3RvcCBzY3Jl
d2luZyBhcm91bmQgd2l0aCB0aGlzIGFuZCBjb3B5aW5nICYgcGFzdGluZyBpdCAKPiBldmVyeXdo
ZXJlLiAgY3JlYXRlIGEgbmV3IGRlZGljYXRlICJsdHBfY2xvbmUiIG9yIHNpbWlsYXIgZnVuY3Rp
b24gYW5kIHN0aWNrIAo+IHRoZSBhcmNoLXNwZWNpZmljIGxvZ2ljIHRoZXJlLgo+IGludCBsdHBf
Y2xvbmUoZnVuYyBwdHIsIHN0YWNrIGJhc2UsIHN0YWNrIHNpemUsIGNsb25lIGZsYWdzLCBmdW5j
IGFyZ3MuLi4pCj4gLW1pa2UKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKU2VyZ2UsCgpEaWQg
eW91IHBvc3QgYW55IG5ldyBwYXRjaGVzIGFmdGVyIE1pa2XFmyBjb21tZW50cyA/CgpSZWdhcmRz
LS0KU3VicmF0YQoKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCj4gTGV0IENyeXN0YWwgUmVwb3J0cyBoYW5kbGUgdGhlIHJlcG9ydGluZyAt
IEZyZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAtRGF5IAo+IHRyaWFsLiBTaW1wbGlmeSB5b3Vy
IHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9u
IAo+IHdoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29kaW5nLiBEaXNjb3ZlciB3
aGF0J3MgbmV3IHdpdGggCj4gQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9z
ZnUvYm9iai1qdWx5Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18gTHRwLWxpc3QgbWFpbGluZyBsaXN0IEx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5l
dCBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAoK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVw
b3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlm
eSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZv
Y3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292
ZXIgd2hhdCdzIG5ldyB3aXRoIApDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDovL3Auc2YubmV0
L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
