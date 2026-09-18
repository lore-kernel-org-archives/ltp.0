Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54619C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC4C83EAD51
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 19:07:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BE513E921C
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 19:06:45 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 564F31401111
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 19:06:45 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4a4492f5cd1so184811b6e.1
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789751204; x=1790356004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XNQQHEZqT5mrRqnHcRnmZgQsdpOuuxzoHOZdN9oi/Ks=;
 b=BEfpicsGklx/KSQIFa5FbEQBUvzViwGBnzGfI/xh/sylZMyL5KVZMzO+K+F8S1sAKV
 4DxPkzJeSn0CwHZLf6IcS5DfrrxK9vyRC2BWUPr371LOwhSScKR93BUdwkrRx8qW2Ltz
 Nz2dCbKgmMfX1OTapTJO1ILhPfme66M+rbDAgxuh1E6yhk0KcXs5YdGEV1a+LTPvKmp6
 HksDkOVWLRPU2n3ulVu5Ul1FiIxCL2wzxVYjWus42A7XglZCqirDmbLugVoDXx83jiSw
 UGCjhOanVgCkgaTg0lLUbIuVlRzfxre9NOXCp0f9Q2M1XSnL+j0AjT5ivRcENU8/aFj8
 rIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751204; x=1790356004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XNQQHEZqT5mrRqnHcRnmZgQsdpOuuxzoHOZdN9oi/Ks=;
 b=dklha61rMgbeUIacR4zDPm12I7G2Y35RVMc3uJxI4rFoLj5omLwf//PCJ1ZhIqi927
 PDvSDeI2Ip9Gcu0B6IutgZQYHSOSkRinGFWlYoaSBaiftEodeHQuzJxWwfkEO5fGlvK0
 krd/T2qu/Hg28oXmt0Pcbf5V1ILtbUvu+0XWgHCE0fBD4pbc04m5MOo2Al371Ejr38Px
 Kr5eAS8xuYPcpO+8abx4Mzu7rmdF2/0wwTxDbNpSg3tKc5dBAa5/17hZ0+cGbxST7qWb
 0BMbCIj3Yu56Zg07gPY3ovzyoQtP+BGgw/QLPUyiJQSsCBjn9D6+Qt+DmD1mvsaMWMaw
 aggQ==
X-Gm-Message-State: AFuF++lpPCZzimhC3rRrkT5gOScYinFy2iJ/GDc2DKeFADvLsjtgRrEU
 oMZPFbzkrPbzepnjHUGg0qhmlFS5FgYmU6ve7ZpUN/0lR4lP6hvaBohZGclh9EWe
X-Gm-Gg: AYBFou33B+r2R6OYabxblagZyxPBSlYNQrUb+pZlF48Z8nPdDTM7YiwedQSkdVnufnY
 Us+CIXz/sAjQpWgpgPzRznaD7plG6cKFGuVz+2ljz/PtKuFwCRy20PcQiWHpuZh36XX7l+CfGqM
 4Vo183+MTXpOU/Ns1aHM0eOytlLRjYgMCw0yu92vER2OxHATPrHre5BsqbvjOnLdNiWAwf3VGz6
 4HxSYSyowRkKRC/tXNR7ySzwPWWwisEV8zXtPScOTfeqUq/Kxw1Mo9+BpnW1VsldTB+LnB7ihRp
 c3KzA7FFS3TtaTrj3xjcJ5NHwcN6IuQMMKjdyIPiiB1PJoYwiEC335FusE0+TNGjRt0Yqn4OCdo
 IoV2cLPx06+VrHmprhsFIdRefJB+x1WAUZ3ZqfCSncGl6Ht/b6yDagjlxzJLszL2U7a1ymzsY3i
 qTt/xmiG8p2CF98Me8JtLdb0wo7DE4G7teCz2dyl7VKv0+yiwOHBwJEUQhjB1++czYX3Uq7NdeK
 Bmsi8IY+nD5CS+8HlCGpdw6290jAUmWIFwV6FpCCvNBbgJHGbDSf/aPN+l/Mb+rvRHGJ+7R99Qy
 w09xwIAwHnhh0HdykGZDwpac
X-Received: by 2002:a05:6808:c225:b0:4b1:bc2e:3f60 with SMTP id
 5614622812f47-4ccf74ace2bmr3508966b6e.16.1789751203792; 
 Fri, 18 Sep 2026 10:06:43 -0700 (PDT)
Received: from
 runnervmlun5p.3gpgvqsy32lepabrsrehjibitb.qrox.internal.cloudapp.net
 ([158.23.19.100]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cd696d6febsm1483372b6e.9.2026.09.18.10.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:06:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Sep 2026 17:06:42 +0000
Message-ID: <20260918170642.4762-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918125021.1939455-2-pvorel@suse.cz>
References: <20260918125021.1939455-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_assert: Use 'long long' to fix 32bit compat mode
 truncation
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

Hi Andrea,

On Fri, 18 Sep 2026, Andrea Cervesato wrote:
> [PATCH 1/2] tst_assert: Use 'long long' to fix 32bit compat mode truncation

--- [PATCH 1/2] ---

> -	if (val == sys_val) {
> +	if (val == (unsigned long)sys_val) {
>  		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
>  		return;
>  	}
>  
> -	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
> +	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> +		path, val, (unsigned long)sys_val);

Casting sys_val to unsigned long causes false passes on 32-bit systems
whenever sys_val exceeds ULONG_MAX and (sys_val & 0xFFFFFFFF) equals val,
while masking the actual value read in the failure log. Compare
val == sys_val directly and report sys_val with %llu on mismatch;
compat-mode truncation should be handled in test-specific code instead of
altering generic assertion semantics.

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
