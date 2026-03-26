Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC47E10A3D81
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774528742; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4wjFCRZgUb8G4Xj2hguj7ayX5YXU83uXZ46rXgMj3DM=;
 b=im8JPigQBln1VK8oGE1XfXcy0VtJ0KKtIRIXyMsESezC+3iik+UquNN6TD/Yj2fH30Krn
 qgmY2iYcUlEDaaXA8F3fIkbIT4A3kfsyMQIemEcZf25Gxp5jUs5XBhVaUo7ftZmiroEjFUf
 EhwNvpgwgL/0KzksJNpjEr7vxsb+27k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5893CAEC3
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:39:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88B993C67DC
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:38:39 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 27CFB1000A59
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:38:38 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43b88b7ca76so712137f8f.3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774528717; x=1775133517; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=he7QyHY1mozAQPBmcK2eUMBc3hnd15+qhW99EarzF9c=;
 b=X6diNHcS/OpRST8C/Svm79e8oBvQGd3YGtIjl/7n3/ZgZWpMMScpVhGV1P+IR7DRI1
 EnVJ/g0uv6m46DnER0E5egnceJ0vpFmmeFeIG7cKcWJw5CUIDbwRysGF5uregYHvZkUc
 jBy/h2e0l/TzvJCyLKSN8BBXx0FPFGg0+83DN0EPDPm37zYWIfTaU9RsifCt/x+9Y0kE
 rsojvdy/hTvM9UkxGuOWXgNt4Qa70ETEJjw3A7+MY1H2GaJLazbSJPmLWGCo0lsoyiIt
 yKz5HzLY8d2GvV0HA+GyLRE/qNGY4lCvlqY4iaWRNWls6KB2OJsCRLXf843nv4y9rewT
 Zh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774528717; x=1775133517;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=he7QyHY1mozAQPBmcK2eUMBc3hnd15+qhW99EarzF9c=;
 b=DiZ2OfETKaJzITJs2Fgb6FazuXvJSN+uoukDilZ9uq4qJn24XVm80s5oxH+6/CASZt
 gRT/mtwqQ4Ebq5TbNFcf2lFBoy3/xgwzwqkytg+Ta2MPRhVu98gwxtRfHOOtHRrt/TN6
 H2x337udEoKHa3CyuNwDidF2FYUYzVmiaE+VWHY/HIXGldT5dy8p4ZSMa1noSjGQRTU1
 zeUQFbz9U4uCH3aSIcZGJsFqzkqCryARNrVDzHgJfRxsFtxyIFkMJdcrCxFafuRm2aLM
 hU38iZtHJMOQ/Y+htWSVg8W4vMfawWca9fRDW8Qz69c09rKiiIS74ePCRdB/yezRWkUJ
 1fFA==
X-Gm-Message-State: AOJu0Yz15B290Q/5RaXUYqNs26O8fWC0Z5PVL+onAfa1KtBmvDyHraGY
 oOkv5tLmc9NczD9Cpr+InJkCcNSIAWEJWQDwM5lg94YhbEvvaOy4xikO1hV5Rcj3Cr7ePyf9Uwv
 pdFrJ0CmrUA==
X-Gm-Gg: ATEYQzzLKiqa6Wr2Mm70Q+wdsJ+YLT3LeJxILp1Z3dvUfc7Vr2yHfd2G0mWeeugGbHB
 5zmPPl86p+kuVPEojNf0DNkMImHQ6gD/ZZ6FwJ5bnO1tt5hbwNHCbBgaC5YQiEcGZ4YoXt1oypV
 W4yuZSvahTH97b0gUERQvavf0Ghe9bKt6Ns6MTIDZj+4rsxZSb7WDA/Q5zyhqLPBvv32pMA+ucK
 60enRSWtt02ZjyFqpMKtS8pzhyxmr10fQvo492lmB3V6HYp4jdMU/cfpVRkNBKSvh998fEGXMFG
 8ySI0r/AKRjppOSPZ/mqIwCy6wl3NBjqddtGsWN7K/G+W0ZeCbLCqPdAQDOpXcxlxvZtWT11Xlw
 hhHlghYYfe2jpXntzZZsmvJyj87VITh7h74oiwsYRNr2oyfz0w6ZSYTQCiFYTyXSDl4c3mwqEE7
 g6MWcrppwmJsS1R5v7hVBKtIuWY2g2BlixV1ujNio/
X-Received: by 2002:a05:6000:3101:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43b889e34edmr12196828f8f.30.1774528716691; 
 Thu, 26 Mar 2026 05:38:36 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919dfb54sm7985134f8f.31.2026.03.26.05.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:38:36 -0700 (PDT)
Message-ID: <69c528cc.5d0a0220.15fc5b.6425@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <33458536-f2e1-4ab8-a7b7-5882481dfa9b@suse.de>
Date: Thu, 26 Mar 2026 12:38:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCj4gCj4gT24gMy8yNi8yNiA5OjM4IEFNLCBBbmRyZWEgQ2VydmVzYXRvIHdy
b3RlOgo+ID4gSGkgcmljYXJkbywKPiA+Cj4gPj4gKwlpZiAocGFnZSkgewo+ID4+ICsJCVNBRkVf
TVVOTUFQKHBhZ2UsIHBhZ2Vfc2l6ZSk7Cj4gPj4gKwkJU0FGRV9NVU5NQVAoY29weV9wYWdlLCBw
YWdlX3NpemUpOwo+ID4+ICsJCXBhZ2UgPSBOVUxMOwo+ID4+ICsJfQo+ID4gVGhpcyBpcyBnb25u
YSBUQlJPSyB3aGVuIGNvcHlfcGFnZSBpcyBOVUxMLiBUaGUgc2FtZSBhcHBseSB0byBhbGwgb3Ro
ZXIKPiA+IHRlc3RzIHdoaWNoIGFyZSBhZmZlY3RlZCBieSB0aGUgc2FtZSBidWcuCj4gCj4gRml4
ZWQgaW4gdjMuCj4gCj4gQlRXLCB3ZSBoYXZlIGEgbWlub3IgZGlmZmVyZW5jZSBpbiB0ZXN0czoK
PiAKPiAkIGRpZmYgdXNlcmZhdWx0ZmQwMy5jIHVzZXJmYXVsdGZkMDYuYwo+IAo+IDzCoCDCoCDC
oCDCoCDCoHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJSZWNlaXZlZCB1bmV4cGVjdGVkIFVGRkRf
RVZFTlQgJWQiLCAKPiBtc2cuZXZlbnQpOwo+IC0tLQo+ICA+wqAgwqAgwqAgwqAgwqB0c3RfYnJr
KFRGQUlMLCAiUmVjZWl2ZWQgdW5leHBlY3RlZCBVRkZEX0VWRU5UICVkIiwgbXNnLmV2ZW50KTsK
PiAKPiBJIHRoaW5rIHdlIHNob3VsZCBoYXZlIFRGQUlMLCBXRFlUPwoKSXQgZGVwZW5kcyBvbiB0
aGUgc3ViamVjdCBvZiBvdXIgdGVzdCBhbmQgYm90aCB0ZXN0cyBhcmUgYWN0dWFsbHkgdGVzdGlu
ZwpvdGhlciBmZWF0dXJlcyB0aGFuIHRoZSBzcGVjaWZpYyB1ZmZkX21zZyBhdHRyaWJ1dGVzIHdo
ZW4gYW4gZXZlbnQgaXMKcmVjZXZpZWQuIEZvciB0aGlzIHJlYXNvbiBJIHdvdWxkIGtlZXAgVEJS
T0sgaW4gYm90aCBvZiB0aGVtLgoKSSBzZWUgdGhhdCBhbHNvIHVzZXJmYXVsdGZkMDUgaGFzIHRo
ZSBzYW1lIGlzc3VlLiBJIGRvbid0IHJlbWVtYmVyIHRoZSBmdWxsCmNvbnZlcnNhdGlvbiBiZWZv
cmUgbWVyZ2luZyB0aGUgcGF0Y2hlcywgYnV0IGlmIG5vbmUgbWVudGlvbmVkIGEgcmVhc29uIGlu
CnRoZXJlLCB0aGUgdGVzdHMgd2lsbCBuZWVkIHRvIGJlIGFkYXB0ZWQuCgpSZWdhcmRzLAotLQpB
bmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAphbmRyZWEu
Y2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
