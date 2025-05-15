Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531E6C2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747300352; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RrvYTBsKGHtcNzD+bMxxYtyZpYiMwHFFRjr7XLNQx74=;
 b=DwY6RJImBcSSXEdg6SgisqMOOhPGQwRgv/XVKJwWkfk8eWz3h3ZgBf9WqU6Z8EOPbhnEO
 6cy0T27yobxsTKcqsBi501VDEv4CFc5jSW7WTSn2twPahc1HMbSpTXFTy+T6zcmBA8ccxwD
 LThz+HMXdLQFjcVuSd7XS9v32QPdx0Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05873CC488
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:12:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 321863CC477
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:46 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EDC8460057D
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:45 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a35b7e60cbso41784f8f.1
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747300305; x=1747905105; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ndkgLd06Wzyar4XwbK9b+5PLWnMA6q3Fhol0YFkjvps=;
 b=RaWAx18XHa08HjfRzrKfkVHXBIM73LQuXrcByocf9HlpAqSvX26/f4NbpQkaI7i3CL
 /ojqyBIxMlBoZATmCs0/n6PyEsxqN+NWbYSH1QjAOC3/iHjEZ2u24lrXvR7MjeSF0Kye
 GzKS4tPhlxv/hajOsDY9caV0iqpx5E0L0Wo9WcxTKcjy/6n7Fu3nNwrqHyw/JlgwusXk
 IgthpDFsuVtJ5zPNUDmltLMNVDUju13Ghj4m71o1IQL0kRdac+H0SK4myBrQ6VvihtTK
 XoghzA26O8npGv/opyJo0x2lxpck9Rqb1BAElCItZIE+ox3gThmgGpPl3vYSQ+RsDha2
 Q5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747300305; x=1747905105;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndkgLd06Wzyar4XwbK9b+5PLWnMA6q3Fhol0YFkjvps=;
 b=iBoB9/mOP0JTShrKHDoCY4kb8GGSWfLG+p/8KWHe731en9FKBklTurt5NCd4LyskNM
 Q2femfeuajWjrYzte6b3JB2o5GuJBj6SPpPJND5EggNxOHq3PnKuRlZXmESvcuxedXjD
 ks1PDqvMjHRJt8y3BO5a/I21JTHEU1i1/Tydtr9yZ2jkcIKmls1HTvtMeuLa5Q89hFBd
 1BiAPGXiU10HL0vj5dRF8YPITiypsN+BIh+3vsytl9jc/RVxX9F5ShA3HMZHQ9ntP70h
 tMOB4fO+mNogY54DNWwuPsVtapYFRY9FOZYplZTQZaSHTnOE0jHj5IY1T6wCauml5nQp
 EofQ==
X-Gm-Message-State: AOJu0YwMOHl/WyRQh8wEo2GmHBpu5ZMMF6XIZdSjehkEcrSsyFyNF3W2
 Xh9CztFTQPuqXdoYHTISZhtLmTdOGnRvR86BB+XdYH3tr7BkEyw7LOef+MwxIlaDp7TtWiBl6DA
 nauYK
X-Gm-Gg: ASbGncvmsZ81kxPtBsaIF7uF3701qoh2kQgeCfvNzdwdjPPYdte27vaNW3Q0RPJEAcO
 x40u93w0qb8jPKMr0UMvNEwHIVvqiQRp4Tjb7xnXoHUi6XRKbEStd1JYEUedAM0SOgC+eRzcZL1
 Qrcq9ejSpgOK/jqdRZjNZ8FNLTw54UeC/QdSxwcovnZbb9rPvNesY3piM/AmvurqlUwnDb22Mts
 vK3GkctiVIIPFWv02Al4gWJJjaUEZmaf4GqyUjcfdguUcjUWnkg1XS2ffBYcrrZmM7LtF4Ou1rf
 UtE0YQ0b/XM0FxTavRybVtVq2no6dh1rN8KcUvw=
X-Google-Smtp-Source: AGHT+IGpnSWo37K8XTkfqKj2Vi3hmMBIPG7YZCVKnPk/tI9ASFBH9hWtzk/A1NXOp9YkZfDgzz5luA==
X-Received: by 2002:a05:6000:220e:b0:3a0:92d9:dae with SMTP id
 ffacd0b85a97d-3a35119c03emr2279582f8f.5.1747300305413; 
 Thu, 15 May 2025 02:11:45 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-879f613b570sm10050951241.7.2025.05.15.02.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 02:11:45 -0700 (PDT)
Date: Thu, 15 May 2025 06:11:35 -0300
MIME-Version: 1.0
Message-Id: <20250515-conversions-kill-v2-1-431063e90b4f@suse.com>
References: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
In-Reply-To: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=rbm@suse.com;
 h=from:subject:message-id; bh=f0iAbFTq0ii80JBwTMy+3Bd9RFep4VsJLg+ey/4Safc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJa/KfPOItRiSKv/z9EHYPCEFowgM6SPPsO3SX
 uQhjMPJDS6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCWvygAKCRDJC4p8Y4ZY
 pg5OEACyQDwZXrKDMcwsyJ7hkMrLcf33H1uQ7Een+BFM0CHgsOe0cS5wK6BQ1Q4MYDsRowQWIAM
 35RXEU5vYhPenK+h9Upp4qICJFwPNtbeOvvga1TTZbs8pbsIfzHcz1i/m+HXAdCTxZE8nowoxUZ
 BzZxcbaLhl5mQI/d8IWAms/GAUO52ymzSjVNW6Fhp9CH0u8rNFHwcMpC+doSlsO+HSrpmrWmaAo
 srXRuERQQkDvoFpteME/VCFvN1cWBV+FtrjY6I0snralmPDrYSCK6uFYFbObPCS5DP+1NglpZFz
 9gUd8KBNKi1I+tYGxXKWziHg6ywAmw3btqeOwhreUyM3eUPEAaV/Zt/Ec9ht/ShGoGWnJarKU/4
 x+8i4YEA6mL+tM6/fnMQLH9sHat4w5t744sYN8xpJShngcc1RTqbDKuc8HrkL5BABw7tu08IMVW
 m0ke2cPoqHVvYqSlurNihh2F9bq2kO1Y3Lh9uOhkfeO7S2U2ixgXMSswpp3T+GJI0J8uvPw3iXd
 n3SOGzeUqxB6Juwed+6ke0AbR57oSctNYEuYh5zMl6RcMsaMAIyRDBO1Xjg7W4Ic2AHhFAJuM7s
 o8SqRex3lj0/EHITq3gM+eF2aplL4qEk+0pGfbCAGkpGUns5l9B0y48SFussqvOt+/kib0KhQXv
 zUo37ldBIfFXCCg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] syscalls/kill03: Fix test description metadata
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwv
a2lsbDAzLmMgfCAxNCArKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2tpbGwva2lsbDAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDAz
LmMKaW5kZXggN2QzMDcwNjc4NTlkNDVlYzY0NTQyZTJjMmI5ZTg5N2ZiNjE5MWIyNS4uOGQ5MWNj
NjE1Mjk0YzZjYmZjYzBiY2ZiOGMwZDE4MjRkYTY0NWUzNSAxMDA2NDQKLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMva2lsbC9raWxsMDMuYwpAQCAtMSwxNSArMSwxNyBAQAogLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKIC8qCiAgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0
aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAxCi0gKgotICogMSkga2lsbCgpIGZh
aWxzIHdpdGggZXJybm8gc2V0IHRvIEVJTlZBTCBpZiBnaXZlbiBhbiBpbnZhbGlkIHNpZ25hbC4K
LSAqIDIpIGtpbGwoKSBmYWlscyB3aXRoIGVycm5vIHNldCB0byBFU1JDSCBpZiBnaXZlbiBhIG5v
bi1leGlzdGVudCBwaWQuCi0gKiAzKSBraWxsKCkgZmFpbHMgd2l0aCBlcnJubyBzZXQgdG8gRVNS
Q0ggaWYgdGhlIGdpdmVuIHBpZCBpcyBJTlRfTUlOLgotICoKLSAqIEhJU1RPUlkKICAqCTA3LzIw
MDEgUG9ydGVkIGJ5IFdheW5lIEJveWVyCiAgKi8KIAorLypcCisgKiBWZXJpZnkgdGhhdCBraWxs
KDIpIGZhaWxzIHdpdGggdGhlIGNvcnJlY3QgZXJyb3IgY29kZXM6CisgKgorICogLSBFSU5WQUwg
aWYgZ2l2ZW4gYW4gaW52YWxpZCBzaWduYWwuCisgKiAtIEVTUkNIIGlmIGdpdmVuIGEgbm9uLWV4
aXN0ZW50IHBpZC4KKyAqIC0gRVNSQ0ggaWYgdGhlIGdpdmVuIHBpZCBpcyBJTlRfTUlOLgorICov
CisKICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KICNpbmNsdWRlIDxzaWduYWwuaD4KICNpbmNsdWRl
IDx1bmlzdGQuaD4KCi0tIAoyLjQ5LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
