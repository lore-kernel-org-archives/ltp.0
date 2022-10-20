Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9338C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E33883CB17A
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:09:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140453CB0D1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:09:40 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CF191A0113A
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:09:39 +0200 (CEST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so2158428pgq.8
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eSasDhmQB6Ozb1AnWh+J605rCJmZYF7f3ngGzyVTqOc=;
 b=Ca2F7h3A/V6MOwr3bEvdAz+91N0plyDy3263jTXMzDGhkTYIdNx2smdWaSjD7K4HPO
 uf7dICWOsfZgpNm1OIv5h9f7r4VPdUnoNRuYSd2I9F5X5KgXCFTy4RNlGgZk1DglFA+N
 oz5vaUdKf1eS3a8JbR2RZifCz28KnZ7bsON/aqsFF8QECdn9YfgJVPLVt7+6BNxYxUVa
 jziB8DKA5FnrFqgyIAltO0Sean+UXZhI8/Jj+wdBvtMQWJ4ZFfpcTcjNK9wtPvBJlHa6
 9riYgR6Jk5GMPuCi8S63l+QrNODat6SWuY96ovDW9i2f+5J0B/HCKhLQXTSzU8AMcMhi
 gTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSasDhmQB6Ozb1AnWh+J605rCJmZYF7f3ngGzyVTqOc=;
 b=ghZhjEryxYlI4XKtInwuzpF7fqViEgXiGpfivoYQEhO4nC5npCQhcU5uqP21+7ePky
 ud5kPnlDbX7m9CYn0F1OqdIYT9i2iSZNeMxBRe+ggb4mDwfPFWEtNdHG94PhEpZ4W7nc
 i4mHxkWSXlqu0zv5mQJ6Sn+iFEwa5/GME97X8vfug+hhhI0moa/USeUW4MS0xMzni2c5
 vvGRqaNuV6XvY+YuA0BYejPOuPA3nHrhT9FglgE26SNtR4G47vqW20qRUOFl9YOccUh4
 gKP/tQFznsrkmXE08s9iD5S+OYJKkvz2ZTyy+/J0Atcz/yINusb4G9HA6CxLTTFCH49v
 pPRg==
X-Gm-Message-State: ACrzQf1rkHUmQHhhnICDHBlupcDYkLnrb1Uq9H4tskv703KprWJO7UJD
 ORwABG3/CTowe2fUO4gjjKs4Ag==
X-Google-Smtp-Source: AMsMyM5z7oA1MjRkaL0oyEu1sFbyjCEBIfLLNkF9+sqiM/M3/LllTCF9ySuNZAwi4fnk9N9o3K2bWA==
X-Received: by 2002:a63:87c7:0:b0:46b:3cf1:e163 with SMTP id
 i190-20020a6387c7000000b0046b3cf1e163mr11844181pge.112.1666267778116; 
 Thu, 20 Oct 2022 05:09:38 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 nt12-20020a17090b248c00b0020ab246ac79sm1604812pjb.47.2022.10.20.05.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:09:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:09:24 +0900
Message-Id: <20221020120924.212843-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_test.sh: Normalize the locale concerned
 variables
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
IDEg5oi744KK44Ob44OD44OX5pWwIDEKClRvIGF2b2lkIHN1Y2ggYSBwcm9ibGVtLCB3ZSBjYW4g
YWx3YXlzIG5vcm1hbGl6ZSB0aGUgbG9jYWxlIGNvbmNlcm5lZAp2YXJpYWJsZXMuIG5ldHdvcmsv
c3RyZXNzL25zLXRvb2xzL2NoZWNrX2VudnZhbCBkb2VzIHRoYXQsIGJ1dCBpdCBpcwpsaW1pdGVk
IHRvIHRoZSBuZXR3b3JrIHN0cmVzcyB0ZXN0LiBBZGQgY29kZSB0byBub3JtYWxpemUgdGhlIGxv
Y2FsZQp0byB0c3RfdGVzdC5zaCBzbyB0aGF0IGl0IGNhbiBjb3ZlciBtb3JlIHRlc3RzLgoKTm90
ZSB0aGF0IHRoZSBhZGRlZCBjb2RlIGlzIGJhc2VkIG9uIHRoZSBrZXJuZWwgaW1wbGVtZW50YXRp
b24gWzFdCnJhdGhlciB0aGFuIHRoZSBuZXR3b3JrIHN0cmVzcyB0ZXN0IHRvIGF2b2lkIHJlcXVp
cmluZyBsb2NhbGUKaW5zdGFsbGVkLgoKU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtp
aGlrby5vZGFraUBkYXluaXguY29tPgotLS0KIHRlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggfCA0
ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMvbGliL3RzdF90ZXN0LnNoIGIvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaAppbmRleCAy
OGI3ZDEyYmEuLjE2ODFlYWExZiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5z
aAorKysgYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCkBAIC04MzEsMyArODMxLDcgQEAgaWYg
WyAteiAiJFRTVF9OT19ERUZBVUxUX1JVTiIgXTsgdGhlbgogCQlmaQogCWZpCiBmaQorCit1bnNl
dCBMQ19BTEwKK2V4cG9ydCBMQ19DT0xMQVRFPUMKK2V4cG9ydCBMQ19OVU1FUklDPUMKLS0gCjIu
MzcuMwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
