Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F1DC5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 07:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786604957; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=cRjRqLXut0xymGMJl2l7yRrSUQVWqd3bP3bW9kQvPEqa2/+zi+hGHmn//XQYdmkfRtmfX
 ji5sQzUHFLYHCPY1RcMiEd+rjFU3atsCyPG0BAe9cR0j9fswIvKQIggsLeerL2O//EhGAuC
 cujl1+/ckWuXOMKnv+yj/GN7n5EUwEI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45CA63E2832
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:09:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE313D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:08:56 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81F1A1000619
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:08:56 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so13233755e9.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786604936; x=1787209736; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=IW4Bzd3ji9UjR+f1riQRr8o0uqMdrw4bjH8A1OaozkQmAc3G0m/LdkoQCfEUPe43pQ
 fuU55byJfJXGtIVF5gpCQBOJOhI6DgWtVW8Wor7mpAvENxj1XC3tZAp03+19YHQ1Utem
 WGQOucujf00a3fJd4aMZrB0pF+r1Ne9c9F8KamxPm5q8mNELOHNx7DzTyEteA2PaeI+P
 zjoFkji+2nAA/dAW/JapAWA0bpDc52DCUrZxPUINVnOiGq8IEPDtXo3tvLC1aGaBmHbT
 mgsVYwWZAeM24L1DHvodNHd4CMaBfHPmgOSBc2WHnJ0d+jJP13FPFMPwGs2C8C8yte9O
 q0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604936; x=1787209736;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=lAuj4PTOiwjfoJxHZM8BGYEoRnUQEQXy7/PLahKYjq623vDSZngDVqrJ9GU0NBBln2
 EeRCADm9r77psCQLH1mPG7FUj2q+wj6EnJ7KhZ6fDPsVtTGNMnt9JB0ZTy1VC8wu8aXI
 nIphvGzg8YlF+f/yGOQQPSmtuNYNxB1fyvvqdDcS42RpfgEN0T0tUNdM1Oy5vvODgwbj
 0TAJVj7aG13df2z/YvK89sn/4ze/rHdtR/I3K5FvFcFcwYqqs65cjg+/SNW32fgD1n5o
 MPIiwibAgvDBAZ8KrYb4NoZhb8HkIT5nOO4M5P5xoyVP9D0JEhHG+5gmtriwFj+MZG21
 Karw==
X-Gm-Message-State: AOJu0YxpDeQY/18ARevMI/6IgGJAUSI1n23JrHTGfikDpQVe4otenhWS
 ARCrOCsT5F0q/EcLugXhhE8IK1NqZJ7O84bYL5Hq2gy7QTQKOGSO/CUnxgTeTitvg/+AwnMS1kR
 /elVgy1c=
X-Gm-Gg: AR+sD125vPLJvCGmV+AG1YUT6uqP+vcqwooj727Vk+f+LCjo58TFmWpT6fU+ygnZnFm
 qwL7Dn/iwiU+BYPcFXlb/bETCiIeriDAXHawMZPl1NMeDrgkfo/EutU0pbsdLq2T0uOWIV06FG5
 U1VhEa1FYJQnXs6pxhwAhd9wqHQIFNR4c/LsFFNMViS+cfBgcn+mq2Q8NmmW4MauhZD/mCbCi/R
 sPzUkUsJ823jVqapJHN/02Vi77nL97uIcI7e8kDZ3LHwvF11elOmpO6bJAw3WlV5Uh8rdWIRjKC
 vsDatGVCI0d2wXO2+xxvgpleinfZaQO6pILhiT+v4yEvOfAFq+N9tWws0+2wvgMbcBWFUE1IoZh
 RNmSw+aDLkKyDaL2AGH95l2YB6ySv3oPihCzjsh0L1Py7W+0a3Hwuxai82NJP7X706hZ5N4Rjk4
 7v1cTBLgVURm3KCr36CWgmpGau3KhEj/+ZavIewDYlAuB4P7OTUHHgrOYtkPhlk6pKDCyPyto=
X-Received: by 2002:a05:600c:4e4f:b0:498:261:dd93 with SMTP id
 5b1f17b1804b1-499821a4a65mr39254495e9.18.1786604935731; 
 Thu, 13 Aug 2026 00:08:55 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981abd6desm47845295e9.0.2026.08.13.00.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 00:08:55 -0700 (PDT)
Message-ID: <6a7d6d87.cdc69361.ebc1d.f39c@mx.google.com>
To: "Frank Ranner" <frank.ranner@intel.com>
In-Reply-To: <20260812112737.2222475-1-frank.ranner@intel.com>
Date: Thu, 13 Aug 2026 07:08:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] testcases/kernel/crypto/crypto_user02.c: try
 non-generic hmac names first
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Frank Ranner <frank.ranner@intel.com>, ltp@lists.linux.it, Eric
 Biggers <ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
