Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A3BCAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758538258; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5Kh9juoq8vr1cfa/1uAb36eMidX9Cbb0Lbb9TWIxuIk=;
 b=KGiAVxzSgZsA1ojfEgrg3Dh5ZDvej/3WXUUZe6SMayP4P2hRmJsv/xrdAqG/wNt1eltGg
 muRwkuaWHo937GuZdSSjZz/XY8P9MRrF49cElcPH2iSWrstiQNFgNa7kF5rMUELSqg1DFrr
 LPsymoA5/xwI6pw3qKUG0T0+7n7a2X4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FE933CDE6C
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 12:50:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C6913CDE5E
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:49:52 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BE661400B61
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:49:51 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso4560466f8f.2
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758538191; x=1759142991; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3H46l7DS4KOEOub2HpyqGGX5PyVJ3M+aWzjUNaPdzqc=;
 b=TvNLMCTDIwJpIOmr3vZWMU6RHFiAQ3mKrZXCR35/ZVlWQdUIMS3H9Unw40udM6QUU1
 wsSsfKA6wmIGWSVmftshzpgoAOFfUu+0VpvENLD9WV6YRIQuHvLbXxNXVOh/eqymyQiJ
 pdEAyQROOmYj4OkX9fpdZ7LSBEt/mRHvBnn00R6LMUorAswwJVXYCeAlcxFIPYmwU8L4
 71Mi4Qs/3qSmjeJE7sAl/NAg90DQw5ciAqJtvB726VORSiqrIv6waojHJxyMUOVDmSnD
 tMcjJYTui00e1H+UKin5HfQ1Wu1u3iprSbDvIJDvJGfY3Wko6GED1eF0xQ0ffjHJtJF9
 UNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758538191; x=1759142991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3H46l7DS4KOEOub2HpyqGGX5PyVJ3M+aWzjUNaPdzqc=;
 b=wzIeNUXsiRbCT+nstWsIygmuiN5w5dK6al7sJOCFGXPqk0+FyyZvB/VyO5rYOGFudO
 GYWpLLFgqFIJq2YbQGxUn/tBluO137M2tJaDxnlvaXuGNs+CFxeNUz8URZJF1kIxeFw1
 FkP3f1j25lGOCgScNMxXvxbCAuJTOG4yJyhj0QFaPUlnT7wEHZuSskBLJ3rLgYOlZbSm
 yw4JDkkXfPge7IjiDKuy+iuhKq8ZE0GK0SxY09J/uMnroXO+xMZolvugRLCvYdQXk+EA
 O4ixuNQFVFqdwHyYIrcaVIoF4fh/Z2SYxTjHnZgSkVi9tgUs9kD0+aUY7J2JNokT6eJJ
 govw==
X-Gm-Message-State: AOJu0YwNrQ8iYtJTnuXlGQ8Gz8nvI/BMBXdKfX8CbNvtXt5C/Xfxk3oi
 ZZ5eKiljGgDIphBEgRCzBpzNNRu6PcX88aG+os9C9unQY3G7hiXGUVe/S6qalEQuOQw=
X-Gm-Gg: ASbGncvaYfTss04JXVmZYZuIXIoHqJnK8H2KN1stNnGnk2HPyAh2ypOej3WGLBoPgif
 CwY7bkNJLRP6+nahqZfPXquYQXGLAtAFwevk4CKNyR6FlncWaD8HXIZbbRuSeUnEBwp4Wl3cWkM
 /cFptupNT2puX0lgMkRbND4dbuI8SbVAR4NxlFoWsXioxeIiBbEzH2OMUqTxDiiPc3bDY1wYmX8
 1yM6wqn/RHdrJRXu6IVuJlPi6IRa8uBKoxfRh9METm1PNPUBifcriOE/qPu/KAyrbVRONcPvjsg
 efFycSPntDbbiml8Gb2NVeel9fvxX2vn4ToR0woOdgbjWEe67x4+INehVC5uMR+iM6ngSm9e+Dp
 34cGlbkME8Q==
X-Google-Smtp-Source: AGHT+IH2+ZyutrMbl+8orusSqzwovkrrc+94dgMx1Z+DjxMKnyHU8zwT5d+78GmYp2mmPlthJwp+gg==
X-Received: by 2002:a05:6000:22c7:b0:3eb:df84:62e with SMTP id
 ffacd0b85a97d-3ee7c5535d9mr11116123f8f.3.1758538190909; 
 Mon, 22 Sep 2025 03:49:50 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4bda15f5796sm68259311cf.11.2025.09.22.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 03:49:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:49:06 -0300
MIME-Version: 1.0
Message-Id: <20250922-fixes-pthread_rwlock_rdlock-v2-2-21802b93c2e0@suse.com>
References: <20250922-fixes-pthread_rwlock_rdlock-v2-0-21802b93c2e0@suse.com>
In-Reply-To: <20250922-fixes-pthread_rwlock_rdlock-v2-0-21802b93c2e0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=rbm@suse.com;
 h=from:subject:message-id; bh=dx9lLqfAZANUBIjVE/mo3HM4Rb7s6CyIIUFimp4mL9A=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBo0SnFu+ckD3/rMn0jKnZwzZbdArf4O+IAELtnG
 XDUOJZt6HmJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaNEpxRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKYGzA//Y9D8YC/MR8aSVI6E3+/+PfkJEBIk4WI
 ae3E8QJIWkCtLfY+edbihoFmy3iF5IT+Eipo3/KYCNM1ygZWD3hDocl+GegglCEfOwHiT3EIuE4
 z2Bn2kM1l4tWdUXP3gPPu4bTy3cVcd+4fc4ue+RbbFOi+FBmFLt9FnTvjyVUyoo2Z3eThTAYQgB
 hJP0B8YgOJm8ldV4VpwwphJWBAtOyI8l3crM0J3gtvM9r8AD0WemLHxyex2bgZrogKsm76/mO/V
 4J1wRH8TrlbJidiSiMn5gRuqKATrVJwR+ifCphcHxDGyU0l2fD+TCiuW5EBv/+5ijPQMjYYErh6
 d1+J2wu3qk7IqvT8NqpSAlzVBSvtT45F7vsnfYZX0r5N/v3YLnt+koC+8i8mvF/s5HPS77MLmvn
 spMfFLwF5NiWFCWCHcJASO9bfL/yc97exT6ROxHpJJM+hGaiPNr6I3WaHVTpi+Q2hRAAn7mv2LC
 V2XeGZ5gbrKmbAG7Fpu5QZ1tPKC6u5BCCJKxbFG8XtZESjx7ErrZmq5FEK/ZyF7o1ymikLzeH3Y
 0qiFJ1M5/kQTq867AgUPAQ/zhgYnUAWLztQGcwK8l9fw1jed+adNq0Pg7O9dS1fhb/41tGiwULU
 BjH+XLgeEL0lxIYL2Q39T/NfA5az/O7nvBILPuMErCJ3LUlE6QaM=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] open_posix: pthread_rwlock_rdlock: Add GLIBC
 workaround
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkdOVS9MaW51eCBkb2Vz
IG5vdCBzdXBwb3J0IHRoZSBQT1NJWCBzdGFuZGFyZCB3aXRoIHJlZ2FyZHMgdG8gdGhlIHNlY29u
ZAphc3NlcnRpb24gb2YgdGhpcyB0ZXN0LiBXb3JrIGFyb3VuZCBpdCBieSBtYWtpbmcgdXNlIG9m
IHRoZSBub24tcG9ydGFibGUKZmxhZyBQVEhSRUFEX1JXTE9DS19QUkVGRVJfV1JJVEVSX05PTlJF
Q1VSU0lWRV9OUC4KCkxpbms6IGh0dHBzOi8vc291cmNld2FyZS5vcmcvYnVnemlsbGEvc2hvd19i
dWcuY2dpP2lkPTEzNzAxClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1A
c3VzZS5jb20+Ci0tLQogLi4uL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9yd2xvY2tf
cmRsb2NrLzItMS5jICAgICAgICAgICAgfCA4ICsrKysrKystCiAuLi4vY29uZm9ybWFuY2UvaW50
ZXJmYWNlcy9wdGhyZWFkX3J3bG9ja19yZGxvY2svMi0yLmMgICAgICAgICAgICB8IDggKysrKysr
Ky0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50
ZXJmYWNlcy9wdGhyZWFkX3J3bG9ja19yZGxvY2svMi0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX3J3bG9ja19yZGxvY2sv
Mi0xLmMKaW5kZXggZmE1N2U2NDk4NWVmNDZkYTE0M2QzZjMyM2JiM2M3MjdlZWIzZGI2Ni4uM2Iy
N2EwYmJiYmRmYWFkZjM3ZmE5NGUxMjlhOTM3Y2RkOWU5ODZkYiAxMDA2NDQKLS0tIGEvdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9y
d2xvY2tfcmRsb2NrLzItMS5jCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9j
b25mb3JtYW5jZS9pbnRlcmZhY2VzL3B0aHJlYWRfcndsb2NrX3JkbG9jay8yLTEuYwpAQCAtMTQ0
LDEzICsxNDQsMTkgQEAgaW50IG1haW4odm9pZCkKIAlpbnQgY250ID0gMDsKIAlwdGhyZWFkX3Qg
cmRfdGhyZWFkLCB3cl90aHJlYWQ7CiAJaW50IHByaW9yaXR5OworCXB0aHJlYWRfcndsb2NrYXR0
cl90IGF0dHI7CisKKwlwdGhyZWFkX3J3bG9ja2F0dHJfaW5pdCgmYXR0cik7CisjaWZkZWYgX19H
TlVDX18KKwlwdGhyZWFkX3J3bG9ja2F0dHJfc2V0a2luZF9ucCgmYXR0ciwgUFRIUkVBRF9SV0xP
Q0tfUFJFRkVSX1dSSVRFUl9OT05SRUNVUlNJVkVfTlApOworI2VuZGlmCiAKIAkvKiBtYWluIHRo
cmVhZCBuZWVkcyB0byBoYXZlIHRoZSBoaWdoZXN0IHByaW9yaXR5ICovCiAJcHJpb3JpdHkgPSBz
Y2hlZF9nZXRfcHJpb3JpdHlfbWluKFRSRF9QT0xJQ1kpICsgMjsKIAlzZXRfcHJpb3JpdHkocHRo
cmVhZF9zZWxmKCksIFRSRF9QT0xJQ1ksIHByaW9yaXR5KTsKIAlwcmludGYoIm1haW46IGhhcyBw
cmlvcml0eTogJWRcbiIsIHByaW9yaXR5KTsKIAotCWlmIChwdGhyZWFkX3J3bG9ja19pbml0KCZy
d2xvY2ssIE5VTEwpICE9IDApIHsKKwlpZiAocHRocmVhZF9yd2xvY2tfaW5pdCgmcndsb2NrLCAm
YXR0cikgIT0gMCkgewogCQlwcmludGYoIm1haW46IEVycm9yIGF0IHB0aHJlYWRfcndsb2NrX2lu
aXQoKVxuIik7CiAJCXJldHVybiBQVFNfVU5SRVNPTFZFRDsKIAl9CmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFk
X3J3bG9ja19yZGxvY2svMi0yLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29u
Zm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhyZWFkX3J3bG9ja19yZGxvY2svMi0yLmMKaW5kZXggZjZm
ZmRkZmJlNDE3YTdhZmZkZjExMTRiOWNjMmU5N2JjMDlmOGZhYy4uNDc5OWIxZTg4NWNhYWI1MDlm
ZDMxMTczYzM0YWU4OWJlYWNlNjhlNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhf
dGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9yd2xvY2tfcmRsb2NrLzIt
Mi5jCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRl
cmZhY2VzL3B0aHJlYWRfcndsb2NrX3JkbG9jay8yLTIuYwpAQCAtMTQ0LDEyICsxNDQsMTggQEAg
aW50IG1haW4odm9pZCkKIAlpbnQgY250ID0gMDsKIAlwdGhyZWFkX3QgcmRfdGhyZWFkLCB3cl90
aHJlYWQ7CiAJaW50IHByaW9yaXR5OworCXB0aHJlYWRfcndsb2NrYXR0cl90IGF0dHI7CisKKwlw
dGhyZWFkX3J3bG9ja2F0dHJfaW5pdCgmYXR0cik7CisjaWZkZWYgX19HTlVDX18KKwlwdGhyZWFk
X3J3bG9ja2F0dHJfc2V0a2luZF9ucCgmYXR0ciwgUFRIUkVBRF9SV0xPQ0tfUFJFRkVSX1dSSVRF
Ul9OT05SRUNVUlNJVkVfTlApOworI2VuZGlmCiAKIAkvKiBtYWluIHRocmVhZCBuZWVkcyB0byBo
YXZlIHRoZSBoaWdoZXN0IHByaW9yaXR5ICovCiAJcHJpb3JpdHkgPSBzY2hlZF9nZXRfcHJpb3Jp
dHlfbWluKFRSRF9QT0xJQ1kpICsgMjsKIAlzZXRfcHJpb3JpdHkocHRocmVhZF9zZWxmKCksIFRS
RF9QT0xJQ1ksIHByaW9yaXR5KTsKIAotCWlmIChwdGhyZWFkX3J3bG9ja19pbml0KCZyd2xvY2ss
IE5VTEwpICE9IDApIHsKKwlpZiAocHRocmVhZF9yd2xvY2tfaW5pdCgmcndsb2NrLCAmYXR0cikg
IT0gMCkgewogCQlwcmludGYoIm1haW46IEVycm9yIGF0IHB0aHJlYWRfcndsb2NrX2luaXQoKVxu
Iik7CiAJCXJldHVybiBQVFNfVU5SRVNPTFZFRDsKIAl9CgotLSAKMi41MS4wCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
