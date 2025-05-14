Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94271C3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219856; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cMMTfv9bQLoucJgO/0mfR6beymqDkq9u+CM1uqW1WTg=;
 b=bXllxR8oTs9GTIPEBORj4NV1V8T1mLLAtyCC9FVJFO8UPAyrFuxh5NAfpm25h3tQuzHwN
 o54SSlul+/So5ZMOP0Vo4fnWQYcjUv9ZZ3SWwMAdAu/oet7rPXCkZcEbhSiexaTrcFeaekO
 oc4cgBeWjX9D6ASUboTFZ+HfZW8EWFM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AE0C3CC3B3
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:50:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 688A43CC39B
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:11 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BF15600CCC
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:11 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a20257c815so3700904f8f.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219810; x=1747824610; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LGH5ksB8xxBg8POtAXlN3SLf23OBnoNxfczAM1F8RVQ=;
 b=biAO17sllxSM24tmh1ZM/hNX8/oBuM2N5xeDSL6CfWv7TL9/Z8uHrKvzaeJIZmKfZT
 jOAP/xaze9fMF1CMaIpv/WbGLPYSgH7t5gvkGebR6nZfud2xPiFVM9yY6uhPt6s2fReg
 A2jGqKLv/X9cGVposcocNiaV+vPLYr7F4AcOE99yGmapf39r0dG9K1UjD1VXNWIGPqv9
 mO27G/XYRWVwm/2IVwRElpmDBWAiB6hp+l2I9EShS8H+Y5hEbjMo3DgUDlBcElBG4WVy
 vJ8HXg2S8Ojl8/qlJUdFZoJLpIlUdRt2xnHzhkQCEfPllrPnzx7ukESPthUQv2SA3Uq6
 Jlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219810; x=1747824610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGH5ksB8xxBg8POtAXlN3SLf23OBnoNxfczAM1F8RVQ=;
 b=F4cyPX2Gzkq26W93uKf9FSR60dVMDMs0tvxrcB9X0xPrxM93hx6GAoGNmftsOmsLXU
 lJscfs36vaQwlAe+bKcxUQTV1UgzEGOkbCVcjtrgKPf7f7dDu9FUcrTvMO/rV+HLH0th
 AdFsDda4OVwnK3vhG4WDYOseTztpTHGTJF5mLgaqMvF7xEeIVT61hEksnNKikH+v4ba1
 M+2sUc71+b4kKl0h7AlTfRDRh5tTqW9FKpNhsaqUiXMo6p8QkNuWYWwVzBbNmPQGD0FP
 LyvwsgI/MI6kuJ9IUIWHbjyoYH+3RiwY1VsFiBb2mvyZ5uuUiB/Qrp5/nDhhejENXOKn
 /+Kg==
X-Gm-Message-State: AOJu0YwdiY22XDOd2yLyyniA4n7c0dovV9fOIxLkX6K9R/hcYd/2/f+m
 H280cb+PXA9CzM96rFBdn+RFSJYk9jY5klJoFX44SlhocFBTBy83j/GaVrQeBKT29Lvd/rwHnAq
 w
X-Gm-Gg: ASbGncsKDW29KxfI/lWewE5BLW6/IveZ6qj7N/0de5ayfAf8KR0rAtKWQjnMpKUllaf
 zmhbR+5Lk1E7q/x21A4o3wISstxDfZ0IH2W+dMGffKbK7DGENxrFteO/FDVQyEZf3KOEImhU2ce
 8FBy5+pIKtH5pgOgAnFo3yTYKfgWw/OyzjT3vn7eykdm9L3N/Qy/JtLASFCzaai5c/BRMFfI2ro
 NOEp+86hkj+E8w5OeuWvsNyu1OI4GEIecHwPUwGPZAPcZ5qeFMSys6yEAHTzW79UYXcBovLvc4N
 /E3QcU/B6a8TcaEnacR1dvhEFlExRvs2at0Dd7g=
X-Google-Smtp-Source: AGHT+IHryVuO5yjFXS2BN0G8Mzq+3C3CwVZhzt3FgSTjEVr+wllkUzFdjtEmVwaYvja9hyH6lny3hg==
X-Received: by 2002:a05:6000:1843:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a34969003amr2342233f8f.4.1747219810143; 
 Wed, 14 May 2025 03:50:10 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-879f613b5d0sm8346250241.6.2025.05.14.03.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:09 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:54 -0300
MIME-Version: 1.0
Message-Id: <20250514-conversions-kill-v1-1-cd633e941e8b@suse.com>
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=rbm@suse.com;
 h=from:subject:message-id; bh=alTAABCYw+zuxBuWfWBuB3caQcLu2tGKvFd64XNbJYE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVZE02PjLswBWTbbWEDtm2XEHM3cfjuvb6tO
 Lj1m2e4FJuJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WQAKCRDJC4p8Y4ZY
 ph5NEACrBwm/VGg40noz0qorghsduZILF/nsMaY+m2NSpnPlMunBh7vDCMIGqA0O13Jzot7vUJm
 CZVy7gbjrSJfAqUv7RBH2aoQLZOcScMmvom/FRI5VQCM62617E2m737A5otlGkJViBQuE5vNXKZ
 NB8UezfA9amW+h11PZQEHKTgBf4apWFsiug3XYzZOc5Hm5Ki8ZjpSt7GZpZQuFMwbH4U2HP3wVd
 gBVQ5fGMOdaff3JIrgrDPiyoq00cFdd67vELdz48AIJ+R30MWQeLL3108Se0bS7wbWBoBbwTE/J
 x28McQKGMJVQvIqYPb0rHYY1uUCoRKAM1JMJNGa5AUajpOePfFi36TF6YLb1p08Q+f1GVMI+eGj
 tCWaqngLZ2chVebUdFWHo+fVw5eDJCdmvfOk2LzAXC+dU98/RCTJ4++yAyP2R3k0dQz/bn/CIfF
 waSV5KehMtaw2je0P4sZfRutO0cKuA/bXmSy2JGZuKinPCgkX5ZSFujC45h0ooJ+3K2nWqbSnxC
 V4gvrM4/bveyeVRJ0qsLvN1c9Ev1G0sSQmzYHJjiVn97pgzNbjXk00fmjDImdybLuCQXXOY6G6i
 WxXzc7Ine5+1wvx/lY8dTQ5Cmt1RsdrD2EkA3O40pdmcJXlhBKG29FEDmdQkAb/dKAEKjep9eVy
 FWbee8rJv1fE+Ng==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] syscalls/kill03: Fix test description metadata
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9raWxsL2tpbGwwMy5jIHwgMTQgKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9raWxsL2tpbGwwMy5jCmluZGV4IDdkMzA3MDY3ODU5ZDQ1ZWM2NDU0MmUyYzJiOWU4OTdm
YjYxOTFiMjUuLjhkOTFjYzYxNTI5NGM2Y2JmY2MwYmNmYjhjMGQxODI0ZGE2NDVlMzUgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDMuYworKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDAzLmMKQEAgLTEsMTUgKzEsMTcgQEAKIC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAvKgogICogQ29weXJp
Z2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMQotICoK
LSAqIDEpIGtpbGwoKSBmYWlscyB3aXRoIGVycm5vIHNldCB0byBFSU5WQUwgaWYgZ2l2ZW4gYW4g
aW52YWxpZCBzaWduYWwuCi0gKiAyKSBraWxsKCkgZmFpbHMgd2l0aCBlcnJubyBzZXQgdG8gRVNS
Q0ggaWYgZ2l2ZW4gYSBub24tZXhpc3RlbnQgcGlkLgotICogMykga2lsbCgpIGZhaWxzIHdpdGgg
ZXJybm8gc2V0IHRvIEVTUkNIIGlmIHRoZSBnaXZlbiBwaWQgaXMgSU5UX01JTi4KLSAqCi0gKiBI
SVNUT1JZCiAgKgkwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgogICovCiAKKy8qXAorICog
VmVyaWZ5IHRoYXQga2lsbCgyKSBmYWlscyB3aXRoIHRoZSBjb3JyZWN0IGVycm9yIGNvZGVzOgor
ICoKKyAqIC0gRUlOVkFMIGlmIGdpdmVuIGFuIGludmFsaWQgc2lnbmFsLgorICogLSBFU1JDSCBp
ZiBnaXZlbiBhIG5vbi1leGlzdGVudCBwaWQuCisgKiAtIEVTUkNIIGlmIHRoZSBnaXZlbiBwaWQg
aXMgSU5UX01JTi4KKyAqLworCiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8c2ln
bmFsLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
