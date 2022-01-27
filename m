Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BEEC433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:38:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41D833C9724
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:38:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCECC3C649E
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:38:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F2F610004BD
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643276321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoqtHl3w6G/LU14dgcSaRf62UuBrEYUfalBxMOXMO7U=;
 b=PPMVJ6LZiPbuLUCegpW9MjnZ/foXJG1bMg8ZEptJxU/f5jeioJ/fPVHMmwo7h5MYyFEzKo
 t/VjbU/BBwFsvZXZAtM1+3Uh89jnvJmv614ecIcJy7BMcWd5mNGqIr9gPFplkWZ+otbAbg
 /0tqwQRIACsOHwzRshpRaRhwkJ+88iE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-MnbBVdHFMs2t67vPcB3Rtw-1; Thu, 27 Jan 2022 04:38:40 -0500
X-MC-Unique: MnbBVdHFMs2t67vPcB3Rtw-1
Received: by mail-oi1-f197.google.com with SMTP id
 o11-20020a0568080f8b00b002cd0d1c3638so1239138oiw.8
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 01:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoqtHl3w6G/LU14dgcSaRf62UuBrEYUfalBxMOXMO7U=;
 b=obAdBo/2niwpEBmvAKlf1qMP2ndXPSotSjYWTrxNarTn6aUK/LmNSH+IjIdNBguxnl
 QDsvQ306LlMtFYvyzVHWGhJMjRjjzgtM1bHqNHrXNSlV9wGfiqlXGOkCmcXg0CkU279b
 +kEdfxjDjiAl0ZVXY/J1lEwDcHkiCf0oP76QKFBJ0BepvhxidlTO+dR3rpf5zJFdDAt/
 BowY441ob3/Lm7SPm4Eq6ikNKSgRUdcAiAYls5og8FW58vxqo6BIdqpO/iZ2dlXz4NsD
 NV4PA+5WVnkiLjG5OLcJnR+8y0EvId/0HM5oaswoekA1VTFvht04CY5MZFRwkgkBKmvo
 jvtA==
X-Gm-Message-State: AOAM532k2mcWUXZs22cKWNDPWiLCNQFGEhzD7DDJUCO45KBBqEz3AZgF
 zq7ftWG97uKnfoapIxIIucQpVGZrYQxa/Xyz7CKWFgUp5W3bzF+urOmrG8XChzvc2wI6wpMRGQA
 4l/rmcivh4Yvp8y66Ui0tWMHZsIc=
X-Received: by 2002:a05:6808:150e:: with SMTP id
 u14mr1738729oiw.339.1643276319259; 
 Thu, 27 Jan 2022 01:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO+d09HSFkS/FsqA3+5ZkVFX6iQO07R5AO2DlQAM7/Jwd0kimcvIPZtSN/676T5GXm96Xt82FrPBIKi6TnmZo=
X-Received: by 2002:a05:6808:150e:: with SMTP id
 u14mr1738711oiw.339.1643276318704; 
 Thu, 27 Jan 2022 01:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20220126140520.15904-1-andrea.cervesato@suse.de>
In-Reply-To: <20220126140520.15904-1-andrea.cervesato@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Jan 2022 10:38:22 +0100
Message-ID: <CAASaF6yH_ToYj0-OVWTi-iHStrY3m-YQbB0Kczo4v-Y8Y_dQfQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm_readv03.c test with new LTP
 API
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

On Wed, Jan 26, 2022 at 3:05 PM Andrea Cervesato
<andrea.cervesato@suse.de> wrote:
<snip>

>
> -static void child_alloc(int *bufsz_arr)
> +static void child_alloc(const int *sizes, int nr_iovecs)
>  {
>         char **foo;
>         int i, j;
> -       char buf[BUFSIZ];
>         long count;
>
> -       foo = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(char *));
> +       foo = SAFE_MALLOC(nr_iovecs * sizeof(int *));

Overall conversion looks good to me, but why this change from "char *"
to "int *"
when foo is char **?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
