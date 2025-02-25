Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901AAC021BB
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740501686; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=YyTnR7z0P3TNqEoDQ266N7Xa5oowwYDhgyLADOEVor4=;
 b=PY5ho1ish53YTSPRsOqu4XTHRiDw3UuCZuAzo2wqXTOjon9YwMOytBicD1/KTAEm1KQqK
 gzPLFXzD8WJbpSdq6yGEEZ4OA+IEELf2LdizvtK7t30ttmSnYx+VR1+RGkUv1pJ/J2V5se8
 tBnTdRAJ2kQrznGVkYPgrb/hjgFoSh4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0A183C9C34
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 17:41:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 820403C9B53
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:41:03 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0C7D637A8B
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:41:02 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb7f539c35so1129296666b.1
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740501661; x=1741106461; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cClEzt8/E3D1dfxcnnLbIpJyLbCsF/846IwktxsROzg=;
 b=ZAJeek9zIgCf2PTlVriSxaIge4FceO4YLX/INP/vp4+TVfk6Q140fBmF2tnxK9fK3l
 BAtiSAEDnW6lM6nKHC9cf2AfjrIo5wpn68TEEPXsn1Kui/Kk9T7v//0Te31BmawQIN5t
 TxZUb5awh2PZ0JV0skJNsKo0gLOdjiIDTveHT0g7nQZUmze9pGGPsyqSww6B7k8Ydl1R
 DY1MgnLn9u7VO6hPWaehTv5GBQAWCaG7tDPG8vnSe7HqsT/4jL3kfiYywlKHkOF/8ftC
 rT6pDYtHETw0HEiEg06wlBfOxiGVqLas8NVv2oM/ocf7K/IV0DDZeF/f//nkNAKPL2s5
 2C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501661; x=1741106461;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cClEzt8/E3D1dfxcnnLbIpJyLbCsF/846IwktxsROzg=;
 b=j14hBoEebALiLfn1jlMP+g9kAgDbtkRopOkRoH/gREYLGsDCS/fvovaRa+5TaGwYfw
 +diaU8G0+G/JYUXw+pbBE2kO5BbiYdvcjcbTYYIfnn0zPX0TjC75nKM33Mszgzq1gzqm
 tw2/AwgrSZPiHk95mU/8qzV4jvh08pi3lpVZOFkPAq7mvhuauFpbiKQ+FZYJOMkAcLm+
 1CC6PZCeXCpd/fmFVmK3IDRCqw0E2HMiWfRndGQu2dONWLJ5/mN+j8Jw8ZU0AJ+Prwjs
 vG31vNKcsXLC053h3QlA006VYuljoxJqK8d1qPMNOR+SotJ7XnP9rlrFUTS58M7WMbqB
 VSGw==
X-Gm-Message-State: AOJu0Yw0zw5Nj6r6c4Odom99VY42CO4olimX5MxDgN0Z3ZlGJDThGagq
 8aaklU/+p2+CSa2bmlZKW1Z/WVvYsjfOtRJ5s6IeXraHsNwtc+fP4/04Z7ndnfXUGgW4DW3++DE
 D
X-Gm-Gg: ASbGncucmho4CZyrN0Zyyr7NUJcdCKQhIkOxuynBcQaKl5fAhLSZDjvRWHWxVsbTUGp
 hwcMl4dCkMp3QfQZmtJ2CeIfB+H+6hpxttxzuqIYow48dwov7vACa5wSwm0jFGVx2ez5h8m+Wnu
 Q3eyCmDlS0kj4HKpr4WJYob70O/Dz4gpiQvJoz1CwoiSZlNA2hMcw9ZV1D0BDu75YPdGW6ttpHh
 8yByzZbYvhg8T+jmNRnu6RraiotqYl8smEvNtnwf5fCFbaJgxlxJIRtoAilbs5vyCZFSrW7JLEt
 YtJC6OexbaGfTvA=
X-Google-Smtp-Source: AGHT+IEcB31zMEQFA0hTP3Lj31yDc3A07jrhHZBHHe8YUwbch8JTiHTp/zwGYxhEO9ZrzOrVwo1RcQ==
X-Received: by 2002:a17:907:96a1:b0:aa6:8d51:8fdb with SMTP id
 a640c23a62f3a-abed0ce9953mr351588266b.19.1740501661411; 
 Tue, 25 Feb 2025 08:41:01 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2230a0b0e38sm16489955ad.247.2025.02.25.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:41:00 -0800 (PST)
Date: Tue, 25 Feb 2025 13:40:58 -0300
MIME-Version: 1.0
Message-Id: <20250225-disable_virt_other_getrusage04-v3-1-47cd3fbc845e@suse.com>
X-B4-Tracking: v=1; b=H4sIAJnyvWcC/42OQQrCMBBFryJZG2mSVokr7yFSJsnYBrSVmRgU6
 d1Nu+pOlw8+7/2PYKSILI6bjyDMkeM4FDDbjfA9DB3KGAoLXemm0rqWITK4G7Y5UmrH1CO1HSZ
 6MnRY1dLb4DSAxb31okgehNf4WgLnS2EHjNIRDL6ftXfghDQP+8hppPdyJKt5/nczK6mk8642B
 q52b5oTPxl3fryLOZn12tb8tOliO6hgFQRE09iVbZqmL1A9hlsyAQAA
X-Change-ID: 20250224-disable_virt_other_getrusage04-c9db2aa9e69c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=rbm@suse.com;
 h=from:subject:message-id; bh=jvqUmKFvdiv1aPwxgPt+7fpgova7RFTBvys7/9CZ7No=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvfKaFnslfLCsW8ReXnp1OCDDY/GTKgUocYt7h
 ZciBqx/3LKJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ73ymgAKCRDJC4p8Y4ZY
 pvf8D/kB+RidxX6o58J40O/yJllvzpS5GI5CiAzYLQQeqVvGpkImlAxRnPQ6gyaXMhawUvAEEzw
 NSEPm9HqeLW6Ek1OBmLzKMALuDBRU/DewRQ8BtgXCh+57+x7+ivRDjXw9jZCXxoFQ5tqMJDP2kq
 neDX3XRlABfyRr1tnApI2x4GvbGwJPM0c7RP2d7ChBVXNYQ+MEFOerRYEQZRylxOcMDKFPq4Npd
 EkHx8MTimYYnZGq4MZlO4PMf+AblUgzBhbENbuZEBdNIOzKY2Qvq6h7CpUc62dhVCNZEGYogFtV
 5lzox2umOARXMGEH4rF/nTa9DNHLWgqJPy+SdLahBECyO2ZG02XI+Xm988fumH7YAj3qQVDVL4a
 b4Z+jfJmcSWSYl1i5pTuX2irR7uxwcq8Y7oocKKNhUOsGKfTYu+oKM+1/5udbVT7punro4RbVLh
 ZxpZQYJL5Bq+dSXQBTfgWHJ4lUBq5CPnDBNyi1vGrdXy96ohQut3dqcMk9Mm+koWPQ7w6tqefSU
 OZr4gPLBPUOgII1WgaEKZtJIUb+klYYe6y/wJL3MC7OYKPtfy7nnXJE1XpuuWfQdvR7W9xQXG2G
 nRM9Dz/RdBWQ4YYC/gMRF9xegHq2r35jEtOekDO/pM5b0ypQMuUmCas/D+QVf11l4o5hqOL1h5A
 IUpWOQ4OQqtGffg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/getrusage04: Disable for VIRT_ANY
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkRpc2FibGUgZ2V0cnVz
YWdlMDQgdW5kZXIgYW55IHZpcnR1YWxpemVkIGVudmlyb25tZW50LCBhcyBpdCBpcyBrbm93biB0
byBiZQp1bnN0YWJsZSB1bmRlciBzdWNoIGNvbmRpdGlvbnMuCgpTdWdnZXN0ZWQtYnk6IE1hcnRp
biBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KUmV2aWV3ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1k
b3VjaGFAc3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KLS0tCkNoYW5nZXMgaW4gdjM6Ci0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlCi0gTGlu
ayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDIyNS1kaXNhYmxlX3ZpcnRf
b3RoZXJfZ2V0cnVzYWdlMDQtdjItMS03MWQ5MWFkZWUzNTlAc3VzZS5jb20KCkNoYW5nZXMgaW4g
djI6Ci0gVXNlIFZJUlRfQU5ZIGluc3RlYWQgb2YgVklSVF9PVEhFUiBmb3IgZnV0dXJlIHByb29m
aW5nCi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDIyNC1kaXNh
YmxlX3ZpcnRfb3RoZXJfZ2V0cnVzYWdlMDQtdjEtMS1iY2I0MzNhZjk2MzVAc3VzZS5jb20KLS0t
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5jIHwgNyAr
KysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2Fn
ZTA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5j
CmluZGV4IGIwM2JjNTQ5YmQ4MzViMzNhY2FhMDI2OTM3MDYyNTVlODhjYmU0ZjguLjk4M2RiMjY0
OTY5MGU0MzE4YjYyY2UzMzQwMTkyMTAyY2IxZGFjZjQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYwpAQCAtMTk4LDkgKzE5OCwxMCBA
QCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQogewogCXRzdF9zaWcoTk9GT1JLLCBERUZfSEFORExF
UiwgY2xlYW51cCk7CiAKLQlpZiAodHN0X2lzX3ZpcnQoVklSVF9YRU4pIHx8IHRzdF9pc192aXJ0
KFZJUlRfS1ZNKSB8fCB0c3RfaXNfdmlydChWSVJUX0hZUEVSVikpCi0JCXRzdF9icmttKFRDT05G
LCBOVUxMLCAiVGhpcyB0ZXN0Y2FzZSBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMiCi0JCSAgICAg
ICAgIiB2aXJ0dWFsIG1hY2hpbmUuIik7CisJaWYgKHRzdF9pc192aXJ0KFZJUlRfQU5ZKSkKKwkJ
dHN0X2Jya20oVENPTkYsIE5VTEwsCisJCQkgIlRoaXMgdGVzdGNhc2UgaXMgbm90IHN1cHBvcnRl
ZCBvbiB0aGlzIgorCQkJICIgdmlydHVhbCBtYWNoaW5lLiIpOwogCiAJQklBU19NQVggPSBndWVz
c190aW1lcl9yZXNvbHV0aW9uKCk7CiAKCi0tLQpiYXNlLWNvbW1pdDogYTFhZWJmZDRkOTlkNWRh
MTI4MzRkYWU1MjE1ODE1ZmY4ZDgyOTk1YwpjaGFuZ2UtaWQ6IDIwMjUwMjI0LWRpc2FibGVfdmly
dF9vdGhlcl9nZXRydXNhZ2UwNC1jOWRiMmFhOWU2OWMKCkJlc3QgcmVnYXJkcywKLS0gClJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
