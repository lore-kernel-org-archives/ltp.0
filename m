Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37002D41169
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768473839; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=r4xkg9fVA2jC6mIF0yHmo1diJYcYfoqvs3iy9pCYdno=;
 b=JZKX7m5208iuUnvPyG7ibTj2/tjhw+WD2JJkj31f83MNimLOe9LJT4gloJZAPmBnkXH09
 /ybDdROHTkfN8ESzZqlvNCH85rFM7P9oV4d0ZExAY7N0Zy6XeMHsytQaaVxiFaC+mtLRIbK
 dRVk7FjAfX7GHYy44viCgx5GAfkxWqs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6993C9EC5
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 11:43:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36B473C0874
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:43:37 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B0247600942
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:43:36 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-432d256c2a9so738278f8f.3
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768473816; x=1769078616; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7xxZlawYwoPmaZ9of72mygS60ogBoAL7eY8Txj1v3A=;
 b=F9cvUfDSltd88/aZXuvrZzH/rNZim33VivgetcQTGOH2gU/UgCIQq6Z4t2dCDGTOE1
 XNlxQbFxRQWICphU3LiGMf84dlPGKWO7deuVEnIJUE3inxScuNXzkG+N1lq6hfPwcBD6
 1FXeOOzqhjM3es6LRFYJ5jdkyBDdnD1OKrtkmHcWtCjmhEtCLtdwQn/1nCd3X8oeZAA1
 Juh48eSP0EQzkgQAQCcj0kCixYG+0IofQ5qEwGKKdzGqsq/JE6hcXkMU9RmO1CdOWJW+
 bxM16StZG4w7NGg/3ACI74huoga0ha8BbuMtNiQFjhYd339yJyAIdsewHI2wUHKeNUBI
 g9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768473816; x=1769078616;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7xxZlawYwoPmaZ9of72mygS60ogBoAL7eY8Txj1v3A=;
 b=STWAB606s59n0bZ+X5luOL0OfcFIqodGieV0kKfUTHLM47FzQpCmoisJQh0a6NXHyq
 fZ4+L1xmH3QQFldoqppDsd5fcuL48oIpSjsL5SgqkNnbF3k0l7Eze99X0dJOompi5UKr
 P6G1fdQPHlbI8d7h6Nxb3TczH+SyRxGcVMCyavAAbXVds1l6d5/8ONTHxCETR4gCeblc
 jdxlJC9k4hdnVDHAwUfaJ+xqUVbSnLTEP1WyBjN35tEnA10S412aevtOSElGPrhy16h0
 3q758N0Pv3C5oumvIc3Z9VEXg5OFEIZt+SBl5vO4x2JZoPj2/96zVRqF1jtBZmhrmmG0
 k8SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkl87yHv/1cBldAXpBL9up1WM+wF3VXy36BabBwxY6et76+pvsTvPQXUiKuPTd8I2Gf0=@lists.linux.it
X-Gm-Message-State: AOJu0YzWqLlxxX187GMUaox9pcqkmpfwUaYqjpHOASsdCDV+1xoQCsxH
 IJXhxkweTHM+9Zg/wvojPf44SKHSPtOdAoq571lqaVKufIjIPoOlX76h3k26bkbhmktgJi0b1MC
 Z61iJ
X-Gm-Gg: AY/fxX7b7fybVZ8kdG6RNoQFnvQMKhRGER392rQ1XqmCPYPWqWdKtrRUkQ4vMYFShNK
 znnzME3Q71qHVYaycUW8rKOJSOu/frapChnhWsqX09pGtlSNqjKcHp6gP6jSsgXIXx8KjCXVf4t
 0LMqFhYHl5zf1nvjiPURxm0HvSHhjN1Phal2NoxfQFH68c/HYc7lkIOgov+3WfDCvV7OwIcid+X
 g0JxpvdMvl/hE3lOWcIRmNQ7teO/s4ZX99LDLStXXKXb2umcIbLdrFvHewOhyfnjkhrdCXb7OzC
 QG/AUKpWQzUtQSRqaXftm727L8yS4oGhf8FyR4fOoSI96tXQcMJkFR6haDPL106j18sI4C7rgP3
 VsirsVjf9vzTV5/lcJY+YoDTpofuqsMtJQ59xVHGNB29LOp+6uhmGUBhg1NUCeyztpUTaM2hCJ+
 iDHxcKT8O/CWXzajvNc9Cw4TuCmPJkTQWSkurCCxHZyLg2Dhr4fSCGFfulFt7KAxxgiz7fMC6Nh
 wuL
X-Received: by 2002:a05:6000:4301:b0:431:6ba:38ac with SMTP id
 ffacd0b85a97d-4342c3f0fcemr7173102f8f.4.1768473816104; 
 Thu, 15 Jan 2026 02:43:36 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6535c7sm5449665f8f.16.2026.01.15.02.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 02:43:35 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 15 Jan 2026 11:43:34 +0100
Message-Id: <DFP3NAUVIKJ1.N9KSMR5ZUDOJ@suse.com>
To: "Li Wang" <liwang@redhat.com>
X-Mailer: aerc 0.18.2
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
 <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
 <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
In-Reply-To: <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> This change worked for me, and I saw in kirk/issues/72 that someone
> still wants support for both methods.
>
> So, maybe keeping it can be helpful to set env for remote SUT
> execution? Since exporting locally may not affect the remote side
> unless Kirk forwards env.
>
> I am not quite familar to Kirk code, so just raise my questions to you
> to evaluation.

The problem to keep both is the reason why these bugs are happening, so I
would just drop --env. An alternative is to drop variables completely
and to use the same method of runltp, where -d and -r are used to set
TMPDIR and LTPROOT.

The reason why --env was added is that we might wanted to have multiple
frameworks, but now that we support LTP only there's no this issue
anymore.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
