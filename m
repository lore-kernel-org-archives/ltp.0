Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6DAFF494B
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774855089; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=pgw4PncfzjG1PAb6P4XLrV74kY0shM6b2qkYcHWq6T0=;
 b=Vx74I78Cn3QGR2YNo4NWmfYQJCKEzDfcCS+oW7Jwgu1MAkvWw8iiyljd1+eCBfhqQcxTm
 3sd6EUHp8htYn5pANjf+53Gn7QmilBd0+o7AORs7axEfjUBOTmL8NtSoYc9t7yZEFcygD3K
 PpcR4bRM1dQkzeXisoHMAZE0670hkGY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A792D3E4F13
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:18:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02A8A3E1558
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:17:44 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 634081000249
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:17:44 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so49161715e9.2
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774855064; x=1775459864; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zf+W3mAFyDuBgW4n3l/PCLC23bRMkD9lYsuWuwc0FDE=;
 b=bz34paughN9uGTDG9B8er9JJccYuCqj5C/Fi/DeS1zXJDI/K8C3rVWHvog97RQ2XYf
 W9Df+BgDMn/qd7YMlKiMCB+oCQrbWezDuE5GV7TJOMXdpvm33xLlBpwj/nE/vDyj8NQt
 JFM7UmmoVn08jF9tWlL7EcH/9WswCuD5i/1A8GaixlGhreQzjLb4X0yCr4b3o8uS9Lw5
 H7XZPP0WuRSyzMfAHSm8zEA3CClCoFXd79LAQZxHmclNnUZi4Ytz5gmvfS5/1oeGclLr
 5rmUvgVFNmi1xtAEO0xEntP+9T/PArohR8Rw++yxK3BPQAWDN+S8d0h65RlHOKReE2AV
 iBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774855064; x=1775459864;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf+W3mAFyDuBgW4n3l/PCLC23bRMkD9lYsuWuwc0FDE=;
 b=S13tiOoPOvPUlNnxSK3yCF3E3c8SwCDxe9l2LyqVWjJ1RJpxdqZEbbNJC3aDIvcbNg
 lsNVWoPfZgoKrOWbu42+Hu1U4+/TtlT3psIvzbQybYytIESaQuxFbMjjizfVdIt44OoT
 LJi2saQsQAA2et7cjpMbjeBEvlmdd/0Fo1carilO1Y25xlblvinJgp+4YMDRPe0JaXU+
 umujFm0H3kZWpJsJExjm8jLelJ4zPTXO1CrHVVg4A+HoN/6i3urI5VNCfXGFb88sC7Ck
 jrU+PVH05zh2Z1HsME+J5dwqo7spp15rD6Dc1fa0rGUmrquztleWay5WlCZx1/eRxMNk
 8+Wg==
X-Gm-Message-State: AOJu0Yx3SlmBuifMi+wewWvm+cNd3hROWv4RHwOO0znMsRSMFQsDB9iW
 41NSVJbr6aWWvEZgadS0swt8mKztgyLxHmKOeuCWxJ7YqAs36xvMd0qQ5PdXlLI4LKI=
X-Gm-Gg: ATEYQzyoxhcdCmGh5MO8ljK8rbdaVdH3NAVWAgbej9FLHmx89ql6TgAJGF+YPlJNYaD
 /KC8ZyACoHGy3i+aa5m/+XOx34exHYvsyC5WGsa3KD2L/x24cOv4ihtxYC/a/oc6WKusuEO40iG
 EqkBOR74E6DQZHo9CtHrrJu1ocl8l7vQyyn2WLyunDGbvHUfeCGF2B46EZ/Q7/Sp6dh+ggzGYx3
 wuhMqOh0U9jVS3BNeOOYLLmNEBCR6oho66RDdiEbUnHg0JImMfZPoqRnDe5UtkIaYZ+BoEOBI6W
 anPtYbR+J0oW1kiq2BziVBWqoDXKb4i6jJk2x8r+zBW0CRmY4eGXABI/Z83vcc+4h/f+4+8TNjg
 nXZkU0yEXArLSwF8JwZq17q35JX+g1YuJdEFDpGXzcIAl4quKi8X/eESzA4YfdiOWyMmkVVtjCJ
 pz9+WaVQnnr4jwMBG44fWsDoyFI1LOYpfwPPu+UO6PP6TML1TyJuqwGn5LzcbJ7c8n7gL87xy58
 cXemsK/R+x8hJosY0ZUcZOYswiGXKzyEw8=
X-Received: by 2002:a05:600c:a407:b0:485:4526:ee06 with SMTP id
 5b1f17b1804b1-48727e8bd95mr161947475e9.11.1774855063675; 
 Mon, 30 Mar 2026 00:17:43 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725fd18b7sm74185325e9.13.2026.03.30.00.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 00:17:43 -0700 (PDT)
Message-ID: <69ca2397.050a0220.19109e.a911@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <acckSVyvtJTMsOGP@autotest-wegao.qe.prg2.suse.org>
Date: Mon, 30 Mar 2026 07:17:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> I remember i have tested in openqa with -i1000 without error in early version such
> as v4 or v5(The main logic not touched compared with v6/v7).
> 

I see, anyway the logic needs to be fixed because at the moment test is not
properly handling both error codes.

> BTW: is this the final comments?

Yes, please send the next patch. I will review it later on.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
