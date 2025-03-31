Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B78C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743443058; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=G07hDafkV7Y9+zE2eRT3Kjd0KKFALi86Nr3ff/XniS0=;
 b=Is3BFPF3j68eTJUqTHIw4UZrosQ0hYPHQnEjdt9D26DI8x+jc8brTEOfUuXmfU1ITzm1G
 PvlCDnBO/AHAxaR2msa0x0S5/xEvIR8l9JO171KFAWF1LvKdtKBCwjl9hemYbzePAo9CPc+
 p1HMxsVqwBTcOxp21oLmrxOEUpY/1LY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B18E83CAD6C
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 19:44:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79AEF3CABC9
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:43:57 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96A9814002B4
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:43:56 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso32502445e9.0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743443036; x=1744047836; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cBXRs0t3XONSx/Nr7M93io1zT/Ny6ykfdNxFY4XxNH0=;
 b=IqOxY8IZdKZST2URlc/uggCS9qLCuKHUDa4xVzdQ+2ORN3Ffp7GlxwZmCYdhXdXIab
 46G3g9k5sBMUiZAPT9qtzKrZX8huWbs8z6F3rUJ4Ijj1uiEn2hXHPcUJyAW9aCdULzf3
 JrozCwynf6xxCbhdKkzrvqYMfCfS4vmU1hrru/tX3yE0zSozpowdH2xH0+lDAgMQk7yU
 c2Ueg3PISqxykfALTFCmSXlQtSIGtb4Zx2S2uto+jSsq4Ax4bi4t7qanbQ1xYM/kOP9L
 D8jYvpIHreODfaR2xVyzc3+Apx7XL1/5nUZYVc0zOqSGkl9kr/t6zPlzxlV0OEdRS/uC
 7/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743443036; x=1744047836;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cBXRs0t3XONSx/Nr7M93io1zT/Ny6ykfdNxFY4XxNH0=;
 b=lL5x/5R1BKO2QVlSM6Df1ZYKT8rjZZRCDkwxov40Zy6uGBWSZ+/yGiR6QO+8hTQzCj
 7s2N9alQV7G9DLVo0izBbp70CZKxWJNPWIxlzxj+VVb5/h9kf886pJzTQea777i6BF2Z
 VJG1vFkOY5rdOqtN2yIeU0ejR+jhlwkmNLotGqXG5hV22k7U5oY5USODxgmzWZyjpWx7
 o9bI59hF3r+TwB+fvFfFoOufrwv3D2YtwrDpTb7eqAYWHvYzkscaMKMREf3EK2pAychl
 hAsAxS2PepBLPNPibpRbuCnFHK576bK8IqlgNX1zTzuQfrV7w9NuALNujyE9vC/5sTAf
 jMDw==
X-Gm-Message-State: AOJu0YxoAQbsRBRF3l8IunUUTv3Gd6JP5KAb/itQ6kUoN5czyJauel8N
 3dhxWerlTr07hhUjC5zhPXB3Hve5PBn5fGe/xQiPB3ih3WUH2faFTSH+G3rnBchzWrqo0XG76nQ
 B
X-Gm-Gg: ASbGncvCy8jhNBVOVjHlQTyHfIDw4hjqGbpW5ccQXilF7uczUFceYXsfthEf/6Xilql
 bUgv6fkUneIRZntK35qfMD+N9xq+coOJ1p4mxBGDHbzgTas+fSW8BQQQ4/m8XVfdojv6fr4chM/
 OFHsp7WZdq+vvH4oRPA4nHLJ53ViG9QAERpMl0yh78uc/sanGN6Xx8tbMwF6DhyNXSeZOm7shaG
 2OFY8fKfZ0xjiRM/fULcsaSgY+y+cpAEb0mJOXYhYXmuy36O4NrFuPOgnnuUi+WhvYboAoCE95G
 upoW2CiqsoONa2eESVBsWzZ6NyRU037hjg==
X-Google-Smtp-Source: AGHT+IFZ/W7RmMf7luFZCs/qQXz2S/gOTaWG32zYipENcy/mVp1LQ/wrJ4d00EylmSKrSOouLvJi7A==
X-Received: by 2002:a05:6000:2a4:b0:391:23de:b1b4 with SMTP id
 ffacd0b85a97d-39c1211d57cmr8118447f8f.45.1743443035930; 
 Mon, 31 Mar 2025 10:43:55 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7397106854asm7428894b3a.106.2025.03.31.10.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:43:55 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:43:46 -0300
Message-Id: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFPU6mcC/43PwWoDIRAG4FcJnmPQ0XXdnPoepRRXx66QXYtup
 SHsu1dzWgIhPf7wzzczN5IxBczkfLiRhCXkEJcauuOB2MksX0iDq5kAg44JkNTGpWBqtUzn6IK
 /fl7cSjVXAgYA4RWSOvyd0IffO/z+UfNoMtIxmcVOjZtNXjG14hTyGtP1fkDhrf5yV+GUUe2U0
 +A565V+yz8ZTzbOpK0qsFf6pwpUBQbWO+nq1ZY9KGKv6KeKqIpXo0LkduBSPijyf4qsiukQ+1H
 Xr4zZKdu2/QHCyN7VpgEAAA==
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=rbm@suse.com;
 h=from:subject:message-id; bh=qy4ORHuibuyw5LEmpVNQAGUiYdXuHmoqRiFr/Bt3mTM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn6tRXaiKpn3VrMXAzq6cVcUS1P7Ckhp+O29DT3
 A/WP5v06EuJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+rUVwAKCRDJC4p8Y4ZY
 plTiD/4zndrAADO/KkzCj48zXvhA/bzP+QRHzu2lFKBkT6KCz2KmLW8pQTqeD2u/1jBJijD/H1s
 ZrQJHvTNDhVCiE5f0ULrAd8kSl5X3bGrcYDjS46YeGqw12prGGlqek6Quu5zflajkKBazvagm0w
 6nudr+bNrrDFNtvFge+DEMy2CG6wDYq8CwTZAK/Zz+cZ5h+w4zOAS2ZIBAwnJ/O3130sXU97E5K
 ZClqmv5NG1c/NZpujGsaxi7TkpF7UeRMLScTV+sh78uLX3wruQT5sEtT+YBbYCVEBpUWJfWJuzb
 krnbeeKoWxPcwbPqXkOwFVqXAv4lrmqJci+vZJHe1F+9B0KThGVatfKXimOTr+SYpupGwhAUrNp
 zGTWOFZxb96qIKS1yUsMLIznKXWRcm5XTYhIE55/bOJeZr96ZMLPrw7rcY9EgG9/i5Pmb0cpzPm
 VZeMy//UjO78Olnu7FxQ/6hYAW2BHbpYE1DdMDZ6mgZkGCkn8jdItpWFFTZG8seH2xj41IhqAV2
 Nz6m8vfGPBiISFmskKgyUsMd8IZBrNj6nwvXKtb7LdnDl5oh85RIeKCL63nkATelyUNcjOdtW1a
 rKBtH2q7RL3otoSeBJ1iLUq/OnQTHoMB8LrpQh5L2fsY0AkICDV2a204HnGt4jiFg9XWxqChN7F
 R1NeQDbQWHeoX4Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] syscalls/modify_ldt: Refactor into new API
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

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjU6Ci0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSAjZXJyb3IKLSBSZW1vdmVkIGNvbnN0
IHNwZWNpZmllciBpbiBjdmUtMjAxNS0zMjkwLmMKLSBJbXByb3ZlZCBtb2RpZnlfbGR0MDIgdGVz
dCBkZXNjcmlwdGlvbgotIEFkZGVkIHJ1bl9jaGlsZCgpIGluIG1vZGlmeV9sZHQwMgotIFJlbW92
ZWQgdW5uZWNlc3NhcnkgI2luY2x1ZGUgImxhcGkvbGR0LmgiIGluIGZpbGVzIHRoYXQgaW5jbHVk
ZSBjb21tb24uaAotIEV4dGVuZGVkIGNvdmVyYWdlIGluIG1vZGlmeV9sZHQwMQotIExpbmsgdG8g
djQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgtY29udmVyc2lvbnMtbW9kaWZ5
X2xkdC12NC0wLWE1ZWU3YjhkODJhYUBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NDoKLSBSZS1hZGRl
ZCB0aGUgYXNtL2xkdC5oIGluY2x1ZGUgZGlyZWN0aXZlCi0gTGluayB0byB2MzogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyOC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXYzLTAtZjZi
NmVlMWM5MTQ0QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYzOgotIERyb3BwZWQgdGhlIHNldF90aHJl
YWRfYXJlYTAxIHBhdGNoIGZvciBhIGxhdGVyIHNlcmllcwotIFNxdWFzaGVkIG1vZGlmeV9sZHQw
MyBjb21taXQgaW50byBtb2RpZnlfbGR0MDEKLSBSZW5hbWVkIHN0cnVjdCB0c3RfY2FzZSB0byB0
Y2FzZQotIFJlbW92ZWQgZmFsbGJhY2sgZGVmaW5pdGlvbiBvZiBzdHJ1Y3QgdXNlcl9kZXNjCi0g
TGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyNy1jb252ZXJzaW9u
cy1tb2RpZnlfbGR0LXYyLTAtMjkwN2Q0ZDNmNmMwQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgot
IEFsc28gcmVmYWN0b3JlZCBzZXRfdGhyZWFkX2FyZWEwMQotIE1lcmdlZCBzaW1wbGUgdGVzdHMg
KGluY2x1ZGluZyB0aGUgZXhpc3RpbmcgbW9kaWZ5X2xkdDAzKSBpbnRvCm1vZGlmeV9sZHQwMSBp
bnN0ZWFkIG9mIHNwbGl0dGluZyBpdAotIEFkZGVkIFNBRkVfTU9ESUZZX0xEVCgpIG1hY3JvCi0g
UmVtb3ZlZCBjaGVjayB0byBhc20vbGR0LmggaW4gY29uZmlndXJlLmFjCi0gVXNlZCB0c3Rfc3lz
Y2FsbCgpIGluc3RlYWQgb2Ygc3lzY2FsbCgpIGluIG1vZGlmeV9sZHQoKSBAIGxhcGkvbGR0LmgK
LSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzI0LWNvbnZlcnNp
b25zLW1vZGlmeV9sZHQtdjEtMC04ZDZkODJmMTA3NjhAc3VzZS5jb20KCi0tLQpSaWNhcmRvIEIu
IE1hcmxpw6hyZSAoMyk6CiAgICAgIHN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBsYXBpL2xkdC5o
CiAgICAgIHN5c2NhbGxzL21vZGlmeV9sZHQwMjogUmVmYWN0b3IgaW50byBuZXcgQVBJCiAgICAg
IHN5c2NhbGxzL21vZGlmeV9sZHQwMTogUmVmYWN0b3IgaW50byBuZXcgQVBJCgogY29uZmlndXJl
LmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQogaW5jbHVk
ZS9sYXBpL2xkdC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzQgKysrCiB0
ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyAgICAgICAgICAgICAgICAgICAgICB8ICAzNyAr
LS0KIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTctMTcwNTMuYyAgICAgICAgICAgICAgICAgICAgIHwg
IDEwICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazA1LmMgICAgICAgICAg
ICB8ICAgNSArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0Ly5naXRpZ25v
cmUgICAgfCAgIDUgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9jb21t
b24uaCAgICAgIHwgIDMwICsrKwogLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlm
eV9sZHQwMS5jICAgICAgfCAyNjEgKysrKystLS0tLS0tLS0tLS0tLS0tCiAuLi4va2VybmVsL3N5
c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAyLmMgICAgICB8IDIyMyArKysrLS0tLS0tLS0t
LS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMuYyAgICAg
IHwgMTA1IC0tLS0tLS0tLQogMTAgZmlsZXMgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyksIDUy
OCBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiAwYTBhNzdjNDQ0YjU2NDgzYmRkZTUwNDZm
ZWViNTE4Yzk2ZjVlNGEyCmNoYW5nZS1pZDogMjAyNTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xk
dC04MTYzMjkyMjNmNmUKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
