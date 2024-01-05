Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA84C47073
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 02:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D31F3CE6EF
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 03:36:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42BFF3C8125
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 03:36:48 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65103600A77
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 03:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704422205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXyUr3Ii8Aq3dDrLdqMF9SwSe1ZsL9LYJblaz1nqBAA=;
 b=B7/zF+G+0t0JQItCLmGN8PD0/8E0WU/p/4EHQam7WRyo15unGwGvRK8k5ojVaDxckOL69e
 oUweqaXTl7klcxjWnsOg2bcWKhxyCMoUKLILJUq3Aequy2uh11I2B73thk1kTxflROBdOI
 3ApsXhJyK84+EiZYu+/cKKAp4z7nCmQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-GOJ9NjrkMRO9iVJOfpu35A-1; Thu, 04 Jan 2024 21:36:38 -0500
X-MC-Unique: GOJ9NjrkMRO9iVJOfpu35A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2cccd597158so10835451fa.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 18:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704422197; x=1705026997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXyUr3Ii8Aq3dDrLdqMF9SwSe1ZsL9LYJblaz1nqBAA=;
 b=TtyHIX5bkqEqA7tCQe66CF/fJHP0uVzYO4o1MXnouvM2xyol7f1x+kzzEmjBtVhpCk
 gs5/+IDepkBCyE18Fmj/zswayWSBGQFeEZDyGUy2KCLvkLZxDaFdjSCIDpUpgq1aXD4b
 cDVVCSuBwEuuYoPeVqJ7d5smfLLH91kX1JELTwnLD0XDqgA2shVK+RixX1PyCQiQrWGm
 iMyxYrMAfRDui5qH+p4KflD8b1rvkJUyJRJ4pSw+GPn9Cl8Ez2U6WwhDbb2xxjZIjy2z
 oMjYqTNd5Eo/+53J4B0McM7f6PQl1oOtGLphEmB26o1uQxc5DMVkVJGBjJ38xtGzaXrV
 PX3w==
X-Gm-Message-State: AOJu0YzkWXmpwWy/CQWdNQQvI5Y0m41zquUErBTpHvgJMxrr9TO1ES7f
 xCqq86vM9nXaCmF1/Z1nqPb/+FGWpYNqzgNpVr6VdLGf4fSlxZgsJxxO2mFvLg9GasZH5My30oh
 So3aLTQDL7Tqlp1h+bDo4ftj6XqqSVoA6tC4=
X-Received: by 2002:a2e:8816:0:b0:2cc:9ec8:fc5a with SMTP id
 x22-20020a2e8816000000b002cc9ec8fc5amr789807ljh.39.1704422197242; 
 Thu, 04 Jan 2024 18:36:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3V1pNT5d5BnlsxX4hla+JmjBXrI6P54AfIOzcW3yqbR2sjeaS6NFr/WdxnD5VLyzwa+G51+ErQxN+WEjjMwc=
X-Received: by 2002:a2e:8816:0:b0:2cc:9ec8:fc5a with SMTP id
 x22-20020a2e8816000000b002cc9ec8fc5amr789802ljh.39.1704422196966; Thu, 04 Jan
 2024 18:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20240104122308.1158487-1-pvorel@suse.cz>
In-Reply-To: <20240104122308.1158487-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Jan 2024 10:36:25 +0800
Message-ID: <CAEemH2dACX-7p7en9wWW228RM3+ATH=WVjkiHdn7hL=w_rsLXw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/3] Cleanup environment variables prefixes
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

Petr Vorel <pvorel@suse.cz> wrote:

I'd like to get it merged before release (TST_ENABLE_DEBUG has not been
> released yet, it'd be good to get it fixed before release). We should
> mention LTP_NO_CLEANUP in the release notes.
>

+1

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
