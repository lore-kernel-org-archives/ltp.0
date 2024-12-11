Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9516BE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733912140; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bKaToSBpWpfIQVXtxCJIO6oPC7301BALEWL27Yc9wEo=;
 b=UHRbOc5UXeJjj35IKt22+QRfKx7+U/1CuQrVnPWPKcH1/1In7Bh0MCGStXxPtg/F4ykgw
 vr2bsVzY0lzqn9m9COhwgfzPv+Nt210DBGy7iuRXjvxXhaeXEgDzr6Y/MmaOV1d26sUfonf
 mdG5Um4jJpX8hv6nOjvucDfjpZcC6Xo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC943E7D30
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 11:15:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02613E7D20
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:15:18 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE57F2275F3
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:15:16 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso4974287f8f.1
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733912116; x=1734516916; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bzggVRFeRLzOn6w6nh2Hr6QncIsZFYQkGZKevGMllrY=;
 b=Xxfj1IwfhWlUpVEMNB9UmPqL67YRdPX5eRhhceUBXUoq+PTtIada2dT/kkYPVd1ou6
 PYou0g+q/pFCMJjpkaI5geO4YfEQEEalbkhpA9D8504EZObr8097icCrFXS/U3gUVnue
 gF2gZzcB2dlYIuSk4qIEpx5EWb8xsLA+fEy1fcwDeupQbZPjWuMlwwsIrChwDcTR3Ilw
 N9EwVZxU8Gi2lfEjPI61mUl1Vs4GqS2nuDULkDM6m2zZKLu5y5DptqRHYY6qMbpDf5z9
 IczMtQgLihJGw0qmghGC/ld9fx9yeCamgt078efH+PwJqEvbiiXJQ+LQDLmdUotVN4li
 H71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733912116; x=1734516916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzggVRFeRLzOn6w6nh2Hr6QncIsZFYQkGZKevGMllrY=;
 b=hdba8ywI74Qyx5bZSqoJReEFmSbEJBf9eUcq/7EjkocRnGVVZguyXdfnGlnDcgH6UU
 /kPkxHa5q7TSRu36J0fI/oxeZWf2pgYx7Kp4dT2hXIihomCoiGHMr3NGejK8Nz/uPyNm
 AL25AouyCrvA/cMJ8MMFtIA1+tZc5cnwhea877xD6k0tLrnr3RfImjTwWZnnxEKOQUeL
 qK+oK9dyCItUCWT/VG51cUWE/aS9t9XTFlyu6E1CtTX3fvT2pWpSps31Gyu7hwMchp6d
 H6irH9A8qgEuxnP0g1exZXTyIeCYGxXgdjbQS6It1zScx0ktxLmuh19U+qHiwAZ/07v7
 bz/A==
X-Gm-Message-State: AOJu0YxMcGpdmsam0uuHyYpWiRETZkOrn2kgUglqkSUyTcDoHi8sF0Zd
 Hp7tRiQ9rM+XJgIokBLaLFobRoYcMu9brXc60zMtanv+ebQPfdSor+djEz2h5nQ=
X-Gm-Gg: ASbGncvFN4yssCOZ3tjnRbdQbaXjwxzO4g18queQX5u7M3xHi4lDW3+fzfHn31Ry8M/
 tc3SZhgG35GTj+nfkhmgYh3j/uhZbyoLjYafCSt3pdMtL3F41PZwFlq30AiUBSRCpX191tR+bwp
 rLsWjDJh2w0fzlPSuHSlaZVH907zfxE87U5DoMTyjmGFgk0MzQ9ZAZG/1XF4fxq4qx5jZ3HQSuu
 HlcrRq0rnsknnavT2ZAhxOJ+o2MNBg2xfQsphHIgXXdjruWDgjfbF3OhDhHjUglng==
X-Google-Smtp-Source: AGHT+IHE5aBf2hUJRlaIQvLtiIjQqplfQIMGaxeoVVZzruVx4HNZXPt+PZ8G+9p0TxHoYk4WR+ZanQ==
X-Received: by 2002:a05:6000:2b04:b0:386:407c:40b9 with SMTP id
 ffacd0b85a97d-3864cea230dmr1248616f8f.28.1733912116376; 
 Wed, 11 Dec 2024 02:15:16 -0800 (PST)
Received: from [192.168.42.37] ([193.86.92.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f474sm10721482b3a.97.2024.12.11.02.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 02:15:15 -0800 (PST)
Message-ID: <98ea873e-d0da-4a69-8dad-1bb4964e61a2@suse.com>
Date: Wed, 11 Dec 2024 11:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241210-fix_input_suite-v1-1-f8bb1d80d2fc@suse.com>
 <20241210172123.GA305921@pevik>
Content-Language: en-US
In-Reply-To: <20241210172123.GA305921@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Verify virtual device availability
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed, thanks!

Andrea

On 12/10/24 18:21, Petr Vorel wrote:
> Reviewed-by: Petr Vorel<pvorel@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
