Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309DEF5A8D2
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DA473E25C9
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 07:35:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1E383E1B19
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 07:35:26 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 451791A00999
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 07:35:26 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so2539630a91.0
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 22:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749725; x=1777354525; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mG0duGw5y2s3rMlsSK7HHdmW6WFWsapHUBC2b73yk4A=;
 b=j2WpyH+1mJtzFKKsIS1mFawoA9Vn9V7Mm5rOjX7QmNouhKiA+IsbHV06QNmbWN4u24
 8qz9KdWLZJ0F+V5iZekUdIUAKzjjuzDDMq4G94WbEPHhuPE9Jsm7f7x1uC+BSX3nST3f
 /9KmWdFDptX5SOqriajt/PE3yRkjl8f8M10SPAY0fRrOSCEwTPSHexDjTYwXIGMzpjLr
 QksK4msUqg+n+K53lkG0UpWQql1/VDCiZjA0tzfYWH9U+j5m4kbFlaDa3+DQpt+9y8Tf
 cKQDBqHpJ/gwxgmnnDktn6irClRC4lTVUPzV56jLIcSvs8ERSoWoTZyV2wyvaRnzSEKR
 JqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749725; x=1777354525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mG0duGw5y2s3rMlsSK7HHdmW6WFWsapHUBC2b73yk4A=;
 b=Mb9LZS6OmbLAakxxQc+Bqx6OQWceeECgKA6HHyXjSj2kAFm+N9QiKpJS9JPm1p/hii
 1RmG8cMlOzJECOmqN1jN0VKFntG1RLSsHPbyUpEBjVunpEC2Klws5fFsnMK5nvKs4FJ4
 gkJ+aQJNfK1NQkDK6PCpx3Y8iDEAmrKA+4Rw8ej7EQUY3aCBOWuVMGO1ymVnmBMz8BOX
 19ee8R3XiAY4kN/YSE9FKEvSrGJRMy3eaNOxU0RbfzhlvABdyWjcdcI08bH5VYM5Jjwi
 voSN6YNoDAFouQY3s7V9eXzRc4n/cXCudsJeyWG8hsMplw91ZupadBiwvhmIDYw/2QWt
 UZWQ==
X-Gm-Message-State: AOJu0YwlVBYl7gxId8y87aEnLeuYTcc1epKzuKV8Z8dYyKHYVqGds6mK
 GHLTmkLcPIgbEiU7JavSN76W1lsQM8xEWw6qHhRTQRfvCnDd/m4amVby
X-Gm-Gg: AeBDieu+YhNpKtOZzRwJwPUibVNai65e5sLhNC1XnjpwLhcA/GcI0y1C+tlcVyweSSD
 fva0zyYcYd2mxV1KS3m1pDSKyPDzu3+arkb7EpMh6duyfo1RxvlzQXV0x7srtjhmWXDympvnQj1
 V1YZxS9egBsEyMUyR6mtOpt1lQ1KMhqtvwjJUztfqQ0tJS2hfQy0S0QxMdR1cs9o9tEEAAKLrls
 dUFi0e/x79wTg82FAfrshPCHg0Rpl0gsTv9ZD/JwK7pS4LI6zJxoPtzk1Shl0isSxhZvTjkfRKZ
 lU3c6V8XGDY02tvPNVRc07H5p2m15THzdWPmlbOoUjjSzRJcvFJtOpQNGgg2K8deQcrImretXbd
 3q5HFOSxRc8Yzzu1NkFtJC1T/uBEKaIpO+q0FJ88OV2xxg4dromzBFSuz8LsPKEDNd6w2/IZZOL
 BbLvMJ7yyVegAoIxDAgK3ValQULaK4+kvg1OzHa7ZO9DdzR+PopiBJv6Vyi4v51BIm7Mliu1bzn
 +whIIlVUm4TzqAip5v9xvM7HAaIguZUQsiFTW3h3sNg1tpzJgipkVJOYA==
X-Received: by 2002:a17:90b:394e:b0:359:d54:846f with SMTP id
 98e67ed59e1d1-361403f10f9mr16166506a91.7.1776749724580; 
 Mon, 20 Apr 2026 22:35:24 -0700 (PDT)
Received: from
 runnervmeorf1.xp4uafbg1gjufkifmppbinpt2g.xx.internal.cloudapp.net
 ([4.154.76.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140edb04dsm12497956a91.0.2026.04.20.22.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:35:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: lepillai@linux.ibm.com
Date: Tue, 21 Apr 2026 05:35:23 +0000
Message-ID: <20260421053523.3918-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421050251.3662828-1-lepillai@linux.ibm.com>
References: <20260421050251.3662828-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Added new_behavior flag to detect kernel version Kernel
 >= 6.11: Tests that creat() succeeds (write to executed file allowed)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGVrc2htaSwKCk9uIDIwMjYtMDQtMjEsIGxla3NobWktY3BpbGxhaSB3cm90ZToKPiBBZGRl
ZCBuZXdfYmVoYXZpb3IgZmxhZyB0byBkZXRlY3Qga2VybmVsIHZlcnNpb24gS2VybmVsID49IDYu
MTE6IFRlc3RzIHRoYXQgY3JlYXQoKSBzdWNjZWVkcyAod3JpdGUgdG8gZXhlY3V0ZWQgZmlsZSBh
bGxvd2VkKQoKVXNlIGltcGVyYXRpdmUgbW9vZCBpbiB0aGUgc3ViamVjdDogImNyZWF0MDc6IFN1
cHBvcnQgYm90aCBvbGQgYW5kIG5ldwp3cml0ZS10by1leGVjdXRlZC1maWxlIGJlaGF2aW9yIi4g
QWxzbyBhZGQgYSBjb21taXQgYm9keSBleHBsYWluaW5nIHdoeQp0aGUgY2hhbmdlIGlzIG5lZWRl
ZCDigJQgdGhhdCB0aGUgcHJldmlvdXMgdHN0X2JyayhUQ09ORikgc2lsZW50bHkgc2tpcHBlZAp0
aGUgdGVzdCBvbiBhbGwga2VybmVscyA+PSA2LjExIGluc3RlYWQgb2YgdmVyaWZ5aW5nIHRoZSBh
bGxvd2VkIGJlaGF2aW9yLgpGaW5hbGx5LCB0aGUgU2lnbmVkLW9mZi1ieSB0YWcgaXMgbWlzc2lu
Zy4KCj4gK3N0YXRpYyBpbnQgbmV3X2JlaGF2aW9yOwoKWy4uLl0KCj4gLSAgICAgICAgICAgICAg
IHRzdF9icmsoVENPTkYsICJTa2lwcGluZyB0ZXN0LCB3cml0ZSB0byBleGVjdXRlZCBmaWxlIGlz
ICIKPiAtICAgICAgICAgICAgICAgICAgICAgICAiYWxsb3dlZCBzaW5jZSA2LjExLXJjMS5cbiIK
PiAtICAgICAgICAgICAgICAgICAgICAgICAiMmEwMTBjNDEyODUzIChcImZzOiBkb24ndCBibG9j
ayBpX3dyaXRlY291bnQgZHVyaW5nIGV4ZWNcIikiKTsKPiArICAgICAgICAgICAgICAgbmV3X2Jl
aGF2aW9yID0gMTsKClRoZSBsb2dpYyBjaGFuZ2UgaXMgY29ycmVjdC4gSG93ZXZlciB0aGUgZG9j
IGNvbW1lbnQgYXQgdGhlIHRvcCBvZiB0aGUKZmlsZSBzdGlsbCBvbmx5IG1lbnRpb25zIEVUWFRC
U1kg4oCUIHVwZGF0ZSBpdCB0byBkZXNjcmliZSBib3RoIGJlaGF2aW9ycy4KClsuLi5dCgpQcmUt
ZXhpc3RpbmcgaXNzdWVzIG5vdGljZWQgaW4gdGhlIHN1cnJvdW5kaW5nIGNvZGUgKG5vdCBpbnRy
b2R1Y2VkCmJ5IHRoaXMgcGF0Y2gpOgoKLSBjcmVhdDA3LmM6MzUg4oCUIE9fV1JPTkxZICh2YWx1
ZSAxKSBpcyBwYXNzZWQgYXMgdGhlIG1vZGUgYXJndW1lbnQgdG8KICBjcmVhdCgpOyB0aGUgc2Vj
b25kIHBhcmFtZXRlciBpcyBtb2RlX3QsIG5vdCBvcGVuIGZsYWdzIOKAlCBsaWtlbHkKICBpbnRl
bmRlZCB0byBiZSAwNjAwLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZp
ZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC1hZ2VudC9hY3Rpb25zL3J1bnMvMjQ3
MDU3NTkzNDYKClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVz
IGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNz
dWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUg
dGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
