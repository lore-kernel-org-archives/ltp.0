Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99052CD4F3D
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 03:47:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 223523C73DE
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 05:47:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96EBF3C737E
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:46:53 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DD6860075C
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:46:53 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-3042dffd80bso545121eec.0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779335212; x=1779940012; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCSQVIftRtdNv3wXOjUw5vgR25FACDQHkN4XpuKZfHQ=;
 b=cDYLgk8OV60Yxg1xt6FH1LAEZvCkW1O+Bjl4owsohEBj7+F0MJa01FdGv9lwJXalF1
 EF0q7EY9R4W9kdaSYiIf+c4+SQC1V4QuEaoOCTXCDFBK75QfQAe4jXe5cpDHfVxZoe3m
 NIyzqrAtH7zCTL5mknoTK6LjKuRwf8UBDYUvRxsL5nnGN6MQfSWPJXlwPwh3bwdKyDny
 yAsSZRIJitn/ur1NVvxF+/TVQuUW/IzB+kAdGnmRsYx4arXrrWHWgpokr37J2ch6ZxCP
 ExAYl+5zmVJmZBHJR4Ouv9GWw/qzH3MC7CWgrb6DtqFtzBJOI8GBgyhfcCJIwrWJbiOz
 lFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779335212; x=1779940012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nCSQVIftRtdNv3wXOjUw5vgR25FACDQHkN4XpuKZfHQ=;
 b=DLikhw7YVRQn0dXtGcFupoDyNJYba+nB/YGN8g/G4/yX1BkOHBDWyQkXgevJAltyKu
 USvZCUEU6TPAZXQoVU0p0n+xcHfOfs57E+a/N+oDbORA/OLcPY0nO3SRQbxRonhpujzX
 5b9ihSdFbEMtKmm2Hy4d+RKVJUzKY/6gvIUjwMv2WU8Gp2bA9R/XXv7yp4RYLR7qgFzk
 FpdqC1QjFAL087AkPPBr5cKbgAmLODon47eUOots8pNAXYeGwJeTKPbLaYJiLJVLQn27
 yY6cqIHLPv09BW6zMqa8tUmZpa4uzKS2PPuWajysx6wc0vOhB2lnYu1cYZRKnsJAgBE4
 bIjQ==
X-Gm-Message-State: AOJu0YyrXEJS/5Ez9XP66EvtUQ++hfgQ3ehTQbeOU/x82VXzvsLgKp1L
 bDvVXRf5Q1OHQCohUrxZdhkmT6bOxxNPPFAnjttBQUW1e5iqwoAbvTjy
X-Gm-Gg: Acq92OHEnMnjyge/yHniT9RunMfxRCPe5gcBYrnAYk3bzo4vMpMcOzVEGVCfYju9I6K
 SV5APLKN848i4pJxMDG1skpYIPFVseGa5joHVQyIREQ7OVKmzWCmaAbvjXfEc7wbJ+6iAQwpfBp
 Wq1rPVWrw3KuLZMBbhhy5hRLL7QQi6HO+D3X5nDa58p+FRowO2VH6zrs0nx/dv0jZSKzOrijPCi
 Xj6VwCAOIW+BSiC4ePJJ4ZebzD1JkmLm4QnJ4HrZeai5Tiy0zsshzqDd7cqPlPFcu6BxmaJIihH
 Anq89SnCQlF+NfgT0svdD2csa+8r70yzVIRc6yxGLjhqY+OkGfpVpIqg1VVhP2V8LysH4lez3+p
 c/GfRO3/58u7debp/W6ryLP6KW80lXhlKizeGivcXNG0BH3W6MZuiawkTZUDYiE1FaE2vnqw05I
 M8HdwyeT9mKlsekpkcrcLxQO4YOJFvyKC5q4tL06kCn4uqZewBmAhzGSIxMdCm8elMqq749RSuj
 2D0qzKWW1y0pSXRW9zVlpzn+xcEU0HYTJoJCws=
X-Received: by 2002:a05:7300:641a:b0:2c4:dd55:ffc1 with SMTP id
 5a478bee46e88-3042f43486bmr759221eec.2.1779335211531; 
 Wed, 20 May 2026 20:46:51 -0700 (PDT)
Received: from
 runnervmrw5os.cddunxfqncwu5ncfdzyn0hhfze.dx.internal.cloudapp.net
 ([52.159.244.82]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6f6sm25971091eec.17.2026.05.20.20.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 20:46:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu, 21 May 2026 03:46:49 +0000
Message-ID: <20260521034649.4079-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521032759.18727-1-li.wang@linux.dev>
References: <20260521032759.18727-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Introduce tst_path_defs.h to consolidate system paths
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgotLS0gW1BBVENIIDIvMl0gLS0tCgpPbiAyMDI2LTA1LTIxLCBMaSBXYW5nIHdyb3Rl
Ogo+IG1ldGFwYXJzZTogRXhwbGljaXRseSBwYXJzZSBlc3NlbnRpYWwgaGVhZGVycyBmb3IgbWFj
cm9zCgo+ICtzdGF0aWMgY29uc3QgY2hhciAqbXVzdF9pbmNsdWRlc1tdID0gewo+ICsgICAgICAg
InRzdF9wYXRoX2RlZnMuaCIsCj4gKyAgICAgICBOVUxMCj4gK307Cj4gKwo+ICtzdGF0aWMgdm9p
ZCBwYXJzZV9tdXN0X2ZpbGVzKHZvaWQpCj4gK3sKPiArICAgICAgIHVuc2lnbmVkIGludCBpLCBq
OwoKVGhlIG5ldyBjb2RlIHVzZXMgc3BhY2VzIGZvciBpbmRlbnRhdGlvbi4gVGhlIHJlc3Qgb2Yg
bWV0YXBhcnNlLmMgdXNlcwp0YWJzIOKAlCBwbGVhc2UgZml4IHRvIG1hdGNoLgoKWy4uLl0KCi0t
LQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4KClRo
ZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9m
dGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhl
IHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rp
b25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
