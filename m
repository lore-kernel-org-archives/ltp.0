Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBD9C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743112677; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oqSD/En0YMG5oCxdCiud7B1ZK1T9Xzev/szAsTwMV4I=;
 b=WEQkPfwZ7vnD1QwAgQGgxeoG1Hft0txWanRpTceywEiAU0Y+0og5tvV2RXECwmDbNvFQV
 YKFvyPBi3ttktCVqdBHGu9jzivkp//wj57C4VJjw4nGz9zHFN9PAvCCd6v2NKodHauU377t
 fULEHDF1Knl6PxLHzkSbS70WbKZvkbM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CA583CA15E
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:57:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F5B53CA131
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:48 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5983760220F
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:47 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39143200ddaso950302f8f.1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743112607; x=1743717407; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IgS7LYo/03r5yTYM0G/aUJD/IG5DVm3a+uyoRLxEh28=;
 b=Y3ZMpVTDbSDqReQVXztQ74jdUCj6sH7XVmmHDP4VWJPLgOntXTYFZTCP5W5ExileVa
 wUtkbntSyW8KqnbjVGYsZxLEupIhAv+O3PLa8S5zJNLgEuValkuRXoN1TtsfwCao6YQb
 LSBmehP/rqitdQG1rQDFd0dpXi+MMSjG11CbXT2As40yz2IyhctVR6flqws+00PMfPE1
 b9qQpzbIWdc2IqEWaT7nSHiBe7PTi+ltKRTWuqIt0ZazrUk3x4bxcNw0/2GPnOJ21X6L
 JzgAgeoLb1SCrIpvh73hmK8Ru2vsJ0id06CA3Ni7NxE5RFEKtJRQ1MUt3QpbViHFahiN
 xH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743112607; x=1743717407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgS7LYo/03r5yTYM0G/aUJD/IG5DVm3a+uyoRLxEh28=;
 b=fKBK3cVn1d6XWMn1B37YxY8fq6ZIp+rnG1u8F/Y8ADW/XZUcFEmAckgueY53ahYnah
 9VeRmLK5bFHsLVQO5nLhywO+V0TGjFfYQetj5qFJqUOBzkXL1C1JiDySLoXeuAgIXW/x
 m4Lk+ppF+QseyGpEbGWzGimq734VmqnPpWFLffXCVZVIHPnFVvlW4GQk39bKGYIUOAWZ
 034L/tlJ+T63eVASTsZJnS/IZERTIj3/HMY+iRLXdEt0CtVxa09xArsEfNlFGc+LzNBs
 RtfUTfa4tkIclaUqrNe3gYMdr6PpPc8S72hqOK6vFlRdPIiYr8bBBC6tN0Rkql+k1W99
 L4gg==
X-Gm-Message-State: AOJu0YwpNesQcg1/iQXPlsKyFuWjUH0Ly6zkvsNNp+fyp8D3wB5RDwKp
 3kYxxaxZt3xVUKCUgjfWO6IPwIbR2a57PaJPxW8DwgrCwwYNXpzJorQ9yBqsidO8F1V2pUNplQC
 Y
X-Gm-Gg: ASbGnctb9BwE2x57hIuh0b+lE7GUHc2zEzBCAyAdR8xtS1xVylKiLdwRyiieamKza/Z
 5DHnw2OwVY2n8Mr48HIbQhrxWL4/tR12YBT4LArmypomZkvUmW0cNcQVExGwrF7QMF6E8FVtioH
 INJCc1KNMVzUyGP8KUIqtt6YWgLoJOhesnKJsTWe87P0zpx3yuKT17cqUa0rZVog4mdqGG6hanR
 MvYEYlBcpWqcID25Zt6cHNxiLx4BcxHqk0hgrz9cmVGH1bIUBixrurNo6mIvUFWdg+DEHqm2nF1
 dn2sDr49UqywX4Pgz4d12M9I+sJOQlL6LA==
X-Google-Smtp-Source: AGHT+IECoWL9I9I1OHm5JoPNHnLlQz1AZNRcSb3SpibjTskiDMQjzdA/eWeLbxUTZRFHclPexxpI3g==
X-Received: by 2002:a5d:59a9:0:b0:399:7918:541a with SMTP id
 ffacd0b85a97d-39ad1742f62mr5154242f8f.10.1743112606726; 
 Thu, 27 Mar 2025 14:56:46 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73970dee7edsm355401b3a.22.2025.03.27.14.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:56:46 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:56:35 -0300
MIME-Version: 1.0
Message-Id: <20250327-fix_make_clean-v1-2-8b9ed2a8d96a@suse.com>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
In-Reply-To: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=rbm@suse.com;
 h=from:subject:message-id; bh=0xZJ9kAHqMLJYbVfH01tJ50lvUWDYFzr8bZT/GhcO4c=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5cmTqi9DxQznr9PHCP3pcTyHtdV5NNsq7DGBz
 6C3NhpaUw+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+XJkwAKCRDJC4p8Y4ZY
 pslWEACiVBEYL8EhsmbujlHEEcBv7xiSkRR8hOVuyva/MfiFswqQFb03NqtsOxbuz+xuW5wCtyM
 g4Mctahxbuewn+w2hIw9QyLfy7t4p1AkG1NfeJtntUewgmhK7TRB6aYuhP7UufBDaM3x/tf6ZQI
 VbCo+eSywUlcNU026ZXqGiseU1XchU0IpKDHIsbo4H+WlHgJ93pHn299SYNTj0BMc7feRUnBA5/
 SnZ0dOdR3Q+JX7zh+x84542ratqX1MM8d1fBj66oh+VLu3gdmwajXEX8ogqHDZ+uYzwddadSY1j
 WHlfMIiJdEt4cmly89m4pcJ05fLxS7cjVvqf0DfN2i+/gakTJsY0IFnBQI1csPga+7DtplY5CJb
 ig56v4rt4PxL1SwROjkgek+JgbUa/flp6abl8eE3U0/MMsxK4WB+g9lCMARG4D6K0M4C1u8y69M
 JmUB2tiTG+wE/WUbmhq66tRqK39qEWNlXmy6PNNBHAq9lPqTRi+gl7jfyR8zaaC7WqALPitIR4Z
 czoqm8uSx/K04EdqnvneXKlu3s7SI/UsZtB7ybcY1b0OsUHfJsOQGqdVtkuAgrewaFN5+NUIwCp
 14OEwUJkqCu2Y+rF9ap/C/pZQ6ElgAifXY+L7ZDqGOFNeYZqvME0RH+i7Fgbf33N0LR2AW9kWd6
 3+5Mx5ARsrhQI0Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] openposix: Makefile: Add the standard
 "maintainer-clean" target
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBpbmNsdWRlL21r
L2F1dG9tYWtlLm1rIGZpbGUgZGVmaW5lIHRoZSBzdGFuZGFyZCAibWFpbnRhaW5lci1jbGVhbiIg
YW5kCiJhYy1tYWludGFpbmVyLWNsZWFuIiB0YXJnZXRzIGFuZCB0aGVyZWluIGl0IGNhbGxzIHRo
ZSBzYW1lIHRhcmdldHMgdW5kZXIKZWFjaCBBVVRPQ09ORkVEX1NVQkRJUlMsIGJ1dCBpbiB0aGUg
Y2FzZSBvZiB0aGUgb3BlbnBvc2l4IHRlc3Qgc3VpdGUsIHRoZXkKZG9uJ3QgZXhpc3QuIEFkZCB0
aGVtIGFuZCBhbHNvIHJlbW92ZSBzb21lIGRhbmdsaW5nIGZpbGVzIGluIGFjLWNsZWFuLgoKVGhp
cyBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4gY2FsbGluZyBgbWFrZSBtYWludGFpbmVy
LWNsZWFuYCBmcm9tCnRoZSBwcm9qZWN0J3MgdG9wIGxldmVsIGRpcmVjdG9yeToKCm1ha2VbMV06
IEVudGVyaW5nIGRpcmVjdG9yeSAnLi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUnCm1h
a2VbMV06ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0ICdhYy1tYWludGFpbmVyLWNsZWFuJy4g
IFN0b3AuCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcuL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZScKbWFrZTogKioqIFsuL2luY2x1ZGUvbWsvYXV0b21ha2UubWs6Njg6IGFjLW1h
aW50YWluZXItY2xlYW5dIEVycm9yIDIKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01h
a2VmaWxlIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0
ZS9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9NYWtlZmlsZQppbmRl
eCA4YjRjOGMwYTI0YjgzM2ZhMGZiMjFjZTNlMjUzNjI5ZjM1OGYxODAwLi5jMGNjZDQ5OWI4Yjlj
OTNlNDUxMzNmNWIzZjE4OWVkYTdkMDliZWIzIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1
aXRlL01ha2VmaWxlCkBAIC0zMSwxMSArMzEsMTYgQEAgQVVUT0dFTkVSQVRFRF9GSUxFUyA9IGlu
Y2x1ZGUvbWsvY29uZmlnLm1rCiAKIC5QSE9OWTogYWMtY2xlYW4KIGFjLWNsZWFuOiBjbGVhbgor
CSQoUk0pIC1yZiBhdXRvbTR0ZS5jYWNoZQorCSQoUk0pIC1mIGNvbmZpZy5sb2cgY29uZmlnLnN0
YXR1cworCisuUEhPTkU6IGFjLW1haW50YWluZXItY2xlYW4KK2FjLW1haW50YWluZXItY2xlYW46
CisJJChSTSkgLWYgY29uZmlndXJlCiAKIC5QSE9OWTogY2xlYW4KIGNsZWFuOgogCSQoUk0pIC1m
ICQoTE9HRklMRSkqCi0JJChSTSkgLWYgY29uZmlnLmxvZyBjb25maWcuc3RhdHVzCiAJQGZvciBk
aXIgaW4gJChTVUJESVJTKSB0b29sczsgZG8gXAogCQkkKE1BS0UpIC1DICQkZGlyIGNsZWFuID4v
ZGV2L251bGw7IFwKIAlkb25lCkBAIC01MSw2ICs1Niw5IEBAIGRpc3RjbGVhbi1tYWtlZmlsZXM6
CiAJCSQoTUFLRSkgLUMgJCRkaXIgJEA7IFwKIAlkb25lCiAKKy5QSE9OWTogbWFpbnRhaW5lci1j
bGVhbgorbWFpbnRhaW5lci1jbGVhbjogZGlzdGNsZWFuLW1ha2VmaWxlcyBhYy1tYWludGFpbmVy
LWNsZWFuCisKICQoQVVUT0dFTkVSQVRFRF9GSUxFUyk6ICQodG9wX2J1aWxkZGlyKS9jb25maWcu
c3RhdHVzCiAJJChTSEVMTCkgJF4KIAoKLS0gCjIuNDkuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
