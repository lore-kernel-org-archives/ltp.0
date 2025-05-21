Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE7C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747816303; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EG7Hl8L85JAX3gpxgMBBJw/LFHlxl3GjVS/A77POnps=;
 b=oau3sLQeD21Cgv+Rb49q+Sx7Jr9CpZSpvCiF3nYPL8ynkFBiRRp7BMlTLkZnjWNew2YBt
 uxDyp6BJIMpI0k8oEHq07H4rO/tkvDa/tsTbKnuZW8jTIX2z49LHIrd2qzY4srZRJwzigxN
 lQZvaeMN5kvXrB86T0K8q96flLgSpFg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5A53CC6DF
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 10:31:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 368683CA55C
 for <ltp@lists.linux.it>; Wed, 21 May 2025 10:31:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 308B820007A
 for <ltp@lists.linux.it>; Wed, 21 May 2025 10:31:20 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so47549485e9.2
 for <ltp@lists.linux.it>; Wed, 21 May 2025 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747816279; x=1748421079; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KbL9R96QqqjEY0ApcAxYwo9d+tIUCLFWQs7lav+vIRk=;
 b=UyJ0khHflO3ecNWrTLZ1rXgwGGpL7iwkNW5kDszsuizPoEDmpDFEsiTUGgw/jrluGA
 dZ7+He5w6kmUxli4XOK9V/eHCIYGdROBL6t/Z2iNVnDbRfoiowsmFteZ8Z0M3JmuMQBw
 +c0EmGYh6A1N7fLBGgHZhcyi49QmJLRCpKooq6YpMKqoe8n5NODAzp7/FsumGO4M5vT+
 8RVARrVsFeb9qSzu6jq4p+GltDg+eo+a5Lw9l5vD72aS5kRMFVvdW4OoyjvdFnoi4b/J
 EqKZ9Dv56bKvVf6XaE/Mq1x+kfgVTRAh+z7uhNRI5eFj62xBhGHs/0NZl8a/BKRS/DYl
 i+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747816279; x=1748421079;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbL9R96QqqjEY0ApcAxYwo9d+tIUCLFWQs7lav+vIRk=;
 b=R+Zwr2d7mUtVspQbpsW/dcQ0PZ1elClwHpK61UiZg4Ay6CTPBuu04UmBU0kCxLaDa1
 eakEHLYgwUsJ+K43AoNYa7ctQKQXByoVHJ9mGfRqSuUGaWpHYKrysNP2+EA7t1CcrKTv
 f6XuqlPrCB1ic2EAdttjotpjassCZZZBP4ORafFSFXSE6f0aeWF37k06Kz/3QOjjtiuk
 xRzr46uOVhc86Wftyb2yOkVp8IXAwOYgv/ioYm3dDlhYQks4WxoUETuUdzaacVEUlkhv
 chIU0rXi3i8P8B6oGwsXWI3Z2P+2HfM52+ausyMwh7gLNSNUDG4C2pLoFhcgu2tEEIVs
 NWCw==
X-Gm-Message-State: AOJu0YxqYR8WRyR4D1jOkouMYWtPOkjm8Eof+ZKgMxdSQT9TSeFfzM24
 j5D0rSZ+80fKRQ3cglFx/2lkOWetHsCeDRylveLNR6okXmAqyQ6f3aTMovVM3OIVu+viqtzIp6c
 BSNoS
X-Gm-Gg: ASbGncvxBKjv1BRFGJ5fCAx0ZQYvtuYIn5aR6B2Ba3v9EH6VMTa7M0283Evz4hSlASS
 afbm8x2aGY/ODNRXDEypbH4jtgqn6ZnRNQWfZHgp8h61ij92Acs3qNbHXK3EvAChT60rzVYmFvi
 LoOJHTq1VAesAsR/H5DzvGS7WqqwU/iJh/iiap1iEbiRNuX4cKWGrgVBVOxDcEbS04ps95aF0OL
 iJu8w6zp17gitL8bgoP/4A+OljgqAUSgCWnRiER6g+/zN0DL5BYfbTW2ls0MeV+99bM9ra2iLOd
 vzdYoJSsA7dNWOrxegWAAwWRW9q/ERJDVzXx73Q=
X-Google-Smtp-Source: AGHT+IG7ICckZNLbhyf39agAeh3O5NEpeZy88jzxeEsZUE5sDwWSJznyJLRchUu+24cTcwzBON+L7Q==
X-Received: by 2002:a05:6000:186d:b0:3a3:6b0c:a8a3 with SMTP id
 ffacd0b85a97d-3a36b0ca9b1mr10445667f8f.17.1747816279263; 
 Wed, 21 May 2025 01:31:19 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dfa66c95cdsm9207503137.12.2025.05.21.01.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:31:18 -0700 (PDT)
Date: Wed, 21 May 2025 05:31:12 -0300
MIME-Version: 1.0
Message-Id: <20250521-fixes-msgstress01-v3-1-5d82167cb3e5@suse.com>
X-B4-Tracking: v=1; b=H4sIAE+PLWgC/4WOOQ7CMBRErxK5xuAlVggV90AUXn4SF7GRf7BAU
 e6OnYoKypHmvZmVICQPSC7NShJkjz6GEuShIXbSYQTqXclEMKGY4oIO/gVIZxxxSYDIOG256iw
 Y1Rp5JoV7JNhLBbvdSzYagZqkg52qKSY/+nCaNS6Qan/yuMT03i9kXqlfa5lTTp2Uaugsl9yyK
 z4RjjbOpI5l8VcgiqDt3dDJ3vXS6i/Btm0ff32jlhIBAAA=
X-Change-ID: 20250512-fixes-msgstress01-4157ceb54b38
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=rbm@suse.com;
 h=from:subject:message-id; bh=zDYz6odJUogkfxSJiWzbP8sVgz3qMJPGyNLJkEDeNao=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoLY9REVVKxSFUVPgmVVTlWFuGZh8yBRNBFnjLe
 sNAEcvVp8aJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaC2PUQAKCRDJC4p8Y4ZY
 pm/kD/9ip8m1nztwtZ7ZtsTgFOpy2ITsOQ7OroXdM0DdYN18AnJaSzAV1aWeze9crXDbEyhGZS/
 YVGuTeQrwbqVwdr0/eFOyXHen9k8xdzUEDoLBBbq/ZFcbvH23KxXguRRjdMAZbes2s1J4oxpF6R
 f7Z+diJjvmTajtZY7iWPEFveyI4WctTU7fwP+uDBwNIEEeEvxBkWCTcQpPHcoeu31YmYPe35P65
 hL0wWceGevOZhoWJwz/8fItO8NXPNcR3QOH++c2eVRkzdSoPSXeCkoGN/tGMlDbEZfx7sMWCzlv
 8PD9ZqqXmPpttowsmzpprg39j1kPUCqF+Zlp06ld0fq6t9U7dcGtof9kNHu6jUxdP0EXB1TG1Jm
 stDriqoMun1L7sHSWhNuqyQYiC/Mzbo88wdu3XdAbAsyv0s4uIcaXgDCgJkdxdqae9/JVZrRvZy
 zbIQdTzpZTZe44kaeEXkNYNVqlQexf50UKgt5zLt8A4H+y2mHysPuHIqyL01kkJ6NIIAWTqLNSm
 mE2cauORfecIm4ZLjVYQYFDaShijGZ1+p40Ab74p0ojrRRN5XzfCX83hNRMdX9r4BblP37gPqvR
 Gy58/BeCtGq1LjHZAKtSjQ7Ilkh+eXGU2aIh430SqS6jr0vi4l4KIxGIvptC0uf9z1ODZo87xwc
 grrp4YbD4Qv4zBg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/msgstress01: Set upper bound for
 num_messages
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBtc2dzdHJlc3Mw
MSB0ZXN0IGhhcyBhIHdvcmthcm91bmQgdG8gbGltaXQgdGhlIGFtb3VudCBvZiBwcm9jZXNzZXMg
aXQKd2lsbCBzcGF3biwgYnV0IGl0IGlzIG9ubHkgdXNlZCBpZiB0aGUgb3B0aW9uIHN0cl9udW1f
bWVzc2FnZXMgKC1uKSBpcwpwYXNzZWQuIFRoaXMgaXMga25vd24gdG8gYmUgcHJvYmxlbWF0aWMg
aW4gbG93IG1lbW9yeSBTVVRzLCBzbyBtYWtlIHN1cmUKaXQncyB1c2VkLgoKU3VnZ2VzdGVkLWJ5
OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8g
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQpDaGFuZ2VzIGluIHYzOgotIFNpbXBsaWZ5
IFRXQVJOfFRJTkZPIGNoZWNrCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI1MDUxMi1maXhlcy1tc2dzdHJlc3MwMS12Mi0xLTQ5ZGY3MzlkOTNjYUBzdXNlLmNvbQoK
Q2hhbmdlcyBpbiB2MjoKLSBQcmludCBhIG1lc3NhZ2UgaWYgbnVtX21lc3NhZ2VzIHZhbHVlIGlz
IHJlZHVjZWQKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNTEy
LWZpeGVzLW1zZ3N0cmVzczAxLXYxLTEtZDMzNWY3YzEzMWMwQHN1c2UuY29tCi0tLQogdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvbXNnc3RyZXNzL21zZ3N0cmVzczAxLmMgfCA2ICsrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9pcGMvbXNnc3RyZXNzL21zZ3N0cmVzczAxLmMKaW5kZXggYWU2Mzdl
NWQ3YWQ4OWMxMjU3YzljY2UwMTQ1MTIyNDk3YzE5ZWU2NC4uMjJhMmMwZTdhYTUyYTM5NTZmNjIy
MWZhMmQwOTk5MWI5ODcxZDQwZCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pcGMvbXNnc3RyZXNzL21zZ3N0cmVzczAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9pcGMvbXNnc3RyZXNzL21zZ3N0cmVzczAxLmMKQEAgLTI3MSw2ICsyNzEsMTIgQEAgc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKIAlpZiAodHN0X3BhcnNlX2ludChzdHJfbnVtX21lc3NhZ2Vz
LCAmbnVtX21lc3NhZ2VzLCAxLCBhdmFpbF9tc2cpKQogCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxp
ZCBudW1iZXIgb2YgbWVzc2FnZXMgJyVzJyIsIHN0cl9udW1fbWVzc2FnZXMpOwogCisJaWYgKG51
bV9tZXNzYWdlcyA+IGF2YWlsX21zZykgeworCQl0c3RfcmVzKGF2YWlsX21zZyA8IG51bV9tZXNz
YWdlcyAvIDIgPyBUV0FSTiA6IFRJTkZPLAorCQkJIk51bWJlciBvZiBtZXNzYWdlcyByZWR1Y2Vk
IHRvICVkIiwgYXZhaWxfbXNnKTsKKwkJbnVtX21lc3NhZ2VzID0gYXZhaWxfbXNnOworCX0KKwog
CWlmICh0c3RfcGFyc2VfaW50KHN0cl9udW1faXRlcmF0aW9ucywgJm51bV9pdGVyYXRpb25zLCAx
LCBNQVhOUkVQUykpCiAJCXRzdF9icmsoVEJST0ssICJJbnZhbGlkIG51bWJlciBvZiBtZXNzYWdl
cyBpdGVyYXRpb25zICclcyciLCBzdHJfbnVtX2l0ZXJhdGlvbnMpOwogCgotLS0KYmFzZS1jb21t
aXQ6IDVkOGNiNWEzZWYzNzQ5ZWIyNmVlMjJkOTZjOTY1NGJmZGU0MzAzMGYKY2hhbmdlLWlkOiAy
MDI1MDUxMi1maXhlcy1tc2dzdHJlc3MwMS00MTU3Y2ViNTRiMzgKCkJlc3QgcmVnYXJkcywKLS0g
ClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
