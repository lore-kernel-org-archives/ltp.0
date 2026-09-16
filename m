Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D6C982C3
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9D753E76D8
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 15:28:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F85B3E69D6
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:28:38 +0200 (CEST)
Received: from mail-vs2-x0a.google.com (mail-vs2-x0a.google.com
 [IPv6:2a00:1450:4864:3a::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20D13600860
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:28:38 +0200 (CEST)
Received: by mail-vs2-x0a.google.com with SMTP id
 ada2fe7eead31-790a13af915so1247882137.0
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789565317; x=1790170117; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7Xd30zUE1+ogrSCgbIv6eUX0fuAQU1ZrbU5TcgQVl8=;
 b=jBLfTbgWcviza3jg5bHhuzw7Yntf6UR9Ja6GF+IM+iWZYnRe5Bu0dK11chlFC46a9v
 zMUlE5ZVr+2R21Z4VWoK/JpHgdZiHKwqkUguiXWfNBg8+vkvB0YcumIiwOGmxiwZMuBh
 xncrXfrhJlf5IO9U/RYCPr5qjZv1gzq/ypev4vzfuNmakpT0OUksEfexqNywRubCtmut
 6KSoBONMRJ3qy2nxOgtWgRJy/A3mybe8kb2wIPxrAF94Wxu4Ls4LgpVQRpMw1ddBLLLq
 qj7yHfg3ic9ZSnwhlVtWvxSoTpuGX/Sk27DmRFTYygCAONboT2kCsFdJyiUGH+wkisII
 vASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565317; x=1790170117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m7Xd30zUE1+ogrSCgbIv6eUX0fuAQU1ZrbU5TcgQVl8=;
 b=Lmx2E0ESUQqp99kZcQtBRsw2fA6aoE5EgQ9u16pGNXCHwxMi/sP+iKNXsDPduTt95E
 jYcd+Tqqn46OW4pi0WWvf7fs0aYfeafKpdwhgW51hIT3OR27zMUFV5zwnW0zW4hleSsQ
 ZAuVlRibNNKZDlxpjf/4mDKF1RJ/1RIKthPMZeTpVE8VgOeBwABarSvca2XOvMXMESgW
 ErQijVvcDruiQiduDQwY0Lbcmhuhp29ngeRcfTrdOl1JZMmx+75jjmz6RCmQDJIUmydz
 IAKTCdqauRlpfaqPryB7/VfdUw8h2rOLWGOdD3aEzd5nxev2fMCyu9NjpqWyRD/CZBsW
 IMyQ==
X-Gm-Message-State: AFuF++moaFiDHwpAYeLWd2qkXE8Qb85sULG+8bsWwlH76SsTOCIhCHaW
 P6KdhKgg+mTTNoovQfFqIUzrVYV85TEH00Azhm35XELhJ6JFwwMbDsUC
X-Gm-Gg: AYBFou2o7xApcd7ds4wFbbq7srKW7Z78oipY9NJjcSG9wGBiFz4A4fzsEk9a5v9PmmY
 5v2AKcAdzweTXntwPePEiq+b2njR9rWN+rw2HOZ3sQIYBmjScsdO9Z2546fdeZGKpk4vJyaysdz
 aAyEpKXPAVt3NTVDZ2tFMC4khAxeF/Cdqit1dyH1b8H6rvX2XsMfsMNK8xXoZk1mO5a6pGsYSnN
 ojO7DquEfArsL4txopaBKynpStLi1U/RnW1eN1lY7bSCpPMxODuRGb6VWYgXyJxVpFjNFETYEZr
 hMASSPIGsNF/IUj6U2U1JQ2Bh05pMT6vzua93uCdHrF/+OFldNeel+txli6YAlmWjr9NbqWZaz+
 kowJT/8B9x+Vv1X5Dx+Uc1QT/+0EXxA9S8LodgHOr/ItJeeuE+sb4FtrsMiLqI6fgHri0rNcImK
 5fy2HOjYJsSEgkL3NcuKe8qzPD4gXEdIsUCRhJ0hwokClU9fQCDsTaYNm34C+ZN42DZq/3Eo9MK
 b7l2hE0bWW/rVdA6sTNvN7lASJ2s5Vm1OAN1vHw2iF141Km3/Fu6aEhAGt7X5TVPsa3iS6mDP3n
 5ArExq31KSTh
X-Received: by 2002:a05:6102:3e96:b0:79c:8aa8:620f with SMTP id
 ada2fe7eead31-7a026569742mr2635082137.7.1789565316687; 
 Wed, 16 Sep 2026 06:28:36 -0700 (PDT)
Received: from
 runnervmlun5p.vuofcnqkcubu3oy5yogz5ckase.bx.internal.cloudapp.net
 ([172.178.118.83]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bddcf56sm25190366d6.2.2026.09.16.06.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:28:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 16 Sep 2026 13:28:35 +0000
Message-ID: <20260916132835.15528-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916072826.19834-1-wegao@suse.com>
References: <20260916072826.19834-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Wed Sep 16 07:28:13 2026 +0000, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.needs_cmds = (struct tst_cmd []) {
> +		{.cmd = "tune2fs"},
> +		{}
> +	},
> +	.filesystems = (struct tst_fs []) {
> +		{.type = "ext3"},
> +		{.type = "ext4"},
> +		{}
> +	},
> +};

The test creates backing files "dev1_file" and "dev2_file" in setup(), but
.needs_tmpdir = 1 is missing. Set .needs_tmpdir = 1 so these files are created
in a temporary directory and cleaned up properly.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
