Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31181C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:37:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10A3E3CB19D
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:37:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D3283CB165
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:37:26 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 835C8200C9D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:37:25 +0200 (CEST)
Received: by mail-pf1-x430.google.com with SMTP id p14so20302526pfq.5
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VNiWQ3ijFqMxBpYSIYKubAy8UgFgmeckLnx0V/gcUME=;
 b=ZQjpgJt/2uiehrkIFfUURJ5yU+hgxpqZaDnz2NQIoJDLT8DF1WNkfupcYoK7QNJTju
 46QaYbaIzHP4zEMs2GnUb26GAUZC7OEAFIHHhBIkeJn9a40JW2eDV9nnnX5X2E01FHDX
 WZ8xR7if52GDrzaFo3sBTiAzIVmBx+2NUa5X/+wvKDuyx3ica0gwt7QAqxzLDL8Ixehn
 eVwG4wpGlwb92a22t7RTf6VxHISw024ZEqBLuep7HwAb2Se+P5sywuozKWA34Pr4N9Mi
 aFjedVaISY0VnbuMUUB8aIzV6AHIft9bKMn2DbHPptB450mx89DTivpEqHJHnITbKOHJ
 hkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNiWQ3ijFqMxBpYSIYKubAy8UgFgmeckLnx0V/gcUME=;
 b=UzxQAKk3wbe8rbJji/NAMWz3j3HaZ2DwzWT25K3KZc+xq6lXEcVLdNI5QmIwmsb8BW
 Ac21515DjReKQYvjEhAz41xNdT7Z4ZYjvEcfWGn0WFSrGdDEn6JsG2RpSuNTkNbmJ3eS
 ngI4EjxfaJ8/cwM7IQPjcQni24wFdi/5b8Z6038YVJC0lBvl47FtULqG/17jjf7vGqTL
 IoWQFbYW8rQcJAnN3o07ER3vTO0QehQhoPAnIHmxxoP3pbGW4OLIy6k85ICgB2f7fFkD
 REO1QnB6RYZ8v1iNZVrvaf5paRrKl3427gfsdGXsryX5t/lqa7oqZWvXRHmrZSFZAo45
 6lwQ==
X-Gm-Message-State: ACrzQf3T+A5nkdWDulN9VHSnNjwVb5oH38VACOYyLNiPV1H6D30DFq4d
 pQ8Z4L5LBFZoFlNN9tANjVPWNInDDUPHtvXo
X-Google-Smtp-Source: AMsMyM7L/aVV4mvZcE6uspwH/C2qBaFrIBKYH3+IUOxAPO5Kmd6LOQU0W1Pohgz3t5A95IbxbXsLBA==
X-Received: by 2002:a05:6a00:1742:b0:565:c73a:90de with SMTP id
 j2-20020a056a00174200b00565c73a90demr14556947pfc.68.1666273044026; 
 Thu, 20 Oct 2022 06:37:24 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a62a214000000b0053e93aa8fb9sm13352742pff.71.2022.10.20.06.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 06:37:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 22:37:15 +0900
Message-Id: <20221020133715.256521-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

bmV0d29yay90Y3BfY21kcy90cmFjZXBhdGgvdHJhY2VwYXRoMDEuc2ggZmFpbHMgd2l0aCBMQU5H
PWphX0pQLlVURi04CmJlY2F1c2UgaXQgcGFyc2VzIGxvY2FsaXplZCBvdXRwdXQuIFRoZSBiZWxv
dyBpcyBhbiBleGFtcGxlIG9mIHN1Y2gKb3V0cHV0OgokIHRyYWNlcGF0aCBsb2NhbGhvc3QKIDE/
OiBbTE9DQUxIT1NUXSAgICAgICAgICAgICAgICAgICAgICAgIDAuMDQw44Of44Oq56eSIHBtdHUg
NjU1MzYKIDE6ICBsb2NhbGhvc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAwLjI3NOODn+ODquenkiDliLDpgZTjgZfjgb7jgZfjgZ8KIDE6ICBsb2NhbGhvc3Qg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjI2MeODn+ODquen
kiDliLDpgZTjgZfjgb7jgZfjgZ8KICAgICDopoHntIQ6IHBtdHUgNjU1MzYg44Ob44OD44OX5pWw
IDEg5oi744KK44Ob44OD44OX5pWwIDEKCkl0IGlzIG5lY2Vzc2FyeSB0byBub3JtYWxpemUgdGhl
IGxvY2FsZSB0byBhdm9pZCBzdWNoIGEgcHJvYmxlbS4KVGhlcmUgYXJlIHNvbWUgdGVzdHMgZG8g
dGhlIG5vcm1hbGl6YXRpb24sIGJ1dCB0aGF0IGlzIG5vdApjb21wcmVoZW5zaXZlLiBBZGQgY29k
ZSB0byBub3JtYWxpemUgdGhlIGxvY2FsZSB0byB0c3RfdGVzdC5zaCBzbwp0aGF0IGl0IGNhbiBj
b3ZlciBtb3JlIHRlc3RzLgoKVGhlIGFkZGVkIGNvZGUgZG9lcyB0aGUgbm9ybWFsaXphdGlvbiBi
eSBzZXR0aW5nIExDX0FMTCwgd2hpY2gKdGFrZXMgcHJlY2VkZW5jZSB0byB0aGUgb3RoZXIgbG9j
YWxlLXJlbGF0ZWQgZW52aXJvbm1lbnQgdmFyaWFibGVzCmFuZCBkb2VzIG5vdCByZXF1aXJlIHRo
YXQgImxvY2FsZSIgY29tbWFuZCBleGlzdHMuCgpTaWduZWQtb2ZmLWJ5OiBBa2loaWtvIE9kYWtp
IDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+Ci0tLQogdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5z
aCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoIGIvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaAppbmRl
eCAyOGI3ZDEyYmEuLjVlYmJlMWQyNSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfdGVz
dC5zaAorKysgYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCkBAIC04MzEsMyArODMxLDUgQEAg
aWYgWyAteiAiJFRTVF9OT19ERUZBVUxUX1JVTiIgXTsgdGhlbgogCQlmaQogCWZpCiBmaQorCitl
eHBvcnQgTENfQUxMPUMKLS0gCjIuMzcuMwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
