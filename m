Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29718C35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742413103; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=dHfgPhZD0Be7OJd5cgH42o74VCz2k404HeO4VvsEpNk=;
 b=hEukU6t68sjeW9owSMnXExKoi0Z3rTj3rnqzMJFlA8M1jeRldPde98parC4mqABcdm5h1
 gMNyXi73UVJiQbXVuQbb+eIHVoY7Njcz3v+bjXA58wnfeYd42zWJ4StsYYw4lcrMbewk8zI
 yHwId+BJV4TWhaM1pO4HSwMruQ0mw5Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD22F3CADFF
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:38:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC733CADD5
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:38:00 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 020951000A2E
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:37:59 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1382695f8f.0
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742413078; x=1743017878; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YGsVHv6juHwT6MgwzHPegxDEp4wTp7W2u2zGSiXDge0=;
 b=EuT+3tkN0qLqmwAjtdPDFgWqjjErex4E/hYnpqnnshyLuk8vNWDKy9Zn/0ruI1NCD1
 MqU5PL4gHW19tvJACPiOGCGqLCEVUsZTcw0ls/Q4eAh4f+VJium3KgGXhIRbOdIvtw5t
 8jjFgr6AywqbU3zEUReDvjY5nse9MSvBpEuI0bYqYE+ssAXu9mjvwbhOMbE4u+SwA0ga
 gR87Ccwh0M/jNjm9nr3DZi7UL+qFZcSPaRGoyepS+Vrk1PmrIrUD/fUAQ7bQRmV/WqGj
 trgafGrVXRyv5ZDENSeWrcf3EkGVHvHD8ARZSzGKpKeDd+uFX2JSCaGqA/pzWRn6Tgx/
 I8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742413078; x=1743017878;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGsVHv6juHwT6MgwzHPegxDEp4wTp7W2u2zGSiXDge0=;
 b=uo2BhC6+36rngxZ8ixfED5OfO05Yr/5kNxvo2D+hpfyDdbf47POH+vwKda1aFy4h8T
 RMU6z5vo2hIsZlzPef0llyrfpxsAV9HvWY0WFqp6Rskk8maQyuD/8GF76w52qZr4kDQL
 mH9oGM8+YU/y2FLpJfqoKCcvQPwBVIHdAORmLq+Ajgy1xGSxqsX2Yf+HccCJJhbjHf9k
 bhObOvgquDppKMt+S1cvv54UKX8jCT3q47YTWtIALkOz1E7ItpepAXtsZOIRYeS1psLI
 Mx1mDz4bqrrLQllX2joTA/ntLKTVcc+Ydz/gA1bmEIeCr+0HZDySM0Gx6PwlCzInfjsl
 YP+g==
X-Gm-Message-State: AOJu0YxV19dMxdN2++AvSDiydYT4uJmgsRhKZxTGt1Wsb6UP50S7yQWh
 sEv106ooqRhIJDHLnFzDlBs/6+Idh03gkuoMPAk+q55rc/gQfnI9u0bvcGf7+FlPjbQxDlfuq6P
 b
X-Gm-Gg: ASbGncu6Bi2AX5z9sdOKwdbGbsuWp/yJMn+Kx1RMPbCZDCrMZ44ibie/ktZNnt4AiOL
 +We7pFNy2pP5yekX6njw6IbCW1QmyEWFHs+7/drlRN1mikpyBOovRWjaxkjoeUVj2VbMGodBdc1
 Q2ZNSQxtJDhJSyhCxVaTYUZluCr0Zwom4rMkSUxgLwjJ41SskUyJc3G50pNU97S0Pt0apTF55L3
 QqagM2nLtqiWNDLwkZIIR5MIAk+vrIn0wf9SoA4qtsNGKEZTlthgK1GiB2gbRE8/mgcF/i3Iv49
 8e4aVFI7KL9BbL9/tNnAtbebONRfQ+ksNQ==
X-Google-Smtp-Source: AGHT+IFiUCKGlb0pD38hCtkyXGHj456xrULbC+exR+AnJpic7FTdCRlFXpToKXBg+UeDqZt5ah1gXA==
X-Received: by 2002:a05:6000:402a:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-399739b7ca9mr3554115f8f.9.1742413078414; 
 Wed, 19 Mar 2025 12:37:58 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6bbfb44sm118751665ad.207.2025.03.19.12.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:37:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:37:54 -0300
MIME-Version: 1.0
Message-Id: <20250319-conversions-ht_enabled-v1-1-e4375ea37b54@suse.com>
X-B4-Tracking: v=1; b=H4sIABEd22cC/x3M0QrCMAyF4VcZubbQ1QnWVxEZaRttQDNJxhDG3
 n2dlx+c869gpEwGt24FpYWNJ2noTx3kivIix6UZgg8Xf+6jy5MspMfMXJ1HEkxvKq5cwxAD+px
 ShHb+Kj359w/fH80JjVxSlFyP3AdtJoVt2wEFojRBgQAAAA==
X-Change-ID: 20250319-conversions-ht_enabled-d82492a0cbb9
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3576; i=rbm@suse.com;
 h=from:subject:message-id; bh=qXOhHXkphWo9YPHZhqe+NT/0CDZAaH70F+NYgyr+noU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn2x0SFtyR918ec9+sxJQD+m5xjN4Wn+Wf3A0JQ
 /+m7w8cb22JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ9sdEgAKCRDJC4p8Y4ZY
 poVKD/0V5I3c/IxMcw/QK09AasaRgH7Z2nO046Q2fYKVBnx7jdVzMszoj+k3BkxPbAEb710M5o0
 6Oeaf86kKihz0qvklgXILkhxXqFzMqSCmwkfspFwIgfuiFOp3x4uTTTpxMu27HGG9SshsyTA1Ze
 QpfFhf8iIktmuI9+TSpPHflyc7zH9I3phCkPWj43g40Qb5RcqFSS6tJPhEwy9Zc7G3Yrdu39fv5
 rTOAgi/3S4EVh1KWPcu/zkaj6KhYSBjQuXs9clgr8OwhV5rCXBXi4VfyDkhBjxHEosjXCToVNw8
 N9ga50DfTsmfmG95gEhRYlwMt1UA0yzZ2kdwChMJpTaLc2f1dZ1GgLQ8bXjpMUkhi2yfC7VwEyX
 JRQwCZOT/lRDQ73U6CtgOKItHAOW/TR0FVBlj8I0cpxpaitzzvJIbPwMXBw4wYgNHM30s6uMH4b
 KvsVjjWTbcVHY2I2NEROMAEspAag1t78h1rmaYZnQYcV6gMBDWCBLPyby3HXgytpQIhtmgFFlgm
 idAC0BB77lPaOAt4puPo5n4hlVSFwOCXtpOJ5hyP1813DrvRwhrvjMVqrBhP3q8Dr4rVRC93U+u
 BN5Fe96SX0qv0j8G5ntBCQeN4kJify2qEviXXu8wnVKW6q7zz48nqHPO0VqiWcabWr6Rjsl8b/E
 ZXbGLBhkSCXKK0w==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hyperthreading/ht_enabled: Convert to new API
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogLi4uL3NjaGVkL2h5cGVy
dGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfZW5hYmxlZC5jICAgfCA0NiArKysrKysrKysrLS0tLS0t
LS0tLS0tCiAuLi4vc2NoZWQvaHlwZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF91dGlscy5oICAg
ICB8ICA2ICstLQogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5n
L2h0X2VuYWJsZWQvaHRfZW5hYmxlZC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9oeXBlcnRo
cmVhZGluZy9odF9lbmFibGVkL2h0X2VuYWJsZWQuYwppbmRleCA5MGYzN2U1NTRmOWQxYWRkNTI1
NDk4ZTE5NjRjNzhiZDE0ZjRiMTZkLi44OGU3MjZkNjU3YTRlNjc3YThlZGU1YjcxMjU5YWFkZjNk
YTQ5NDk0IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5n
L2h0X2VuYWJsZWQvaHRfZW5hYmxlZC5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvaHlw
ZXJ0aHJlYWRpbmcvaHRfZW5hYmxlZC9odF9lbmFibGVkLmMKQEAgLTEsMzIgKzEsMjggQEAKLS8q
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioKLSAgICAgICAgICAgICAgICAgICAgICAgICAgSFRlbmFibGVkLmMg
IC0gIGRlc2NyaXB0aW9uCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0t
LS0tLS0tLS0KLSAgICBlbWFpbCAgICAgICAgICAgICAgICA6IHNvbmljLHpoYW5nQGludGVsLmNv
bQotICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKi8KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCisvKgorICogQ29weXJpZ2h0IChjKSBzb25pYyx6aGFuZ0BpbnRlbC5jb20K
KyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgorICovCiAKLS8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKLSAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICoKLSAqICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkgICoKLSAqICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgICoKLSAqICAgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3IgICAgICoKLSAqICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKLSAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKLSAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCisvKlwKKyAqIFNtb2tlIHRlc3QgdGhhdCBjaGVja3MgaWYgSHlwZXJ0
aHJlYWRpbmcgaXMgZW5hYmxlZCBieSBkZWZhdWx0IGluIHRoZSBob3N0LgorICovCiAKLSNpbmNs
dWRlICJ0ZXN0LmgiCi0jaW5jbHVkZSAiaHRfdXRpbHMuaCIKKyNpZiBfX2kzODZfXyB8fCBfX3g4
Nl82NF9fCiAKLWNoYXIgKlRDSUQgPSAic210X3NtcF9lbmFibGVkIjsKLWludCBUU1RfVE9UQUwg
PSAxOworI2luY2x1ZGUgInRzdF90ZXN0LmgiCisjaW5jbHVkZSAiaHRfdXRpbHMuaCIKIAotaW50
IG1haW4odm9pZCkKK3ZvaWQgcnVuKHZvaWQpCiB7Ci0JaW50IHJldF92YWwgPSAxOwotI2lmICAo
IWRlZmluZWQgX194ODZfNjRfXyAmJiAhZGVmaW5lZCBfX2kzODZfXykKLQl0c3RfYnJrbShUQ09O
RiwgTlVMTCwKLQkJICJUaGlzIHRlc3Qgc3VpdGUgY2FuIG9ubHkgZXhlY3V0ZSBvbiB4ODYgYXJj
aGl0ZWN0dXJlLiIpOworCWlmIChjaGVja19odF9jYXBhYmlsaXR5KCkpCisJCXRzdF9yZXMoVEZB
SUwsICJIVCBpcyBub3QgZW5hYmxlZCBieSBkZWZhdWx0IGluIHRoaXMgc3lzdGVtIik7CisJZWxz
ZQorCQl0c3RfcmVzKFRQQVNTLCAiSFQgaXMgZW5hYmxlZCBieSBkZWZhdWx0IGluIHRoaXMgc3lz
dGVtIik7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsgLnRlc3RfYWxsID0g
cnVuIH07CisKICNlbHNlCi0JcmV0X3ZhbCA9IGNoZWNrX2h0X2NhcGFiaWxpdHkoKTsKK1RTVF9U
RVNUX1RDT05GKCJUaGlzIHRlc3QgY2FuIG9ubHkgZXhlY3V0ZSBvbiB4ODYgYXJjaGl0ZWN0dXJl
IikKICNlbmRpZgotCXJldHVybiByZXRfdmFsOwotfQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zY2hlZC9oeXBlcnRocmVhZGluZy9odF9lbmFibGVkL2h0X3V0aWxzLmggYi90ZXN0Y2Fz
ZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfdXRpbHMuaAppbmRl
eCBjMDNhMTI0MjU1MWNlMTMwZDM4NjJjYmUwZGIzMjlmNzExMTE4M2VhLi42MWYwZmYzZDk4ODZh
ZmIyMTFkNjM2ODY2NWRlOWY2MzliMmQ2NjU0IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfdXRpbHMuaAorKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2VuYWJsZWQvaHRfdXRpbHMuaApAQCAt
MSwxOSArMSwxNyBAQAotCiAjaWZuZGVmIF9IVFVUSUxTX0hfCiAjZGVmaW5lIF9IVFVUSUxTX0hf
CiAKICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KLSNpbmNsdWRlIDxzdGRsaWIuaD4KIAogaW50IGlz
X2NtZGxpbmVfcGFyYShjb25zdCBjaGFyICpwYXJhKTsKIAogLy8gcmV0dXJuIDAgbWVhbnMgUGFz
cywKIC8vIHJldHVybiAxIG1lYW5zIGh0IGlzIG5vdCBlbmFibGVkLAotaW50IGNoZWNrX2h0X2Nh
cGFiaWxpdHkoKTsKK2ludCBjaGVja19odF9jYXBhYmlsaXR5KHZvaWQpOwogCiBleHRlcm4gY2hh
ciBidWZbXTsKIAotaW50IGdldF9jcHVfY291bnQoKTsKK2ludCBnZXRfY3B1X2NvdW50KHZvaWQp
OwogaW50IGdldF9jdXJyZW50X2NwdShwaWRfdCBwaWQpOwogCiAjZW5kaWYKCi0tLQpiYXNlLWNv
bW1pdDogYWUyNzkyNzY1MzVmYzljYTMxMTdhMTJjNGJiYTAwMjlkNzkyOTA0ZQpjaGFuZ2UtaWQ6
IDIwMjUwMzE5LWNvbnZlcnNpb25zLWh0X2VuYWJsZWQtZDgyNDkyYTBjYmI5CgpCZXN0IHJlZ2Fy
ZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
