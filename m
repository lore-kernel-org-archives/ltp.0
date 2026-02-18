Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5ADE9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771419154; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QN40XM6h36gBoxot9ZcFD+k0vvA3F+H14kWtw+52agQ=;
 b=rGTvup7VUrurjTMeJa1FFkrnAOzmK8rtNxY8tqBHwCziiyhgGF6yT6mnOYrYV5maBY/OO
 HnYYQ4znY6/JeGa5FbOkYaQIXKPoinNX5S1euZcC/8H+ePIw4z7zFf0jSd4DQOr72TBJAgj
 fUcEyrk3k7qbgJNh8kPCpxHqv+qh0Po=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FF823CB063
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:52:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 875AA3C9EA0
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:52:09 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EEBB61A00108
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:52:08 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43622089851so4826255f8f.3
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771419128; x=1772023928; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKF/CRQy4Vc3kHvZcvharMCmKAulKzSiStjudhRqxfM=;
 b=FnfTxsZjO9glbDOg1Ble15KeAQVgPsZnjp1PlFQimSPg/AFysPbyCT3aUgAJZ4Etxg
 S7Ct611wtlnBPwBSZdZuwyLxNK1BUWqTwhrdqkkhRXHD47cWg2rivu76NXv6mK9Lce49
 xmk9Q8gr7eaYY3jyNP4tQfKiQd+hKKxqHvYaWMf3lRN/8RpK+5EKyZ/XHpv3o2nanKok
 xi14oA/hYLphoSaeQ0JorBj7NxcVEkaaHhdwcdWZqsYobqG+CRKMW4BCFgsDKEO8yVfx
 zrxcZpsYXgItZ8bS3pKWHBa0IUHxnlZJjnKCDsl96E/yj9zLt/01CvzqXnZvzMaHSann
 STDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771419128; x=1772023928;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKF/CRQy4Vc3kHvZcvharMCmKAulKzSiStjudhRqxfM=;
 b=h2ApbYMTJYzE+n5lzxpvlEDYFanERsmu8ScTqtY5wsNMYn4AvDxAYM9btfmEeWScko
 lrDqudaMSsuQupL7LSQVY/4EM1I8MLROfXmCR9Iqs29utLZ+XNSWSQ3fpGrc6rMyqGAx
 yCE/XU0FXjTryuXshdfcjYV+lSX3/3huGTiRCjU+yXCIHNAlWqfZF4bqGVOhKe4kBN4c
 TqLvjV3IJBVuSx4ne/3oU5J6fBTvDz1g2qEzYbxgyO/5gAdL2x4q7MhSclhRnftm4C48
 ORVemUCZrtEY6LaZuKMZnMTqNFvzVbxCu0mNeGA/LCBt61egxOh3z8KZN9F47mfBfVoq
 EYSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZLIrBHRvthHIsUGSpDFINY6Jfdraliwc9/Wjz8S8hJg01pKb9llTZ+rX15P8N5xV52Ic=@lists.linux.it
X-Gm-Message-State: AOJu0Ywxu+bR+aq4rxb0CWISpGtCAy1bUrkSIjoLbeck8zhHUxo+iZJa
 4dspeKjTj+zOlnrersJwWdZ0vfwPY1s3Jg61299mofdbe9TRTkAwgf0MVFFG32UDoBxD5Qd5jyD
 sKhIml5w=
X-Gm-Gg: AZuq6aLEnR2gobLeqpKc7RupThNR4JOG8ZhYDRb5NkzSV+3w2S1002Cmj0fD1QoRtib
 OPPbFhtNmcD7YvHOneTOaUIz6w3tHxs+hC/SPzfR+y5CKvQQeT5e8qh+hiH5qx015HyCmJT/a1l
 zfJQTnzmfe1+umGuEM2t9r0MiOYgiIrAMS+LEY6AIfzLIiVxmgZZqEelyx194Mv9Rqq2eLPSMqc
 l7oVC3PwY4QPEGx+Uv9ep4hlUW80x6qYP7FqyGgmXFhHicob2DxwYFbM6P+E5Gwg/SupXFcCxSE
 Ec0AfHS1lGWlvncIfWHU72/UUPzd3QG1dC/ofet3m/te7t/p6jxBHrPxvrPJJGLBkNVytLdVKf1
 vZHwS0ZyYQuEHv7F8cKjtu+Bu5xeBladQEX80X0Q2/l2MWYDu5vSXwUK2+c24bBcf+IfU252Eh8
 hIesY9i7andgu9mk0LPEHRAppMtHSdwrfMw+B7Jts1VWdjWTkWgUDDGZymbCgnQTtxpie4foXfu
 9wMjGESFjbFoueFo8k=
X-Received: by 2002:a05:6000:178c:b0:437:75c1:577e with SMTP id
 ffacd0b85a97d-43958df1610mr3177665f8f.11.1771419127907; 
 Wed, 18 Feb 2026 04:52:07 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5acaasm37735072f8f.6.2026.02.18.04.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 04:52:07 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 13:52:07 +0100
Message-Id: <DGI3O8O64JV0.3VFNYUAEVXXFG@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260217-agents_file-v4-1-e71ae27ea2d9@suse.com>
In-Reply-To: <20260217-agents_file-v4-1-e71ae27ea2d9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] agents: Add AI agent configuration for code
 reviews
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I think this configuration is working pretty well as a starting point.

---

The setup I'm using to test it is the following:

1. install OpenCode from https://opencode.ai/ (npm is the fastest way)
2. open OpenCode in the LTP repo folder
3. configure OpenCode to make sure we can modify the current repo

    $ cat .config/opencode/opencode.json 
    {
      "$schema": "https://opencode.ai/config.json",
      "permission": {
        "*": "ask",
      }
    }

   In this way, we make sure that we have control on what the LLM will
   do on our folder. The LLM will ask for permissions when it will
   read/write files or download patches in our system.

   I know it's possible to give sudo permissions, but it sounds like a
   bad idea to me.

4. setup OpenCode in Build mode (TAB), so it's possible to modify the
  current folder. This is needed in order to apply patches in the
  current LTP directory.
5. CTRL+x-m to select the Model we want to use.
6. provide to the LLM a link to patchwork/lore to start a code review on
   a developer patch
7. provide the commit/branch on the local repo if you want to review the
  current work you are working on

---

To test this patch, it's better to apply it on a new branch and
explicitly tells to the LLM that we want to always start a review from
this new branch containing the agents configuration. For example,
tells to LLM:

    "ALWAYS start a review from the branch <my branch> instead of master"

All reviews will create a new branch starting with "review/" prefix and
they won't be removed lately. In this way, it's possible to review logic
flaws in the patch after an initial LLM review.

---

Please take a look at it and let me know what we can improve. I would
like to merge this patch-set pretty soon in order to start using it and
save a lot of time to review the most common errors.


Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
