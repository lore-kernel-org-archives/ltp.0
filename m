Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BA4CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756501375; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qiKaf5UQ8ZO9vEk5/7z3b3B3zVBNrE9E8xxwEuItAGw=;
 b=pCBkO2iv4BnQ4Q8i1uERRPbxvQxRGyVSrLIQvPlSen78glpG/3rDtXk6EuI0GxvXqnwdq
 V9DUQwmIBqjfjGmx5vJAUd6F4tn4syDmmDXUiuTUI5WvE3DC7n8A2tjmARAwv6WRXCWbFMM
 Rhe6mNBxDw/dw05LBKdJXf2jrpZJwAU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FE6F3CCA63
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 23:02:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32ADB3CD0AB
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 23:02:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A606C20004A
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 23:02:13 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7d497abaso14352935e9.0
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756501333; x=1757106133; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/9fb8POq3uvWHFvtExXze7dzlBbxmqBY7LjwHqFJ+s=;
 b=JfUx36ZhMYXP42m2LFLnlRYzATjAIPbvuYcKzWAMHF4NDE0CeoRTRIOcFWrVPpVY4v
 lSHK3prB31pk1WQY0pS/XiSGTbSVNTtzoLyOldfcLK0xFwXR1TjnP0/gvulpjkhgulYW
 LOBhcTKedVe10SufQCikl3flW0W5/SOUTAUEjfIm4+BBd7ZBQpmDZADlJgLwHRaWrNID
 LTqugP15d9J6V9ghiWpGG4Ustfc6BuwdZJJkXLmmOgI6smtMPLTjX0z230E/m3Wj89Fz
 MAq5XWKIJO0TkzHrmDPult54kGFr/ishOlx0EUq1TNEop0/sHaOaZvSuEfprZ874jV/2
 FfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756501333; x=1757106133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/9fb8POq3uvWHFvtExXze7dzlBbxmqBY7LjwHqFJ+s=;
 b=s/oU04Bv5IC6TRPZw1Ou4p98CmFBT/BXHFlfUgKP8TLV1hTSh3t6f+dm3V1rr7hhHk
 UuCbMsMPlzoC9zjuNAMTcrTu8nnBrUL0WZE+GLSP2YKwhy+fL9WNLRjUYQhpOhQpFHjo
 uEknLe5IPBCozX2ecoJgKZrO4TUrho3MxyGZwtlUeO5B4SHT7rUMULIEEMauT+xWs37U
 zsS0J8JZhl6FZ4YjxnrZGU3QR6CisaqjZO8pmyJZeXmNbyo2aWjcj+uRRFoAsQfVBNTW
 QHLbOLxFxHS50NZEohcV7haAc3vU643H9FWpgKbXx2rYkQW/wnI+Pci5Ip2Nsqzxhk5a
 SrtQ==
X-Gm-Message-State: AOJu0YzkSAHXjoiu0kwoImHLggWLL6sVNMrOVSg3zWswF3ALiBwbn4yg
 9rJ6OYOM4IBVRcA6qjFb11Yx4AJoevvSonPR6udgVYnnKL5SsbURO2T0fA57VHDFX3XEV7kJlem
 7q6bVHaJiDA==
X-Gm-Gg: ASbGnctl4ZR9n2RyA2LF1Xc0aZnx68mdgwC7Ea6z16r4BACzfjKD7rdXgjM8P3/PNZZ
 bFh5DImo6WCnQ4PINiltqbNwjOcp+7YVYPksOP2D4XERq3bpZe/+w86qmfqrTe8fnGPpnXUqnRK
 axXNeu1ZgC0eTMv05S3XlaCDAI4zpZftbF/Ibv4mIKpPQzt7qwlDRvp9xyRz90qiDjf1U6Z1BeU
 9wODWNPuTFH6P7I68FBgCpEeVWujeE6pWnH9OvPZr+37Ia1gBBFJwe1WOzpAnlNnW3TkG06CdKZ
 td5Dw/l+AWouejUzNLkhCHw6PHMobTkIP7GplvP1Jm9oPM8Dtki5PCQuL0UqtznGq41Y2SSwXd9
 +174C6y4J+qooyDzNGfFJ
X-Google-Smtp-Source: AGHT+IHZFCEFXU11KE8VhY2ONgBiNpQ3If1y8SjqkYFL04723VNm9r4SRKjMsZ+H7ElqAFi6sAPv4A==
X-Received: by 2002:a05:6000:40dc:b0:3d1:5c56:16a5 with SMTP id
 ffacd0b85a97d-3d1de3bd58cmr4305f8f.18.1756501332701; 
 Fri, 29 Aug 2025 14:02:12 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-722673c62f0sm6225317b3.7.2025.08.29.14.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 14:02:12 -0700 (PDT)
Date: Fri, 29 Aug 2025 18:02:00 -0300
MIME-Version: 1.0
Message-Id: <20250829-conversions-lchown-v5-1-7c3f25cd1de4@suse.com>
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
In-Reply-To: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=rbm@suse.com;
 h=from:subject:message-id; bh=Hwires67BmRGFajPCFScGmR4duFBmyY+UqvUIyHGsIk=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBoshVObELBuEaNnbJoZsZr2WbR5pkopgn3Bj1aL
 lqXpnMm8wqJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLIVThsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKYFBA//RxAJ3GnhqkfQcPDgMSf7FZJ5VtZvlAc
 ZzrdENMfxksatMa0DKn00Q2FsOOzyb0u0XxllpsQScdsLK3s5tERIVD2DRKv1Bos/RskCKCUXNX
 z816jjAfI+O2NKiVTLS4JCl7P6Iqu6VF33whFVuhMRLLGkYEBmfjSSkNVxQcjKVuIKjiTRMQKZm
 M9e3ow8FBc4NkAyNYYsgVesCbdp7N0crfX7RiMZpRRwLEBdo4aBsyDAB9ROwsZQcuWC1rw0rmMy
 pZ1a4lJsYnNh4pr9TAmIo2ZaRs9znTDrrdAusoPAR7O36+ahYarnrN1ux45utRO8EVaqWjf5tX/
 M1GFsW+KERiRPiqypAMClfcbz13P9JAK8Q0xp8OIBVA3Fo5zra8Htj7dC617VoZfgxDYvv5rDvU
 9pIjwnRG53I64l06fwSeovai12I99YAsBk8mhndUaf9gGTJ0wDP0y7vy+5fo/N1LD7N5IARweMD
 X9/4MFBlfG7RLXAdMykkimk1tTW1FtXVb0UTX8anKxrgFW6qVRAx2vICqF1kXfjUYHw6VmAShwT
 1MsdJx8D8gCmMrle4I9lCUsVA/33bYYrNxbOhZD9NKsTHuvNLVU8dZyxyP1pz/6aPEY+bqyTuou
 yj1arezR4Jzbs7Pk6o/50xCepNQMnbBOcyImw5fSnFZ4Pbsh+olM=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] lib: Add SAFE_LCHOWN
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KLS0tCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggIHwgIDMgKysrCiBpbmNsdWRl
L3RzdF9zYWZlX21hY3Jvcy5oIHwgIDMgKysrCiBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oIGIvaW5jbHVkZS9zYWZlX21h
Y3Jvc19mbi5oCmluZGV4IGQyNTYwOTFiNzZhZDEwYjA2YjI5ZTNmZDVmYWQ4ODUzZmFhMTRjMDgu
LjM3OTk4NzNhMjQ4ZjM2ZTBmZjMxYzg2MmRlMjcwM2ExM2ZlZTFiZmQgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvc2FmZV9tYWNyb3NfZm4uaAorKysgYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKQEAg
LTE1MSw2ICsxNTEsOSBAQCBpbnQgc2FmZV9jaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKIGludCBzYWZlX2ZjaG93bihjb25z
dCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwK
ICAgICAgICAgICAgICAgICBpbnQgZmQsIHVpZF90IG93bmVyLCBnaWRfdCBncm91cCk7CiAKK2lu
dCBzYWZlX2xjaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkICgq
Y2xlYW51cF9mbikodm9pZCksCisJCWNvbnN0IGNoYXIgKnBhdGgsIHVpZF90IG93bmVyLCBnaWRf
dCBncm91cCk7CisKIHBpZF90IHNhZmVfd2FpdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQg
bGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKICAgICAgICAgICAgICAgICBpbnQgKnN0
YXR1cyk7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggYi9pbmNsdWRl
L3RzdF9zYWZlX21hY3Jvcy5oCmluZGV4IDE5NTA0YmViNTdhZDM3OWM4MzVhMTNlZDVkMzVmZTA2
ZTQyYTZlZDYuLjQxZDE3YjFjYTQ1OTA0NThjZjY1MWE1OWE2ZTM3N2MyMTU3MjcwOTQgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKKysrIGIvaW5jbHVkZS90c3Rfc2FmZV9t
YWNyb3MuaApAQCAtMjIwLDYgKzIyMCw5IEBAIGludCBzYWZlX2dldGdyb3Vwcyhjb25zdCBjaGFy
ICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQgc2l6ZSwgZ2lkX3QgbGlzdFtdKTsKICNkZWZp
bmUgU0FGRV9GQ0hPV04oZmQsIG93bmVyLCBncm91cCkgXAogCXNhZmVfZmNob3duKF9fRklMRV9f
LCBfX0xJTkVfXywgTlVMTCwgKGZkKSwgKG93bmVyKSwgKGdyb3VwKSkKIAorI2RlZmluZSBTQUZF
X0xDSE9XTihwYXRoLCBvd25lciwgZ3JvdXApIFwKKwlzYWZlX2xjaG93bihfX0ZJTEVfXywgX19M
SU5FX18sIE5VTEwsIChwYXRoKSwgKG93bmVyKSwgKGdyb3VwKSkKKwogI2RlZmluZSBTQUZFX1dB
SVQoc3RhdHVzKSBcCiAJc2FmZV93YWl0KF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHN0YXR1
cykpCiAKZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIvbGliL3NhZmVfbWFjcm9zLmMK
aW5kZXggNzI2YzlhZThlZTUzNzU5YmE5ODMzMzk2NjJhNmI0MWU5NGVhY2Q3YS4uNjBkMjhiNWJk
ZjJiZDZmZGQzNDhmYWQ1MGJlNDVjYTY2ZmIxNTlhMSAxMDA2NDQKLS0tIGEvbGliL3NhZmVfbWFj
cm9zLmMKKysrIGIvbGliL3NhZmVfbWFjcm9zLmMKQEAgLTc3NSw2ICs3NzUsMjUgQEAgaW50IHNh
ZmVfZmNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFu
dXBfZm4pKHZvaWQpLAogCXJldHVybiBydmFsOwogfQogCitpbnQgc2FmZV9sY2hvd24oY29uc3Qg
Y2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCisJ
CQljb25zdCBjaGFyICpwYXRoLCB1aWRfdCBvd25lciwgZ2lkX3QgZ3JvdXApCit7CisJaW50IHJ2
YWw7CisKKwlydmFsID0gbGNob3duKHBhdGgsIG93bmVyLCBncm91cCk7CisKKwlpZiAocnZhbCA9
PSAtMSkgeworCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51
cF9mbiwKKwkJCSJsY2hvd24oJXMsJWQsJWQpIGZhaWxlZCIsIHBhdGgsIG93bmVyLCBncm91cCk7
CisJfSBlbHNlIGlmIChydmFsKSB7CisJCXRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwg
VEVSUk5PLCBjbGVhbnVwX2ZuLAorCQkJIkludmFsaWQgbGNob3duKCVzLCVkLCVkKSByZXR1cm4g
dmFsdWUgJWQiLCBwYXRoLAorCQkJb3duZXIsIGdyb3VwLCBydmFsKTsKKwl9CisKKwlyZXR1cm4g
cnZhbDsKK30KKwogcGlkX3Qgc2FmZV93YWl0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAogICAgICAgICAgICAgICAgIGludCAqc3Rh
dHVzKQogewoKLS0gCjIuNTEuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
