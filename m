Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F9C0218A
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 12:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B2343C7694
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 13:07:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC16C3C1BD1
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 00:35:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D64EA239491
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 00:35:23 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso920945e9.1
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738193723; x=1738798523; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ad4OWAvie9bFaeOk+7TOkUim/AHORb3zPHq5phrxsYQ=;
 b=gS/vGiyeKsVAA2BaUZs2kovYB20eaD1JtmZwEoOnFwmovqKpm9D7MFoQW/P7q4gskj
 9tI76e0Yi+8JBUMNwYQnjpt1fbtXtP3fDbrOuv2TQ+8IQMTgsorFT3V4B4sRzpq3ea9X
 9Mr9U/6qb/202PNQW1AI2mJsoc53t8qHL2iKsSUFsz0YYd6vwHB35oo5qKtERMkgBMUB
 mvOM/v06DwW9eNSSP5zDYPwYJVX5VPUXCtLQAynIJT7SXxgDmSoZUXiXeZT87RFi1oHi
 36dTXKD4gkYsUZas6pg2uXxQLakm0oGOv5hquFvAG2T1vlgVQmXXtSiRzcWnyOiSitfH
 Qziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738193723; x=1738798523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ad4OWAvie9bFaeOk+7TOkUim/AHORb3zPHq5phrxsYQ=;
 b=u1XrpRv8lvXAX2z/knG3uV1+wJvb+FpXx1STG0BpI5RezUb8OUBnvkah5ZAeanqFgk
 jqJ5GoIq7qT8/ftC3LSLXIPr1rfOSahltwZd3hWlIXeQykylFxmGrNAS6NpBzV1FNgmX
 TOejtNxI3yDGHKrxLzcWLak0M3F1GRnfKIjNyNuTY9cfH4+w4tLgdSlpXJ95rkHZHSdF
 ECGiAJ3O07hC6zQAIrXuP3pX+GBBzVCWBgocAzEWZVWovWBkeC3Y9qiQOItr4cVEuJUL
 NryUQUWvakXCejsV4tlba5ihcKNgx+DG7F0or44xFXTGxxGI8CMVs6PrZWdS+EmJYHsC
 d5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8qsItCgG59sVwM8GkwFR881yrHSQ21I71mbGFhIxCVhwd1J+hM0qBGFa5Qs83EJ13Njo=@lists.linux.it
X-Gm-Message-State: AOJu0YyFygNhVlgVs2c6bGUIwCO8HbEL9j3E+A+CujpFPdXb5hVPRtI8
 iV8PnhBLScILc3Vb8ihEYor4i4rV/FG+k5Fd+uv98saJk6bbhYH0
X-Gm-Gg: ASbGncvnd9g1oYNuMG1pZ9xzpHGWILv/FJoaocHpf0h7ZmomVSDOxkR54aEO3c67988
 wn4uZFqsd0T35m8rJXxlBHL9YQazmNzMWOw7ugCD1QEQqTnR88YxPBR8PbenltA+EYRdcp12LZ+
 TL2+3Df/3CIEiQGXbnQPZOZ3FSRxC7KXQ30RAHyFRZVUg9tYN/81HKG1flqdeoK8VIoaBLrOtGb
 PVVThKFdLakJDabmAo5qsxvzyk2pkcrFruJvmm/uXQId6F/j6iT8s4wkoddh7dlgj2kDRX35VfJ
 mVYnaB5GBXlCPzc=
X-Google-Smtp-Source: AGHT+IEOlRIyw9nkUEKhHze05eDFF7ISQwE5h/yuUotX2U7dtDcjVrU1nVe8IqRMIJfxkree188UHQ==
X-Received: by 2002:a5d:694f:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38c520bfa02mr3661961f8f.53.1738193722922; 
 Wed, 29 Jan 2025 15:35:22 -0800 (PST)
Received: from nadav-dell ([87.71.205.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec315sm210513f8f.4.2025.01.29.15.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 15:35:22 -0800 (PST)
Date: Thu, 30 Jan 2025 01:35:19 +0200
From: Nadav Tasher <tashernadav@gmail.com>
To: Petr Vorel <petr.vorel@gmail.com>
Message-ID: <Z5q7NwweeZ0iNlzc@nadav-dell>
References: <20250129224631.GA452802@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250129224631.GA452802@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jan 2025 13:07:19 +0100
Subject: Re: [LTP] [uclibc-ng-devel] LTP test fstatat01.c FTBFS on Buildroot
 bootlin-sh4-uclibc toolchain
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
Cc: devel@uclibc-ng.org, buildroot@buildroot.or, ltp@lists.linux.it,
 linux-sh@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMjksIDIwMjUgYXQgMTE6NDY6MzFQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBhbGwsCj4gCj4gTFRQIHRlc3QgZnN0YXRhdDAxLmMgWzFdIEZUQkZTIG9uIEJ1aWxk
cm9vdCBib290bGluLXNoNC11Y2xpYmMgdG9vbGNoYWluCj4gKHVjbGliYzogMS4wLjUwLCBrZXJu
ZWwgaGVhZGVyczogNC4xOS4yNTUpLiBJdCBsb29rcyB0byBtZSB0aGF0IG90aGVyIGJvb3RsaW4K
PiB1Y2xpYmMgYmFzZWQgdG9vbGNoYWlucyBhcmUgd29ya2luZywgdGhlcmVmb3JlIGl0J3MgcHJv
YmFibHkgc2g0IHByb2JsZW0uCj4gCj4gTG9va2luZyBpbnRvIGluY2x1ZGUvc3lzL3N0YXQuaCBp
biB1Y2xpYmMtbmcgWzJdLCBleHRlcm4gaW50IGZzdGF0YXQgKGludCBfX2ZkLAo+IC4uLikgZGVm
aW5pdGlvbiBpcyBndWFyZGVkIG9ubHkgYnk6ICMgIGlmZGVmIF9fUkVESVJFQ1RfTlRILgo+IEJ1
dCBpbiBnbGliYyBpby9zeXMvc3RhdC5oIFszXSBndWFyZGVzIGl0IHdpdGggIyAgaWZkZWYgX19V
U0VfVElNRTY0X1JFRElSRUNUUwo+IGFkZGVkIGdsaWJjIDIuNDAgYTRlZDA0NzFkNyAoIkFsd2F5
cyBkZWZpbmUgX19VU0VfVElNRV9CSVRTNjQgd2hlbiA2NCBiaXQgdGltZV90IGlzIHVzZWQiKQo+
IHdoaWNoIHJlcGxhY2VkIHByZXZpb3VzIF9fVVNFX1RJTUVfQklUUzY0IGFkZGVkIGluIGluIGds
aWJjIDIuMzQgNDdmMjRjMjFlZSBbNF0KPiAoInkyMDM4OiBBZGQgc3VwcG9ydCBmb3IgNjQtYml0
IHRpbWUgb24gbGVnYWN5IEFCSXMiKSBbNV0uIFNob3VsZCBzaW1pbGFyIGNoYW5nZQo+IGJlIGFk
ZGVkIHRvIHVjbGliYy1uZz8KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+ICQgY2Qgfi9i
ci10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xpYmMvYnVpbGQvbHRwLXRlc3RzdWl0ZS03Mjg3NTk1
MDZjYmUwODYxMjE4MzI3NWIzNTQzMDA3ZDFjNDdmN2Y0L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZnN0YXRhdAo+ICQgbWFrZSBWPTEgZnN0YXRhdDAxCj4gYnItdGVzdC1wa2cvYm9vdGxpbi1z
aDQtdWNsaWJjL2hvc3QvYmluL3NoNC1saW51eC1nY2MgLURfTEFSR0VGSUxFX1NPVVJDRSAtRF9M
QVJHRUZJTEU2NF9TT1VSQ0UgLURfRklMRV9PRkZTRVRfQklUUz02NCAtRF9GT1JUSUZZX1NPVVJD
RT0yIC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLUkuLi8uLi8u
Li8uLi9pbmNsdWRlL29sZC8gLURfTEFSR0VGSUxFX1NPVVJDRSAtRF9MQVJHRUZJTEU2NF9TT1VS
Q0UgLURfRklMRV9PRkZTRVRfQklUUz02NCAgLU8yIC1nMCAgLUlici10ZXN0LXBrZy9ib290bGlu
LXNoNC11Y2xpYmMvaG9zdC9iaW4vLi4vc2g0LWJ1aWxkcm9vdC1saW51eC11Y2xpYmMvc3lzcm9v
dC91c3IvaW5jbHVkZS90aXJwYyAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUgLVdh
bGwgLVcgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtc3RkPWdudTk5IC1MLi4vLi4vLi4vLi4vbGli
IGZzdGF0YXQwMS5jICAtTGJyLXRlc3QtcGtnL2Jvb3RsaW4tc2g0LXVjbGliYy9ob3N0L2Jpbi8u
Li9zaDQtYnVpbGRyb290LWxpbnV4LXVjbGliYy9zeXNyb290L3Vzci9saWIgLWx0aXJwYyAtbGZ0
cyAtbGx0cCAtbyBmc3RhdGF0MDEKPiBmc3RhdGF0MDEuYzo2Mzo1OiBlcnJvcjogY29uZmxpY3Rp
bmcgdHlwZXMgZm9yIOKAmGZzdGF0YXTigJk7IGhhdmUg4oCYaW50KGludCwgIGNvbnN0IGNoYXIg
Kiwgc3RydWN0IHN0YXQ2NCAqLCBpbnQp4oCZCj4gICAgNjMgfCBpbnQgZnN0YXRhdChpbnQgZGly
ZmQsIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBzdHJ1Y3Qgc3RhdDY0ICpzdGF0YnVmLCBpbnQgZmxh
Z3MpCj4gICAgICAgfCAgICAgXn5+fn5+fgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBici10ZXN0
LXBrZy9ib290bGluLXNoNC11Y2xpYmMvaG9zdC9zaDQtYnVpbGRyb290LWxpbnV4LXVjbGliYy9z
eXNyb290L3Vzci9pbmNsdWRlL2ZlYXR1cmVzLmg6NDA5LAo+ICAgICAgICAgICAgICAgICAgZnJv
bSBici10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xpYmMvaG9zdC9zaDQtYnVpbGRyb290LWxpbnV4
LXVjbGliYy9zeXNyb290L3Vzci9pbmNsdWRlL3N5cy90eXBlcy5oOjI2LAo+ICAgICAgICAgICAg
ICAgICAgZnJvbSBmc3RhdGF0MDEuYzoyNzoKPiBici10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xp
YmMvaG9zdC9zaDQtYnVpbGRyb290LWxpbnV4LXVjbGliYy9zeXNyb290L3Vzci9pbmNsdWRlL3N5
cy9zdGF0Lmg6MjQzOjEyOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhmc3RhdGF0
4oCZIHdpdGggdHlwZSDigJhpbnQoaW50LCAgY29uc3QgY2hhciAqIHJlc3RyaWN0LCAgc3RydWN0
IHN0YXQgKiByZXN0cmljdCwgIGludCnigJkKPiAgIDI0MyB8IGV4dGVybiBpbnQgX19SRURJUkVD
VF9OVEggKGZzdGF0YXQsIChpbnQgX19mZCwgY29uc3QgY2hhciAqX19yZXN0cmljdCBfX2ZpbGUs
Cj4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cj4gCj4gWzFdIGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZnN0YXRhdC9mc3RhdGF0MDEuYwo+IFsyXSBodHRwczovL2NnaXQub3BlbmFk
ay5vcmcvY2dpL2NnaXQvdWNsaWJjLW5nLmdpdC90cmVlL2luY2x1ZGUvc3lzL3N0YXQuaCNuMjQ3
Cj4gWzNdIGh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWJsb2I7Zj1p
by9zeXMvc3RhdC5oO2g9NGJlYTllOWE3Nzg1ZjUxYWY4ZWVmZDAzNTg3NGY0NzViOTJiYjI2ZDto
Yj1IRUFEI2wyNjgKPiBbNF0gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9naXQvP3A9Z2xpYmMuZ2l0
O2E9Y29tbWl0O2g9YTRlZDA0NzFkNzE3Mzk5MjhhMGQwZmEzMjU4YjNmZjNiMTU4ZTliOQo+IFs1
XSBodHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC8/cD1nbGliYy5naXQ7YT1jb21taXQ7aD00N2Yy
NGMyMWVlMzg3MDFhZTI3NWFhOWU0NTFmNzBmYTNlNzc0NzhjCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkZXZlbCBtYWlsaW5nIGxpc3QgLS0gZGV2
ZWxAdWNsaWJjLW5nLm9yZwo+IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gZGV2ZWwt
bGVhdmVAdWNsaWJjLW5nLm9yZwpNeSBndWVzcyBpcyB0aGF0IHRoaXMgaXMgc29tZWhvdyBjYXVz
ZWQgYnkgdGhlIGZhY3QgdGhhdCB0aW1lNjQgb24gMzItYml0IHRhcmdldHMgaXMKbm90IHN1cHBv
cnRlZCBvbiBMaW51eCA8IDUuMS4wLgoKUmVnYXJkcywKTmFkYXYKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
