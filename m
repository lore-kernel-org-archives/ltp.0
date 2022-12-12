Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A252C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E7DE3CBE75
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:45:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2F3A3CA4DD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:45:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3EE0460066B
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:45:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 77B89336D7;
 Mon, 12 Dec 2022 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670856332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVCHK/3ai2dCzz5itejvjir7IA7z9AKRAp4hA16htGs=;
 b=fTvYE/yWmG+SzXJS/+USbr0WGTIBwU97ASDvc3HSTlMPzmm9RUkECoTyMNfxH6zJ5H8NKM
 OCf0OVHAKXVntfQZMFmRdN8VmxpPRV40QzJpMay9w7R1Ubzmjjb0+P6C7HaWXNodwXjWAJ
 iUPK9AI9SnjAfGPvVRlm+3oqtdix7mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670856332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVCHK/3ai2dCzz5itejvjir7IA7z9AKRAp4hA16htGs=;
 b=/BqbSV+epFnI1rEzqieXqOmHq57+oX/7sq6RDnFg/c8i0F2HPtpUG3MJL8tns/9nF/QwMc
 rWGFBK6i2mTjAkCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5072C2C141;
 Mon, 12 Dec 2022 14:45:32 +0000 (UTC)
References: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Xinkuan Yan <lucky33newman@gmail.com>
Date: Mon, 12 Dec 2022 14:36:55 +0000
Organization: Linux Private Site
In-reply-to: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
Message-ID: <87mt7su1dg.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question about log format.
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpYaW5rdWFuIFlhbiA8bHVja3kzM25ld21hbkBnbWFpbC5jb20+IHdyaXRlczoKCj4g
SGVsbG8gbGlzdCwKPgo+IEknbSB0cnlpbmcgdG8gZG8gYSBjb25jaXNlIHBhcnNpbmcgb2YgdGhl
IExUUCByZXBvcnQuCj4KPiBJIGRvbid0IGhhdmUgbXVjaCBleHBlcmllbmNlIGFuZCBJJ20gbm90
IGZhbWlsaWFyIHdpdGggTFRQLCBzbyBJJ20gZ29pbmcgdG8KPiB0YWtlICNtYXRoIGFzIGFuIGV4
YW1wbGUsIGZvciBpdCBpcyBub3QgY29tcGxleC4KPgo+IFJ1biB0ZXN0IGNvbW1hbmQ6Cj4KPiAu
L2x0cCDigJNmIG1hdGgg4oCTcQo+Cj4gSSBoYXZlIHRocmVlIHF1ZXN0aW9ucyBub3csICB0YWtp
bmcgdGhlIG9uZS1saW5lIG91dHB1dCByZXN1bHQgYmVsb3cgYXMgYW4KPiBleGFtcGxlOgo+Cj4g
ZmxvYXRfaXBlcmIgMSBUUEFTUzogVGVzdCBwYXNzZWQKClRoaXMgaXMgYSB0ZXN0IHVzaW5nIHRo
ZSBvbGQgQVBJLCBzbyBub3QgdGhlIGJlc3QgZXhhbXBsZS4KCj4KPiAxLCBJdCBpcyBjbGVhciB0
aGF0IFRQQVNTIG1lYW5zIGl0IHBhc3NlZCwgYnV0IHdoYXQgaXMgdGhlIG51bWJlciAxCj4gc3Rh
bmRpbmcgZm9yLgoKSSBkb24ndCBrbm93IHRvIGJlIGhvbmVzdC4gSXQgd2FzIHJlbW92ZWQgaW4g
dGhlIG5ldyB0ZXN0IEFQSS4KCj4KPiAyLCBXaHkgdGhpcyBsaW5lIHNob3dlZCB1cCB0d2ljZT8g
KCBQUzogQmV0d2VlbiB0aGVzZSB0d28gbGluZXMgYXJlIG1hbnkKPiBUSU5GTy4pCgpQb3NzaWJs
eSBiZWNhdXNlIHRoZXJlIGFyZSBtdWx0aXBsZSBpdGVyYXRpb25zIG9mIHRoZSB0ZXN0LiBQb3Nz
aWJseQpzb21lIHBhcmFtdGVycyBhcmUgY2hhbmdlZCBiZXR3ZWVuIGl0ZXJhdGlvbnMuCgpPbmx5
IHdheSB0byBmaW5kIG91dCBpcyB0byBsb29rIGZvciB0c3RfcmVzbSBjYWxscyBpbiB0aGUgc291
cmNlIGNvZGUuCgo+Cj4gMywgV2hlcmUgdG8gY2hlY2sgdGhvc2Ugb3V0IHB1dCBzdGFuZGFyZHMs
IHRha2luZyB5b2N0byBwYWNrYWdlIHRlc3QgYXMgYQo+IHNtYWxsIGNvbXByZWhlbnNpb24sIHRo
YXQgc3RhbmRhcmQgd2FzICggUEFTU3xGQUlMfFNLSVApOiBUZXN0IGluZm8uIEhvdyBpcwo+IGl0
IGxpa2UgaW4gTFRQPwoKaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAv
d2lraS9DLVRlc3QtQVBJIzEyLWJhc2ljLXRlc3QtaW50ZXJmYWNlCgpOb3RlIHRhaHQgdGhlIG5l
dyBBUEkgb3V0cHV0IGxvb2tzIG1vcmUgbGlrZSB0aGUgZm9sbG93aW5nOgoKc2gtNS4yIyAuL2Jw
Zl9wcm9nMDcKdHN0X2J1ZmZlcnMuYzo1NTogVElORk86IFRlc3QgaXMgdXNpbmcgZ3VhcmRlZCBi
dWZmZXJzCnRzdF90YWludC5jOjExNjogVENPTkY6IElnbm9yaW5nIGFscmVhZHkgc2V0IGtlcm5l
bCB3YXJuaW5nIHRhaW50CnRzdF90ZXN0LmM6MTU2MDogVElORk86IFRpbWVvdXQgcGVyIHJ1biBp
cyAwaCAwMG0gMzBzCmJwZl9jb21tb24uYzoxNzogVElORk86IFJhaXNpbmcgUkxJTUlUX01FTUxP
Q0sgdG8gMTA0ODU3NjAKdHN0X2NhcGFiaWxpdHkuYzoyOTogVElORk86IERyb3BwaW5nIENBUF9T
WVNfQURNSU4oMjEpCnRzdF9jYXBhYmlsaXR5LmM6Mjk6IFRJTkZPOiBEcm9wcGluZyBDQVBfQlBG
KDM5KQpicGZfY29tbW9uLmM6Mzk6IFRDT05GOiBIaW50OiBjaGVjayBhbHNvIC9wcm9jL3N5cy9r
ZXJuZWwvdW5wcml2aWxlZ2VkX2JwZl9kaXNhYmxlZApicGZfY29tbW9uLmM6NDE6IFRDT05GOiBi
cGYoKSByZXF1aXJlcyBDQVBfU1lTX0FETUlOIG9yIENBUF9CUEYgb24gdGhpcyBzeXN0ZW06IEVQ
RVJNICgxKQoKU3VtbWFyeToKcGFzc2VkICAgMApmYWlsZWQgICAwCmJyb2tlbiAgIDAKc2tpcHBl
ZCAgMwp3YXJuaW5ncyAwCgpzaC01LjIjIC4vYnBmX3Byb2cwMQp0c3RfYnVmZmVycy5jOjU1OiBU
SU5GTzogVGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKdHN0X3Rlc3QuYzoxNTYwOiBUSU5G
TzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKYnBmX2NvbW1vbi5jOjE3OiBUSU5GTzog
UmFpc2luZyBSTElNSVRfTUVNTE9DSyB0byAxMDQ4NTc2MApicGZfY29tbW9uLmM6MTE0OiBUUEFT
UzogTG9hZGVkIHByb2dyYW0KYnBmX3Byb2cwMS5jOjk1OiBUUEFTUzogdmFsID0gMQouLi4KClNv
IHRoZSBmb3JtYXQgaXMgbGlrZToKCjxmaWxlX25hbWU+OjxsaW5lPjogPHR0eXBlPjogPG1lc3Nh
Z2U+CgotLSAKVGhhbmsgeW91LApSaWNoYXJkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
