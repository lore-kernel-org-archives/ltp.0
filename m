Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E50ECAAA1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 02:54:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C23B3CA6FB
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 04:54:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 322EB3C1351
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 04:54:28 +0200 (CEST)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E27EB200AD4
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 04:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1661914463;
 bh=0p3Nw27gHOF9IcKDFp6qJyerv8NtZ+O8zexjGQGL0Ss=;
 h=From:To:Cc:Subject:Date;
 b=UY5nb+HVqhkHEAol+8in86aevF7++r8S6Fwhz58DFhRXwOId62mo5TZ/EI5hr1u/3
 tRp+o84FkZCNEJqT2/jNKZmlSS6fjNsG216/v1VUSXVCUi/S9G1OyXKD1QzICTyQ8A
 ashyKI18ABz52JjYQg2wXRBsl8GIT3hbUnJUGBqs=
X-QQ-FEAT: 8OvYDnhju3O/ODVHBXsG1LJhgVZzcn/k
X-QQ-SSF: 0000000000000050000000000000
X-QQ-XMAILINFO: NtXZwV1Lq3W47hsPz2ns/croa1oMC6kbTChQz80TJRpgEanYRVLi1r40T+up/Y
 rjmhCvstr5o4JByyiE4zsFiLOA8/btc5JzqPfwDPDoFMPnqy3C9T6Zjuiew9f97Ipr7zgYlJo6LTh
 w5UlrF1c9ni5tw/vl55RrV5UKsTqqgKjMywnNCU05FE7Yco2L0DSjxXk7z0sWd91ooeD4Ll0Mbm5q
 f//i7EjW83Gntb0i/0maiJyymd2LTnxqlkbzgMRnLZZvBm+Kluhj2WYtq2TK3cRdHMps8Mi8RQbmF
 OLszN/VVzHuAF6pbFM7C5211cUH1nhpaY+/bb+yPnZPiKn17HJHABq3suPiSfcCBbZqXBTwffjJl6
 43pzDRA7jT2Qo3fDLIHBknQ5KUmj9985+ToGq4Wry40MGwGOuGuy0vZ4icCrGkp5byIkCeUhIH/GI
 FaE+/HDimabzJmxWbkprCpHyHRNjBmd+U/vRXWJzPrmfLVYb6Jqzi+VUFrHyQYrbeQHZ39iEnp39w
 hPXjjd10rxzZiVZEwGfPmpkD6L+x8Kvs4AGIEUV+RYx+3A+cDPMlhg/jDA9uDURF6LPPEX4+3opAD
 nUVkGbSExu0u2MI24gwejjUvuaGSkzI7iMksNV/qa01s7pZZdAf5KtWu+Vxluu9EM7HqQR21cdSm6
 BNQJdHMSIoxe54Ss2559jrL1MfWncfn4kwDYCrpUt4VXNz+ltGwEbopyFIy96WN1OxqjETZhPHsvu
 jyv2OYl1WSAWArKYpzDIoH+yrdcdZMG7HEhQCzkQF2FCVR7fE95in6VE8tft53QkwrnNtC8q9zHZF
 FMcwiZYhqxSTsnC5Eg+oJtrQUzSEHlbHHdTuUoZi4zgPDyGpH0l5PinxkmhXFoKhrTsSPYqaDjWif
 kdhrYR054525jNO7vdJnKVzsYdTRC8+
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 123.52.132.231
X-QQ-STYLE: 
X-QQ-mid: webmail228t1661914463t1473855
From: "=?ISO-8859-1?B?ZHJlYW1oag==?=" <huangjuniter@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ciBWb3JlbA==?=" <pvorel@suse.cz>
Mime-Version: 1.0
Date: Wed, 31 Aug 2022 10:54:22 +0800
X-Priority: 3
Message-ID: <tencent_FC84BA33DF807F332CAC5E2F9040B2B5E50A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pm_include.sh: Fix no_of_sockets calculation
 error of is_multi_socket() function.
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: =?ISO-8859-1?B?bHRw?= <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0719139053=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a multi-part message in MIME format.

--===============0719139053==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_630ECD5F_10B456B8_173F3083"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_630ECD5F_10B456B8_173F3083
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

Jmd0OyBuaXQ6IENvbW1pdCBtZXNzYWdlIGNvdWxkIGJlIGJldHRlcjogc2hvcnRlciBzdWJq
ZWN0IChmaXJzdCBsaW5lKW5pdDogQ29tbWl0IG1lc3NhZ2UgY291bGQgYmUgYmV0dGVyOiBz
aG9ydGVyIHN1YmplY3QgKGZpcnN0IGxpbmUpDQomZ3Q7IGFuZCBtb3JlIGRlc2NyaXB0aXZl
IGRlc2NyaXB0aW9uIGFmdGVyIHNpbmdsZSBibGFuayBsaW5lLg0KJmd0OyBUaGF0IHdvdWxk
IGhlbHAgbWUgYXZvaWRpbmcgYXNraW5nIHF1ZXN0aW9uIGJlbGxvdy4NCiZndDsgDQomZ3Q7
ICZndDsgRnJvbTogSnVuIEh1YW5nIDxodWFuZ2p1bml0ZXJAZm94bWFpbC5jb20mZ3Q7DQom
Z3Q7IA0KJmd0OyBuaXQ6IHRoZXJlIHNob3VsZCBoYXZlIGJlZW4geW91ciBTaWduZWQtb2Zm
LWJ5Og0KJmd0OyANCiZndDsgU2lnbmVkLW9mZi1ieTogSnVuIEh1YW5nIDxodWFuZ2p1bml0
ZXJAZm94bWFpbC5jb20mZ3Q7DQoNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24hDQoN
Cg0KJmd0OyBJIHdhcyBnb2luZyB0byBtZXJnZSBpdCwgYnV0IGlzIGl0IHJlYWxseSBuZWVk
ZWQ/IFVuc29ydGVkIGlucHV0IHRvIHVuaXF1ZSB3aWxsDQomZ3Q7IGNhbiBsZWFkIHRvIGhp
Z2hlciBudW1iZXIgb2YgY291bnQsIGJ1dCBiZWNhdXNlIGFueXRoaW5nIGhpZ2hlciB0aGFu
IDEgcmVzdWx0cw0KJmd0OyBpbiBlY2hvIDAgYW5kIDAgd2lsbCByZXN1bHQgaW4gMSBkdWUg
dGhpcyBjb2RlOg0KJmd0Ow0KJmd0OyBbICRub19vZl9zb2NrZXRzIC1ndCAxIF0gOyBlY2hv
ICQ/DQomZ3Q7DQomZ3Q7IGkuZS4gMiBvciBtb3JlIGRpZmZlcmVudCBmaWxlcyB3aWxsIHJl
c3VsdCBpbiBjb3VudCBoaWdoZXIgdGhhbiAxIHJlZ2FyZGxlc3MNCiZndDsgdXNpbmcgc29y
dGVkIHVuaXEgKHNvcnQgLXUpIG9yIGp1c3QgdW5pcS4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0
aGluZz8NCg0KDQpUaGUgbWFpbiBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gY2hhbmdl
ICdjcHU/JyB0byAnY3B1KicsIG90aGVyd2lzZSBhbiBlcnJvcg0Kd2lsbCBvY2N1ciB3aGVu
IHRoZSBudW1iZXIgb2YgY29yZXMgZXhjZWVkcyAxMC4NCkFzIHlvdSBzYWlkICdzb3J0IC11
JyBoYXMgdGhlIHNhbWUgZWZmZWN0IGFzICd1bmlxJy4gSSBzdWdnZXN0IHVzaW5nICdzb3J0
IC11Jw0KdG8gbWFrZSB0aGUgY29tbWFuZCByZXN1bHQgbW9yZSBpbiBsaW5lIHdpdGggdGhl
IG5hbWluZyBvZiAnbm9fb2Zfc29ja2V0cycuDQoNCg0KDQoNClRoYW5rcywNCkp1bi4=

------=_NextPart_630ECD5F_10B456B8_173F3083
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj48ZGl2IHN0eWxlPSIgIDsgOyA7OyAiPiZndDsgbml0OiBD
b21taXQgbWVzc2FnZSBjb3VsZCBiZSBiZXR0ZXI6IHNob3J0ZXIgc3ViamVjdCAoZmlyc3Qg
bGluZSluaXQ6IENvbW1pdCBtZXNzYWdlIGNvdWxkIGJlIGJldHRlcjogc2hvcnRlciBzdWJq
ZWN0IChmaXJzdCBsaW5lKTxicj4mZ3Q7IGFuZCBtb3JlIGRlc2NyaXB0aXZlIGRlc2NyaXB0
aW9uIGFmdGVyIHNpbmdsZSBibGFuayBsaW5lLjwvZGl2PjxkaXYgc3R5bGU9IiAgOyA7IDs7
ICI+Jmd0OyA8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IFZlcmRhbmE7Ij5UaGF0IHdvdWxk
IGhlbHAgbWUgYXZvaWRpbmcgYXNraW5nIHF1ZXN0aW9uIGJlbGxvdy48L3NwYW4+PGJyIHN0
eWxlPSJmb250LWZhbWlseTogVmVyZGFuYTsiPiZndDsgPGJyIHN0eWxlPSJmb250LWZhbWls
eTogVmVyZGFuYTsiPiZndDsgPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBWZXJkYW5hOyI+
Jmd0OyBGcm9tOiBKdW4gSHVhbmcgJmx0O2h1YW5nanVuaXRlckBmb3htYWlsLmNvbSZndDs8
L3NwYW4+PGJyIHN0eWxlPSJmb250LWZhbWlseTogVmVyZGFuYTsiPiZndDsgPGJyIHN0eWxl
PSJmb250LWZhbWlseTogVmVyZGFuYTsiPiZndDsgPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5
OiBWZXJkYW5hOyI+bml0OiB0aGVyZSBzaG91bGQgaGF2ZSBiZWVuIHlvdXIgU2lnbmVkLW9m
Zi1ieTo8L3NwYW4+PGJyIHN0eWxlPSJmb250LWZhbWlseTogVmVyZGFuYTsiPiZndDsgPGJy
IHN0eWxlPSJmb250LWZhbWlseTogVmVyZGFuYTsiPiZndDsgPHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiBWZXJkYW5hOyI+U2lnbmVkLW9mZi1ieTogSnVuIEh1YW5nICZsdDtodWFuZ2p1
bml0ZXJAZm94bWFpbC5jb20mZ3Q7PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9IiAgOyA7IDs7
ICI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9IiAgOyA7IDs7IHBvc2l0aW9uOiByZWxhdGl2ZTsg
Ij48ZGl2PlRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uITwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+Jmd0OyBJIHdhcyBnb2luZyB0byBtZXJnZSBpdCwgYnV0IGlzIGl0IHJlYWxseSBu
ZWVkZWQ/IFVuc29ydGVkIGlucHV0IHRvIHVuaXF1ZSB3aWxsPGJyPiZndDsgY2FuIGxlYWQg
dG8gaGlnaGVyIG51bWJlciBvZiBjb3VudCwgYnV0IGJlY2F1c2UgYW55dGhpbmcgaGlnaGVy
IHRoYW4gMSByZXN1bHRzPGJyPiZndDsgaW4gZWNobyAwIGFuZCAwIHdpbGwgcmVzdWx0IGlu
IDEgZHVlIHRoaXMgY29kZTo8YnI+Jmd0Ozxicj4mZ3Q7IFsgJG5vX29mX3NvY2tldHMgLWd0
IDEgXSA7IGVjaG8gJD88YnI+Jmd0Ozxicj4mZ3Q7IGkuZS4gMiBvciBtb3JlIGRpZmZlcmVu
dCBmaWxlcyB3aWxsIHJlc3VsdCBpbiBjb3VudCBoaWdoZXIgdGhhbiAxIHJlZ2FyZGxlc3M8
YnI+Jmd0OyB1c2luZyBzb3J0ZWQgdW5pcSAoc29ydCAtdSkgb3IganVzdCB1bmlxLiBPciBh
bSBJIG1pc3Npbmcgc29tZXRoaW5nPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIG1h
aW4gcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIHRvIGNoYW5nZSAnY3B1PycgdG8gJ2NwdSon
LCBvdGhlcndpc2UgYW4gZXJyb3I8L2Rpdj48ZGl2PndpbGwgb2NjdXIgd2hlbiB0aGUgbnVt
YmVyIG9mIGNvcmVzIGV4Y2VlZHMgMTAuPC9kaXY+PGRpdj5BcyB5b3Ugc2FpZCAnc29ydCAt
dScgaGFzIHRoZSBzYW1lIGVmZmVjdCBhcyAndW5pcScuIEkgc3VnZ2VzdCB1c2luZyAnc29y
dCAtdSc8L2Rpdj48ZGl2PnRvIG1ha2UgdGhlIGNvbW1hbmQgcmVzdWx0IG1vcmUgaW4gbGlu
ZSB3aXRoIHRoZSBuYW1pbmcgb2YgJ25vX29mX3NvY2tldHMnLjwvZGl2PjwvZGl2PjwvZGl2
PjxkaXYgc3R5bGU9InBvc2l0aW9uOiByZWxhdGl2ZTsiPjxicj48L2Rpdj48ZGl2IHN0eWxl
PSJwb3NpdGlvbjogcmVsYXRpdmU7Ij5UaGFua3MsPC9kaXY+PGRpdiBzdHlsZT0icG9zaXRp
b246IHJlbGF0aXZlOyI+SnVuLjwvZGl2PjxkaXYgc3R5bGU9InBvc2l0aW9uOiByZWxhdGl2
ZTsiPjxicj48L2Rpdj4=

------=_NextPart_630ECD5F_10B456B8_173F3083--


--===============0719139053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0719139053==--

