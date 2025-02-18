Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3BBC02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 11:45:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17C993C9C90
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:45:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C25DF3C7ADA;
 Tue, 18 Feb 2025 12:44:53 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C22CD1A0CE55;
 Tue, 18 Feb 2025 12:44:52 +0100 (CET)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc6272259cso3060900a91.0; 
 Tue, 18 Feb 2025 03:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739879091; x=1740483891;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85Nq6oBYDS0Z+aMhCm3Ngo+EcyONh3oVn3wK+KrETpU=;
 b=u/Q34Josma4kzWjVj9DZ9CqFzUN8K1RhDe9FzjXll2hFk+k1w8CQasutnRIfY+Kerm
 9IItg/yFkQxtC8a4ckgBCXkRKCVNoIsEz6Ubjy3DpV7DosCwE1386yykwNrR00iBOsiP
 cyR2dM/m8iVMW3kQf5s1cEEmfMIOnDi1rEN7L8QVJgCzQbXDy15R0Ya3n6KjUasWtpGI
 /MzTSGNrKLzdawRziMIs/UL532ZGv86ArkGSCiy8aoOM66tnsuKHhMNsCMUVtE7KXZzB
 tHdP5GK5Awdd+ocmMncHcl3FvRazjWFwCdtOaKFffJS7GlNIMD1pdmpLk2O6rr1Hq3B0
 G70A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7Y0V58yQUgOiV9z2jUXdVEwv5oJRdi+yW8tJpOzpXNNEyGenhsKJb95cAoFtGPPRY+Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yx4pVvUVitpRBuIW5gk3N4qtqJBsDXcJdbw/1Vyu4k+yRtR0XHu
 kZ71xGf6xsDrs5rYFsZnvnpe5bq4tQffTvdiFGFUyTVq8YbWaqk8O10HReNH
X-Gm-Gg: ASbGncv2B9c7kzpqtX8qQ5eaGiGKM/ML3wqVQrNmylQ2Y2N5FXy+6JbMLnDQbuJ4Tlz
 AIjSvDsD/FBVMFWBn09zwkGMNYlSNAIOGJL2VFD3/pKQQbe754vuD/AUccQyCTwqk/1jdDWTmqC
 KXMQwfOl/VOa4Q8vyDcM0SDGn3nntUu0m4ngoenhZz91zLJgOM1ztiGO4liVZrlhp6QYwaokp9c
 X4+hhm6fQQiYlO2lsgEissIp70wSXH0g5bQjsks4+w3p51nBBONdDWHV8Pg4NkOylSiXlD2My/y
 gRd7bvfboJFR1Z7q7jZhehNoh6ax3mmo
X-Google-Smtp-Source: AGHT+IHlQq17ZB4R3ZKhCM/ouovRxidmNN29qry7lX3mFnqNAIBz81e9hdtM1zIIjEps3g24MXj3Dw==
X-Received: by 2002:a17:90b:4a49:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2fc40d13e61mr21313771a91.1.1739879090660; 
 Tue, 18 Feb 2025 03:44:50 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ba60b6sm9882257a91.46.2025.02.18.03.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 03:44:50 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739879088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85Nq6oBYDS0Z+aMhCm3Ngo+EcyONh3oVn3wK+KrETpU=;
 b=AbaISg7UrOUIb7rkqoHol04qXRpKa9KgxObE4BWoQI2fx4bvzj/ATlT2g9jFFNCJ2MDENb
 ySBSqBCXlqSwA1KC/W2xQ3lBwLbLbR/GfomkADlBmkpOTK00G4Prnm9yXBisz9q2KFRzwQ
 PoJfu/L07Ne0fTVMZ5Z0FY9RbwItdMy8cIqHncyDWURAo+0EKFJdCJdAKnc78tbWCutoou
 FGb8LvJ4f1QnwHvO7XiNDpvSJnUgREEci184+CQIEaYZcwYbbWi/ktRyrURELEUTa7X2I9
 vqNSwvWmENaL0WH/dvITRw8h4MrdjAaMIjloqeerCk1sjyLycrslh99NYZiRCg==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Tue, 18 Feb 2025 08:44:45 -0300
Message-Id: <D7VJNTFZM1Z5.1WXQYU2HD3T0P@marliere.net>
To: "chunfuwen" <chwen@redhat.com>, <ltp@lists.linux.it>
References: <20250218023107.1208990-1-chwen@redhat.com>
In-Reply-To: <20250218023107.1208990-1-chwen@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpBIGZldyBjb21tZW50cyBpbiBsaW5lLgoKT24gTW9uIEZlYiAxNywgMjAyNSBhdCAx
MTozMSBQTSAtMDMsIGNodW5mdXdlbiB3cm90ZToKPiBUaGUgdGVzdCBlbnN1cmVzIHRoYXQgdGhl
IHByb2Nlc3MgZ2V0cyB0aGUgY29ycmVjdCBzaWduYWxzIGluIHRoZSBjb3JyZWN0IG9yZGVyOgo+
Cj4gRmlyc3QsIGl0IHNob3VsZCBnZXQgU0lHWENQVSBhZnRlciByZWFjaGluZyB0aGUgc29mdCBD
UFUgdGltZSBsaW1pdDY0Lgo+IFRoZW4sIGlmIHRoZSBDUFUgdGltZSBleGNlZWRzIHRoZSBoYXJk
IGxpbWl0LCBpdCBzaG91bGQgcmVjZWl2ZSBTSUdLSUxMCj4KPiBTaWduZWQtb2ZmLWJ5OiBjaHVu
ZnV3ZW4gPGNod2VuQHJlZGhhdC5jb20+Cj4gLS0tCj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvc2V0
cmxpbWl0L3NldHJsaW1pdDA3LmMgICB8IDEyOSArKysrKysrKysrKysrKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3NldHJsaW1pdC9zZXRybGltaXQwNy5jCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRybGltaXQvc2V0cmxpbWl0MDcuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0cmxpbWl0L3NldHJsaW1pdDA3LmMKPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uMDMxZDU4YzY0Cj4gLS0tIC9kZXYvbnVs
bAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0cmxpbWl0L3NldHJsaW1pdDA3
LmMKPiBAQCAtMCwwICsxLDEyOSBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTcgUmVkIEhhdCBJbmMu
IEFsbCBSaWdodHMgUmVzZXJ2ZWQuCgpJcyB0aGlzIGFuIG9sZCBzb3VyY2UgYmVpbmcgc2VudCB1
cHN0cmVhbSBvciBjYW4gd2UgYnVtcCB0aGlzIHRvIDIwMjU/Cgo+ICsgKiBBdXRob3I6IENodW5m
dSBXZW4gPGNod2VuQHJlZGhhdC5jb20+Cj4gKyAqLwo+ICsKPiArLyoKPiArICogRGVzY3JpcHRp
b246CgpObyBuZWVkIGZvciB0aGlzIGxpbmUuCgo+ICsgKiBTZXQgQ1BVIHRpbWUgbGltaXQ2NCBm
b3IgYSBwcm9jZXNzIGFuZCBjaGVjayBpdHMgYmVoYXZpb3IKPiArICogYWZ0ZXIgcmVhY2hpbmcg
Q1BVIHRpbWUgbGltaXQ2NC4KPiArICogMSkgUHJvY2VzcyBnb3QgU0lHWENQVSBhZnRlciByZWFj
aGluZyBzb2Z0IGxpbWl0IG9mIENQVSB0aW1lIGxpbWl0NjQuCj4gKyAqIDIpIFByb2Nlc3MgZ290
IFNJR0tJTEwgYWZ0ZXIgcmVhY2hpbmcgaGFyZCBsaW1pdCBvZiBDUFUgdGltZSBsaW1pdDY0Lgo+
ICsgKgoKVHJhaWxpbmcgbGluZSBzaG91bGQgYmUgcmVtb3ZlZC4KCj4gKyAqLwo+ICsKPiArI2Rl
ZmluZSBfR05VX1NPVVJDRQo+ICsjaW5jbHVkZSA8ZXJybm8uaD4KPiArI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgo+ICsjaW5jbHVkZSA8dW5pc3RkLmg+Cj4gKyNpbmNsdWRlIDxzeXMvdGltZS5oPgo+
ICsjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+Cj4gKyNpbmNsdWRlIDxzeXMvd2FpdC5oPgo+ICsj
aW5jbHVkZSA8c3RkbGliLmg+Cj4gKyNpbmNsdWRlIDxzdGRpbnQuaD4KPiArI2luY2x1ZGUgPHN5
cy9tbWFuLmg+Cj4gKyNpbmNsdWRlIDxpbnR0eXBlcy5oPgo+ICsKPiArI2luY2x1ZGUgInRzdF90
ZXN0LmgiCj4gKwo+ICsjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ICsjaW5jbHVkZSAibGFw
aS9hYmlzaXplLmgiCgpJIHdhcyBhYmxlIHRvIGJ1aWxkIHVzaW5nOgoKI2RlZmluZSBfR05VX1NP
VVJDRQojaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+CgojaW5jbHVkZSAidHN0X3Rlc3QuaCIKCiNp
bmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCgpTbywgcGVyaGFwcyB0cmltIHRoZSBpbmNsdWRlcyBk
b3duPwoKPiArCj4gKyNpZm5kZWYgSEFWRV9TVFJVQ1RfUkxJTUlUNjQKPiArc3RydWN0IHJsaW1p
dDY0IHsKPiArCXVpbnQ2NF90IHJsaW1fY3VyOwo+ICsJdWludDY0X3QgcmxpbV9tYXg7Cj4gK307
Cj4gKyNlbmRpZgo+ICsKPiArc3RhdGljIGludCAqZW5kOwo+ICsKPiArc3RhdGljIHZvaWQgc2ln
aGFuZGxlcihpbnQgc2lnKQo+ICt7Cj4gKwkqZW5kID0gc2lnOwo+ICt9Cj4gKwo+ICtzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKwlTQUZFX1NJR05BTChTSUdYQ1BVLCBzaWdoYW5kbGVy
KTsKPiArCj4gKwllbmQgPSBTQUZFX01NQVAoTlVMTCwgc2l6ZW9mKGludCksIFBST1RfUkVBRCB8
IFBST1RfV1JJVEUsCj4gKwkJCU1BUF9TSEFSRUQgfCBNQVBfQU5PTllNT1VTLCAtMSwgMCk7Cj4g
K30KPiArCj4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiArewo+ICsJaWYgKGVuZCkKPiAr
CQlTQUZFX01VTk1BUChlbmQsIHNpemVvZihpbnQpKTsKPiArfQo+ICsKPiArc3RhdGljIGludCBz
ZXRybGltaXRfdTY0KGludCByZXNvdXJjZSwgY29uc3Qgc3RydWN0IHJsaW1pdDY0ICpybGltKQo+
ICt7Cj4gKyAgICByZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9wcmxpbWl0NjQsIDAsIHJlc291cmNl
LCBybGltLCBOVUxMKTsKClBsZWFzZSB1c2UgdGFiIGluc3RlYWQgb2Ygc3BhY2VzLgoKPiArfQo+
ICsKPiArc3RhdGljIHZvaWQgdmVyaWZ5X3NldHJsaW1pdDY0KHZvaWQpCj4gK3sKPiArCWludCBz
dGF0dXM7Cj4gKwlwaWRfdCBwaWQ7Cj4gKwlzdHJ1Y3QgcmxpbWl0NjQgcmxpbTsKPiArCXJsaW0u
cmxpbV9jdXIgPSAxOwo+ICsJcmxpbS5ybGltX21heCA9IDI7Cj4gKwo+ICsJKmVuZCA9IDA7Cj4g
Kwo+ICsJcGlkID0gU0FGRV9GT1JLKCk7Cj4gKwlpZiAoIXBpZCkgewo+ICsJCVRFU1Qoc2V0cmxp
bWl0X3U2NChSTElNSVRfQ1BVLCAmcmxpbSkpOwo+ICsJCWlmIChUU1RfUkVUID09IC0xKSB7Cj4g
KwkJCXRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLAo+ICsJCQkJInNldHJsaW1pdF91NjQoUkxJTUlU
X0NQVSkgZmFpbGVkIik7Cj4gKwkJCWV4aXQoMSk7Cj4gKwkJfQo+ICsKPiArCQlhbGFybSgyMCk7
Cj4gKwo+ICsJCXdoaWxlICgxKTsKCm5pdDogVXNlIHRoZSBmb2xsb3dpbmcgdG8gbWFrZSBjaGVj
a3BhdGNoIGhhcHB5OgoJCXdoaWxlICgxKQoJCQk7Cgo+ICsJfQo+ICsKPiArCVNBRkVfV0FJVFBJ
RChwaWQsICZzdGF0dXMsIDApOwo+ICsKPiArCWlmIChXSUZFWElURUQoc3RhdHVzKSAmJiBXRVhJ
VFNUQVRVUyhzdGF0dXMpID09IDEpCj4gKwkJcmV0dXJuOwo+ICsKPiArCWlmIChXSUZTSUdOQUxF
RChzdGF0dXMpKSB7Cj4gKwkJaWYgKFdURVJNU0lHKHN0YXR1cykgPT0gU0lHS0lMTCAmJiAqZW5k
ID09IFNJR1hDUFUpIHsKPiArCQkJdHN0X3JlcyhUUEFTUywKPiArCQkJCSJHb3QgU0lHWENQVSB0
aGVuIFNJR0tJTEwgYWZ0ZXIgcmVhY2hpbmcgYm90aCBsaW1pdCIpOwo+ICsJCQlyZXR1cm47Cj4g
KwkJfQo+ICsKPiArCQlpZiAoV1RFUk1TSUcoc3RhdHVzKSA9PSBTSUdLSUxMICYmICEqZW5kKSB7
Cj4gKwkJCXRzdF9yZXMoVEZBSUwsCj4gKwkJCQkiR290IG9ubHkgU0lHS0lMTCBhZnRlciByZWFj
aGluZyBib3RoIGxpbWl0Iik7Cj4gKwkJCXJldHVybjsKPiArCQl9Cj4gKwo+ICsJCWlmIChXVEVS
TVNJRyhzdGF0dXMpID09IFNJR0FMUk0gJiYgKmVuZCA9PSBTSUdYQ1BVKSB7Cj4gKwkJCXRzdF9y
ZXMoVEZBSUwsCj4gKwkJCQkiR290IG9ubHkgU0lHWENQVSBhZnRlciByZWFjaGluZyBib3RoIGxp
bWl0Iik7Cj4gKwkJCXJldHVybjsKPiArCQl9Cj4gKwo+ICsJCWlmIChXVEVSTVNJRyhzdGF0dXMp
ID09IFNJR0FMUk0gJiYgISplbmQpIHsKPiArCQkJdHN0X3JlcyhURkFJTCwKPiArCQkJCSJHb3Qg
bm8gc2lnbmFsIGFmdGVyIHJlYWNoaW5nIGJvdGggbGltaXQiKTsKPiArCQkJcmV0dXJuOwo+ICsJ
CX0KPiArCX0KPiArCj4gKwl0c3RfcmVzKFRGQUlMLCAiQ2hpbGQgJXMiLCB0c3Rfc3Ryc3RhdHVz
KHN0YXR1cykpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4g
KwkudGVzdF9hbGwgPSB2ZXJpZnlfc2V0cmxpbWl0NjQsCj4gKwkuc2V0dXAgPSBzZXR1cCwKPiAr
CS5jbGVhbnVwID0gY2xlYW51cCwKPiArCS5mb3Jrc19jaGlsZCA9IDEsCj4gK307CgpXaXRoIHRo
b3NlIGZpeGVkOgoKUmV2aWV3ZWQtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyaWNhcmRvQG1h
cmxpZXJlLm5ldD4KClRoYW5rIHlvdSwKLQlSaWNhcmRvLgoKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
