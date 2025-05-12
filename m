Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEE8C3ABCD
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747051863; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Sh8hoTh1ppCkzTo7WU+TJ2nL5SP4deuCz6kEPyyI9R4=;
 b=gb46hhjdtuyeJQYHgM0S4PfufT6ph7f1uFkv60nJ8/hKgUmPg752ngQj1gh63q0RFadeT
 wWJar8htuLlrirjnvfIB/CS641V9qv6DzxJF6nE/h4W2UeEJfDLWfFxCRZ/3oQpl3LHjZfL
 ssNnqzr39whfO+0bgis4Qz3wwOu/uec=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EB0B3C99DD
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 14:11:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2CB93CC2BA
 for <ltp@lists.linux.it>; Mon, 12 May 2025 14:10:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E270600810
 for <ltp@lists.linux.it>; Mon, 12 May 2025 14:10:40 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso47388555e9.0
 for <ltp@lists.linux.it>; Mon, 12 May 2025 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747051839; x=1747656639; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1jJ0UIkqBEBlivNMD4vdDWY5HoNpmkyLcnb9/+H6tG4=;
 b=fuPKxbbsxRdE1nDRyIOi8KUA13uTo6XKGlr4rfnJ/is2ZEeENpvzrsUbJ+FoqFP8oJ
 5vGXT43adFGcYFqa4OHrTF4bTYQRXSW07oasnzHHlqfvZRlGConCPHJvJYktGvyXsWpX
 axmqOvkch3p3cwsbF/rvByHv8y70ArHtBjAOBBLhiTIlsH7fXzR7qkRQFvUrZWxEl8K+
 BXFb9nD3a+HUGwPjqtv30PvaGOZRO4I8QDyQYZPI9U78MHIJn8dNmO1M0m7l2e0/0eWJ
 P49VdcN0sDJl5pK7vMXKkqeLuNrlFosUQGC5+A6cFOc/+k+a4l7uN4q6NV/c09fYHTjE
 PSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747051839; x=1747656639;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1jJ0UIkqBEBlivNMD4vdDWY5HoNpmkyLcnb9/+H6tG4=;
 b=rmzE1o8BhVld5Vu/vGGOPBiZw1+No1WAvMcMNsB62oR4nYPlhnroZH53RIy09n71od
 hxaE3H7TRyw3UMQWxdraMKVkv1+esgwzOwEpD+7urKlY4pvq3+CjAaAQUqAlHjpLm22X
 leFSd1rtYp01oUnmvOXLn2VWcqS2cn1Sa7IU1vpz8CvDkU7LUNOuUWDq/Hx/RsUAIFXk
 eN1IkrIcDYAPCiluBgvP3/XoEVCe8QKYDcQmNa9KPnaeD6ol2oQKtpBpPGJdQXTXZDW8
 Mf+5xSOeFIo+N8oo5PFyDjRUZ8coInFdLpKk8ihGPhoY7VVjJaejWD3+if6Bm9/VTVXw
 kuUQ==
X-Gm-Message-State: AOJu0YzrWHB3McggVWcUROlohNQhvvUDdQzYMrhgMIhAWgeurYRPJZOD
 gun1J7pyDzWKdW6P8U7X2tfS83+RGernvIRiQMmJ7TXCeHAD8TIiqDJlDtXwQzI6T3KZ+XZT1N4
 g
X-Gm-Gg: ASbGncuDnXehHTXTlp/7LUcpDj29HAvtpB9e0Yr3RCqUx2TmeE+t1ZXXr+KYhQSWbpL
 HE1vYoGMCgePb00vkKRKpDrXs8ccX7jrIeExOr8PCc/AWuGAdrGMD3LRy9EEet6l4k+aJNtk5wq
 8+0djqoaxXI1AzQCNUgtTqhjoV4RvQTYzhZ3BCnjqihiyYh1MekXg0DGQT1r8SRCJZ6zkZH2lw4
 CpE31lIOuuWFo6BgHmrv779G7sZUv3u7qOhW4t0qi6lRDVAFKDwBGUyli2YHCvZxAowABM/zayr
 l9BUjsCTSlnFfiJpCFHCXmKU3c4eMHzAalExL4Q=
X-Google-Smtp-Source: AGHT+IEKx7B5KuW0+m63x9bsZsYeB8EcgQmtBrZ6kH2XhWojlsVGzprgivDp3bEyHI3uXhXOwaUyYQ==
X-Received: by 2002:a05:6000:2585:b0:3a2:6b2:e545 with SMTP id
 ffacd0b85a97d-3a206b2e7f0mr3520433f8f.15.1747051839658; 
 Mon, 12 May 2025 05:10:39 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dea857f73fsm4972581137.3.2025.05.12.05.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 05:10:39 -0700 (PDT)
Date: Mon, 12 May 2025 09:10:36 -0300
MIME-Version: 1.0
Message-Id: <20250512-fixes-msgstress01-v2-1-49df739d93ca@suse.com>
X-B4-Tracking: v=1; b=H4sIADvlIWgC/32OQQ6CMBBFr2K6tsq0NBhX3sOwaMsAs6A1M0g0h
 LtbOIDLl/z3/1+VIBOKup9WxbiQUE4FzPmk4ujTgJq6wspUxlUOjO7pg6InGWRmFKlA1+CaiMH
 Vwd5U8V6MR6hoz7Zw8II6sE9x3Jsy00DpOnmZkff8SDJn/h4XFtitf2sLaNCdta5vIliI1UPeg
 peYJ9Vu2/YDr0+sn9EAAAA=
X-Change-ID: 20250512-fixes-msgstress01-4157ceb54b38
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=rbm@suse.com;
 h=from:subject:message-id; bh=3yWIKFiFCtZRsAIno4Cujw9U8HwqudfSPOuac2coNJc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoIeU8ZR1TtwQ07BhLzr3kL/fEd2mB6bj722C1V
 /d5+993CbSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCHlPAAKCRDJC4p8Y4ZY
 plvtD/9tbwh75MVu21/OHrRH2pu/jyOym0L/9gJYuXQwq+qWsOlptL0TunCC+gLa/gsUwSe7heU
 Ekg3MOgY9Xj7rKwwYC9Uq/0aJ0nyuDy/goPZ+/TeJo3SDJY+QK1Bq0V2qhrFSzJ0LYN9+8WFlG3
 HT55jUmMxgSQ5svyrBDmBTkE9Bh2dxHjYdGz0+CCvy47xg1FwyPBivf/wnstspOzDeV62F4OGbO
 9s21RAADln7g/d1sU6Ht1yriXYEMWCVnIQOCciml33SrUb9PsbeIz7aDRCp4eILq8i4e0dco5lS
 uxCfNMNFQjB7h5j7jTXvU2aIaj5Tj3RRsTEGIi1yKAQoWovpHsgcXVARPVXlAKA4X8xbFpPz8U7
 7YhaaWM/0nETTKW7zC+ozWnQ/DgMBatMxQA4QxDoZGw21Z7Z55g0z8QuqX5ZhQQozvvIYau0fVi
 Q45aoCHxTGpkJon6R2vjpLxYE5GyePuMsJt+bDVAWkcZT+GZ7EHRma5sgbVwxP5IHpe760cKeNI
 lO2jxFaBEM2Bx85+l9LIB41fyrMwstYcdE89rNDK/mcnyFhsiWGzuyGuAeoqDnvpgUsDsFlli3C
 LsEbY4vu6QDHqqsWmNqBsM7cKsJiZtB2tJDw1ejQypKCljupkHcMht5P9Wug7Fny4m8KIFKMNOb
 VRW0ahnxGRJXgQg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/msgstress01: Set upper bound for
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
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQpDaGFuZ2VzIGluIHYyOgotIFByaW50IGEg
bWVzc2FnZSBpZiBudW1fbWVzc2FnZXMgdmFsdWUgaXMgcmVkdWNlZAotIExpbmsgdG8gdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA1MTItZml4ZXMtbXNnc3RyZXNzMDEtdjEtMS1k
MzM1ZjdjMTMxYzBAc3VzZS5jb20KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9t
c2dzdHJlc3MvbXNnc3RyZXNzMDEuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9t
c2dzdHJlc3MvbXNnc3RyZXNzMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21z
Z3N0cmVzcy9tc2dzdHJlc3MwMS5jCmluZGV4IGFlNjM3ZTVkN2FkODljMTI1N2M5Y2NlMDE0NTEy
MjQ5N2MxOWVlNjQuLjVmZDRjZDQzMGY2M2RlNDc1NWI0YzFkMDNiZjEyMmZiNDlkZGYwZDEgMTAw
NjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJl
c3MwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dz
dHJlc3MwMS5jCkBAIC0yNzEsNiArMjcxLDE0IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAJ
aWYgKHRzdF9wYXJzZV9pbnQoc3RyX251bV9tZXNzYWdlcywgJm51bV9tZXNzYWdlcywgMSwgYXZh
aWxfbXNnKSkKIAkJdHN0X2JyayhUQlJPSywgIkludmFsaWQgbnVtYmVyIG9mIG1lc3NhZ2VzICcl
cyciLCBzdHJfbnVtX21lc3NhZ2VzKTsKIAorCWlmIChudW1fbWVzc2FnZXMgPiBhdmFpbF9tc2cp
IHsKKwkJaWYgKGF2YWlsX21zZyA8IG51bV9tZXNzYWdlcyAvIDIpCisJCQl0c3RfcmVzKFRXQVJO
LCAiTnVtYmVyIG9mIG1lc3NhZ2VzIHJlZHVjZWQgdG8gJWQiLCBhdmFpbF9tc2cpOworCQllbHNl
CisJCQl0c3RfcmVzKFRJTkZPLCAiTnVtYmVyIG9mIG1lc3NhZ2VzIHJlZHVjZWQgdG8gJWQiLCBh
dmFpbF9tc2cpOworCQludW1fbWVzc2FnZXMgPSBhdmFpbF9tc2c7CisJfQorCiAJaWYgKHRzdF9w
YXJzZV9pbnQoc3RyX251bV9pdGVyYXRpb25zLCAmbnVtX2l0ZXJhdGlvbnMsIDEsIE1BWE5SRVBT
KSkKIAkJdHN0X2JyayhUQlJPSywgIkludmFsaWQgbnVtYmVyIG9mIG1lc3NhZ2VzIGl0ZXJhdGlv
bnMgJyVzJyIsIHN0cl9udW1faXRlcmF0aW9ucyk7CiAKCi0tLQpiYXNlLWNvbW1pdDogNGEwZTNh
OGZhN2I1OTI5NThmOGUzY2QzNjZmNjNjNzhmYmE5ZjAxNApjaGFuZ2UtaWQ6IDIwMjUwNTEyLWZp
eGVzLW1zZ3N0cmVzczAxLTQxNTdjZWI1NGIzOAoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBC
LiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
