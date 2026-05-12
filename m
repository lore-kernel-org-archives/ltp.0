Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C10CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 14:36:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AF633D666F
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 16:36:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514553CF9F4
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:36:16 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E07236007A3
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:36:15 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c80170db7d6so2123778a12.0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596574; x=1779201374; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bUA+lkKkv2f6TLfPX6qZLhQAd12/xsHXnZloD6RZyk=;
 b=Ju5tkPOdj8XGPtK0knen8m8+h+GEVvP5mMETO6xdeUzvYkOhOaqAC19k7koae1P8Le
 M7eN24FHbyTQzbIEOqaRr7g4s444bd3JTvrT5y8XroGVyCS1eoRxhAMBhuCMC/wYMbTa
 ObnIWYds1N5u/6jaQm5Y0VH24YjiIE6Pul3oM7SJJRxqVMg4B89EevOZGG2G5FLt6e7I
 topemsg7ckI5WDq/XyF+G6avbrPFRDhh7lY4Xtm1eLUX+UhJCGCMw9fwcT2VdhRHUynI
 fP+sM68Mx6LzbkX98e62xO4nUW0lRh4A/tNgp62KE4mG6+xp4WqKD/dLZ4heVlbilWiQ
 U4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596574; x=1779201374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6bUA+lkKkv2f6TLfPX6qZLhQAd12/xsHXnZloD6RZyk=;
 b=CXrt12ylSpzhEbetUtloWlz5xQsY916TbKakjh5Xn8ANMEmIb4TPizMWXfmd1DdGpX
 Fka7Lr6ifMKMHuv9SElRJS+K29cDBU5fVKxJWugdJvZTHfJodlxavpV028QUMJN0M3bH
 R+q+vLYxUtuOrsPftlN5AxhO/gIMR75lS5ZNwCL62WV9fbQ0eZxFIkkcNCVtv2zcqa6Z
 +R25LQyiCkw5Ne2EcZRkbt1qtOkgsvLz3v+VDZNvx8cStqHvwI9RBMFFKpx9gxsXT2p1
 vTSvOAQcDeBX+7uc9e6kPXDFDUz1LutikiKRUk1TIrOhRFz1cQk+Xh12lYlzoUZrgmnZ
 YSyw==
X-Gm-Message-State: AOJu0YwqbI07xfoS+7/kxQTFWlreOeF1g3GJhznAo5finjPbd+Md0BGr
 IZXhkxdNaWbbQaCII0fMT3FWoVyUrYQsMI/nKzaexRlmkapYUr8krksLKLC0Ju0=
X-Gm-Gg: Acq92OGOqvjjNAQZ8R9I0nK26JvxSiNgF9arDZbuV8tBqk5i+QEqMzpQrrKDxyBKX+1
 GAk2JC4yBsWrxN+CG0wU64E+xw6XY233whix/UnpJ1uYzYfUaeBTBZffKS8ldTgfT5d4Bdd2Npe
 AuWkc9hSnh9vak8inXDNj51fEb6oZtiL+BL8zcA7T0TefNtkrcKZDvu4KaymhfLgg9vE3ilwM8b
 fEA7XEGiNFchVd2KD/TGrKpkdheGfvPKSj7A4wYbE80kPcEtylt11GBek72/BbzsDQPd39sjMSg
 lMzZXWLUfGS7XKFaMQ0hEBO4yvdkCuxsmaHWsDPaI1RxKNahmL8+WSZHOFkpB/pL5NNf1E3PMn/
 AVftWqNaf0T09tiVhAkcp7YSoTW7TlQYER6W2wFnpvxW4BlDdVOsrJG8+VsKz2pxisBjmikqXXP
 X0bfQaIjQJ7I0MyMBjOffoKdUJqjenQeRU4PY0oG76Jw==
X-Received: by 2002:a05:6a20:394c:b0:398:9c27:2479 with SMTP id
 adf61e73a8af0-3ad948af390mr4220618637.5.1778596573915; 
 Tue, 12 May 2026 07:36:13 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8267689d76sm12155040a12.11.2026.05.12.07.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:36:13 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 12 May 2026 23:35:41 +0900
Message-ID: <20260512143549.868-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69fb5489.5d0a0220.d655e.18b1@mx.google.com>
References: <69fb5489.5d0a0220.d655e.18b1@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getpid: Link manpage and fix minor issues
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thanks for the review. I'll update the patch accordingly.

Also, do you have any preference on how to handle the overlapping coverage
between getpid02.c and getppid02.c? Since getpid02.c seems to exercise
broader coverage, I was considering whether it makes sense to merge them.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
