Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0592C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 14:45:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1D003C9111
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:45:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 897793C222E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:45:41 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 23D7310008F8
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 15:45:41 +0100 (CET)
Received: by mail-io1-xd2d.google.com with SMTP id s6so39686003ioj.0
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i996TKkw5fDc5LVlaCOyIwbORTnreV6zkwDWs1zJoLI=;
 b=K9V6whKcCF8m6Pk/71quQzwZgUnPGvBV0PHuch9XeL7XBhuBrLkrneERc6fodvl76K
 KspLxquJWLjcqf90iRSG9qnI3aAW5KQSBT/U1Lbc7HQtfStEV/1aWrXk86uGTGqf3fkU
 Z0vpkURdZU92gb/uyzitMg2Y/tJtUGRSFBc1wTDmAlUTplf1n3t3KfP7ShVPy6z/yjEm
 /ZpneHsGRNNm1YZKl7ESyDHk8ZgIqS9IKqG3sV5/ay+ySWX5eCRi4O4yg//6/+jnFCKq
 KFgHm01EOQS8yKCg41eFbtazmynKNLdkhpp3C9cOIuEklM7VESVRtAojQvDppLMx6Go0
 h20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i996TKkw5fDc5LVlaCOyIwbORTnreV6zkwDWs1zJoLI=;
 b=4tqRIFNSTwkMssZMlqClPbSg8dlA+vKflkFGU01dI1MVrmiKENLcCmrK1AqHwhEbqY
 uHrIrAPntjfl8Gu3Pya+ybfyaknyGeDWUg7idajZZl1aSSDvHuXfUznEHwe2SqTb4J1B
 OX4CEjCKK6ufwGvVLw5pglsJaJ5zZPYvWNsIc3WFCZrrswHLIQF5TO5ur94Y1q0jDu+H
 Sq4vivVFtkl+tzY61M9/a0XUXeN866jxbPfBaY8zKeCq7RdVj9eB0TZEkvpA8aGfkAnG
 x2ZQN2ywFF0zzhfnv57eXECsHFFVOcRc3KextY1u+TrmrRbEI6Er/DtGweLGXe/9SLxQ
 gRrA==
X-Gm-Message-State: AOAM5332kJwUB5KeQsegUJd+xAZvvln8B5xxWJEMTnR3vH8vboBe189r
 YoDehC1UJuE4KRo/6iTPCnuj/3kkrvvl0+kP84U=
X-Google-Smtp-Source: ABdhPJzTSmWmJogMmeYaBVsQZK8l3bCXgtRWRUnJDV9J3ervq/DMztujblbFC5UCD3KvjAquKGNYu2++tyhZXDVX+dY=
X-Received: by 2002:a05:6638:3391:: with SMTP id
 h17mr25392669jav.188.1641393939600; 
 Wed, 05 Jan 2022 06:45:39 -0800 (PST)
MIME-Version: 1.0
References: <YdWC0f+70TF6Eluk@yuki>
In-Reply-To: <YdWC0f+70TF6Eluk@yuki>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Jan 2022 16:45:28 +0200
Message-ID: <CAOQ4uxg4sv9otWKSJCvdtaJnQrgaXUqvgPtnydDp6V8jio3nUA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 5, 2022 at 1:35 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> As usuall it's time to start preparing for the next release.
>
> Given the amount patches waiting for the review I guess that we should
> try to get reviewed and merged as much as possible in the next few days.
> I would go for git freeze at 14. 1. as that would give us a week for
> pre-release testing and the release would be, as usuall, finalized
> around the 21. 1. Feel free to reply if you think that the schedulle
> should be different.
>
> Also if there are patches that you think should be merged before the
> release let me know ASAP so we can have a look soon enough.
>

Maybe that's a good time to say I did not understand the resolution on the
discussion [1] about timing of merging tests for new (i.e. v5.16) features.

Specifically, I am referring to the FAN_FS_ERROR tests [2].

Thanks,
Amir.

[1] https://lore.kernel.org/ltp/Ybc5QJSZM3YIji70@yuki/
[2] https://lore.kernel.org/ltp/YcDGZ+eNcQ5fPsmN@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
