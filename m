Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D84ECD4F3D
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 03:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF63D3C73DE
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 05:42:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5061B3C737E
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:42:39 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6368D60012C
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:42:37 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-135e88b8e55so5772510c88.0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 20:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779334956; x=1779939756; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvxAEhXIvJRqk+BSvdDit6vRHuw85sYEp+xZtU11UlQ=;
 b=MPnSBf0Z5RwNJ2RR+LhaK1yMR9Esm3CixXmkJPjqXePDVnyYxFM8Dp0+yRnnkUk2wI
 Jwqw7GPBrmK8iB6O1rNps1Zsr4xCv/m6L1hJWGOmIbWwx3Lvk6qN3oTsgFk70+gtDJ18
 I6qY37HY3IUzi+XqdJJf2xhSYLOM1RyxUKn/dTDNdMsD4XSp2FWfFPnv5lCRu1hjeh0Q
 i0DE6asWucBwwEJYTsgLvNAfUa9x4tcTyHfuVPvTnhgvM3rNT5w2/+wD09JIUG9UGHeT
 iCnKwk4z3wdTvVIwnq+Xp/2/XRrKZODn5zbBqjUIISI0Jotu0wLGj1qJznkt+qBnbGGj
 ydfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779334956; x=1779939756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvxAEhXIvJRqk+BSvdDit6vRHuw85sYEp+xZtU11UlQ=;
 b=oAyqT4b+jotL9vpiose7BYYaChMuR5UMGmbyrUrHdk4ZZP1TWT+Nn4kTyRoiTTg0DO
 icriN/n1dXsB1xmxrK2eOKUGE75CyerWzW4y4JH39E0U58bV0VRmUngUNxIoMDmLbc+1
 X+R4egPgfuHucUSR39boH1cCMJjQTnz0zB9j18Ngmtldum+IGecX8EYBMHXDpPVtfM7A
 Z1ikDT9afpt72NOc9UXKTby8P730zatLBbun2X69SQefsJZbwcYUOKbCsGJkzXeMqUgV
 n2yxX/Q1QU6VNnH+UDWfo+XW97CpH9a5wkJgCwwJRTujJFRGhH6XhiKIuL7Vxk+T77al
 Q7vA==
X-Gm-Message-State: AOJu0YxFRNjmcDJqowYpjtcCowXwQAy9MAE6qaqNyd3mlWA02p1cVJVx
 EJPyA+oqyuUm7Q2YKmmJCNIvLKuQvEQPrq7ftl4H367s9a2FhyJ/pct0
X-Gm-Gg: Acq92OGm+ZWxj8XDsVZk/xaBncKoWJl1TNuEiJb7mnBEl4IQZ6EgY5KHN5LCIfjPNIg
 4KDvYelRy4EXcFldXsU4SjiK3P+z2P8H2/O/lrlNE43GSBPrwA/I3N2kerbe8mCVzbzEOrUd+W2
 olAyIyrr+9sy35fBsJxaZGGS0iMQJygeZvBn1KEMYDA7kxgrocr7M0r6o6ZHAHfslHEe+eU62m6
 yF9AYlRQkYnq3/U33T0VnxzuqyaUptrQpsL8wHdhtnFUqMg3KaeIcAzVaa5/xV931De9UPWuL7x
 muCLPmoWBLsz1d3rqq8Sg2pIoVmUp9JxQCScYI+9ZYkJXBeBwb0StYrTb5sGZ66TUCkVL0HWIgh
 HCNA1TD49orVQdioYxmWiVedTtQQr3lH9wfnhjfY26gmYd/K61vFzXV0Z8ZEZyHMC7bKtJDYCwn
 R+mcuaowzR1xciaMdN3Cvd2VwGMbbDMv3FT3dNLZRFR2hbRb3CySZZ+5IYfxnYXc4mNy2fGv6S3
 10GmBW7/bBTmvAAFX8QGH/E5v23K/T6EzckX3NiaAuETPD+kxo=
X-Received: by 2002:a05:7022:ea28:b0:12b:fb81:d69b with SMTP id
 a92af1059eb24-13632e45002mr602683c88.19.1779334955632; 
 Wed, 20 May 2026 20:42:35 -0700 (PDT)
Received: from
 runnervmrw5os.ad2jx1yswqge1po1cwcnrolnac.dx.internal.cloudapp.net
 ([52.159.227.195]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cb5b3c20sm28949389c88.0.2026.05.20.20.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 20:42:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 21 May 2026 03:42:33 +0000
Message-ID: <20260521034233.4014-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521022315.8924-1-wegao@suse.com>
References: <20260521022315.8924-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Return PTS_UNTESTED when detaching or joining
 joined thread returns 0
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKT24gMjAyNi0wNS0yMSwgV2VpIEdhbyB3cm90ZToKPiBPcGVuUE9TSVg6IFJldHVy
biBQVFNfVU5URVNURUQgd2hlbiBkZXRhY2hpbmcgb3Igam9pbmluZyBqb2luZWQgdGhyZWFkIHJl
dHVybnMgMAoKPiArICAgICAgIGlmIChyZXQgPT0gMCkgewo+ICsgICAgICAgICAgICAgICBwcmlu
dGYoIlRlc3QgVU5URVNURUQ6IEltcGxlbWVudGF0aW9uIGRvZXMgbm90IHJldHVybiBFU1JDSFxu
Iik7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFNfVU5URVNURUQ7Cj4gKyAgICAgICB9CgpD
b3JyZWN0IGFwcHJvYWNoIOKAlCByZXR1cm5pbmcgUFRTX1VOVEVTVEVEIGlzIG1vcmUgc2VtYW50
aWNhbGx5IGFjY3VyYXRlIHRoYW4KYWNjZXB0aW5nIDAgYXMgYSBwYXNzaW5nIHJlc3VsdCB3aGVu
IEVTUkNIIGlzIHRoZSBleHBlY3RlZCBvcHRpb25hbCBiZWhhdmlvci4KClJldmlld2VkLWJ5OiBM
VFAgQUkgUmV2aWV3ZXIgPGx0cC1haUBub3JlcGx5LmdpdGh1Yi5jb20+CgotLS0KTm90ZToKCk91
ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmll
dyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9s
dHAvbGlzdC8/c2VyaWVzPTUwNTI2MAoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBm
YWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJ
ZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVt
YWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
