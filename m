Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4225D10ED674
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774618794; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=QMTNsVLSLaxNZwooQVla7DB3JbBAQ99zqdLhkyF+mlU=;
 b=LwbfrsSyzqTNWgb/5z2zau3aiYfzGeYRY7m12zyo1cpsvBex7F5p2O1+947tqxuSvGw45
 na4lXe4yHxgYjDoxvEhCCvbU4WX/bGO/O/fCHjByrf7utPMzcG5PFPO11fOW7CIB9Y5ksgH
 tXvCHpg5X1Mza96T1VtO5ddpUtvztZI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E6513CFFAB
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 14:39:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D19C43C2150
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 14:39:29 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 34AB4201DDD
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 14:39:29 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-487012ce896so13206205e9.0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774618768; x=1775223568; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jQBhtSBCFYEA00d8eV+aonwFMBkS1nniq6UknLGxZwk=;
 b=KZ2AHRD/fBo/c+jnro0PX92jC2Zp7GMC/UOZezpcmA7XAAq2m91IZYtvxNG+Tg1R3i
 C7Ty/OXzQjjU//W8ZlbOJwJTerS/VUDQV/8+lLtDv2oKt+XQee50bYkHICY3xTqQbPCz
 1LR7vhfJqif6o9BF5KGJTeZcXebRIO4UB+QN2TBf0OKPxPzpzlRxZrc5vyfk/oQR4XxK
 mvhO7X9Bpw1Us+BnTGFe4mqAYJVrEyvHWWKeq4eJ0AHAlherrI0AB4fJU5fF/iXRkfX7
 YNR/opk81Vj5C9Awz2SO2PRdKgAckNQmeaaTQ4QxVu/5Fpwxhb01URnHokatddnEZEvn
 Dd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774618768; x=1775223568;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQBhtSBCFYEA00d8eV+aonwFMBkS1nniq6UknLGxZwk=;
 b=AZRc7siNcOadCLCIzjvthHNJYBkK1PWi64L2Qc63QWV9iYnpuN6H84+klZDCAdE8S2
 3X73yPJIr3tZ5ZTN65pX/bs/L0NcgKNWZBJzw3rkUoCrcqY1ECHQixSz787rzWDgNBbM
 08fRjzc+HZObLNgOpem6zbXqoZpj0qT4JiDjGiv9s51E8drn96aw+POTmuk77/NNl1hi
 4LvP+FDyx29NiLN16ezlskhLy3iMAEixJpneOLK39Eg53/wbotAT90blHw78A9F9uzY2
 H1BLcAkeRoM92SdRULG7vmSpHDwtwkIiOUcDVAE8hHcQvlLUl2rF/besQYXZVnkeW0xy
 CdAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1GulmsLOnPnez2G5gqfv2DY9c2EieRMZT5IMpvg7Y/QWiXp9CRvPwuyjVhLIJuT1AgwM=@lists.linux.it
X-Gm-Message-State: AOJu0YwAjBO1/Ux1UhPDLt71py0gTiZjVWA68TnX/dEsVRSrU8w3lFHm
 7Ft2yC5HVuHNqEsV28VSEX2cTAZjcIuEKTZvwRoACezCC1rscotyzW0nPDC2K4a4Txg=
X-Gm-Gg: ATEYQzzWq/ta5g2x+gKlj9K1niUgQdEgvzh11xL7r3ffOdOcMOgr413tQzHZZw9FVUL
 fh0vP2JqCwlzv4pyE15evH2FGvk4vwOGeAukeFStKVT8sZfUk6j4H7Weh/PxmS1GvaaU9dv45Wu
 zAAXD7qfgbKnDk2+C/uNVf/8fVJchEFK6s5+MXsu+kyjLig1UpM/KCUk+FgIPALmO/ScSLdP0Zh
 kInB0qjzu0zyEtKR090bGdPd6Q4gYYttc+b8sausjkHuEqa+wrG/eGswX8HQk96yt7Dp0OCksId
 6sFh3cnXST7X2djkFWjIE6RiBQ96Jcw+XiUkn+x55H1xHQqsJkp+EQpVgKy0u6WyXDSTsEXeqVF
 fB9XEMDtf3L0TzmTpQQeUfAlScvO6Y8fxmlDM+krxGSuijRL2czG447nv6f5QaoBU5FGD2saUOW
 BkJ36CyzTj3+Gt43JmxWRVfgH34A8b4/aNHMMjhdM=
X-Received: by 2002:a05:600c:c178:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48727ef16bamr43274615e9.27.1774618768449; 
 Fri, 27 Mar 2026 06:39:28 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm90451775e9.12.2026.03.27.06.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:39:28 -0700 (PDT)
Message-ID: <69c68890.7b0a0220.33fc19.bf70@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327123351.GA1083266@pevik>
Date: Fri, 27 Mar 2026 13:39:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test
 Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> FYI I asked for 4 in v1 [1], Jan had originally 8 and I'm ok with following
> kernel. It's just my personal preference to display tab as 4 spaces and not 8
> (IMHO editorconfig plugins don't allow certain setup to be overwritten).

Sorry I missed that. I'm just wondering if editor configuration is applied
only for visualization or also for typing. If it's applied for typing then we
can't use 4 chars, otherwise we will have many issues with checkpatch.pl when
verifying the source code.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
