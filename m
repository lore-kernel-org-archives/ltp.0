Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7CC83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 11:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753703756; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=PK0MCQQGCi5RIwF1Kq4i8ZwvNJGqNq8+O7r/Umi4uLI=;
 b=gn4sux2xplGB4kIEPlD7WhTAZnXahZ1ziee5ab2LE3CPD9z6IckW6p6xrAaOl51XuH0Zg
 msIlhrAV2dRR6iq/9eThw/Sk6o7p2Pc69NwuhRj3lYbXgknE/WpEyjOi+d2+DB/b3LPYRqK
 kmrZDAgeq5aXZqCZTFUURp+Oeyw6KjQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AD2B3C7AA4
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 13:55:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69CD13C4F29
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 13:55:35 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E33E1A00341
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 13:55:34 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so796900f8f.2
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753703734; x=1754308534; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zDcFxiu4mULHQM9X5+TTSBY6Ej4rSe7jjpc2iGvU54o=;
 b=V1cZqdgbac+8TnMcNusDr0UuFTeMw2L0n9EjuhRR7ix0YGRZ0pY6a38Ge0GfN4+1rx
 c/KGOAp/zAddXmZggQHLk+pG32YQGKOXJ46+d0RIgPaibpZ8HC4mY5Y9ZpfG4+Uq2Vky
 tP7VpRy8H91iGNZ1J6y04GZatLF4e/tH8vT6nCc2+XM/3k/W8BkxyrrvqwHFeV1u3g1g
 IzGCBbkRoB4xgqebA+W5g147KXWBYOGElkXX0paJNUqvvK6ciFfkaW/2JLSjK+B4L6nn
 qYv9wv4hATmqeAR3ktkyngJKOUTd3wwO/LJBUgximTTRykB6mMc4K99J9AJTidj0YPpi
 TK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753703734; x=1754308534;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDcFxiu4mULHQM9X5+TTSBY6Ej4rSe7jjpc2iGvU54o=;
 b=cpM+Hnds1W0IJEXW0xqii5qZUDaLU5O3XD1PzReX0/UrVwtsUPvGD7cI1Y02PYNXtv
 clXOkpQpT4hpo4oeEjxeelo5p1C+coIXKk51dOYKHSNVHqFl++PngSRwfUw7rPrix2qk
 otG/432iHofMIgqvmy0hUOeHdf4fTXVtVSaLXH/sQjT02QQ4TzG2SnkPivGLGV6vJkDw
 SCrBJgviRp0l3uN4j6jcCH4Q78b1Q35NgGT92KODJMKjyTa7zIZRs/4QJpxMbPqqGI79
 lYMaUA4GIuFkyenQ749tVyrsGRr7jjzsbGq9pjTNVqN+kln1uNNkBFXjuH99x8ERbt9o
 UhSQ==
X-Gm-Message-State: AOJu0YyKM5XN7HV/cOtlfe01MtmG5LyYfdyiyTOI/i7fR0I5y3frQZvY
 v9Znb3yEIKWc/XuwwUWMKsAejn9ewaj/tJg+EaH7yuUeKHtk3Zu78dOCrE2aW4VBxlBUOn7IohB
 p3aAi
X-Gm-Gg: ASbGncsQRnYn+eFOGNMvC2zncEmroSEYXjvqInHno5n+fDuZ6CxE/JpfEv1Isi1zTwz
 LpyIE64Gq1Z9lMpDuLIN3QrrNVX5Hps9BQXiam8fX7YLjfo4uVUEy/LZwiWnUzvPar2h4lYYJCZ
 Rqst7ZXmkxqak0bCRt5s5HaoaRtqXri2wyiutUaRUXdJJreD/YtToLYzbV9/S9BKZ1YbRZRc9+3
 nXZttyxRub7Q+ofccZqjzeCk9dJXNqVRwEtrda9k40k1uxmm1YXx0Kw+DFNsnhYrr4yQQ1jA9KF
 vUN+qsaSuTSagbR4CksCrIRljsqlAQItpENvBjUVRXUZ5z3svnZLFQ1ubww84dCZK5DGbz61cYu
 F1iIvqjV/rg==
X-Google-Smtp-Source: AGHT+IGMUIFQ4E+uYrE93i2i4wRuUSo72XCpJfLppWDOzLZBDccdc1CE4e0m7AxO+m/DzdTRK/nwOA==
X-Received: by 2002:a05:6000:40dd:b0:3b7:8362:fed8 with SMTP id
 ffacd0b85a97d-3b78362ff93mr4344540f8f.2.1753703733778; 
 Mon, 28 Jul 2025 04:55:33 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-24008efc073sm29752885ad.58.2025.07.28.04.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 04:55:33 -0700 (PDT)
Date: Mon, 28 Jul 2025 08:55:29 -0300
MIME-Version: 1.0
Message-Id: <20250728-fixes-munmap04-v1-1-e32ef11d594a@suse.com>
X-B4-Tracking: v=1; b=H4sIADBlh2gC/x3MQQoCMQyF4asMWRuI1ergVcRFWqOTReuQqAjD3
 N3o8oP3vwVcTMXhNCxg8lbXRw9sNwPUiftdUK9hSJQyHdOIN/2IY3v1xjPtkRKNu5oz1UOBiGa
 T/yKa8yVc2AWLca/T76axP8VgXb8eC82PeQAAAA==
X-Change-ID: 20250728-fixes-munmap04-02083c550c6b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=rbm@suse.com;
 h=from:subject:message-id; bh=gyGzYFHmiaaXUe/wszHMy9fGkHQ/1+/VqQjlAZVQjog=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoh2Uy/MILE0nye1ZL91vySVgrihsq7MZyGJR1x
 85ePnUMEVCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaIdlMgAKCRDJC4p8Y4ZY
 pmGQD/sERVPMjPNzmf9Z/2vA4ZI2ax1nwCI4ZvlOBFZmZZ7AozV7e5a/66XuegQRpw2V5QtEopO
 bvUqbhwtuz3jdLyNWNHqg30gngg902g4SFQOA8PME2JYe03+FJEP8WoO0A3bCQ/yts7wmA9oZHJ
 cc9i5ukfvYWAibsepF04D0obIJIZe5O+u1opcU9dxZ+qOYw/k1B1baIGmOhlJPB+defNr2Ph4MX
 iN0TKCXuMcrfQITIoAYisDf/1TRFYjbk16r/XGvA+K3g2Pki+lvlRrWHI4e6FOAt6MYy+PIjgi2
 lnsiIGDwp/GMCxm8jK+3huduaAG6Plv4Qbw6TVQNjgq8lzeXfkZFcJcxRpk0MfWaY19IOSV7htP
 XrxNFuNTkL73sJk1iHIcxsLr4nWUMa5Cxv5AtOh2N7KgrLixEahZ9+ttJkjAkeAhuZKppbUPUsg
 cpeVV5TPjpcQwfxn+okOJiBDlJ9GguOtOXiz/2ddTlCB4eAfxoihloHoGR15rijFneAMtrWjhf8
 HPtCvxV+S21MXNSu4huJDHLgpXWd5+hsmX058OfpEbe1eYCHvQhKpYtYeRF+cC0RwP69+/7vxDa
 N4L3IkHzEA+cqPSG8DE/qNiah7UW1cIfCe+B0jjaQXcStILjfAeRyCUdB8iM68lwmSY5n6748GK
 8iVd39F4++lxgSQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/munmap04: Stop using MAP_FIXED_NOREPLACE
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCk9uIHNvbWUgbWFjaGlu
ZXMsIG1tYXAoKSBjYWxsIG1pZ2h0IHJldHVybiBNQVBfRkFJTEVEIHdoZW4gcGFzc2VkIHRoZQpN
QVBfRklYRURfTk9SRVBMQUNFIGZsYWcgZm9yIHJlYXNvbnMgb3RoZXIgdGhhbiB3aGF0IHRoZSB0
ZXN0IGV4cGVjdDogdm1hCmxpbWl0IHJlYWNoZWQuIFdoaWxlIGF0IGl0LCBhZGQgYSBzYW5pdHkg
Y2hlY2sgaWYgbm8gcmVnaW9ucyB3ZXJlIG1hcHBlZC4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8g
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tdW5tYXAvbXVubWFwMDQuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVu
bWFwL211bm1hcDA0LmMKaW5kZXggZTA0NmQxN2E3NWY4Zjc1YzViMTFkNTY5YzMzZGE0MWQ3YWRj
N2QwOS4uZjU1YWE3NzBhOTlkMmZhY2I1MzIzNGZhNTkzZmEzZjQxYTE2Y2IwMCAxMDA2NDQKLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYworKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCkBAIC0zNyw4ICszNyw3IEBA
IHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAKIAl3aGlsZSAoMSkgewogCQl2b2lkICpwID0gbW1h
cCgodm9pZCAqKShiYXNlICsgUEFEICogdm1hX3NpemUgKiBtYXBfY291bnQpLAotCQkJICAgICB2
bWFfc2l6ZSwgUFJPVF9OT05FLAotCQkJICAgICBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMg
fCBNQVBfRklYRURfTk9SRVBMQUNFLAorCQkJICAgICB2bWFfc2l6ZSwgUFJPVF9OT05FLCBNQVBf
UFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsCiAJCQkgICAgIC0xLCAwKTsKIAkJaWYgKHAgPT0gTUFQ
X0ZBSUxFRCkKIAkJCWJyZWFrOwpAQCAtNDYsOCArNDUsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2
b2lkKQogCX0KIAogCWlmIChtYXBfY291bnQgPT0gTUFQX01BWF9DT1VOVCkKLQkJdHN0X2JyayhU
QlJPSywgIk1hcHBlZCBhbGwgJWQgcmVnaW9ucywgZXhwZWN0ZWQgbGVzcyIsCi0JCQltYXBfY291
bnQpOworCQl0c3RfYnJrKFRCUk9LLCAiTWFwcGVkIGFsbCAlZCByZWdpb25zLCBleHBlY3RlZCBs
ZXNzIiwgbWFwX2NvdW50KTsKKwlpZiAobWFwX2NvdW50ID09IDApCisJCXRzdF9icmsoVEJST0ss
ICJNYXBwZWQgMCByZWdpb25zIik7CiAKIAl0c3RfcmVzKFRJTkZPLCAiTWFwcGVkICVkIHJlZ2lv
bnMiLCBtYXBfY291bnQpOwogfQoKLS0tCmJhc2UtY29tbWl0OiA2YWY2MTk1NTJjZTc2NzYxNzFl
NDdiODg5NjRmZmI1YjA4NDk5YjM2CmNoYW5nZS1pZDogMjAyNTA3MjgtZml4ZXMtbXVubWFwMDQt
MDIwODNjNTUwYzZiCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
