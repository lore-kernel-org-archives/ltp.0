Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F15C46CA2
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 07:21:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40AE83CF331
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:21:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D41063C8224
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:21:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1800E1000947
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 08:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702884075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WHHzd7sxA/T3P7fbygpLJ+XskEFGe5kZ51+Kvk9lymU=;
 b=WiT7lylzQu1yJWd4fjEcSOIIrCgfUYmiTPhMuTyhS8EoCYv2+gaKafKDeDsWtDGz+DgvC4
 YVVrMqlb4ZvHg2BZdFKnvfGu4OayFCnwD+1xycg2vQAxGC4Z1eTNn1aYgzid7TJBYZDEui
 A2A6N1jr9HNo9rGLOOjtVSIu/IDd6t8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-tzw0qE_YOaSwImOzX7iCzQ-1; Mon, 18 Dec 2023 02:21:12 -0500
X-MC-Unique: tzw0qE_YOaSwImOzX7iCzQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50c1c0710f6so2113829e87.1
 for <ltp@lists.linux.it>; Sun, 17 Dec 2023 23:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884071; x=1703488871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHHzd7sxA/T3P7fbygpLJ+XskEFGe5kZ51+Kvk9lymU=;
 b=OpKAo5UIWj7zJd1plvQnRdwxiFQWfHGka8gPmIOOlNlhnM4p4BitOu4fA75Rc9J5G/
 zmEmjAsr0Y4A8H0mvtJs4eMJPaYtqSuE4iEIUGZ6ZF1BngHb0nFo2zzdkhU/X6FFHyyy
 OWKa0cazaDm+nO24tNO5goCVi9hoULLpg9J8QCKJTXxy9vqVABjgXBwpGwd5uIgfFe1l
 73sEbrWlJj57DNpq8BEujr7qtEAVMzLvEtETUyLuDLlUBQaAE7VDr0DUnuTTjFYO6GWd
 BxviauTDe0haZcp5Gx8l2FJc22MF22GXG4j3/7XTZjBnJcfmmCWaxaBSGC1hMJ7hrhcm
 ggCA==
X-Gm-Message-State: AOJu0YyqTonIIyztx2tkGJwnKYwuwtzR98Qx8TXrP18tLO/jZEukAcD9
 ZkBLRYgKnMAb6fOWnjWa67XgIOkbZBZPndq1xiQHsK9Bl5UIL1tJj0wdFpRNaoH3GrUUD7zep6r
 KHGKM4DD3unS6C1fVilWi1c6ACxQ=
X-Received: by 2002:ac2:4a6e:0:b0:50e:2d42:cd37 with SMTP id
 q14-20020ac24a6e000000b0050e2d42cd37mr1410224lfp.33.1702884071321; 
 Sun, 17 Dec 2023 23:21:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1I1QK5SmBytDx5nmUjd8KGvJ1icugVW/wGsxqPruJtZnNHJqtru5jVMdjRN9Hp1HWqC2qUUlFSfbAs44EGPc=
X-Received: by 2002:ac2:4a6e:0:b0:50e:2d42:cd37 with SMTP id
 q14-20020ac24a6e000000b0050e2d42cd37mr1410221lfp.33.1702884071016; Sun, 17
 Dec 2023 23:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com> <20231215185749.GA58273@pevik>
 <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
 <20231218043033.GA160518@pevik>
In-Reply-To: <20231218043033.GA160518@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 15:20:59 +0800
Message-ID: <CAEemH2ehu_q4J02uPKVaCXNdfHCnCJ4X4L0rTMugpy0diFq2EQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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


>
> > Agreed, anything related to the dedicated ops should be put into the
> > corresponding header files. tst_safe_file_ops.h is a generic operation
> > for Linux (but not for specific) files. So I vote for adding *_MEMINFO()
> > to tst_memutil.h.
>
> +1
>
> I understand that it's a good idea when we separate things according to
> e.g.
> libc header. But we also have separated C files in lib/.
> It's probably easier if we have more shorter files than fewer very long
> files,
> but I wonder if some sourcers should not be in single files, e.g. these:
> tst_supported_fs_types.c, tst_fs_type.c => tst_fs.c
> or
> tst_fill_fs.c, tst_fill_file.c => tst_fill.c
> or
> tst_fs_setup.c, tst_path_has_mnt_flags.c => tst_mount.c
> (into some more generic name)
>


Yes, I think so. Unless there is some necessary reason (I overlooked) to
prevent mergeing them together.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
