Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95712FB44C8
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D486E3E28F4
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:09:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3693E2570
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 10:09:18 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35D98600640
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 10:09:15 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so6015214a91.0
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777018153; x=1777622953; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbZX4bDKDmhasXyVQeTfpM/bLIqTBsJmMMReaa06uM4=;
 b=RUJEN7qku0PLABvC8d/6BXYmeZHuH1r9eZi5XfxJIMKlcv9bDlCFzN4wBA3a1Ygyx1
 gSOAHCl7XOitAK/qlbtbzXxD91rmA70K63RkLbiE2ecNjEyaCTJTnKxWCHUpWtqyWdt9
 6chwYz7vapabvVftoN/Dl6hvViiHkO2B1gGabmXRk7Ksc0mAd7M8uRPOCY2/WeBwvdyH
 suqZOkaG/wV2/QfxqxEPBl9I72DhzX7H6pD0qkEPvVs44fATLqRH6S3fdbhzWVuiy0H5
 sPqgp0tBaa683Si5wWX/EpS8wzLdqVM+Jl/vdZxsJlDJw8hKb9UBH6w6RiTV5IJjU1LL
 Kcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018153; x=1777622953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RbZX4bDKDmhasXyVQeTfpM/bLIqTBsJmMMReaa06uM4=;
 b=ftbN0ZhfRJuEa7jYOdRmVyAf6rlXtq/DHE/9WQnyA/V0Oj9tLvM9PfAcwQs1tC8LYb
 Ex/6iXcHjTdejHpz0JCc1AyRlcz9WycsSPvejggD7uNoHZjKMPeFvNZx0TldKJQlfK/y
 PBuzX8Oo8MSy1AsO0Rx1y3gR+p0q3IZkmbs7pZL2h8R9DxeylXz3XtGjMtmFOQ6Zzp8G
 4jGis2KrZ7f+BeheJsRufLgDfPrAO29WZMqjAjikLvLrZIe7tdlgI32Vk7suJukrCIv9
 LgvcoddnV7ingkGHxwp/WnMbYU9V5eHvPTulsPbBM206X9TvnmxCwyl34ok172XcqHEE
 /7WA==
X-Gm-Message-State: AOJu0YyBnZZiVYcmDpfGaUlO+Vk3/ZDMOLJu8n2nhUuXLREbtv+VP1bw
 srkzY3tmKxdm8H39nE9OfEXHB9owmWb8MyG/CAcOfZvYLJCEycbTjrU6
X-Gm-Gg: AeBDievsOGpMaiernuXVgNSBL90bZJqCnZKZUVNsyx5XQ1Pp2R+0nMvNGE37cSedymt
 M1gBghY7dOFU1AO4oKoO8hH1fDo3M2a9RR+uicH+55VEP2666qoEW1DCjq18H4tKKVFpPQmbf0g
 rTiHOuxm61wHigoS7dtApq2sw9Lxg+zbkMhZGk+TkArs53HGweZhUzySScikild5AZmXFf1g7H2
 kdYH+5PPITiezlbmI9Cg4qHccgIQIMxZnjhK5d3RgTVoVbti6RaMXqkhk3Z4IESrDm8+J1TZAbY
 1XsENkHY19YLxm/ADhDir3iU5Yk0xQAtdqj8efFe4JL8+aIm6EjQRSW8Os7PYrqwKkPbiLVPyFi
 OF6hujnjWTsvJzUiEWgGW8r4FVADft0xUxdBEuX2GmWDU5kw6FOcMSGvH6Ko7usJdmKDQ7U/GmD
 RlWzfNwfMOhNdltSvkceQMzJBnjqsumWml+/t33MbmaZ2g4v4MwSfK7mdbZCuSDGkuWULc5eBAz
 ShokvnwiQii1f93wotWhdue1/egO4HgVjJqCIernklGNf8=
X-Received: by 2002:a17:90b:4c52:b0:35c:30a8:31f with SMTP id
 98e67ed59e1d1-361403bdd28mr34119983a91.2.1777018153605; 
 Fri, 24 Apr 2026 01:09:13 -0700 (PDT)
Received: from
 runnervmeorf1.4y430nl00ooexjpdoumriazz4c.xx.internal.cloudapp.net
 ([20.3.166.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bafa9sm22534761a91.15.2026.04.24.01.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 01:09:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2026 08:09:12 +0000
Message-ID: <20260424080912.4039-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424060543.462475-1-pvorel@suse.cz>
References: <20260424060543.462475-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioctl_pidfd06: Update kernel version
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

Hi Petr,

On 2026-04-24, Petr Vorel wrote:
> ioctl_pidfd06: Update kernel version

> -	if (tst_kvercmp(7, 0, 0) >= 0)
> +	if (tst_kvercmp(6, 18, 14) >= 0)
>  		err_nr = EREMOTE;

tst_kvercmp(6, 18, 14) >= 0 is too broad: because tst_kvercmp compares
(major, minor, patch) as ordered integers, it evaluates true for all
v6.19.x, including v6.19.0-v6.19.9 which do not carry the backport
(which landed in v6.19.10). Those kernels would see a false EREMOTE
expectation and TFAIL.

The check needs to handle both stable branches independently, e.g.:

	if (tst_kvercmp(7, 0, 0) >= 0 ||
	    (tst_kvercmp(6, 18, 14) >= 0 && tst_kvercmp(6, 19, 0) < 0) ||
	    tst_kvercmp(6, 19, 10) >= 0)
		err_nr = EREMOTE;

Also, since this corrects a bug (TFAIL on kernels with the backport),
please add a Fixes: tag referencing the commit that introduced the
original tst_kvercmp(7, 0, 0) check.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24879016987

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
