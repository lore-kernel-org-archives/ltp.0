Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F242CD4851
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 14:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88A9D3C1C3B
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 16:19:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93BA63C1C3B
 for <ltp@lists.linux.it>; Thu, 14 May 2026 16:19:16 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13883600844
 for <ltp@lists.linux.it>; Thu, 14 May 2026 16:19:16 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8b821f39a12so63767836d6.2
 for <ltp@lists.linux.it>; Thu, 14 May 2026 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778768355; x=1779373155; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jQB1LnkQhbRvtIxSlcXTGngmUXRRCcsfPGKCbJM4qA=;
 b=ZmOeYqQu4mOgXozuvrGzYLj6ivd96q7mpo32gNmA4k8JohnPnxf1qi5tyO1GXI5pxf
 s7WS02HRMGeqjlS+xJNYTIIvlRwNPgoTpC+UkBsJenjuE4VsHODbWpPUbcAXRP0IvG9j
 tPrbF9y5OdhPpBQR6GQWR8nht3pAX0ESR4F3amzhw3fAn8fKlsdPMFJAkcPW/Pxs3GwP
 qm5pL8xJYancBKqGLK84FxbFXjf7f+96ryN7TDe1GqrbB+Tzj/uIEbfBA+bu+/BkpLTn
 eSSNUtZ9NvAdGyGk9ezcEkhGTXShup4zVkisiF6rJiInlios+JUUw+D55OIaldLpJEjB
 IyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778768355; x=1779373155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5jQB1LnkQhbRvtIxSlcXTGngmUXRRCcsfPGKCbJM4qA=;
 b=RVijEfgYJszd/NYcWrSODKNYbIbxZnEpssEwbVsL8XOyTBQLy86H/BMC4vJCoj9IGs
 6FqdK8IODYvmnlm5vM54oYm9U4KdEej0U5OK4G4dScw+53QOkplSqTuYCG00HFELOIwT
 Yp8Nnjs6LgdndkDlOM2NVqwjg3xhOtdSLWSvGXXVcpnQSbbfPc8NCsluEA3//JcXbGl4
 tCHTzkRlQF2XYB+xcgW08kvCQLLf+lBIVRYCo/qa5GVd/aNGct/ZJlUGggpJfFzE/iiM
 6XO5Ufz8bsVddeAQBSfzFozkzvSYMuvxhuzUigCiYbaoJa5+awrMYBIICZEydUbEkPI+
 PnFg==
X-Gm-Message-State: AOJu0Yz3oMSKsAgi8uliXLz/PxVFyoXDdufH4+IM3e9McjtAlrihHM73
 nJ9kagUkYkA8uRkSmyZJsjR0aMw+0aq1og36N5fHB+VdizTG77Pzkbtu
X-Gm-Gg: Acq92OEnndxnSmwreX//ynis0bgJlzREKWl6Ct1mmiRWSATBT2ZWuh2sUQmBIiuDUp6
 Qsuvk4ZA95uQvnxyuHJNXl2e/cTCmcPR0p/U2c5ULrcnjtlfI3MWh4w2GG9yO6EVbweysLK5BJp
 2cdY0yZOLXvOFUEaNpw/fufnGjom29Y3kSVU/vljIRyI5znLGV403+tQE/5szd5wIk8tKBanThX
 birx8nmJ+mYSKXVSKUlFPNPYtCuwBiHlUxBvZihxVUjMyh8IPaSDscIPJggF6cWHXkXcrBeBIyJ
 Ze7nrK0e5bD0tnk8MCrekw/rYuUeXNfvG4HTCTV+LsUGfv6x5Zxd24QDh7LPPY4Pp6vFTVp5IgK
 Uc34hH8XbrSeDlXIsvp2WsFxA0syAbRwqdb3jtcob/NIOT3CnrFDGlrgI04590c7ZB3pGWlTbEt
 OeyXBi053jnlBgY+BN7+G8cciyN2uTfmnDI6Z3UKkwprVtJvH2T6wvKwpiVIebCNNFzhp+9s8op
 bKy1WtN4Pm08S4f943FWku1I855uHSFsKffKTV1fN2+JluBLxKuKpEOXkeNVQ==
X-Received: by 2002:a05:6214:3f85:b0:8b9:428a:e640 with SMTP id
 6a1803df08f44-8c7b92c5a91mr128840926d6.2.1778768354770; 
 Thu, 14 May 2026 07:19:14 -0700 (PDT)
Received: from
 runnervmeorf1.t3oumd1fll4enhbzgildoccnla.ex.internal.cloudapp.net
 ([52.240.176.168]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908e11929sm24614976d6.14.2026.05.14.07.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 07:19:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 14 May 2026 14:19:12 +0000
Message-ID: <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514133446.144550-2-piotr.kubaj@intel.com>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

SGkgUGlvdHIsCgpPbiBUaHUsIDE0IE1heSAyMDI2IDE1OjM0OjQ3ICswMjAwLCBQaW90ciBLdWJh
aiB3cm90ZToKPiB0aGVybWFsOiBhZGQgbmV3IHRlc3QgZ3JvdXAKCj4gKwl3aGlsZSAoc2xlZXBf
dGltZSA+IDApIHsKPiArCQkuLi4KPiArCQlpZiAodGVtcCA+IHRlbXBfaGlnaCkKPiArCQkJYnJl
YWs7Cj4gKwkJc2xlZXAoc2xlZXBfdGltZS0tKTsKCkcyOiBzbGVlcCgpIHVzZWQgZm9yIHN5bmNo
cm9uaXphdGlvbi4gVGhpcyBpcyBub3QgYSB0aW1lciBBUEkgdGVzdCBzbwp0aGUgRzIgZXhlbXB0
aW9uIGRvZXMgbm90IGFwcGx5LiBDb25zaWRlciBwb2xsaW5nIHdpdGgKdHN0X3RpbWVyX2V4cGly
ZWRfbXMoKSBvciBkaXNjdXNzIHdpdGggbWFpbnRhaW5lcnMgaWYgYSB0aGVybWFsLXNwZWNpZmlj
CmV4Y2VwdGlvbiBpcyBhcHByb3ByaWF0ZS4KCj4gKwkJCXRzdF9yZXMoVElORk8sICJDb29saW5n
IGRvd24gZm9yICVkIHNlY29uZHMiLCBDT09MRE9XTik7Cj4gKwkJCXNsZWVwKENPT0xET1dOKTsK
CkcyOiBTYW1lIGlzc3VlIOKAlCBzbGVlcCgpIHVzZWQgYXMgYSBzeW5jaHJvbml6YXRpb24gYmFy
cmllciBmb3IgQ1BVCmNvb2xkb3duIGJldHdlZW4gem9uZSB0ZXN0cy4gSWYgYSBub24tc2xlZXAg
YWx0ZXJuYXRpdmUgaXMgZ2VudWluZWx5CmluZmVhc2libGUgZm9yIHRoZXJtYWwgdGVzdGluZywg
dGhpcyBuZWVkcyBleHBsaWNpdCBqdXN0aWZpY2F0aW9uIGluIHRoZQpjb21taXQgbWVzc2FnZS4K
Ci0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4g
VGhlIGFnZW50IGNhbiBzb21ldGltZXMKcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2gg
b2Z0ZW4gaXRzIGZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UKZmluZCBpc3N1ZXMgd2l0aCB0
aGUgcmV2aWV3LCBwbGVhc2UgY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUKc3VnZ2Vz
dGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
