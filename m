Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39235C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:11:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E19673C93B7
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:11:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791473C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:10:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 435F3601033
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:10:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641895851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOqx0vHLAarCQK4tCKRUl+YBbd2oJZNqc4F3q74QbqQ=;
 b=ZZ++1lNJkFmRSC5xHmNUZtHaAMAX20Qq5j2fGetFllsaSWagr7ONiBUOBfhzTtPb2kQ4tm
 KRyZqN9YCegO31JS6BoJBVq7rmPLeh3RAi9oxf8QfUKLzJ4UqMdzs/SkIfjCQlAlplbKqs
 YdGzviN7klFcnfgZKxpUlxS6UQuk49k=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-JFysmKHzMZypgCRFgkU4XQ-1; Tue, 11 Jan 2022 05:10:50 -0500
X-MC-Unique: JFysmKHzMZypgCRFgkU4XQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 m135-20020a25268d000000b00611717a11d9so4266059ybm.10
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nOqx0vHLAarCQK4tCKRUl+YBbd2oJZNqc4F3q74QbqQ=;
 b=25Z9/S2s1idzc16cdrcctOCU+YNq8im09T4DP607Dhrf4of4S+izKQmfaMMGPxdgnC
 NbT14yju4NPwymRNpCBG2e1RBdEMUM1dlFOhiQFw6sVPcJNNu9qGy7uLh2iUN0uhClMd
 8UfUF+o5RhWGd1hcyA5FLJyGMU848Xz8NKkJNKM0Mu4C8xLY12B1PpaUmXTzRIySR7uu
 KevuAg4q6px7xxo4cvCabkWAtRqCbIm3SIm9Qvzev8wAEBLIqO+AwHETCuDBGBs1XYQW
 sCC/O2T+KBFIZxWu4Ba1deI10AdFsUPRGiO/jtt7jvUvsXx5mhXqTI+fJK4sOefFrTGb
 BFZA==
X-Gm-Message-State: AOAM532HFBMhn0iCj0qtq5+JI/Tg6flg4g3NF6WNOJUtk1LdKsqrC42v
 WFS2zKcDOsMBCBMPCSLfFuJRArX31eSVUkhwGPsDkE9o5UPonUN1a1bQpLr2lG2Isv4UYG8wieZ
 7WSA+EY1FmAVLBKOTcX7GuEqti8w=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr5239184ybh.71.1641895850041; 
 Tue, 11 Jan 2022 02:10:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyN9kZpygPGJmGdxgNjp+BT61S2Ku9YOYzzxw3S2y3G8y2STZ7BBPpNgcZy5xOGR4HkUvidFKC6tj8zH7HcV0=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr5239162ybh.71.1641895849851; 
 Tue, 11 Jan 2022 02:10:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ccc2WBpVvxz49X4DuO7iCLrpGoy1EJ4rqLN6EQ1TK0sw@mail.gmail.com>
In-Reply-To: <CAEemH2ccc2WBpVvxz49X4DuO7iCLrpGoy1EJ4rqLN6EQ1TK0sw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jan 2022 18:10:25 +0800
Message-ID: <CAEemH2dV9Vb4eQpjWy6AKdRh+7jrG_g1_Et3-TmZWftsUUOBtw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] controllers: Expand cgroup_lib shell library
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +cgroup_cleanup()
> > +{
> > +       [ "$_cgroup_state" = "" ] && return 0
> ?> +
> > +       tst_cgctl cleanup "$_cgroup_state"
>
> I don't understand what exactly the $_cgroup_state do here,
> isn't that just 0 or 1 which returned by 'tst_cgctl require "$ctrl" $$' ?

Ah, I got it, that comes from a string printed by tst_cgroup_print_config.
(Sorry I was read these codes from top to down.)

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
