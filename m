Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27602C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A75604AC
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24A75604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03CB63C6550
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 10:25:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6453C26A5
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:25:35 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7FC0F200DE4
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:25:31 +0200 (CEST)
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000010
X-QQ-FEAT: qfvbM89F703ekHeUeUlzlnMOW/bxPEzLavwewbAvKtTbvoj+m+TLGfq3Ufoll
 hwr2+QmEaWFoXI31FZWOUDbik1mBTihYNVSyWmQ455ZC8tukUIXNNIrl5r9oe6B018HV1ij
 FC82/JtA6KRl5pXZhhaBfbi+QWXxYmXqyZu+w6enEwptaY5nNZ1zPiykb4LBvm+HwfqKubV
 JeY3QetwflZ9vl3+xInSugaEdD9k9mA2KIt7lMz5pV5YwkB0YD4W6eTTHLrMO3k7EI/A1tR
 QsQnHw3rCXPSOJTSqPuZh2L0zADw/14lE2emTTwwtlH39Zq/S6gXMZEARSMkt2kN99xXxYl
 K1K8CqT9NwchJYZXmc=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 58.240.86.85
X-QQ-STYLE: 
X-QQ-mid: logic525t1635150324t1163195
From: "=?utf-8?B?5rGk5a2f?=" <tangmeng@uniontech.com>
To: "=?utf-8?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>,
 "=?utf-8?B?TGkgV2FuZw==?=" <liwang@redhat.com>
Mime-Version: 1.0
Date: Mon, 25 Oct 2021 16:25:24 +0800
X-Priority: 3
Message-ID: <tencent_019185364707BDF116DD7C74@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20211022043806.19171-1-tangmeng@uniontech.com>
 <CAEemH2dOJWGqji+2nYg8X9eKZfFeJPhn0pV2TX6UovS9M_=_Tg@mail.gmail.com>
 <YXZmuCPM1kdBG/eo@yuki>
In-Reply-To: <YXZmuCPM1kdBG/eo@yuki>
X-QQ-ReplyHash: 2034584598
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 25 Oct 2021 16:25:25 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] link/link02: Convert to new API
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
Cc: =?utf-8?B?TFRQIExpc3Q=?= <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0485701737=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a multi-part message in MIME format.

--===============0485701737==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_617669F4_191EC940_2CDFC7C0"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_617669F4_191EC940_2CDFC7C0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGksJm5ic3A7Q3lyaWwgSHJ1YmlzIGFuZCBMSSBXYW5nIQ0KDQoNCkZpcnN0IG9mIGFsbCwg
SSB3YW50IHRvIHNheSB0aGF0IEkgYW0gZXh0cmVtZWx5IHNvcnJ5Lg0KU2luY2UgaXQgd2Fz
IHRoZSBmaXJzdCB0aW1lIEkgc3VibWl0dGVkIGEgcGF0Y2ggaGVyZSwgdGhlcmUgd2VyZSBt
YW55IHVuZmFtaWxpYXIgYW5kIG1pc3VuZGVyc3RhbmRpbmdzIGluIHRoZSBwcm9jZXNzLCB3
aGljaCBsZWQgdG8gbXVsdGlwbGUgc3VibWlzc2lvbnMuDQpJIHdpbGwgdGFrZSBjYXJlIHRv
IGF2b2lkIHRoaXMgcHJvYmxlbSBpbiB0aGUgZnV0dXJlDQoNCg0KLS0mbmJzcDsNClJlZ2Fy
ZHMsDQpUYW5nTWVuZw0KLS0tLS0tLS0tLS0tLS0tLS0tJm5ic3A7T3JpZ2luYWwmbmJzcDst
LS0tLS0tLS0tLS0tLS0tLS0NCkZyb206ICZuYnNwOyJDeXJpbCBIcnViaXMiPGNocnViaXNA
c3VzZS5jeiZndDs7DQpEYXRlOiAmbmJzcDtNb24sIE9jdCAyNSwgMjAyMSAwNDoxMCBQTQ0K
VG86ICZuYnNwOyJMaSBXYW5nIjxsaXdhbmdAcmVkaGF0LmNvbSZndDs7IA0KQ2M6ICZuYnNw
OyJ0YW5nbWVuZyI8dGFuZ21lbmdAdW5pb250ZWNoLmNvbSZndDs7ICJMVFAgTGlzdCI8bHRw
QGxpc3RzLmxpbnV4Lml0Jmd0OzsgDQpTdWJqZWN0OiAmbmJzcDtSZTogW0xUUF0gW1BBVENI
XSBsaW5rL2xpbmswMjogQ29udmVydCB0byBuZXcgQVBJDQoNCiZuYnNwOw0KDQpIaSENCiZn
dDsgUGx6IHN0b3Agc2VuZGluZyB0aGUgc2FtZSBwYXRjaCBhZ2FpbiBhbmQgYWdhaW4uIEl0
IGxvb2tzDQomZ3Q7IGxpa2UgYW4gZW1haWwgYm9tYiB0byB0aGUgbWFpbGluZyBsaXN0Lg0K
DQpQYXJ0bHkgbXkgbWlzdGFrZSwgd2hlbiBJIGxvb2tlZCBhdCB0aGUgbGlzdCBvZiBwYXRj
aGVzIGZvciBtb2RlcmF0aW9uIEkNCmRpZG4ndCByZWFsaXplZCB0aGF0IHRoaXMgaXMgb25l
IHBhdGNoIHNlbmQgbWFueSB0aW1lcywgc29ycnkgZm9yIHRoYXQuDQoNCkhvd2V2ZXIgVGFu
ZyBpZiB5b3UgZW1haWwgdG8gYSBNTCBpcyBoZWxkIGZvciBtb2RlcmF0aW9uIHBsZWFzZSB3
YWl0DQppbnN0ZWFkIG9mIHJlc2VuZGluZywgSSBkbyByZXZpZXdlIHRoZSBoZWxkIGVtYWls
cyBuZWFybHkgZGFpbHkgc28gdGhlDQpkZWxheSBzaG91bGRuJ3QgYmUgd29yc2UgdGhhbiBh
IGRheSBvciB0d28uIEFsc28gaWYgeW91IHNpbmcgdXAgdG8gdGhlDQpNTCB0aGUgZW1haWxz
IHdvdWxkIGdvIHJpZ2h0IHRocm91Z2guDQoNCi0tIA0KQ3lyaWwgSHJ1YmlzDQpjaHJ1Ymlz
QHN1c2UuY3o=

------=_NextPart_617669F4_191EC940_2CDFC7C0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGRpdj48Zm9udD5IaSwmbmJzcDs8L2ZvbnQ+Q3lyaWwgSHJ1YmlzIGFuZCBMSSBXYW5nITwv
ZGl2PjxkaXY+PGluY2x1ZGV0YWlsPjxkaXY+PGJyPjwvZGl2PjxkaXY+Rmlyc3Qgb2YgYWxs
LCBJIHdhbnQgdG8gc2F5IHRoYXQgSSBhbSBleHRyZW1lbHkgc29ycnkuPC9kaXY+PGRpdj5T
aW5jZSBpdCB3YXMgdGhlIGZpcnN0IHRpbWUgSSBzdWJtaXR0ZWQgYSBwYXRjaCBoZXJlLCB0
aGVyZSB3ZXJlIG1hbnkgdW5mYW1pbGlhciBhbmQgbWlzdW5kZXJzdGFuZGluZ3MgaW4gdGhl
IHByb2Nlc3MsIHdoaWNoIGxlZCB0byBtdWx0aXBsZSBzdWJtaXNzaW9ucy48L2Rpdj48ZGl2
Pkkgd2lsbCB0YWtlIGNhcmUgdG8gYXZvaWQgdGhpcyBwcm9ibGVtIGluIHRoZSBmdXR1cmU8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0tJm5ic3A7PC9kaXY+PGRpdj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6ICZxdW90O2x1Y2lkYSBHcmFuZGUmcXVvdDssIFZlcmRhbmE7Ij5S
ZWdhcmRzLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogJnF1
b3Q7bHVjaWRhIEdyYW5kZSZxdW90OywgVmVyZGFuYTsiPlRhbmdNZW5nPC9zcGFuPjwvZGl2
PjxkaXYgc3R5bGU9ImZvbnQ6VmVyZGFuYSBub3JtYWwgMTRweDtjb2xvcjojMDAwOyI+PGRp
diBzdHlsZT0iRk9OVC1TSVpFOiAxMnB4O0ZPTlQtRkFNSUxZOiBBcmlhbCBOYXJyb3c7cGFk
ZGluZzoycHggMCAycHggMDsiPi0tLS0tLS0tLS0tLS0tLS0tLSZuYnNwO09yaWdpbmFsJm5i
c3A7LS0tLS0tLS0tLS0tLS0tLS0tPC9kaXY+PGRpdiBzdHlsZT0iRk9OVC1TSVpFOiAxMnB4
O2JhY2tncm91bmQ6I2VmZWZlZjtwYWRkaW5nOjhweDsiPjxkaXYgaWQ9Im1lbnVfc2VuZGVy
Ij48Yj5Gcm9tOiA8L2I+Jm5ic3A7IkN5cmlsIEhydWJpcyImbHQ7Y2hydWJpc0BzdXNlLmN6
Jmd0Ozs8L2Rpdj48ZGl2PjxiPkRhdGU6IDwvYj4mbmJzcDtNb24sIE9jdCAyNSwgMjAyMSAw
NDoxMCBQTTwvZGl2PjxkaXY+PGI+VG86IDwvYj4mbmJzcDsiTGkgV2FuZyImbHQ7bGl3YW5n
QHJlZGhhdC5jb20mZ3Q7OyA8d2JyPjwvZGl2PjxkaXY+PGI+Q2M6IDwvYj4mbmJzcDsidGFu
Z21lbmciJmx0O3RhbmdtZW5nQHVuaW9udGVjaC5jb20mZ3Q7OyAiTFRQIExpc3QiJmx0O2x0
cEBsaXN0cy5saW51eC5pdCZndDs7IDx3YnI+PC9kaXY+PGRpdj48Yj5TdWJqZWN0OiA8L2I+
Jm5ic3A7UmU6IFtMVFBdIFtQQVRDSF0gbGluay9saW5rMDI6IENvbnZlcnQgdG8gbmV3IEFQ
STwvZGl2PjwvZGl2PjxkaXY+Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0icG9zaXRpb246cmVs
YXRpdmU7Ij48ZGl2IGlkPSJ0bXBjb250ZW50X3JlcyI+PC9kaXY+SGkhPGJyPiZndDsgUGx6
IHN0b3Agc2VuZGluZyB0aGUgc2FtZSBwYXRjaCBhZ2FpbiBhbmQgYWdhaW4uIEl0IGxvb2tz
PGJyPiZndDsgbGlrZSBhbiBlbWFpbCBib21iIHRvIHRoZSBtYWlsaW5nIGxpc3QuPGJyPjxi
cj5QYXJ0bHkgbXkgbWlzdGFrZSwgd2hlbiBJIGxvb2tlZCBhdCB0aGUgbGlzdCBvZiBwYXRj
aGVzIGZvciBtb2RlcmF0aW9uIEk8YnI+ZGlkbid0IHJlYWxpemVkIHRoYXQgdGhpcyBpcyBv
bmUgcGF0Y2ggc2VuZCBtYW55IHRpbWVzLCBzb3JyeSBmb3IgdGhhdC48YnI+PGJyPkhvd2V2
ZXIgVGFuZyBpZiB5b3UgZW1haWwgdG8gYSBNTCBpcyBoZWxkIGZvciBtb2RlcmF0aW9uIHBs
ZWFzZSB3YWl0PGJyPmluc3RlYWQgb2YgcmVzZW5kaW5nLCBJIGRvIHJldmlld2UgdGhlIGhl
bGQgZW1haWxzIG5lYXJseSBkYWlseSBzbyB0aGU8YnI+ZGVsYXkgc2hvdWxkbid0IGJlIHdv
cnNlIHRoYW4gYSBkYXkgb3IgdHdvLiBBbHNvIGlmIHlvdSBzaW5nIHVwIHRvIHRoZTxicj5N
TCB0aGUgZW1haWxzIHdvdWxkIGdvIHJpZ2h0IHRocm91Z2guPGJyPjxicj4tLSA8YnI+Q3ly
aWwgSHJ1YmlzPGJyPmNocnViaXNAc3VzZS5jejxicj48L2Rpdj48L2Rpdj48IS0tPCFbZW5k
aWZdLS0+PC9pbmNsdWRldGFpbD48L2Rpdj4=

------=_NextPart_617669F4_191EC940_2CDFC7C0--




--===============0485701737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0485701737==--



