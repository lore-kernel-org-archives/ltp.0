Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B39C7EE30
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751451975; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=s0srxVpuUSrYJboGrDNh010H6ZRdKMqpyxitpppzrwY=;
 b=pl13JkwgtvMeFMWvNYfWDHThE/C7+255De881E6zDmRgEeDJwTIoS41bDfyVf1ukiDklF
 SCib1s0IYNnJxcoks6Xr4N/ehVvbZZR8WuMYSUOoo2Yyvs6E9muaONZkxHRSPk30f3KW92K
 w7d/3m5yVYQ4M54+nwtvKrXTeOu6aDY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19F423C8818
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 12:26:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7EC83C8623
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 12:25:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACB911A010E0
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 12:25:51 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453426170b6so40184235e9.1
 for <ltp@lists.linux.it>; Wed, 02 Jul 2025 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751451951; x=1752056751; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A35qQXPRCB8OvkXIV18pzLJuJJcWstrwn4xS+9re1Ek=;
 b=Qm7YbOih3l1IDOeQsehrWlVSm0NNcXxYXWAHz7/G2cj2p9iK/Q/uEPNheGhsmFqSjA
 532jhDE/o5LMcegNxABQZdRnUGp1b+E0Wi8w7PzS0kRXVZuWXPL7UvvVEQ1yGPWgg+//
 RYpRXTJvoU0FY9F09AmV4GIdM88/KD2drg1Byvf39oaaBfq73nLbbP0oX8FHUEy4UnS3
 D1w1qqGcNdeA1XINHN0r+Dae+e9536RHAure4vd7D46hJyOp2qbS8goqU8VBFT0i+vFS
 QARyrEc4cU1hdX4SwbKo8MMChY72pLFEvKQgWV9EvukoVmpF9dD/ADnL/EPQhQHuH/lJ
 FEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751451951; x=1752056751;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A35qQXPRCB8OvkXIV18pzLJuJJcWstrwn4xS+9re1Ek=;
 b=Z8QDxzCHHyU8Ug/KEoDgfjd5H7rl2J/2wFTSEWqcEfZaGW5KUVVnEcXc9AEXoW5erE
 WcCrYdfVqHCjzJFr+LQsGf/MoqvzRbmHOwjsKX0qWfdAp1ws4+s9RlCTaosnNQce3An+
 z01+LNihbU4rvr45WF+Jf9byHZYUXf/uBaHVgup0PEADUnWwVMKk0Sx+mMZF0jHLt8+k
 Zp5rZ8C8RsmU4t5CQlny9eSW2j2lSZuLMgDniPkQvsapscHSwpYqIIG7BPj0gqd9skIE
 rjFcaYy4SRiWb5lebQY1LuSsSAVbA60sNt88cXk4lRTzxDhqbCGKFeAdDSYz7Zkw3UQC
 /ayQ==
X-Gm-Message-State: AOJu0YwepZut2ToZqL+h6WKCccRK402xGca01tZaCS8xr7OxN278029F
 LY0wWbMMi5LWdC+cJFmrQ65GBnquDdNxBlJsaG9vYIQccbx8qUGWGPNG0BBTyb0UdW8=
X-Gm-Gg: ASbGncsvcPRBuSsK500B3Ei8J5NpRKGuQN+IitPk5RsC4YWeenkr9egVMWmurLi3c+r
 IpoQNQ789ngCNdcNr1SwDz5NGkwDtZYu3Z3EX28FnYPGDyaACULl49FGhNer1Vrq5U1jDI+GEBT
 UC90mQ9ZslNPx+IHfDX4xjqGOdJiBOcRqAC8cV4KGVS8T5Sh73yBS2y+A4KTB06pLlX4DGWOD6E
 IpZqf6Nj4bhnFrx51YYFCu3sBO2pwOExfq65vl0iDvv3pGYOmyqQfSK8o8cvXUVunyCC0m5R6f2
 R8UqJdkDCPgBgQdBxEZFkV80XdZyD9OXzJhif9KZTIoZ/W9GtA==
X-Google-Smtp-Source: AGHT+IF6MadAUQEZbb0E7GNBpb/IIrk6sH2dxtsUSFGW/0uBWK4EZn7gLXmpO/buy23s1NAgCOr8hw==
X-Received: by 2002:a05:6000:4029:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3b1f80ecda3mr1813286f8f.20.1751451950558; 
 Wed, 02 Jul 2025 03:25:50 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a7fc13a311sm90334891cf.25.2025.07.02.03.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:25:49 -0700 (PDT)
Date: Wed, 02 Jul 2025 07:25:40 -0300
Message-Id: <20250702-conversions-lchown-v1-0-ac7adb3af51d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACQJZWgC/x3M0QrCMAyF4VcZuTbQVYbFVxEv2iyzBU0lkU0Ye
 /d1u/zgnH8FYy1scO9WUJ6LlSoN/aUDylFejGVsBu/84G7OI1WZWY+Z4ZtyXQTDmGgI16l3KUA
 7fpWn8j+jj2dzisaYNArlI/WJ9mOFbdsBCUz4gH0AAAA=
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=rbm@suse.com;
 h=from:subject:message-id; bh=d0fh2fYmiPP4t88EXuuwhJLKVzk7qWMwxG/TWumSzCE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoZQkpRUZfm2nGWujZLi/CEuAig+a87HF9qxUGN
 UPOe8IjGhaJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGUJKQAKCRDJC4p8Y4ZY
 puCREACkgXSQFOXYoPvAbhvHck2GY2aMpQ/UBTmK5BqYyHJS4j1+UTNSZv+qu15rpUVBVXqsvOR
 05eVfaXBrFppGQD9lLgbKfvfZHrecyloy9RADJHHleGHRHm8NScL0TAaACVCBpO5tNlN69akbTJ
 e6HLmhllc4YPvOkISAX+qxmJtmP8adQ+XWfAHvNNN8J6M+xewf7AtK9r2267AP6IfxEPqk/0K97
 oFX7OAa+58lj5JGpcJwNWhG0+05yeKjUO4y5AAOqSEu0YTlzqFy1YhLAELm/URH8hKvfybmX/c2
 PPPYycA2F4W+McivdZCDmX3bj3wg2Qb5qPI9cvtihYnkl41whfBUcM2I8CA/AMvXAw/OhZd9P/n
 9ze65i2DVoZHK/hJiQGs22Yfdt6vms/ds16ubwTBxgYw5lf+Zn1m5LZRfXBGeGokRt2c22iMAo4
 5RoG+GM0/wr9YuKARvhlzX/DuuO72JCvVTtC1hmLM6IRzGt6Jk2J0YYutsdmkBHUxMIp1UTn8cm
 PiIz8PHcMWEhAHrLqWB6osSKcIxn+0UIfwQLj8aJc/ZhIgB2SnqrRpsnvpcLqEJxVNcuHR3qV44
 Ih4yUIXAdIDpPYsHyYXc++h9njh+MgaT3WzPmPqH8YN91LNzWqkezS7WPfftpT81ib7ZGpVKeEE
 m45af6fQnmGzrBw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] syscalls: lchown: Convert to new API
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tClJp
Y2FyZG8gQi4gTWFybGnDqHJlICg0KToKICAgICAgbGliOiBBZGQgU0FGRV9MQ0hPV04KICAgICAg
c3lzY2FsbHM6IGxjaG93bjAxOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IGxj
aG93bjAyOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IGxjaG93bjAzOiBDb252
ZXJ0IHRvIG5ldyBBUEkKCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggICAgICAgICAgICAgICAg
ICAgIHwgICAzICsKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAgICAgICAgICAgICAgICAg
fCAgIDMgKwogbGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
OSArKysKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL01ha2VmaWxlICAgfCAgIDUg
LQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vbGNob3duMDEuYyB8IDE5OCArKysr
KysrLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9sY2hv
d24wMi5jIHwgMjU0ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAzLmMgfCAxNzAgKysrKystLS0tLS0tLS0tLS0tLQog
NyBmaWxlcyBjaGFuZ2VkLCAxOTkgaW5zZXJ0aW9ucygrKSwgNDUzIGRlbGV0aW9ucygtKQotLS0K
YmFzZS1jb21taXQ6IGE5MDhjZmY3MGY5Mzg5YzJkZDJiZjUzNTk3NmNiMTc5YmZhOGYzNDAKY2hh
bmdlLWlkOiAyMDI1MDcwMi1jb252ZXJzaW9ucy1sY2hvd24tOGRiYzU4M2YxMGI4CgpCZXN0IHJl
Z2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
