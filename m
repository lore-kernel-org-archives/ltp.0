Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F73C5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749126052; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2y1Bvys9rBR+UuA35mum2+8eZeC28HzYOVODofArAbk=;
 b=IrOYrMwe99X3PhZo1wXhuKar4GLMWMGshOZDM25hEci4/obQdbbC9e1I0N17b+V0nJkbr
 CuFuHt6Q7l7Z4HAxZ1HA3gkQkC+UG2SR1Ugn53IN8kWPJpASGLFpdjZ1oQAkQ3AV7nwR8ib
 b0hmu67xHNEaasUJoT1u7C2VZfLeVl4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3A13CA395
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:20:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 875933C9188
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:20:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C34431400E18
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749126027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=571rkS413CiWWbbcwv7FgESj3mERrZ9nPnlBF6FNtRE=;
 b=G0qEsRax2nInU2Qrym8sjEgpey3GwrM+LkannfF/qXDk0BmwX38MrDuadqn5WntEVvMxGE
 6zs0xYrG2RG9tqpuxe+kiJGrhMV82pCPHNlelBWfBKm6XVtx/i3EO9FuBB6iqPK6nV/R+C
 v7MzC/2LSdZjHl/4eN/uYCHjxgPFNCo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-JlsVkzB9P5yc8G2FAlP9WA-1; Thu, 05 Jun 2025 08:20:26 -0400
X-MC-Unique: JlsVkzB9P5yc8G2FAlP9WA-1
X-Mimecast-MFC-AGG-ID: JlsVkzB9P5yc8G2FAlP9WA_1749126025
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30ea0e890ccso935552a91.2
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749126025; x=1749730825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=571rkS413CiWWbbcwv7FgESj3mERrZ9nPnlBF6FNtRE=;
 b=qO8VNBWiDVPFAYuGb10paeIRWn39ASFF7sk/Sb5XHcACd1ZlcLYi+qid87Lls50PKM
 0yIzEcg8k2QYylFCQBzchcImFCJ8arh6HdCQ2hKD6dKx5EOZqW8ydR+5F4ACn29ceg3U
 nw0qYMxGP/+7c8r4lKA7Un+73ZcyURGmKMEMKTeFgHDDpyKUbxw7S2t9LTZUE+PcgQv6
 GjnQdkXkgfxzhfdQL4tsOJVojo54D9ej6DV+F00qE1cEVWgafk8XPqtqvohre8rp5BNi
 gWLOfO/yQpqHL/KBJYcXi90BLLMlHA2sojtZXtJPvL9yGWSbhx3d1rejFIW+HzutNLoP
 u0vA==
X-Gm-Message-State: AOJu0YxQDCrflL5MLgymfsGPOZjkoJcN1ELOt7ZiUyMWckAwSNMAcONV
 jnTMnpb8NRuNrfG+7JEX9vBoLniRDQZ8GpvStTRJEWYLNutPz5t2VhmdaJbyDwartYL1l0ksMcw
 deXG7xBGd9q7TDr0dPURNkDcGvzlFAAiIEOyvCiyT+ig62GEMhWkniXCC2G8FGtmjxsaKbymzUS
 z2pKP5SRC2HJ0Gm1CS6qeAk+DywQ0=
X-Gm-Gg: ASbGncvCHuyvljI5K0/+d1mdFvFByWovOEQ1llwFcQ0POr3JgF8KeQaKiBj6TAn2dYq
 /gZmVNZu2cb34xoo10jbFJzTRdGp1KvBYgC1BCDtBF8f5rRQYv1yDchANwBusGdy/03dTy29BUH
 ITTjDw
X-Received: by 2002:a17:90b:3512:b0:313:283e:e881 with SMTP id
 98e67ed59e1d1-313283eea8dmr5120858a91.11.1749126025155; 
 Thu, 05 Jun 2025 05:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAnzLm3k208V3Ht+VbJcA4Cu2WMY382an+AAWkvUAtRrhdFEOL1KMPw6tHTNOgQcKwVQArGMa9MzMGanBkF4=
X-Received: by 2002:a17:90b:3512:b0:313:283e:e881 with SMTP id
 98e67ed59e1d1-313283eea8dmr5120815a91.11.1749126024746; Thu, 05 Jun 2025
 05:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250605120702.213048-1-liwang@redhat.com>
 <20250605120702.213048-2-liwang@redhat.com>
In-Reply-To: <20250605120702.213048-2-liwang@redhat.com>
Date: Thu, 5 Jun 2025 20:20:12 +0800
X-Gm-Features: AX0GCFtgoZED1KeL_y7f3wEjiQDl7z6eIvaXAhYuITEGcW-dm4vrAeK8lmimUR8
Message-ID: <CAEemH2e9XBOx65zRPVmoKE60Nj1k5TxdFVHxoW6N3pLHV+Z+Tg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _cTejGgT1FaiWEA6OkoNOqBGH9l7baHkgQfnkJ5tg1U_1749126025
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] lib: moves test infrastructure states into
 a shared context structure
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

 Li Wang via ltp <ltp@lists.linux.it> wrote:


> +               size_t futexes_offset = offsetof(struct ipc_region,
> futexes);
> +               tst_max_futexes = (size - futexes_offset) /
> sizeof(futex_t);
>

I suddenly realized that Cyril's meant:
  tst_max_futexes = (size - offsetof(struct ipc_region, futexes)) /
sizeof(futex_t);

Okay, we can refine this before the patch merging (or in patch v3 if
needed).


@@ -178,12 +198,22 @@ void tst_reinit(void)
>                 tst_brk(TBROK, "File %s does not exist!", path);
>
>         fd = SAFE_OPEN(path, O_RDWR);
> +       ipc = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
> fd, 0);
> +       SAFE_CLOSE(fd);
>
> -       results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
> MAP_SHARED, fd, 0);
> -       tst_futexes = (char *)results + sizeof(struct results);
> -       tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
> +       if (ipc->magic != LTP_MAGIC)
> +               tst_brk(TBROK, "Invalid shared memory region (bad magic)");
>
> -       SAFE_CLOSE(fd);
> +       /* Restore the parent context from IPC region */
> +       context = &ipc->context;
> +       results = &ipc->results;
> +
> +       tst_futexes = ipc->futexes;
> +       size_t futexes_offset = offsetof(struct ipc_region, futexes);
> +       tst_max_futexes = (size - futexes_offset) / sizeof(futex_t);
>

tst_max_futexes = (size - offsetof(struct ipc_region, futexes)) /
sizeof(futex_t);


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
