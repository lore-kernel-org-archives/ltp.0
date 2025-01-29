Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAD1C02190
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 22:46:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CE313C6FA0
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 23:46:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12C983C6E52
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 23:46:37 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7ED7864C1AE
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 23:46:36 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso149507f8f.1
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 14:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738190796; x=1738795596; darn=lists.linux.it;
 h=content-transfer-encoding:content-disposition:mime-version:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bq5HSBH3IUQQ6t95U9MV+TMJF2wzLuKzSVhBRPVa0Vk=;
 b=B5yiZPjbQ4Yxm60MdW4ouuI8FwizB5u6Et3LROViHFyAq0dxoSE09LJ9DpLTMqNetp
 FvqMQz6RgAwF4ka2niZm43DNhKWCf3eD7uspi+rTW3jcEJ5etSGY9SK9s96T11RGXQZT
 ieixXxoCbM0LYzU8jpSJbayRXMnmrGw3SYPxdiRLjcFPlQ93xQJHXUWNTlfG65py9Pa7
 qLZMNAx1UkL5Q3bFGASzl7A3WFsLeq0bar/4JhRLKn/WFOsUjXih49rIm4cTC6PBO81m
 73VuWjJb36DpzDNh1yCSIQ+3LHIFvSN78DcGvVsS3tTug539M0QfK6JJxOwl6oe1ldTU
 FKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738190796; x=1738795596;
 h=content-transfer-encoding:content-disposition:mime-version:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bq5HSBH3IUQQ6t95U9MV+TMJF2wzLuKzSVhBRPVa0Vk=;
 b=F/YFrhe82jbDy564HHRGRryn74Hdw6UJmGKF4Vty22G7MRTPZ8kj8hoYoCR50lZzOK
 xoHH9G8Mimy/RNxKzx2Vj+NA23yPpUoDaI+1SubdOXsCz5AKJ+nqpF2lindrmciNMVcW
 KZXQArIvhXYn0sryPzTbAsyMrq3NQf6x9fm9njJInIxUm3hKACDn/4xxuxu3hiy486Gs
 KUontNT42FAUO41XLLrxvrhMfGI/rlsRGLi6s01f3571LYvNnFzp/imxd5MGneWKNIYb
 YiVgp1NrCTH4EMNmjxAgK9lAR8pISFhDsI1RpQYLLH/2cgSOsFZ6ZsvIAzeojypbEgqu
 cT9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZTBjG3bSYfJrOk13/BbKFn2mMXUQWa1cbKWoFwKSFG347ZABz5EbuAQPsBq0cA9nxOWs=@lists.linux.it
X-Gm-Message-State: AOJu0YwR44dNfLJk8BIM7ROFEFtRviccnZKH7dOkpqHHr8URSXJOWWMF
 UFZbSSMVR9GgkAPhjvJEplMxNkbNDvCJRW3XmjinCxK3GA1DLKyq
X-Gm-Gg: ASbGncufR5sc51lN4VoGpGsm2cHPKtRTLqT2JM+OJn9iRhjklpZs/iRy1Pokn7/0Rsx
 0Culb3m1riUEiCDfkWTCfeOklFHYX4eAiIwoQDlqFqWizVIKPThnZffRF7ztpcVOrDMsaH9HzN0
 0jWSVWrQHJNtdR8G+4DNjqcMNtClT8aAsxQbrmJ5byfEmz1YrndIRUuyQQWv2bNAJSwhA5jY1hI
 YwNhN20p5PXK1/mZ0wRQWNjfexB68NIsxiZYnRv8pLO0gcm5eNozlCt/buOTnv3+oDPWkkf3TFK
 rA/rIGgLYJm/uBx7qoxt
X-Google-Smtp-Source: AGHT+IEMEXjwXlRQfN7vWeuXK/GlMDRdhd5em34babQOjlNDCktXzG2ivOzywizd/lCfyORLH3bH7A==
X-Received: by 2002:a5d:4f90:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38c519526edmr3798383f8f.20.1738190795618; 
 Wed, 29 Jan 2025 14:46:35 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c125f0fsm120379f8f.57.2025.01.29.14.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 14:46:34 -0800 (PST)
Date: Wed, 29 Jan 2025 23:46:31 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: buildroot@buildroot.or
Message-ID: <20250129224631.GA452802@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP test fstatat01.c FTBFS on Buildroot bootlin-sh4-uclibc
 toolchain
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: devel@uclibc-ng.org, ltp@lists.linux.it, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKTFRQIHRlc3QgZnN0YXRhdDAxLmMgWzFdIEZUQkZTIG9uIEJ1aWxkcm9vdCBib290
bGluLXNoNC11Y2xpYmMgdG9vbGNoYWluCih1Y2xpYmM6IDEuMC41MCwga2VybmVsIGhlYWRlcnM6
IDQuMTkuMjU1KS4gSXQgbG9va3MgdG8gbWUgdGhhdCBvdGhlciBib290bGluCnVjbGliYyBiYXNl
ZCB0b29sY2hhaW5zIGFyZSB3b3JraW5nLCB0aGVyZWZvcmUgaXQncyBwcm9iYWJseSBzaDQgcHJv
YmxlbS4KCkxvb2tpbmcgaW50byBpbmNsdWRlL3N5cy9zdGF0LmggaW4gdWNsaWJjLW5nIFsyXSwg
ZXh0ZXJuIGludCBmc3RhdGF0IChpbnQgX19mZCwKLi4uKSBkZWZpbml0aW9uIGlzIGd1YXJkZWQg
b25seSBieTogIyAgaWZkZWYgX19SRURJUkVDVF9OVEguCkJ1dCBpbiBnbGliYyBpby9zeXMvc3Rh
dC5oIFszXSBndWFyZGVzIGl0IHdpdGggIyAgaWZkZWYgX19VU0VfVElNRTY0X1JFRElSRUNUUwph
ZGRlZCBnbGliYyAyLjQwIGE0ZWQwNDcxZDcgKCJBbHdheXMgZGVmaW5lIF9fVVNFX1RJTUVfQklU
UzY0IHdoZW4gNjQgYml0IHRpbWVfdCBpcyB1c2VkIikKd2hpY2ggcmVwbGFjZWQgcHJldmlvdXMg
X19VU0VfVElNRV9CSVRTNjQgYWRkZWQgaW4gaW4gZ2xpYmMgMi4zNCA0N2YyNGMyMWVlIFs0XQoo
InkyMDM4OiBBZGQgc3VwcG9ydCBmb3IgNjQtYml0IHRpbWUgb24gbGVnYWN5IEFCSXMiKSBbNV0u
IFNob3VsZCBzaW1pbGFyIGNoYW5nZQpiZSBhZGRlZCB0byB1Y2xpYmMtbmc/CgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCiQgY2Qgfi9ici10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xpYmMvYnVpbGQvbHRw
LXRlc3RzdWl0ZS03Mjg3NTk1MDZjYmUwODYxMjE4MzI3NWIzNTQzMDA3ZDFjNDdmN2Y0L3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZnN0YXRhdAokIG1ha2UgVj0xIGZzdGF0YXQwMQpici10ZXN0
LXBrZy9ib290bGluLXNoNC11Y2xpYmMvaG9zdC9iaW4vc2g0LWxpbnV4LWdjYyAtRF9MQVJHRUZJ
TEVfU09VUkNFIC1EX0xBUkdFRklMRTY0X1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1E
X0ZPUlRJRllfU09VUkNFPTIgLUkuLi8uLi8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5j
bHVkZSAtSS4uLy4uLy4uLy4uL2luY2x1ZGUvb2xkLyAtRF9MQVJHRUZJTEVfU09VUkNFIC1EX0xB
UkdFRklMRTY0X1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0ICAtTzIgLWcwICAtSWJyLXRl
c3QtcGtnL2Jvb3RsaW4tc2g0LXVjbGliYy9ob3N0L2Jpbi8uLi9zaDQtYnVpbGRyb290LWxpbnV4
LXVjbGliYy9zeXNyb290L3Vzci9pbmNsdWRlL3RpcnBjIC1nIC1PMiAtZm5vLXN0cmljdC1hbGlh
c2luZyAtcGlwZSAtV2FsbCAtVyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1zdGQ9Z251OTkgLUwu
Li8uLi8uLi8uLi9saWIgZnN0YXRhdDAxLmMgIC1MYnItdGVzdC1wa2cvYm9vdGxpbi1zaDQtdWNs
aWJjL2hvc3QvYmluLy4uL3NoNC1idWlsZHJvb3QtbGludXgtdWNsaWJjL3N5c3Jvb3QvdXNyL2xp
YiAtbHRpcnBjIC1sZnRzIC1sbHRwIC1vIGZzdGF0YXQwMQpmc3RhdGF0MDEuYzo2Mzo1OiBlcnJv
cjogY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmGZzdGF0YXTigJk7IGhhdmUg4oCYaW50KGludCwg
IGNvbnN0IGNoYXIgKiwgc3RydWN0IHN0YXQ2NCAqLCBpbnQp4oCZCiAgIDYzIHwgaW50IGZzdGF0
YXQoaW50IGRpcmZkLCBjb25zdCBjaGFyICpmaWxlbmFtZSwgc3RydWN0IHN0YXQ2NCAqc3RhdGJ1
ZiwgaW50IGZsYWdzKQogICAgICB8ICAgICBefn5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSBi
ci10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xpYmMvaG9zdC9zaDQtYnVpbGRyb290LWxpbnV4LXVj
bGliYy9zeXNyb290L3Vzci9pbmNsdWRlL2ZlYXR1cmVzLmg6NDA5LAogICAgICAgICAgICAgICAg
IGZyb20gYnItdGVzdC1wa2cvYm9vdGxpbi1zaDQtdWNsaWJjL2hvc3Qvc2g0LWJ1aWxkcm9vdC1s
aW51eC11Y2xpYmMvc3lzcm9vdC91c3IvaW5jbHVkZS9zeXMvdHlwZXMuaDoyNiwKICAgICAgICAg
ICAgICAgICBmcm9tIGZzdGF0YXQwMS5jOjI3Ogpici10ZXN0LXBrZy9ib290bGluLXNoNC11Y2xp
YmMvaG9zdC9zaDQtYnVpbGRyb290LWxpbnV4LXVjbGliYy9zeXNyb290L3Vzci9pbmNsdWRlL3N5
cy9zdGF0Lmg6MjQzOjEyOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhmc3RhdGF0
4oCZIHdpdGggdHlwZSDigJhpbnQoaW50LCAgY29uc3QgY2hhciAqIHJlc3RyaWN0LCAgc3RydWN0
IHN0YXQgKiByZXN0cmljdCwgIGludCnigJkKICAyNDMgfCBleHRlcm4gaW50IF9fUkVESVJFQ1Rf
TlRIIChmc3RhdGF0LCAoaW50IF9fZmQsIGNvbnN0IGNoYXIgKl9fcmVzdHJpY3QgX19maWxlLAog
ICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KClsxXSBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZzdGF0YXQvZnN0YXRhdDAxLmMKWzJdIGh0dHBzOi8vY2dpdC5vcGVuYWRrLm9yZy9jZ2kv
Y2dpdC91Y2xpYmMtbmcuZ2l0L3RyZWUvaW5jbHVkZS9zeXMvc3RhdC5oI24yNDcKWzNdIGh0dHBz
Oi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWJsb2I7Zj1pby9zeXMvc3RhdC5o
O2g9NGJlYTllOWE3Nzg1ZjUxYWY4ZWVmZDAzNTg3NGY0NzViOTJiYjI2ZDtoYj1IRUFEI2wyNjgK
WzRdIGh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWNvbW1pdDtoPWE0
ZWQwNDcxZDcxNzM5OTI4YTBkMGZhMzI1OGIzZmYzYjE1OGU5YjkKWzVdIGh0dHBzOi8vc291cmNl
d2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWNvbW1pdDtoPTQ3ZjI0YzIxZWUzODcwMWFlMjc1
YWE5ZTQ1MWY3MGZhM2U3NzQ3OGMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
