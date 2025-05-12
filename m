Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF188C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747049028; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ms5pEfkqvuxlOSFcIJrstGpNU4Y9WdKR8382gdPLWus=;
 b=KHvbBL7ZW5XBVQ27ALA2KvfFWJteJEzo6LIax1sRxqotQiamas3VAAAcwOuDLqbK3YsQb
 Yo06vwZKL+RtwxBehwmvC2qtev0F4vsIJ9hFA8nm+mEjGeOHafKxZljLfTms+tWh9uSg7P+
 wfe3ZxwEHUfNxZABNv8B/x1QHLWnmgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44E333CC2BB
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:23:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876E63CC26C
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:23:27 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 42F7F6001FE
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:23:26 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so31050515e9.0
 for <ltp@lists.linux.it>; Mon, 12 May 2025 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747049005; x=1747653805; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dW9u7m9VuCtaBp8h1xaL12zzDxQO4coYJAyE6sVBaBU=;
 b=AGfiiIxZBwTdjs07CJrqP4H2gpP75ivlQQu2mOZqO6Ozd1giCbIQ6W/yU7yBn4JOAy
 g8X4A5WXfRZ5OeIXrj46rVOVBCVt5YHmAME9Cmvk54YYdTlQ6uj/QgOgj714zAZR42ZJ
 OUzHk0lM0mn61BEA3axpElpFfcvH8JYYrPKabSZbCACBA7NMkJJIlDRnE5EbeG/U4gZ2
 dJtcwBwimpvGGSzH1Klw7hbQQpLbTo3USAxpodNHqNS+UbV8zXayLHBDbYto+KpsawIR
 CPVelRHUssiMD4bbEvNebvhcJMcR14iZBXufsBpe+mPFkNEZhEdDGt+NeETvj9qszmZZ
 GhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747049005; x=1747653805;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dW9u7m9VuCtaBp8h1xaL12zzDxQO4coYJAyE6sVBaBU=;
 b=qUki1RwGFIpfs8aMe7RNJSpxvj3a5n/4prorBblCc2akC//Ck1ZWb+KiMMI/G+m4tC
 hh3IGAo15LM9bRHhx1AvojotVPbqy7+IKA2ykduYyWBdmym3iaGWwxUGOWhUmYD3GJed
 QL62foEy9FLBWSutU4n/sxTH82oV21vJefXPaAIrpEBLVmMpmOXptcz/tVw02k3kCjNd
 QeJPnriX/nAZE65BxiijH4E74rQRQx720km5rmyegPErRp2aPDkUEUtapqeeF9TD3ZSk
 40tQDmEfmVscW5xL4Vkx+4Os7UnfHGbyYMca+hK3D1LbTEa0eKWqtYdTBrWPBmNNS8od
 DQkg==
X-Gm-Message-State: AOJu0Yzn6yyH63rKnP9fCGSbRsKjI71wm2d7NpqidN1s5DJm7AZ4kVxh
 RljlY5P5KYF9XznBcRFK0KfMlvL1rPqiemX/a9HSneoGt1Rta6w7lAGygdJMbB4=
X-Gm-Gg: ASbGncuInFY2toDw/ip6ZTELaTcsliGqtFphNm5nFJBCk8HCe4qTBTM1onY8uB6UyVB
 RODKJJRurvtNS+NRStzfnz1lqnlaQvC36weI/EiepPlDPiLJ6j36lHoctQiMI2lhfKBPiMLUZTW
 5SCD/AftiHdQp4frEqPS+YyCaiWK9h8MgtG9r7Rx1hi/fGO2hXXJk5VPFU6bK7yS9b+pKP++RY3
 4gBmTRW+evGLCGHFeaJl/j+ehLa0LSeNmc5n1tdfuXA+hCCLr1dFMdqPBqjBkF3uk7gpSOBkhZc
 VEd1LsbEazw0GFD6JYh7ULVae88W3F1OkyrzsMY=
X-Google-Smtp-Source: AGHT+IEe/0TNJhAdN1MS0CG0BCdD+lVR3C19TlyLlvoDnSgtJ1tMOsUO3EXZoixkqRJv5K3hDSjZkQ==
X-Received: by 2002:a05:6000:2509:b0:3a2:133:b1a2 with SMTP id
 ffacd0b85a97d-3a20133b60amr5593467f8f.13.1747049005656; 
 Mon, 12 May 2025 04:23:25 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-879f6198699sm4860742241.18.2025.05.12.04.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 04:23:25 -0700 (PDT)
Date: Mon, 12 May 2025 08:23:20 -0300
MIME-Version: 1.0
Message-Id: <20250512-fixes-msgstress01-v1-1-d335f7c131c0@suse.com>
X-B4-Tracking: v=1; b=H4sIACfaIWgC/x3MwQrCMBCE4VcpezaYxAbFVxEPSRzTPTSV3SJC6
 bu7evxg/tlIIQyl67CR4M3KSzeEw0B1yr3B8cNM0cfkU4juyR+om7XpKlD1wY0hnStKGsvpQta
 9BP+RZbe7uWSFK5J7nX5Pi3DjfpyzrhDa9y+ilmYfgwAAAA==
X-Change-ID: 20250512-fixes-msgstress01-4157ceb54b38
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=rbm@suse.com;
 h=from:subject:message-id; bh=4FPx1/oS1N3+deFhgwaqCRBhUJNtjJkW/+n9RdAlWVw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoIdoptA55x2k/MG2lTeRoKCEvwKjQvvIe+P7nM
 KKTy1bOe8yJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCHaKQAKCRDJC4p8Y4ZY
 pi0WD/wIdEoob1THnycRo+oaPSNN8zpfSYyb7ElAEeogoDwqotjgi1VxFs+ARMx4IVytXWgFuBH
 8j9bgA3hmBJkebPP7afJzTcJkufBoLy+1lzpmYeQYyGZ38ffT7bAIYKgOule5W1W3fCStTWt7t+
 lSOsKd9tmTXDWdhcENx97toTWp/QS/s6ssZ9ci8nOQjKBsUfTNTQH1fMQ5eKKtPpvvTXtj1a2tm
 VSpTzHwdymp8lBtpvWP66q8sR3Gcg2tcgm4SeP+Rn+UeNXQ13Afg1NNXP0s5Xa+TTqPQ+71wMG1
 CtTJ9CTBG3ccJkuxICeB1S2Hx/31yn/BXA1++EM+auRnU3KA9bh4H046f3uY8/fizuJIDlN2ZUB
 McoFIMi3om4Q746p0O/p1ASZ8eVkacVVrObiY/XIaMASPXW+FXnks6YJ32cTEfVTIulQ8xZCG4Y
 vsT7dJJefql8uHOlxrbpLdRLEPs/MRSSfvZ45gkAjWUR1kJTjgEV00zSDp7czvDiW149Iy5q0fj
 vJkEbxCLMJ1BD1j4kEqqcG9vr6Rom5rk456KWlUey4i6yoEZXteMyK71Xgn9X//BGA/TPi0a25V
 8MUG4LL37SPdctg3s38lV7sL/7ywRUpMgDvhBJ8fGrjxu2ARl4yQbCdqUJ5GGz1gmqAq0X4k0IE
 tlAQHLnsyySaLew==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/msgstress01: Set upper bound for num_messages
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
aW4gbG93IG1lbW9yeSBTVVRzLCBzbyBhZGQgYSBNSU4oKQp0byBmb3JjZSB0aGUgdmFsdWUgb2Yg
YXZhaWxfbXNnIGludG8gbnVtX21lc3NhZ2VzLgoKU3VnZ2VzdGVkLWJ5OiBNYXJ0aW4gRG91Y2hh
IDxtZG91Y2hhQHN1c2UuY3o+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+Ci0tLQpIZWxsbywKCmFzIGRpc2N1c3NlZCB0aHJvdWdoIEdpdGh1YiBbMV0s
IGhlcmUncyB0aGUgcHJvcG9zZWQgZml4LgoKVGhhbmsgeW91LApyYm0KClsxXSBodHRwczovL2dp
dGh1Yi5jb20vb3MtYXV0b2luc3Qvb3MtYXV0b2luc3QtZGlzdHJpLW9wZW5zdXNlL3B1bGwvMjE5
NzcKLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dzdHJlc3MvbXNnc3RyZXNz
MDEuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dzdHJlc3MvbXNnc3RyZXNzMDEuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMS5jCmlu
ZGV4IGFlNjM3ZTVkN2FkODljMTI1N2M5Y2NlMDE0NTEyMjQ5N2MxOWVlNjQuLjM1MjViMGIyYjk3
M2IxNzRhYzhkZjA4OTU4MGE4NWMxOTA1N2YwNWUgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMS5jCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9tc2dzdHJlc3MwMS5jCkBAIC0yNzEsNiArMjcx
LDggQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIAlpZiAodHN0X3BhcnNlX2ludChzdHJfbnVt
X21lc3NhZ2VzLCAmbnVtX21lc3NhZ2VzLCAxLCBhdmFpbF9tc2cpKQogCQl0c3RfYnJrKFRCUk9L
LCAiSW52YWxpZCBudW1iZXIgb2YgbWVzc2FnZXMgJyVzJyIsIHN0cl9udW1fbWVzc2FnZXMpOwog
CisJbnVtX21lc3NhZ2VzID0gTUlOKGF2YWlsX21zZywgbnVtX21lc3NhZ2VzKTsKKwogCWlmICh0
c3RfcGFyc2VfaW50KHN0cl9udW1faXRlcmF0aW9ucywgJm51bV9pdGVyYXRpb25zLCAxLCBNQVhO
UkVQUykpCiAJCXRzdF9icmsoVEJST0ssICJJbnZhbGlkIG51bWJlciBvZiBtZXNzYWdlcyBpdGVy
YXRpb25zICclcyciLCBzdHJfbnVtX2l0ZXJhdGlvbnMpOwogCgotLS0KYmFzZS1jb21taXQ6IDRh
MGUzYThmYTdiNTkyOTU4ZjhlM2NkMzY2ZjYzYzc4ZmJhOWYwMTQKY2hhbmdlLWlkOiAyMDI1MDUx
Mi1maXhlcy1tc2dzdHJlc3MwMS00MTU3Y2ViNTRiMzgKCkJlc3QgcmVnYXJkcywKLS0gClJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
