Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9w58-0002kk-Hp
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 08:05:18 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9w57-0003wy-P2
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 08:05:18 +0000
Received: by mail-pw0-f47.google.com with SMTP id 5so2411936pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 01:05:17 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 6 May 2010 01:05:22 -0700
Message-Id: <0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

T24gTWF5IDUsIDIwMTAsIGF0IDExOjU2IFBNLCBTdWJyYXRhIE1vZGFrIHdyb3RlOgoKPiBTdWJq
ZWN0OiBMVFDFmyBzeXNjdGwwMyB0ZXN0IGZhaWxzCj4gCj4gSXNzdWVzIERlc2NyaXB0aW9uIEJl
bG93Ogo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAjIC4vcnVubHRw
IC1zIHN5c2N0bDAzCj4gPDw8dGVzdF9vdXRwdXQ+Pj4KPiBzeXNjdGwwMyAgICAxICBURkFJTCAg
OiAgRXhwZWN0ZWQgRVBFUk0gKDEpLCBnb3QgMTM6IFBlcm1pc3Npb24gZGVuaWVkCj4gc3lzY3Rs
MDMgICAgMiAgVEZBSUwgIDogIEV4cGVjdGVkIEVQRVJNLCBnb3QgMTMKPiBzeXNjdGwwMyAgICAx
ICBURkFJTCAgOiAgRXhwZWN0ZWQgRVBFUk0gKDEpLCBnb3QgMTM6IFBlcm1pc3Npb24gZGVuaWVk
Cj4gPDw8ZXhlY3V0aW9uX3N0YXR1cz4+Pgo+IGluaXRpYXRpb25fc3RhdHVzPSJvayIKPiBkdXJh
dGlvbj0wIHRlcm1pbmF0aW9uX3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9uX2lkPTEgY29yZWZpbGU9
bm8KPiBjdXRpbWU9MCBjc3RpbWU9MAo+IDw8PHRlc3RfZW5kPj4+CgoJQWxyZWFkeSBrbm93biBh
bmQgcmVjZW50bHkgZGlzY3Vzc2VkLgpUaGFua3MsCi1HYXJyZXR0Ci0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAt
bGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
