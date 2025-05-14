Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E89C3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219880; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=saizfYXhkF+y+tk2Ye76CJ2yrYQMovlJm1CGN1WF7x4=;
 b=UFETbc2wuofKkcwgSgPzxG+NGXmfnfB+taZgt+HBAZwpa0QPRayXiA7CrEhxrBX0n3GzF
 EAqynNWrb3BqqhISsb4FPqJ+QuMESWoI43v0YhOxQZjB8NND7SdDAci/kTEaxXVEyD3KxBi
 MS4GrNJXVcKL4huzdE1/Pm/OkATK33E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5174C3CC3B3
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:51:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B3C53CC3B2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:14 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0609B1A00ECD
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:14 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so4078860f8f.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219813; x=1747824613; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EhgDmVUoVsGKgQuDyANCk2TE2g0LZumkn3l+Zu7flI0=;
 b=PrZ2IyAab4xbawj7oou3Tb6+9s2gYfKDEZ3BbZRB7ICBy9bkjrlWU4WcznUfbEgubO
 +r7Fv66JVukhCPfAnMDvpOpKCN+KVWZwez45VrRkKLb6BYNy9h1kbhMq2uJUGQ1HnZzv
 VUObnXg8QZxXyXcdljU4XDbFvsImMHGToAlehkV7tENRsj+hXMS9ezqu7lWDUXDfGAkW
 hVgphbIkpnZ2Xs86mQMatEcb2X6NjvaiAVIxsnHqHdM6vRK2PUB6DvTrWI1dZbU64/+D
 USh81gmMt2qR4rq0i8DfFkzwOs1/7jE+Z8qNwcQDpZqcMx12hVrDdcmN1imAU1e+3z3l
 4g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219813; x=1747824613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhgDmVUoVsGKgQuDyANCk2TE2g0LZumkn3l+Zu7flI0=;
 b=udZUcE9BPwIxp+mcfp+6dCgclr9/AWBkOaJv/ZuqpGgAREF1W5tNwbTun38eQdGvqI
 gekQXPYeiCVbiS09OJHfQ/1dDRgaIJw03YJFLLN4uXPjhqzaYZ8/QGmW5cMf+08Ry591
 ramj2UvRA0SiqcmO0ZZoiG+SqtrvNb6u/VOuPygpzlZ15vLZ9koMTqDvH5v5g9haVPbv
 GfViFykQIKxy03juORKpArJo/KSu2S2VxYQXEU+s0XDvSPChZl43Z8HSdsEYnVGkd2RO
 S6Kd5WdjXhJbO0c/TJhLODeHvfG40tSDMhBdkagaYp1ZXuPriKNe1mcAHuVWJMB/Ukc6
 XoxQ==
X-Gm-Message-State: AOJu0YxJMgL5gVyVKH4H9jWSqKf+Y9kKML02UtOKTtPrYhbEVNjFucsy
 T3XbMCZGkV6qfRQzyMrmlxn8yUQWS8YSvuOdHqLvfHjp85rM+rKR2H0wMezfG7Nmx1jmHjJKZ22
 l
X-Gm-Gg: ASbGncsT9qRUY0YeMY93mnMdJT6VJeWPckAnXVyx9+jJhxUcoM3D0HHu9UY6Ypyisc7
 dyr/DXvIasXTUet9ev1gRANOSkuMOPYR2rkC9kPjpWA2EdiDI49D6crg9ctmKiER1bsSOeL2FUJ
 MBzdizYOIF9BdK7CShpWn0/ANGCWMhgUtoD2Be0Ziws1Do5e04MOSjXRY3wZkYgyS60HEJio8Jo
 MLg8//AdzQeyUV4K7JO2DosOL84oeFuWHgSiuzsPv1NecZ7T60tEDJbImhHizRb/rOASWlWQdyH
 V2Hyjt78EhDaO0y5tVGOlbD1vr3dZDtIZy6yvko=
X-Google-Smtp-Source: AGHT+IGhHXFTy/g9ZQH8HkxXany5l+NEjky9lDqNs+qCCX6HJK7M3O6KiSeFHoFyc8vL+pkJqLM8tg==
X-Received: by 2002:a05:6000:2901:b0:3a0:8842:f7ce with SMTP id
 ffacd0b85a97d-3a3496a692emr2094196f8f.22.1747219812648; 
 Wed, 14 May 2025 03:50:12 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52c7ff62bbesm4514210e0c.29.2025.05.14.03.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:12 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:55 -0300
MIME-Version: 1.0
Message-Id: <20250514-conversions-kill-v1-2-cd633e941e8b@suse.com>
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=rbm@suse.com;
 h=from:subject:message-id; bh=tzuQpul7c36qE8RKsmFmrM4sVS6Jv+IGQ5N3+473bec=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVafHPrQQGn7RqyHpXxIyhvHMx8JJq0OpYcQ
 X+QphW3Ox6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WgAKCRDJC4p8Y4ZY
 pgnRD/925xJE3jZ9nbvvNZGHw/EHSvWtDySMR3eXKkfgKYUERWqtJlMv31VPS0CtLFDPUCblIvC
 8FIYwD2qAQuKB4mkIePN9vmZN+7wgLOecRiV3ZY4MlcIO9uRIlGMUwi+IrWJeoEprRueHXSXTE1
 nt5GdPAwdMyVGqstZ2C1JOATx9dhBvuOCcyEwRIbxTRuFPQfDUJ+Hl6iLgUNTHGZKmX6QN1Igq+
 4etudkwzhlXcVzbC5n4SpgUTyVkkmWT6V/FZ/T/zFBysGZl8vN9HhCLQId64vRpBAT4hUYL0keO
 foNzDtWfAx7V6dCBd14Xeo9pgWgKSYhvRqVBmkC+mabOQOqf/ZgoTtUJLxe7opRU6bZi6gZgdcX
 HLYT9mY6E9N/MJ3F2cDTlxkfTKCvsluvYi61D3R7FAbBAO8FJjCvuXA2AMKfgSmz8tEjeXVWmWu
 SRQEyrre7kL0JeIMLKvIKNfHmqq/W03Q8uRUvqIRp+3HiqFw3RLo5SKCl6q+zHI09WDMnl8Z2vJ
 w+tbgvlOb+/d4fVrKkN5YuIvSqVY4oYFUT4KnMVdVPp85jOGbcyWx11IfezRGpULhHJSQ4dCFyt
 Niq/ONg/axSN4KiVUnSM/6/MQHFXvoL71JfMVpQkDZC62jCcXos9xcVvfhdohioC9YFb82cDMKb
 yYoD7qXP9gxbe0g==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] syscalls/kill05: Fix test description metadata
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
bC9zeXNjYWxscy9raWxsL2tpbGwwNS5jIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9raWxsL2tpbGwwNS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9r
aWxsL2tpbGwwNS5jCmluZGV4IDhlYzcxYmU0OWFiY2JiMDcyYjg3NDRiNWRlZTI5ZGE5NTQyOGE2
NGIuLjNjMzE3ZTJmY2IwOGM2NDUzMWI1OTdiZTM3ZjM5ZjJmOGFiM2Q0MTYgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUuYworKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA1LmMKQEAgLTIsOCArMiw2IEBACiAvKgogICogQ29w
eXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMQog
ICoKLSAqIFRlc3QgY2FzZSB0byBjaGVjayB0aGF0IGtpbGwoKSBmYWlscyB3aGVuIHBhc3NlZCBh
IHBpZCBvd25lZCBieSBhbm90aGVyIHVzZXIuCi0gKgogICogSElTVE9SWQogICoJMDcvMjAwMSBQ
b3J0ZWQgYnkgV2F5bmUgQm95ZXIKICAqCkBAIC0xMiw5ICsxMCwxMCBAQAogICogICAgICAgIHNl
Z2ZhdWx0IGluIGNhc2Ugb2YgZXJyb3Igd2l0aCB0aGlzIHN5c2NhbGwpLgogICogICAgICAtIEZp
eCBkZWxldGlvbiBvZiBJUEMgbWVtb3J5IHNlZ21lbnQuIFNlZ21lbnQgd2FzIG5vdCBjb3JyZWN0
bHkKICAqICAgICAgICBkZWxldGVkIGR1ZSB0byB0aGUgY2hhbmdlIG9mIHVpZCBkdXJpbmcgdGhl
IHRlc3QuCi0gKgotICogUkVTVFJJQ1RJT05TCi0gKglUaGlzIHRlc3QgbXVzdCBiZSBydW4gYXMg
cm9vdC4KKyAqLworCisvKlwKKyAqIFRlc3QgY2FzZSB0byBjaGVjayB0aGF0IGtpbGwoKSBmYWls
cyB3aGVuIHBhc3NlZCBhIHBpZCBvd25lZCBieSBhbm90aGVyIHVzZXIuCiAgKi8KIAogI2luY2x1
ZGUgPHN5cy93YWl0Lmg+CgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
