Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405E3C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748336897; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1H8Fd9UeNo85o7tar7HRKj7LJmE/yDUMXwWpw1zSNMI=;
 b=fzFUSHjMR+SywYJ88GRIHvD0Fn4/uwFfS1+8UMJSrrIqBfiFHwPxTS5zG9NC/Ym26ZkIl
 pAeRK9yoXKRm/Jl3A6BLFBZH469rLKNxblNaMqUMQGN16eOO+cZDmKBXw00xyITM1MmNhRf
 98Nvi7SulhSEiTH844pduS9BBa6mMIM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990E63C5529
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:08:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F9A13C13E5
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:07:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 337D01400060
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748336872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGN4206tDO/CwqSzF6XpZw4iP60hxCKxbDlURDgfNwI=;
 b=be2Ta5wR2k3IVQirtE8BKARqukEOUR5h0QbtH+Y/2Rjpk1Sgh3jAB1tJpWits4EjxsMyLk
 Ih2JudYl0bOCtRL+OxoJcLziqocNFV0QkZRyMdsBffQiPVyyoRatadBdgMHlcEDciczhT6
 +iIO8brxRSwjiTdRGyfp8L71lEnxe7c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-wmddLvDmNhaKKVQl8BCTdg-1; Tue, 27 May 2025 05:07:50 -0400
X-MC-Unique: wmddLvDmNhaKKVQl8BCTdg-1
X-Mimecast-MFC-AGG-ID: wmddLvDmNhaKKVQl8BCTdg_1748336870
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3111a070de6so5169864a91.0
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336870; x=1748941670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGN4206tDO/CwqSzF6XpZw4iP60hxCKxbDlURDgfNwI=;
 b=ciImEFO1kYykNqAkNXf2IkmQ2YOforF9CIVR3eJnverjbMNMtlRrznQxs8TGIE/wFS
 j7s2dzsbMbEWfc2vLyPGFWV9paxqewlvYuJcORqcbTPr/Ry+7jc074IxnB1uyFENwH8m
 mMg/F55oXteP2UBhARmLnx/lnI0a4HDbb2he8CbfWoGTclcgEa3cBReOKxvY4M7HjgQ0
 LlJ7HhfjcxMLoYIzzdgGHaezR28anU1vxssYtBrKFFmRD8wbPvWKwrQZsR+Nnat6CrdO
 6pNBlTz4i4mpDzV0Bid63hJcu+nTGrTY1+1srWLPLk8CYTVA+fA6OAw7t9haiEu7GtjF
 6Ztw==
X-Gm-Message-State: AOJu0Yy4tPnzEsot6FwuMI2nI68pnRMEUL8cFY3y8iBrn/17Qqg3290Q
 CPD9Lxna7aT2jy7+ZXieS0l/kOoL171FGM3oiFhO4VNwt/svmvAZeBPoikUih4Q/SInMgcbZj0B
 RUehnLbGgxAhTALdpE2EbfcPjgFBNaWGKgM8Ci+z+xXr5IOolftD1Sxb9g20LXOhqMlsrJCshKb
 1qu98x/Aa8mjRPxtrTK6kNn4GUp8Q=
X-Gm-Gg: ASbGnctwJdYjEEJtdrjkVAGIP7nxUD5vdLOjeF0TFTmTVbisWA0dkkKPj2Aje/l6rtK
 YK1OpsZYgETP0jkM0QaCliIz/Z7fKN7aY30pKUHwbeeZ1SX8ELx1uempVwhZQbux6xf8MIQ==
X-Received: by 2002:a17:90b:2682:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-3110f72e2cbmr17396740a91.32.1748336869732; 
 Tue, 27 May 2025 02:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs0m7904VWg3UNBnkfhMUXSp9eKxecRdhi8dbRO1qtQufNYPhGrFUWrRfuptFfr49NKzLzH/YQybBvkH/uaEk=
X-Received: by 2002:a17:90b:2682:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-3110f72e2cbmr17396673a91.32.1748336868915; Tue, 27 May 2025
 02:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
In-Reply-To: <20250526155132.GA151544@pevik>
Date: Tue, 27 May 2025 17:07:36 +0800
X-Gm-Features: AX0GCFsiNwQV0vfRy5HVdZnaDGT5gtJEoMgOVvTBMxDK5iVtmgMi2qRPcTeDl7M
Message-ID: <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 92LMA4xOlgMTudV9PgipkRofzHsFyCiTMIgeBjZSTgA_1748336870
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

Petr Vorel <pvorel@suse.cz> wrote:

> > -     skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
> >       only_fs = getenv("LTP_SINGLE_FS_TYPE");
> > +     force_only_fs = getenv("LTP_FORCE_SINGLE_FS_TYPE");
> > +
> > +     if (only_fs && force_only_fs) {
> > +             tst_brk(TBROK,
> > +                     "Only one of LTP_SINGLE_FS_TYPE and LTP_FORCE_SINGLE_FS_TYPE can be set");
> > +             return NULL;
> > +     }
> > +
> > +     skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
>
> >       if (only_fs) {
> >               tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > -             if (tst_fs_is_supported(only_fs))
> > +             if (fs_could_be_used(only_fs, skiplist, skip_fuse))
> >                       fs_types[0] = only_fs;

One more thing I'm a bit hesitant about, do we need to explicitly set
fs_types[1] to NULL here?

> >               return fs_types;
> >       }
>
> > -     for (i = 0; fs_type_whitelist[i]; i++) {
> > -             if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
> > -                     tst_res(TINFO, "Skipping %s as requested by the test",
> > -                             fs_type_whitelist[i]);
> > -                     continue;
> > -             }
> > -
> > -             sup = tst_fs_is_supported(fs_type_whitelist[i]);
> > -
> > -             if (skip_fuse && sup == TST_FS_FUSE) {
> > -                     tst_res(TINFO,
> > -                             "Skipping FUSE based %s as requested by the test",
> > -                             fs_type_whitelist[i]);
> > -                     continue;
> > -             }
> > +     if (force_only_fs) {
> > +             tst_res(TINFO, "WARNING: force testing only %s", force_only_fs);
> > +             fs_types[0] = force_only_fs;

fs_type[1] = NULL; ?

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
