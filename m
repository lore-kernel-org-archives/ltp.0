Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Xu@windriver.com>) id 1OACyI-0001k9-RK
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 02:07:22 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OACyE-00052k-JQ
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 02:07:22 +0000
From: Henry xu <feng.xu@windriver.com>
In-Reply-To: <20100506065815.23879.4005.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065815.23879.4005.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 07 May 2010 10:12:22 +0800
Message-Id: <1273198342.26977.140.camel@lishuang-desktop>
Mime-Version: 1.0
Subject: Re: [LTP] [09/12 FAILURE] LTP timer create04 fails
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
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

5ZyoIDIwMTAtMDUtMDblm5vnmoQgMTI6MjggKzA1MzDvvIxTdWJyYXRhIE1vZGFr5YaZ6YGT77ya
Cj4gU3ViamVjdDogTFRQxZsgdGltZXJfY3JlYXRlMDQgZmFpbHMKPiAKPiBJc3N1ZXMgRGVzY3Jp
cHRpb24gYmVsb3c6Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4g
IyAuL3J1bmx0cCAtcyB0aW1lcl9jcmVhdGUwNAo+IDw8PHRlc3Rfb3V0cHV0Pj4+Cj4gdGltZXJf
Y3JlYXRlMDQgICAgMSAgVEZBSUwgIDogIGRpZG4ndCBmYWlsIGFzIGV4cGVjdGVkIFtleHBlY3Rl
ZCBlcnJubyA9IDIyCj4gKEludmFsaWQgYXJndW1lbnQpXTogVEVTVF9FUlJOTz0/Pz8oOTUpOiBP
cGVyYXRpb24gbm90IHN1cHBvcnRlZAo+IHRpbWVyX2NyZWF0ZTA0ICAgIDIgIFRGQUlMICA6ICBk
aWRuJ3QgZmFpbCBhcyBleHBlY3RlZCBbZXhwZWN0ZWQgZXJybm8gPSAyMgo+IChJbnZhbGlkIGFy
Z3VtZW50KV06IFRFU1RfRVJSTk89Pz8/KDk1KTogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQKCkkg
dGhpbmsgdGhlIEZBSUxzIGFyZSBjYXVzZWQgYnkgTUFYX0NMT0NLUyBpbiBjb21tb25fdGltZXJz
Lmggbm90IGVxdWFsCnRvIE1BWF9DTE9DS1MgaW4ga2VybmVsLklmIGVxdWFsaXR5LHRoZSBjYXNl
IGNhbiBiZSBwYXNzZWQuCgpyZWdhcmRzCgo+IHRpbWVyX2NyZWF0ZTA0ICAgIDMgIFRQQVNTICA6
ICBmYWlsZWQgYXMgZXhwZWN0ZWQ6IFRFU1RfRVJSTk89RUZBVUxUKDE0KTogQmFkCj4gYWRkcmVz
cwo+IHRpbWVyX2NyZWF0ZTA0ICAgIDQgIFRQQVNTICA6ICBmYWlsZWQgYXMgZXhwZWN0ZWQ6IFRF
U1RfRVJSTk89RUZBVUxUKDE0KTogQmFkCj4gYWRkcmVzcwo+IHRpbWVyX2NyZWF0ZTA0ICAgIDUg
IFRQQVNTICA6ICBmYWlsZWQgYXMgZXhwZWN0ZWQ6IFRFU1RfRVJSTk89RUZBVUxUKDE0KTogQmFk
Cj4gYWRkcmVzcwo+IHRpbWVyX2NyZWF0ZTA0ICAgIDYgIFRQQVNTICA6ICBmYWlsZWQgYXMgZXhw
ZWN0ZWQ6IFRFU1RfRVJSTk89RUZBVUxUKDE0KTogQmFkCj4gYWRkcmVzcwo+IDw8PGV4ZWN1dGlv
bl9zdGF0dXM+Pj4KPiBpbml0aWF0aW9uX3N0YXR1cz0ib2siCj4gZHVyYXRpb249MCB0ZXJtaW5h
dGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD0xIGNvcmVmaWxlPW5vCj4gY3V0aW1lPTAg
Y3N0aW1lPTAKPiA8PDx0ZXN0X2VuZD4+Pgo+IAo+IFNVWlVLSSBLLiBQT1VMT1NFIHNhaWQgdGhh
dCB0aGUgc2FtZSBwYXRjaCBmb3IgaXNzdWUgIzggd2lsbCBzb2x2ZSB0aGUgcHJvYmxlbSA6LSkK
PiAKPiBSZWdhcmRzLS0KPiBTdWJyYXRhCj4gCj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMdHAtbGlz
dCBtYWlsaW5nIGxpc3QKPiBMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
