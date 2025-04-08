Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861C1C369A5
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744119892; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rYlaQxGc+sWdkG3479/fIKnzdNF6/8mqNKXg7xeCazQ=;
 b=cT9hX1osxWglQDljhLS7O2u4XKZxY9T/8W0lcXf5sHCGHjlKJJDoiK8brCnC3yYCr29rR
 cz7KCR9iCYV07e0GgFIDotG5PFzgCPD0H6VRAhr+iWOS5H8FrPo1evZV2ENBuAjxqGdnTZr
 6eFb0JWSmCBXTjIwl69Yn/lx3H5L5n4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01BCF3CB388
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:44:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC2883CB388
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:10 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6633C1A000A4
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:44:10 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so5229088f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744119850; x=1744724650; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fo3FYIDUIoqM69l4imG2Kx1aLahWPrTnGIJw775TLTk=;
 b=LpVCxUFyqt4UELYYRYIXjfd6giuUUgOTZmLf6OLHdPO2PQMvFjBcpXwT+xPktCofAm
 G+Po95M6qxVAXsRJUuEHoVA4txbzU6es5a7ce5UE7srlC+7TMmSUfaVcG24DUa3x8foV
 ry9W/DYOkCeNc/Yyyif3IAr37P3eVDPOhbnta5UL/oBaioZA/dqZx3RLSNrAc52a86Nx
 yxSdiEThhlfPXDxCK/IHAnsuljkUnzMYyN15b3pdoyPn2UKXc/T2x70sov7yj2cW8oGm
 StEYDhUAErH3CgWvhOYRmlcTRMFJLO3H7N7j62439zYkueZ9UbLBk7Tr5RWtlJyIFKbm
 mvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119850; x=1744724650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fo3FYIDUIoqM69l4imG2Kx1aLahWPrTnGIJw775TLTk=;
 b=mSstNIso9TqfrRBiZkalaUNO9bfE/KJ7lSeIMwmH+hFlmD6VceXsItIcX2y2mWj1kB
 Qw4AaSBEchqO8gKlLYs5TmewZj1AbB7zFFse/DruiQRD6sqtBA/ctPmD7gyoAtqw5boh
 mMt0rfMZxsPQJwP4NZFl5fvGeStgToXnl3cUmRdYHHiUBLBU37OJOuXiUzeGIULI5+CY
 dAsJP3SlPULWCrvd0o+405bxPjPhsT1jyQZDlCpB99QlZfk97789CJwXEuewh95VQTwJ
 XIRDqH9wIJq9ukVOU7gmJ5nwKxEJZ5Kq9BB0MKBirWQjN0rL3hKw522O9WfeLJc6GAbW
 nQYg==
X-Gm-Message-State: AOJu0YyfF1BI4hSFhOBcjWQ6pOiEBcnuxPzhFlZFupTwtNHAcZaTZRSb
 fwvShSaaQE7/oUTRBu2qoo453vb0vKPv2pEx1UXgYFZkjvnNcFTLI5Vy+tdSse0isqjgAWvr0hy
 n
X-Gm-Gg: ASbGncvwTGXwM1QA8AwfRwa6MKV6LkYVErE++wMlue34elJRcyAfXHiS0L8BuWNId0K
 Ar3D9UKYZ9fC5BgFOcTU34nm6idxLed8mTBrBkH4PA5k/IUi/jsCuHzPLyuNGFwlA3HpVbivZln
 YD8YI8cnmRLcocyR/5GegoIJ3p95w7tHa7HHi1WTI0H2Eh7SnEPPyjpNzwamtPwZMK62SnDF5t+
 fe9yid4VwWiEwBAYrXXajC2XqXQvkWmZk//ANLoXQggQRxVZb5g8HRT9lv4/xLw6hnhu8xY0vwS
 vxNy9iYF3rGRnVjr8+hEKc7KJ6fDq8VAqA==
X-Google-Smtp-Source: AGHT+IFf++ekwpIRLeh8nWw3Bn9BvKLF2cQi7+x/5YMIs1RP9IW1OllrO3rV8xQg/AJ6Ff67S3o5MQ==
X-Received: by 2002:a05:6000:1849:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-39d6fc49319mr11452095f8f.15.1744119849796; 
 Tue, 08 Apr 2025 06:44:09 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-739d9e9dc9dsm10819164b3a.96.2025.04.08.06.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:44:09 -0700 (PDT)
Date: Tue, 08 Apr 2025 10:44:00 -0300
MIME-Version: 1.0
Message-Id: <20250408-fix_make_clean-v2-1-48f93c3dd0bf@suse.com>
References: <20250408-fix_make_clean-v2-0-48f93c3dd0bf@suse.com>
In-Reply-To: <20250408-fix_make_clean-v2-0-48f93c3dd0bf@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=rbm@suse.com;
 h=from:subject:message-id; bh=7gIkitv5zZy5NCsCtbo2dV75SQdtvRZdLx6OgWC08JA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9SgiKCAHDfYyz4yQT3mjvPM0Y5+arDrrLrMNt
 rvLnWtdteqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/UoIgAKCRDJC4p8Y4ZY
 poknEACpcmKmQQkBzq4tqrqh3jkSJEEYBXbAfGGj3yke5J1jwMVreWLL3APgYP5LJCv0Wq/z/Os
 /UIjU9Bs/dwXPvKEp/BvO89xXCIcYWoftl6HiIGUNp7qzfbZ+K/W4MX1gTycc5FjDK8W5x1255D
 jnsS8aGK68LYRFhbYGPcELaLg3lvCLYVUdbGHe607DMujrXtB0oLUtoFnl+N3+5xlvdGxbkTSxU
 tj//rp+c4liX0NQNO5aPAA3vHlRYXecjDuSBeQXPdY2REB0HwUvAShekekZA+DVM6M3pT86bebS
 wlvz9knUYBoSCgqlnZTmc+uoR4NJz7ICVZNCy+MPSyjgA0/EcEY2PHhTjIhCdvmfbOfODMJvN1U
 YzszHzPBHxjMRRjalJ6H4Ze+bdjkeA1uLnZiPfKbPl/poz3KjKTBur/NhjcYFaUfH9WrbrGB3OV
 CnSJVshnoR7XJ3F+G5khcUeGPS1RvEC223uIWNxSBsA/VqB3lKWuNROxvqoe/CohR6CLh/03e0e
 Djv40eHInLFViuBHW2MYACwwU4u4OiFKU9vWT1050Tvt86VDyCf0AG01TCRvUnO/l0fP9cjmyMn
 1yxlBmBfLTuUACWQGDuOlWbIEqi2hYWsiJ0zA0XqM+xBto6Hqrtfxrg3xBtwr4Kee5DGKedY5+L
 YyxsGyIOg1bj+6A==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] openposix: Makefile: Add the standard
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
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
aW50YWluZXItY2xlYW5dIEVycm9yIDIKClJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNv
bT4KLS0tCiB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUgfCAxMCArKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlIGIvdGVz
dGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlCmluZGV4IDhiNGM4YzBhMjRiODMz
ZmEwZmIyMWNlM2UyNTM2MjlmMzU4ZjE4MDAuLmMwY2NkNDk5YjhiOWM5M2U0NTEzM2Y1YjNmMTg5
ZWRhN2QwOWJlYjMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9N
YWtlZmlsZQorKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKQEAg
LTMxLDExICszMSwxNiBAQCBBVVRPR0VORVJBVEVEX0ZJTEVTID0gaW5jbHVkZS9tay9jb25maWcu
bWsKIAogLlBIT05ZOiBhYy1jbGVhbgogYWMtY2xlYW46IGNsZWFuCisJJChSTSkgLXJmIGF1dG9t
NHRlLmNhY2hlCisJJChSTSkgLWYgY29uZmlnLmxvZyBjb25maWcuc3RhdHVzCisKKy5QSE9ORTog
YWMtbWFpbnRhaW5lci1jbGVhbgorYWMtbWFpbnRhaW5lci1jbGVhbjoKKwkkKFJNKSAtZiBjb25m
aWd1cmUKIAogLlBIT05ZOiBjbGVhbgogY2xlYW46CiAJJChSTSkgLWYgJChMT0dGSUxFKSoKLQkk
KFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0dXMKIAlAZm9yIGRpciBpbiAkKFNVQkRJUlMp
IHRvb2xzOyBkbyBcCiAJCSQoTUFLRSkgLUMgJCRkaXIgY2xlYW4gPi9kZXYvbnVsbDsgXAogCWRv
bmUKQEAgLTUxLDYgKzU2LDkgQEAgZGlzdGNsZWFuLW1ha2VmaWxlczoKIAkJJChNQUtFKSAtQyAk
JGRpciAkQDsgXAogCWRvbmUKIAorLlBIT05ZOiBtYWludGFpbmVyLWNsZWFuCittYWludGFpbmVy
LWNsZWFuOiBkaXN0Y2xlYW4tbWFrZWZpbGVzIGFjLW1haW50YWluZXItY2xlYW4KKwogJChBVVRP
R0VORVJBVEVEX0ZJTEVTKTogJCh0b3BfYnVpbGRkaXIpL2NvbmZpZy5zdGF0dXMKIAkkKFNIRUxM
KSAkXgogCgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
