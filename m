Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1NGWsR-0006d5-5X
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 12:03:11 +0000
Received: from kuber.nabble.com ([216.139.236.158])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGWsJ-0004gH-V8
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 12:03:11 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NGWsE-0005td-Kc
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 04:02:58 -0800
Message-ID: <26635869.post@talk.nabble.com>
Date: Fri, 4 Dec 2009 04:02:58 -0800 (PST)
From: =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
In-Reply-To: <1259853116.5085.38.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
References: <MissingID.a80dccbd1ec591894c70e0c5448ac200@nabble.com>
	<200912011820.37533.vapier@gentoo.org> <op.u399hfgxu2flwt@debian>
	<1259853116.5085.38.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Small fixes (some bashisms and probable typos)
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
To: ltp-list@lists.sourceforge.net

CgpTdWJyYXRhIE1vZGFrIHdyb3RlOgo+IAo+IE9uIFdlZCwgMjAwOS0xMi0wMiBhdCAwMDo0MiAr
MDEwMCwgSmnFmcOtIFBhbGXEjWVrIHdyb3RlOiAKPj4gT24gV2VkLCAwMiBEZWMgMjAwOSAwMDoy
MDozNiArMDEwMCwgTWlrZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPiAgCj4+IHdyb3Rl
Ogo+PiAKPj4gPiBvdGhlciB0aGFuIHRoZSBtaW5vciB0aGluZ3MgaSBtZW50aW9uZWQgc3BlY2lm
aWNhbGx5LCB0aGUgcmVzdCBvZiB5b3VyICAKPj4gPiBjaGFuZ2VzCj4+ID4gbG9vayBmaW5lIHRv
IG1lLiAgdGhhbmtzIQo+PiAKPj4gT0suIEknbGwgcmVzZW5kIHRoZSB0d28uCj4gCj4gVGhpcyBy
ZXNlbmQgaXMgeWV0IHRvIGFycml2ZSA7LSkKPiAKClRoaXMgcmVzZW5kIHdpbGwgbm90IGFycml2
ZSwgYmVjYXVzZSBJIGJlbGlldmUgTWlrZSBkaWRuJ3Qgb2JqZWN0IGFnYWluc3QKdGhpcyBvbmUu
IEJ5ICJ0aGUgdHdvIiwgSSByZWZlcnJlZCB0byB0aGUgInN1Y2Nlc3MgY29uZGl0aW9uL2VjaG8w
MSIgYW5kCiJzZXQgLXUiIHBhdGNoZXMgKHdoaWNoIHdlcmUgYm90aCBhY2NlcHRlZCBpbiB0aGUg
bW9kaWZpZWQgdmVyc2lvbikuCgogIEppcmkgUGFsZWNlawotLSAKVmlldyB0aGlzIG1lc3NhZ2Ug
aW4gY29udGV4dDogaHR0cDovL29sZC5uYWJibGUuY29tLy1QQVRDSC0tU21hbGwtZml4ZXMtJTI4
c29tZS1iYXNoaXNtcy1hbmQtcHJvYmFibGUtdHlwb3MlMjktdHAyNjYwMDU4OXAyNjYzNTg2OS5o
dG1sClNlbnQgZnJvbSB0aGUgbHRwLWxpc3QgbWFpbGluZyBsaXN0IGFyY2hpdmUgYXQgTmFiYmxl
LmNvbS4KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSm9pbiB1cyBEZWNlbWJlciA5LCAyMDA5IGZv
ciB0aGUgUmVkIEhhdCBWaXJ0dWFsIEV4cGVyaWVuY2UsCmEgZnJlZSBldmVudCBmb2N1c2VkIG9u
IHZpcnR1YWxpemF0aW9uIGFuZCBjbG91ZCBjb21wdXRpbmcuIApBdHRlbmQgaW4tZGVwdGggc2Vz
c2lvbnMgZnJvbSB5b3VyIGRlc2suIFlvdXIgY291Y2guIEFueXdoZXJlLgpodHRwOi8vcC5zZi5u
ZXQvc2Z1L3JlZGhhdC1zZmRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
dHAtbGlzdAo=
