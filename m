Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFFEC36001
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742456715; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=AMRxbZVEPGUdlJ2NeLSMqJDITx8mMgPtDpAWS0TC4o8=;
 b=UaHPieUnYrbHGxKTHhG9ukfuPuh1fs2oGk1FUJClM442q4DiQgUvb3zqxKyXkkwyoEkOV
 M7rlf9+qHnjNnRTB9cxzrz81br8D6cSpVCA9j8Jw/7Foo3pWx/6UXY+1gL8icBWsHnyaBN8
 /fdG6JLS+4skFpNWESUI4T3itPK67Mw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C333CAD4A
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 08:45:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03FC3CAD4A
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 08:44:53 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EA6E31000531
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 08:44:52 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso4796985e9.3
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742456692; x=1743061492; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJuDeJtQoMTuypQl7EIVM8Q6OuZ4kr9ZrtJyY8tRMFg=;
 b=MFs32mStCepJCcj0CLc0bteSOlR2W2d1nGAoYe6le0vg8GyFtOOq/HNjboq4n9kxM4
 ohFdLn+XloKCKNwRGDyEqr3pmvgbuMYtXnu1tWM+PTxy5MeLw2Mz5uSavqXYdGPyKJ7A
 vnvEOYijTewhLGnCIyVWF+OTsZMLvrOI6+LUUfEgEgZECQxDWUHtRKwcts1C1pYCCoiF
 mkY0Q8XUXqJQNJmvYeAaRBSEOdEc6N2ccJPWlL/ReGkIDbhB9JxPgmGu9/ZUBlnSi1Qj
 MZxd8pGMN0SOAiDm7LCxOAfGtpY9yPtbQxi9HaiiFcyyDdrh8+N04KrXnEjvK7iM0Yn9
 zz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742456692; x=1743061492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJuDeJtQoMTuypQl7EIVM8Q6OuZ4kr9ZrtJyY8tRMFg=;
 b=GxN2yGezvsZF9fu/6Pplke9yqLFJv+SDdpz4rty2u2GQAVY8+QYCgMQSGP1ikCR5XQ
 1PS08mPAuM6e9n0T1u3BxTvDM/iRuCxAkQnreyawEea4o+HmS2DjYy6b9NxrG5igCCOQ
 Rv3eT+B/Qd/Jifq6ZmjkjFxgx0MX0SzVcG0OPt7zvFaMfGVpryONUWX27J/2u30/XxlH
 LCUM2l2G9vBELqZMIIFXq+w+USm3OuvNrFeSkfmsJekWbqfHkhX51I7xOjcx895d2H65
 GQgUYUMbHC5Be8reHFLuz8eiGAIMa5oLsGM0HiGosLgG4CRPt8WSrMyxTdWoHzqsASy5
 bwSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJmzeZCWTcjJLlBKDwY9v5ItUV7X0gLjVfESz6mMbFj2RHqA/3q9VVcmsaRVfWY2Xs5+U=@lists.linux.it
X-Gm-Message-State: AOJu0YxwC4f35FgjUSizhdzzveTpefc2TcyBOq0ca2yFqTuxGh4y67CM
 LqodFcfGiLjW6jR/DD2eVdtoAIRdmQDcuYT5vo3r7T3UcCo9hPC7LCkUNLtaVMk=
X-Gm-Gg: ASbGncvEdqpNnS2CnSCyonYE5UZlHlauG4pD/cuyqYt4KyqfWt/+LHvz44NbVmNpRTQ
 7WV4LHjUR6QXc2jkbg0mV0eSxtBHeIXBP71RFJ1ZSsm+NS10CNGgFB3+JskUBeX7u8Vqo1CZQlC
 qdPGvXJrENOH4W7kiTFXySlAowoV1ClLbzI4L7nB3XrmMb3d3HHXDerYDaKhXGiotbXgtZ/BLl8
 h1uaBM08yXVD9X5RravWPz7ynaSbsdNrnBgByXy7syqAoaiGlO/fhlDwWot7+GwZ96WC058Vm5b
 xXb+PV/GLwnliNosUqatZ4vK4M+KfmqSPDIZl+f3GOT17ux9FpdsKzn075slfdsH0Vf5ieyagFG
 0Z9jHxNB7m0qVa0xk8epPEUzixL/FFcqGILyg0JqF3oaJZkTBl9OqNdRvSUkuESoXVUsVn1a/gf
 97WzHpcjuk7A0NxgaXug==
X-Google-Smtp-Source: AGHT+IFgaoBe9HmKci+9EvGqS1CNzj282LbwBQUQN5kyGbWesnIS0KIKZhUk5SNCDPaiRFzPNHOEqw==
X-Received: by 2002:a05:600c:b8f:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-43d4379505amr58526125e9.12.1742456692240; 
 Thu, 20 Mar 2025 00:44:52 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeb6esm40191875e9.31.2025.03.20.00.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:44:51 -0700 (PDT)
Message-ID: <4d71b5c1-1e08-4d7c-9999-fdd7868a73d2@suse.com>
Date: Thu, 20 Mar 2025 08:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250319-conversions-ht_enabled-v1-1-e4375ea37b54@suse.com>
Content-Language: en-US
In-Reply-To: <20250319-conversions-ht_enabled-v1-1-e4375ea37b54@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hyperthreading/ht_enabled: Convert to new API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCnRoaXMgaXMgbm90IGEgdGVzdCBidXQgYW4gdXRpbGl0eSB1c2VkIGJ5IHNt
dF9zbXBfYWZmaW5pdHkuc2ggLCBzbyBpdCAKbmVlZHMgdG8gYmUgcmVmYWN0b3JlZCB1c2luZyBU
U1RfTk9fREVGQVVMVF9NQUlOIChzZWFyY2ggaXQgaW5zaWRlIHRoZSAKcHJvamVjdCB0byB1bmRl
cnN0YW5kIGhvdyB0byB1c2UgaXQpLgpJIGd1ZXNzIHRoaXMgY29kZSBzaG91bGQgYmUgcmVmYWN0
b3JlZCB3aXRoIHRoZSBlbnRpcmUgaHlwZXJ0aHJlYWRpbmcgCnRlc3Rpbmcgc3VpdGUuCgpSZWdh
cmRzLApBbmRyZWEKCk9uIDMvMTkvMjUgMjA6MzcsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBs
dHAgd3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+
IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0t
Cj4gICAuLi4vc2NoZWQvaHlwZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF9lbmFibGVkLmMgICB8
IDQ2ICsrKysrKysrKystLS0tLS0tLS0tLS0KPiAgIC4uLi9zY2hlZC9oeXBlcnRocmVhZGluZy9o
dF9lbmFibGVkL2h0X3V0aWxzLmggICAgIHwgIDYgKy0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIz
IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc2NoZWQvaHlwZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF9lbmFibGVkLmMgYi90
ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfZW5hYmxl
ZC5jCj4gaW5kZXggOTBmMzdlNTU0ZjlkMWFkZDUyNTQ5OGUxOTY0Yzc4YmQxNGY0YjE2ZC4uODhl
NzI2ZDY1N2E0ZTY3N2E4ZWRlNWI3MTI1OWFhZGYzZGE0OTQ5NCAxMDA2NDQKPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfZW5hYmxlZC5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9oeXBlcnRocmVhZGluZy9odF9lbmFibGVk
L2h0X2VuYWJsZWQuYwo+IEBAIC0xLDMyICsxLDI4IEBACj4gLS8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBIVGVuYWJsZWQuYyAgLSAgZGVzY3JpcHRpb24K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tCj4gLSAg
ICBlbWFpbCAgICAgICAgICAgICAgICA6IHNvbmljLHpoYW5nQGludGVsLmNvbQo+IC0gKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqLwo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIHNvbmljLHpoYW5nQGludGVsLmNvbQo+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjUgU1VTRSBMTEMgUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KPiArICovCj4gICAKPiAtLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+IC0gKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqCj4gLSAqICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgICoKPiAtICogICBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSAgKgo+
IC0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yICAgICAqCj4gLSAqICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIg
dmVyc2lvbi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKPiAtICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKgo+IC0gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwo+ICsvKlwKPiArICogU21va2UgdGVz
dCB0aGF0IGNoZWNrcyBpZiBIeXBlcnRocmVhZGluZyBpcyBlbmFibGVkIGJ5IGRlZmF1bHQgaW4g
dGhlIGhvc3QuCj4gKyAqLwo+ICAgCj4gLSNpbmNsdWRlICJ0ZXN0LmgiCj4gLSNpbmNsdWRlICJo
dF91dGlscy5oIgo+ICsjaWYgX19pMzg2X18gfHwgX194ODZfNjRfXwo+ICAgCj4gLWNoYXIgKlRD
SUQgPSAic210X3NtcF9lbmFibGVkIjsKPiAtaW50IFRTVF9UT1RBTCA9IDE7Cj4gKyNpbmNsdWRl
ICJ0c3RfdGVzdC5oIgo+ICsjaW5jbHVkZSAiaHRfdXRpbHMuaCIKPiAgIAo+IC1pbnQgbWFpbih2
b2lkKQo+ICt2b2lkIHJ1bih2b2lkKQo+ICAgewo+IC0JaW50IHJldF92YWwgPSAxOwo+IC0jaWYg
ICghZGVmaW5lZCBfX3g4Nl82NF9fICYmICFkZWZpbmVkIF9faTM4Nl9fKQo+IC0JdHN0X2Jya20o
VENPTkYsIE5VTEwsCj4gLQkJICJUaGlzIHRlc3Qgc3VpdGUgY2FuIG9ubHkgZXhlY3V0ZSBvbiB4
ODYgYXJjaGl0ZWN0dXJlLiIpOwo+ICsJaWYgKGNoZWNrX2h0X2NhcGFiaWxpdHkoKSkKPiArCQl0
c3RfcmVzKFRGQUlMLCAiSFQgaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBpbiB0aGlzIHN5c3Rl
bSIpOwo+ICsJZWxzZQo+ICsJCXRzdF9yZXMoVFBBU1MsICJIVCBpcyBlbmFibGVkIGJ5IGRlZmF1
bHQgaW4gdGhpcyBzeXN0ZW0iKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0geyAudGVzdF9hbGwgPSBydW4gfTsKPiArCj4gICAjZWxzZQo+IC0JcmV0X3ZhbCA9IGNo
ZWNrX2h0X2NhcGFiaWxpdHkoKTsKPiArVFNUX1RFU1RfVENPTkYoIlRoaXMgdGVzdCBjYW4gb25s
eSBleGVjdXRlIG9uIHg4NiBhcmNoaXRlY3R1cmUiKQo+ICAgI2VuZGlmCj4gLQlyZXR1cm4gcmV0
X3ZhbDsKPiAtfQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhy
ZWFkaW5nL2h0X2VuYWJsZWQvaHRfdXRpbHMuaCBiL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvaHlw
ZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF91dGlscy5oCj4gaW5kZXggYzAzYTEyNDI1NTFjZTEz
MGQzODYyY2JlMGRiMzI5ZjcxMTExODNlYS4uNjFmMGZmM2Q5ODg2YWZiMjExZDYzNjg2NjVkZTlm
NjM5YjJkNjY1NCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhy
ZWFkaW5nL2h0X2VuYWJsZWQvaHRfdXRpbHMuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2No
ZWQvaHlwZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF91dGlscy5oCj4gQEAgLTEsMTkgKzEsMTcg
QEAKPiAtCj4gICAjaWZuZGVmIF9IVFVUSUxTX0hfCj4gICAjZGVmaW5lIF9IVFVUSUxTX0hfCj4g
ICAKPiAgICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPiAtI2luY2x1ZGUgPHN0ZGxpYi5oPgo+ICAg
Cj4gICBpbnQgaXNfY21kbGluZV9wYXJhKGNvbnN0IGNoYXIgKnBhcmEpOwo+ICAgCj4gICAvLyBy
ZXR1cm4gMCBtZWFucyBQYXNzLAo+ICAgLy8gcmV0dXJuIDEgbWVhbnMgaHQgaXMgbm90IGVuYWJs
ZWQsCj4gLWludCBjaGVja19odF9jYXBhYmlsaXR5KCk7Cj4gK2ludCBjaGVja19odF9jYXBhYmls
aXR5KHZvaWQpOwo+ICAgCj4gICBleHRlcm4gY2hhciBidWZbXTsKPiAgIAo+IC1pbnQgZ2V0X2Nw
dV9jb3VudCgpOwo+ICtpbnQgZ2V0X2NwdV9jb3VudCh2b2lkKTsKPiAgIGludCBnZXRfY3VycmVu
dF9jcHUocGlkX3QgcGlkKTsKPiAgIAo+ICAgI2VuZGlmCj4KPiAtLS0KPiBiYXNlLWNvbW1pdDog
YWUyNzkyNzY1MzVmYzljYTMxMTdhMTJjNGJiYTAwMjlkNzkyOTA0ZQo+IGNoYW5nZS1pZDogMjAy
NTAzMTktY29udmVyc2lvbnMtaHRfZW5hYmxlZC1kODI0OTJhMGNiYjkKPgo+IEJlc3QgcmVnYXJk
cywKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
