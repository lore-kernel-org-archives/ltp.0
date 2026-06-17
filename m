Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9ABCD98E4
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781699690; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=tSDXwYPeZpQX/g8mpSCx2GVlMNfKrl30gm77hmSd1WQ=;
 b=KFyCjKPUXUW0tjnqcEEPIh52D/kC2EH0TGrh9C7NVyDKZ+BgWExzOcrpe4UC3U9MHbBSS
 +nK3sDBVdJkAXiiPYJ7efwizkiSJM5Ddkd/rQnwQWg0REvOHk/Qibwu16B+FeK4JqaBUbkU
 OBa777WV7yVoVZ/izOfcHkO30Bxekuo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C12E3E592D
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 14:34:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E2593C036C
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:34:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CBDD600663
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:34:29 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso49101395e9.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781699668; x=1782304468; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CyCTS30V1ZMSyvuOvuJUHQGruFimrN1Aog3FyzC0dug=;
 b=MehHaANut2xMo2kT604+ZOtjDcjgwOi4VcnN5jWY5t/hclgIgQD5DM45esXXuwT/ID
 RRzXUlaM+0XHogAdqekaU9Pls0HMpErn2ybVkgCmTMmbSRIftAKMUTvF7tqU55YXs/cD
 H0mpN3x+cEn6PtlQgc3/SdhQTnfnmvoXyV6Njc3+RQ/MrriL2h75kg6Fi9Ojdgk42bEw
 pUB/cvfIwCiDFRRpQ7NGE43KF8xqjybDJU6zK4gKiDuRH+08vpMMAiu+qQyDSIGYl9zz
 eRAUtnahXkpiUsWn12gOA9fVh7uD6Uw1R1TnK1zcE6PAY/4cwgtz7GdUOSLGsHJ16Wc/
 pKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781699668; x=1782304468;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyCTS30V1ZMSyvuOvuJUHQGruFimrN1Aog3FyzC0dug=;
 b=Bt+1SRsjCV1dxjFeJr8d6+WrNnG41LYxo7VaGlaFHACyVZNU+RM39VlXYJ9rGiBjzf
 o2wFg+DvCKSizVd44B9usZN7k6GTQtLH3Q8NMANBD4+6/SeTF1GVthA8HZctJ+kPd4Df
 khjneVpiYJWY8nWeOhwcpHNXAOVlhCazaB81pKum+Gwgix6HB1xtf82oGSOBz8kfg7G6
 d9ARqGGc5iJDkjbRJdCAzsbGz1JJG2nboZHwHdV9g0PNKnGDqoAXaYaDf7SzATqOZwgB
 qDDatOvD2AvDcCDoTs3ufxur6Nxqv63/sMg3ZsWQmRSL3vj4v+Ini5RfeCad2Io+WNlO
 vqww==
X-Gm-Message-State: AOJu0YzjukEuulPxEuARTM463KX84O9NBjKljp93x+MMTkQ5GUHmmupp
 Qd4YDlEiat56kjb3+3cuNSiXTOWmuEBN+bfZHS0Bt1z7jM+tjaf/knbsFndAYKIYv9PQKdh9EbS
 OdZ8b6M8=
X-Gm-Gg: Acq92OHIuEBb6incl6PmQPcaYQeV8pQH9Bvpr7pubh6luWMLKtGLM1cLMZrRpkOPTnf
 muzaHlVab3NRK56+MAcsmlbZfSb5It5dsA/GdCDWA6r9h0bFY3CxVL/A8OpqRukeSMoqN5xbW1s
 EHHqICtZSCY6UGuYmQ+AHhKaxv4/2J1GS80x/ZyUV5IdMuoPiG8TM7DQPPdNFJxftkCEE8FH1G5
 kRw7cgOfxArU1hAptsbuc48xIgV7UA1PfE3FzrqnRvOwF1g2no6WNMPHVcKXG6Nbmfp63opiLX5
 bsOMDU3ewEwecuay3ib3o2t8dn2xEzDPL45iNnBKnV9wOiVGW00WXb23OxE49mkg8470IlJlAXg
 cknTEdwWyT9HD3dPBq/bIFcuF5SxnPhr4znK4WostUJcwPfAaI8SqUvmDDWH9OI1Mjm4fyUKr/3
 miEDtmRNc8abwnQhzImvySm/ZajBwThL45oTsL/mxDuLqugSN4VH5qW9xgf9jBew==
X-Received: by 2002:a05:600c:e547:20b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-492333bfd96mr47798845e9.14.1781699668194; 
 Wed, 17 Jun 2026 05:34:28 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96b47sm130892905e9.13.2026.06.17.05.34.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 05:34:27 -0700 (PDT)
Message-ID: <6a329453.f77846b0.1cf411.6a0d@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260616183025.26554-3-mmenashe@redhat.com>
Date: Wed, 17 Jun 2026 12:34:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v15 2/2] futex_cmp_requeue03: Add EFAULT error
 coverage test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

the patch LGTM, but agent is right: we are missing a unaccessible
memory test for addr2.

   {
       .desc = "uaddr2 PROT_NONE",
       .uaddr = &futex_ptr,
       .uaddr2 = &prot_none_addr,
       .exp_errno = EFAULT,
   },

The test description is mentioning this check but there's no trace
of it inside test code.

Please send a follow-up patch, then we can merge it if no issues
will pop up.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
