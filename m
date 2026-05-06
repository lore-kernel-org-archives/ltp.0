Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E2CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778073064; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Gtf1H50La/E9AYiJCDW5KKhq7YcaqP/9c9eh0cQKmL7mn907/4PGNLewkWxNyq2o8QASm
 xgIy2NtGg2psTNbVDa4CObBhM3UGcBgAfLCOyuZem8+SoGe0TtFfnjA1p3gXItSWkR/e5mx
 C5Bki3TjQsHQeKCLgQXMhhc/dy1aLgo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B5943E65A5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:11:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A07803E6158
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:10:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 062E51400C74
 for <ltp@lists.linux.it>; Wed,  6 May 2026 15:10:40 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso76886675e9.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778073040; x=1778677840; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=OvFbnTAKJ9ne7u9OUddM3BPIsxvPt8MWsMW9meLCwr2SS6YpWzhbV6bwpE8VRQajY/
 t2A4A8LTmtxd9/Ii7Kecb6I0x9vM1GJSlpNY+nKKcqaygelAAeaIEHYW/zYsQGAdeOqi
 1Jk4nSDPH0/yvll6kV+H7R7E0kspwXmnZfQdhBkLA2XZKCj89g9ONZwLkz94huFEhSNS
 iB9K6HRwP+B3Mobq4FLMbu7KQqHWdAZ0GPblgD+0UdEDJY09slxB2DRFZ1zt7V8Md/Ge
 To7San/pF8GXIodJ8DUGMy0+l+JjBy0I07EV2AomgNBHsLgtDOdGbd2XLsEmxZkzw46u
 8BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778073040; x=1778677840;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=h+SaxRcTJU+hNa/loj3LaLQs6I1ck9pd1lWGcgAHQziRbVjn4MaqxaULhS5p2pCpSm
 EsJyBtyl5dYT0FSLwBFKBi4XUrpb+ehDYzZHFc/swhsfefGb/+s/qsVWDa1y5q3euqnY
 vbPUK8aJRLL2vGNo8pUW3MHFIeRZM9UIxWWnMUko1L3jcZ3Z7rL0rSDxp80Dzo/7GqWQ
 NBwmOHWdRg+vsQA+3d41CX1rtQtSEjdmjM3k2jWY5kFvD6gDMPIvxFs8Oi4CxX0SjDs/
 bsVH/whwD3yzlH8Uh9/P1kBseXXQDFSRbA6YjCdo7sMaYOcSWCyOoMwq4ZfY5g8BhQRV
 1KIA==
X-Gm-Message-State: AOJu0Yz4Wd4Ju+SgFZTYeZsxvkPWRCq70Mcqdy0ayJrtREtZ/niU6euW
 tLbk8lgdLl63r9a6Sk8DjCijJs3H21C90x1BRbSMvxSZJhOoTOy6nGjb+kgb+LhrdRY=
X-Gm-Gg: AeBDievOnNEp/4O5MdVCh7J879oJhL3DNX6WtFWHRMnMMpCexGlS04eujeEzaGPpAmu
 Jcn8/S0XTHJkbs8czcnWaXfXQ1AjpEVfaPIsvF6ZutiltFVipGMINM4AWYmfcmIDTjXpanwyc6v
 ypLOPU6KefDVt2V39w+TV2MourOdnylXJ4fHmiDolOyouMxEmMwgNyFilA/nHQbb3DRASNg0fHW
 iaa5bPyg7wlv4KKu0SM7JTcdqGkLvePlVH5fdKfjJuonRyND5+H/vNhkCxaWqW+CwnBEs8c4NG4
 7P7fB9qNgdQIPfujL86WoDdGF50W0ih0ADZm/O23Zud6+eRmRn60OtXth27sXYoUhmoZhYDIdeo
 dw1FnqSLfCGhRb/3OxMi7gL0442s0Fe9+TWsFRyeB08ermupY9x/rgxv2CuuI4W92JrJd8XdOet
 hhj8KzlXFKdaqoXQRhyMT+3zSDUuQcpRHRHBC8Re619iKRcR0rrvM9S0DGymwzwEclfqEfHYTBF
 I3cWQZMpbqP45Kp42kvOV/UWk20BONf9v1h8am4qKTmPnYIhU49v2b+ZBK57YdJE7iBs5ZB9ztO
 bAZ0tn03dbDzpZ0oTHMgFO4=
X-Received: by 2002:a05:600c:3151:b0:48a:7605:751e with SMTP id
 5b1f17b1804b1-48e51e0837amr57110825e9.4.1778073040276; 
 Wed, 06 May 2026 06:10:40 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a4878fsm12051144f8f.9.2026.05.06.06.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:10:39 -0700 (PDT)
Message-ID: <69fb3dcf.df0a0220.bfdef.8231@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260325-ioctl_getlbmd01-v1-1-00dc526e326f@suse.com>
Date: Wed, 06 May 2026 13:10:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add logical_block_metadata_cap struct fallback
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
