Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F0DD5E147
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765890503; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Rg2T1dNhz2PAYJBAszcAE/OVdV9tKFiMn+jL8lxlLmo=;
 b=j1UzVvkLiHqAkaMfQUnLylvmmAFXE9jrlC0OMpm4eIsb5XgRnMV8/i24P/dz7VGLfegAy
 zwZmNOLh2nL+1u4fF4/ehmW7agMiuwJ/1eqvXS3105xxBPOLm1MsXp6ahyDroSUO8zDSQQA
 Yj7cJePdge69Onk11kd7iYg9+dD6kbc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 688723D0350
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 14:08:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CD2D3D0350
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 14:07:59 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41A091400B81
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 14:07:58 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so37359725e9.0
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765890477; x=1766495277; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYfBnVzKcA85bfUFjglgWmLjQ5DuptWHuH2MsIA39e4=;
 b=BDtw4xZ8V9NgoIs23KwpSus+5KSUqh74UU05tgzbzHjliE+/bOfLp7138pububfVrb
 tjT+0UZ9ywnRExNahkYxs5eqQh5HkQ+Iocl43qRhrwOm2kxTmIPYwTVc5IAIkDUEMgcl
 Dqj1U6BgMxxRsWWNEyYnPErvqN35Mkbj0L/mMg1w2jNLwye+T1qVe28AwLVK/hPXoZa5
 tv+EZaRx00MO0Ub3nyAe1AuQ+Cz4Rlxh/TazmiEJs9AK4OgdmMjM2BZezraYvP/pDtB5
 ajh7852IcOwIv/KMjFWvDdt980xZJL4YUvKivti1LNdQAzBprH+MLGUc+qzxhgT6Akbh
 gLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765890477; x=1766495277;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYfBnVzKcA85bfUFjglgWmLjQ5DuptWHuH2MsIA39e4=;
 b=NbOWgqBfzMnP9+T3rrdA1n1mHvtdwUPgWljhpOFOKuqgf7Yc96P396aB5uVD3syZL7
 /v9nxoIZzlieTdrZYFnNxx3k82tBoNJY1xBkiriVSSEml2MTbB7vGPFoDQvNQcU1TAxV
 HZ8yQ8pvX2NyNUwTKz4Vl3XDktEi9/IQtE+uBJ3cvEDOEv4BaWWurOn5I83lsZaZ8CAL
 l+ZJuKCPXiHrtQvmjniy7BqM5ZIE9c+VDBNceyOgE6JZcncv2mmqzOItSazLalFjHxOt
 Jm+ppD/FkahNO7Wg2iu4q16YZMGN15mo482c26FwO12GHX2iHwbIuH9pmPf1jp5CfNTe
 9csA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEEF71cok3m6zi51bXZSMQnPqelH6vnTrxleqIoNLxSzCTSiasPKJa8UyMvfKpHM+F+lQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwjXJgfXj/JRFrHKcbt+Sl2b0k8KBh28REYB3Co4xhThtgdbsfa
 DCBFKvBKRBI5ZqJgSx4/xwLdLLJKgqo/c1pXp+tUV0lui0k/NhKM0pNDRbl37n1rlUU=
X-Gm-Gg: AY/fxX64TBnYxXLDSZvwTMEPgHR7zIRPP/lejeeYKUTkCRNSpKlqLDzKxAmXKbxtUrv
 0TaM7SMb7UHz5QNF+zGmQleIXa1EPcebeOohDe760LsW2W6LpwBIQAQOYdREzha5jNhG2lU3tYP
 Qdc7xzLKvvbULXsrsJnlkb8U7E1eKUIRDaKr+tV+Kmxs9GCpX/CwveZq9pEcKRYyODFUCNsRlKq
 4ZtnFtU54RhX5rBe+R/TCuNaqbRrm9wXtrFjLo8IG1YXjoBmClXmXY7GJQyO3gQNMPs+Z8qqltM
 SegcrBYEJFjaNUcEPpU0HBW2aFCS4ksjExKVpeFU6vcANmh4KI/l27N4wOFYgMZUcK6WgfDbMnK
 X1jawMJsZLkxpZ7VREgOM18g93qoj/bwcebPEDVKmw/hASwttQilvXA/smiXUgT16FyZAYr0Mo8
 6Vp/rVgZwI27RF3omOxZI=
X-Google-Smtp-Source: AGHT+IFEcKV3WHlKEyHLxIwLNjQzmEVYwpFm4BdzTfQvDzbDkPdOu+vtdV30pKKiidFTEuycbOT3DA==
X-Received: by 2002:a05:600c:c172:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47a8f915c34mr123178135e9.34.1765890477575; 
 Tue, 16 Dec 2025 05:07:57 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f775012sm238490965e9.7.2025.12.16.05.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 05:07:57 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 14:07:56 +0100
Message-Id: <DEZNXHGNC47J.JXP5ADB0V6DX@suse.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251128150815.294092-1-piotr.kubaj@intel.com>
In-Reply-To: <20251128150815.294092-1-piotr.kubaj@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] thermal: add new test group
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
Cc: tomasz.ossowski@intel.com, helena.anna.dubel@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

I followed this discussion but I did't have time to reply yet, I
apologize for it.

Honestly, I have mixed feelings towards this patch because we already
have `genload` tool in LTP and there's no reason to use something
different for one test only.

Happy to see thermal interrupt being tested, but, in the other hand,
we should not merge something that is using external tools which
are already implemented in the project itself.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
