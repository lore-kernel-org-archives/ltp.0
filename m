Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA35CD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781783650; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=W2vSHWUKCKYEoXW+3EwNYO9JBjTfdVo3sFpyO4jdY02FTx2mTj9ucwFMkCehujS8ftaeH
 POYtc4DjlvOGo7nkqbTOr5osBVlxpvRs7fJGbZRN6eKlFKql3Tecds6NHQP6x7BFTOemHYd
 kwmw1ptU5ZzlOFY6/AueuRqmi4rE1WY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 206393E5875
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:54:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 420D33E5872
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:53:39 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C48EC200246
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:53:34 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4624c1409c9so636936f8f.3
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781783614; x=1782388414; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=M5nveGb+CfzCF05flyetvWzLXhlmmsZJ9pJ8qDxUWacJivxycfn7Cas9aC9TVuxyA/
 +WREiJ/Hf0QGdgDtCCL8TIvq2R5UY8dc/IGqQe+wfRirltuA9JdY+6Yf1rR1xY+qcT7G
 HXTi93zGvAV7R/OYHXZOSz8NaeAItmEmqJa0jLLmVzf4VMZC/RpU1JiK3/IyFRwkBLTE
 qDUy+PPCM7c74qlN4o92wHRokhorUtr126KF6l5ADsQ0/r2C8L1X/wj03ZP8jZRd16bB
 zp3wSlyJ+2eH1YrxfKy1tnsIWY3yl/ZDtIvLcyZ7Hgiu59+qUhVuHck7T4yXfB0ml+cM
 OpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783614; x=1782388414;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=KzKMaOk9f8hRvY2NhzznJHinyX1IArsiixuf4YxY0TAjPnRBXBrjyOfDwAj9sZIR/B
 7ZQtqNZV1uXuEYZTpSS3iXEBp7V5ibMN6n/H9ORllzuj0cLEwhqJFmgyvp3RARV1K4XH
 qoHL0mpZwYddwOPEeDsnYY9ZiuKWtChi7/Wa2hSgjQ2omQMv3w2A8w1NhL8z4hdcYnzL
 DjL5rJ2f0+/+X7cUqQJT27B0XKILbmm1WZT/zvgtuyU0jd8s5CEWyx6GmApaxevrmbsw
 rpRsKvXPNUyqvaRv55GHfuKuT2GnjE8+2NH8R7E5hjytkAUfHKQi+jULiPYo/ve8sB53
 O6zg==
X-Gm-Message-State: AOJu0YyU39EHz/hvjSAH+GfbAqaGgmm639bq+bhzbzD2CMYocLaEd4hw
 SLHJTWUP1XvvbhL39FJVaAf1ptX6TstpwEhGFqolC3vJ2OT+N84/LEZMf39AHM+Yjbo=
X-Gm-Gg: AfdE7cl8cK1dzCuA8/RwdhJJ6eeAtGkpxk+7NKjxNF8mTod+3c2DNvMysnff2foWJ7Y
 j4PrsCi1kEYdVFV0n1VFIA320eyaBQETQXxWgfKYTsHaiCGFFleu5FF7gjBwYeYK3Xx9Q251+88
 +gsycutmyvL7zI5HX59U4ROPIH4S5GdM0wXophaaNZJvI/t8ZkIVE2uXDYEm228pwBZCctCbqwX
 dDcb2P4VcDUiS96mXpRXc5t0KOOai6scwj/kkop6V/ANGzGw2UT6BvKQ3VoYIyGnXJ9PBBdjMK+
 591w2lm5E6zYgnFXOvAfyrpdvTHPwfjgR7Z84b9zmt7eeltsnPu8YXbd4hlfSqBjs5LCrSdc91j
 IvpiM5016+++fO2vRN0TtW++sRsvy66Mu/fJCy8XQB5LwPpKzyfGiYOxq7gCXmGgHdSUArHr7Pg
 2HfSdjKcGw8105R0dlHDkzaCP0/FUfGUW3JCCcRzB30NMBJ9EZj3812tj13m9+4A==
X-Received: by 2002:a05:6000:2013:b0:460:3233:beed with SMTP id
 ffacd0b85a97d-4641db19285mr3354323f8f.41.1781783614078; 
 Thu, 18 Jun 2026 04:53:34 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm66033504f8f.16.2026.06.18.04.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:53:33 -0700 (PDT)
Message-ID: <6a33dc3d.1d29a1e2.e9ce3.e178@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260618114706.105296-1-avinesh.kumar@suse.com>
Date: Thu, 18 Jun 2026 11:53:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fw_load0[12]: Skip on Lockdown and Secure Boot
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
Cc: ltp@lists.linux.it
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
