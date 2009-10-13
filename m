Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxicT-0000NT-AV
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:57 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxicN-0005Ux-RF
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:57 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEXvNf001812
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:33:57 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEifIp214948
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEieUX017185
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091008165929.GA27576@us.ibm.com>
References: <20091008165929.GA27576@us.ibm.com>
Date: Tue, 13 Oct 2009 20:13:51 +0530
Message-Id: <1255445031.8438.70.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/1] p9auth: fix a bug in the p9auth setup script
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
To: "Serge E. Hallyn" <serue@us.ibm.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

T24gVGh1LCAyMDA5LTEwLTA4IGF0IDExOjU5IC0wNTAwLCBTZXJnZSBFLiBIYWxseW4gd3JvdGU6
IAo+IElmIGJ5IGNoYW5jZSAvZGV2L2NhcGhhc2ggZXhpc3RlZCBidXQgL2Rldi9jYXB1c2UgZGlk
IG5vdCwgdGhlbgo+IHRoZSBjaGVja3A5YXV0aC5zaCBzY3JpcHQgd291bGQgdXNlICRtYWogd2l0
aG91dCBzZXR0aW5nIGl0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNlcmdlIEhhbGx5biA8c2VydWVA
dXMuaWJtLmNvbT4KCkdhcnJldHTFmyByZWNlbnQgY2hhbmdlcyBkZWxldGVkIHRoaXMgZmlsZToK
aHR0cDovL2x0cC5jdnMuc291cmNlZm9yZ2UubmV0L3ZpZXd2Yy9sdHAvbHRwL3Rlc3RjYXNlcy9r
ZXJuZWwvc2VjdXJpdHkvcDlhdXRoL2NoZWNrcDlhdXRoLnNoP2hpZGVhdHRpYz0wJnZpZXc9bG9n
LAoKfGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L3A5YXV0aC9jaGVja3A5
YXV0aC5zaApiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvcDlhdXRoL2NoZWNrcDlhdXRoLnNo
CnxpbmRleCA0MzY1NDI3Li40YTVhN2Q0IDEwMDc1NQp8LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
ZWN1cml0eS9wOWF1dGgvY2hlY2twOWF1dGguc2gKfCsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2Vj
dXJpdHkvcDlhdXRoL2NoZWNrcDlhdXRoLnNoCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZp
bGUgdG8gcGF0Y2g6IApTa2lwIHRoaXMgcGF0Y2g/IFt5XSAKU2tpcHBpbmcgcGF0Y2guCjIgb3V0
IG9mIDIgaHVua3MgaWdub3JlZAoKUmVnYXJkcy0tClN1YnJhdGEKCj4gLS0tCj4gIHRlc3RjYXNl
cy9rZXJuZWwvc2VjdXJpdHkvcDlhdXRoL2NoZWNrcDlhdXRoLnNoIHwgICAgNCArLS0tCj4gIDEg
ZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L3A5YXV0aC9jaGVja3A5YXV0aC5zaCBi
L3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvcDlhdXRoL2NoZWNrcDlhdXRoLnNoCj4gaW5kZXgg
NDM2NTQyNy4uNGE1YTdkNCAxMDA3NTUKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5
L3A5YXV0aC9jaGVja3A5YXV0aC5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkv
cDlhdXRoL2NoZWNrcDlhdXRoLnNoCj4gQEAgLTQ3LDcgKzQ3LDYgQEAgaWYgWyAkPyAtbmUgMCBd
OyB0aGVuCj4gIGZpCj4gCj4gIG1hamZpbGU9L3N5cy9tb2R1bGUvcDlhdXRoL3BhcmFtZXRlcnMv
Y2FwX21ham9yCj4gLW1pbmZpbGU9L3N5cy9tb2R1bGUvcDlhdXRoL3BhcmFtZXRlcnMvY2FwX21p
bm9yCj4gIGlmIFsgISAtZiAiJG1hamZpbGUiIF07IHRoZW4KPiAgCWlmIFsgJHllc25vIC1lcSAx
IF07IHRoZW4gZWNobwo+ICAJCWVjaG8gIm5vIgo+IEBAIC01NiwxNiArNTUsMTUgQEAgaWYgWyAh
IC1mICIkbWFqZmlsZSIgXTsgdGhlbgo+ICAJZmkKPiAgCWV4aXQgMQo+ICBmaQo+ICttYWo9YGNh
dCAkbWFqZmlsZWAKPiAKPiAgaWYgWyAhIC1jICIvZGV2L2NhcGhhc2giIF07IHRoZW4KPiAgCXJt
IC1mIC9kZXYvY2FwaGFzaAo+IC0JbWFqPWBjYXQgJG1hamZpbGVgCj4gIAlta25vZCAvZGV2L2Nh
cGhhc2ggYyAkbWFqIDAKPiAgZmkKPiAKPiAgaWYgWyAhIC1jICIvZGV2L2NhcHVzZSIgXTsgdGhl
bgo+ICAJcm0gLWYgL2Rldi9jYXB1c2UKPiAtCW1pbj1gY2F0ICRtaW5maWxlYAo+ICAJbWtub2Qg
L2Rldi9jYXB1c2UgYyAkbWFqIDEKPiAgZmkKPiAgY2htb2QgdWdvK3cgL2Rldi9jYXB1c2UKCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KQ29tZSBidWlsZCB3aXRoIHVzISBUaGUgQmxhY2tCZXJyeShS
KSBEZXZlbG9wZXIgQ29uZmVyZW5jZSBpbiBTRiwgQ0EKaXMgdGhlIG9ubHkgZGV2ZWxvcGVyIGV2
ZW50IHlvdSBuZWVkIHRvIGF0dGVuZCB0aGlzIHllYXIuIEp1bXBzdGFydCB5b3VyCmRldmVsb3Bp
bmcgc2tpbGxzLCB0YWtlIEJsYWNrQmVycnkgbW9iaWxlIGFwcGxpY2F0aW9ucyB0byBtYXJrZXQg
YW5kIHN0YXkgCmFoZWFkIG9mIHRoZSBjdXJ2ZS4gSm9pbiB1cyBmcm9tIE5vdmVtYmVyIDkgLSAx
MiwgMjAwOS4gUmVnaXN0ZXIgbm93IQpodHRwOi8vcC5zZi5uZXQvc2Z1L2RldmNvbmZlcmVuY2UK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3Qg
bWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
