Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B06C433EF
	for <ltp@archiver.kernel.org>; Sun,  6 Mar 2022 18:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC1983C1B82
	for <ltp@archiver.kernel.org>; Sun,  6 Mar 2022 19:51:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CC5D3C0653
 for <ltp@lists.linux.it>; Sun,  6 Mar 2022 19:51:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 16B4220009C
 for <ltp@lists.linux.it>; Sun,  6 Mar 2022 19:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646592701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZn58zO0pL3KnoM5ZMC6Yiqd3coNEh9mIX9mutP0thk=;
 b=ZDTqHBLhXyG3ca3cyLBNyhmhRK5BbQkiTnqjs2BXiSYFWS7maYMWQbyogjQGBUvR2a0vwG
 92BTt0hOthf6KvPkSEQ51bO6q2WJoYMY9rwR2U4esPetJRZPU0t0Mv6eLTz1PkNPNnDI/y
 hF1etVSkmHPJRcemlhuAouPU1LafrHw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-tWaMcqHlOY6Q1bvpyCNVxQ-1; Sun, 06 Mar 2022 13:51:39 -0500
X-MC-Unique: tWaMcqHlOY6Q1bvpyCNVxQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 6-20020a2eb946000000b002463d2915d2so5477856ljs.9
 for <ltp@lists.linux.it>; Sun, 06 Mar 2022 10:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PZn58zO0pL3KnoM5ZMC6Yiqd3coNEh9mIX9mutP0thk=;
 b=1cqCQYEMR3sK/M657Y3zLFLHG53Tpf+pURoAXMqw3hQMpP2F8LA/JBrhGEoD0AuzCZ
 ucOSmn/xiUkdbQ+uHiq+xnB687mkd3T6neDVJmUFAIFMjmuok2WPHSwHZnoBRvkM66Ac
 9pISQyzOBTPtNcpGV9JTLBrbUIsHgcA6TQuzvLYJ568UExbwRidGAm5/lNkB1z2Q0WEB
 HtXV6GUVNAV5uQgK+Plwb5OaSemg58lW6bbzVbrH6PHF4+KItsZH2O4nnJR4rKelUMeO
 4JOeu88paRD35fVfFncxmR4GJJyYzCoaI64800Vine03l7ewVfht++sVcVEMcs3Ws6Rs
 9tmg==
X-Gm-Message-State: AOAM5338iDIV+HPxggNmv20EMWpO/Y0ONKYxdndwqny4k4IA1P8TKqJD
 PUVerwBnASW88kvoDxb/T5P2qpoOnG27L3s0gKCdV8NkgPzrG6d4bM29fv9UBk/X/YuptUJ8eu6
 QN5rnRcArOofH8LXu4P+QgdT7zZw=
X-Received: by 2002:a05:651c:2cb:b0:23d:3168:915b with SMTP id
 f11-20020a05651c02cb00b0023d3168915bmr5253614ljo.22.1646592698350; 
 Sun, 06 Mar 2022 10:51:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaNtU2Wh+zjeOzK0tUUXZnVw2V6IDR+gWqUzW+59s+SirJUmfUTeDyEG4++pRGt9mmGu2MU+R9b0Pw3IB5Bws=
X-Received: by 2002:a05:651c:2cb:b0:23d:3168:915b with SMTP id
 f11-20020a05651c02cb00b0023d3168915bmr5253607ljo.22.1646592698143; Sun, 06
 Mar 2022 10:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20220303083429.3827302-1-liwang@redhat.com>
 <YiI4XgwISfrk1BdP@yuki>
In-Reply-To: <YiI4XgwISfrk1BdP@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 6 Mar 2022 19:51:22 +0100
Message-ID: <CAASaF6xyMDgn1_wCt0nbOhB2dZC901m260Ugdb0DaBOa9dV6OA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] migrate_pages02: check file exist before opening
 it
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
Cc: LTP List <ltp@lists.linux.it>, Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> +               "?NUMA_BALANCING",
You probably meant "?"NUMA_BALANCING

>
> Maybe we just need to enhance the .save_restore with another parameter;
> a value to set the knob to if it does exists, so in add_key05.c it would
> look like:
>
> struct tst_path_val {
>         const char *path;
>         const char *val;
> };
>
>         .save_restore = (const struct tst_path_val const[]) {
>                 {"?/proc/sys/kernel/keys/gc_delay", "1"},
>                 {"?/proc/sys/kernel/keys/maxkeys", "200"},
>                 {"?/proc/sys/kernel/keys/maxbytes", "20000"}
>                 NULL,
>         },
>
> And in cases we do not need to set value we would just pass NULL as val...

That should work for most testcases, I don't recall one where we need
to cycle through more values.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
