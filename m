Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B89BC433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 10:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CBC23CA61F
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:13:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84EEA3C0CD0
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:13:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7CDD1600C60
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652955208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jc0T90QFnztacf0oQg5cmrvKTL9M84zd9VcrgfzAbDo=;
 b=FTa93RobnJgX3RlHvAx2fVtJ8DcspvqZpvym4i4Cd6lF46nB7FYDUNltlfTNNfaRlY2azB
 Ej7vuOHWmXBcbslOUt0JWT/EFtuVx6ztf1DcsucBx/PUTCdSTpT43PRD79r7W/OrQuuJAj
 R2AXpEgpZNG4GBRFi5jm3oRZsKGDVgw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-mskbm9ozNB-xL8upNlCe0w-1; Thu, 19 May 2022 06:13:26 -0400
X-MC-Unique: mskbm9ozNB-xL8upNlCe0w-1
Received: by mail-lf1-f71.google.com with SMTP id
 k15-20020a192d0f000000b004743fcaf464so2438038lfj.17
 for <ltp@lists.linux.it>; Thu, 19 May 2022 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jc0T90QFnztacf0oQg5cmrvKTL9M84zd9VcrgfzAbDo=;
 b=7xo/BoWazBvhGjJfos2iUWk/jj3jhis85X8FCaYpp7IHWkAvHj2b3HB/rsCRutXXCI
 GagUIOndVmpYRdMMQZgBIReBtuu2Q6jFLKIegKjfzKdbP51Scc4KaHTsj666JiBrsDdV
 jNM5deogXSAKeLblb4Tys2yC3s/gVbmo/RvkWkX+1R5fgyDXIV5j3rGcDZ2Jle1ngqCF
 58hfWn9sn3HlzXZHhPb7UnioA0vnLn3Q01cNj6Mg8L2BZli1oUSwxIUBefstjRd7/cS6
 RvnWxU4vJMEoMiXMDqlXUKsSBJ6DnRSXF3i3Qt4sGiSPdHQ9/N+YhTFjXU42RaqLPbtP
 3qdg==
X-Gm-Message-State: AOAM532J9pXC+uMSBkFxYmUuIvjhIbWnAwKQ6scdGTkpskYL8QiYZss9
 Ueiqza7rDnUEUwWZvefsWMzrzEqzXqHV2g1Z67XYVDR9zW2NG1ypQmNjHMDAWotJyj6DRi12tQU
 Yk1JRDnCCK4LCNMWV/1Zeuj9dZTY=
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id
 x6-20020a0565123f8600b0044af5bfec9amr2858862lfa.490.1652955205295; 
 Thu, 19 May 2022 03:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFLWLWIsyKZVNBbIA5WeRe28ENzrmAS5g2mlaOWNkOHZsWSBI4EAobwP0f+ij6qBtfGjD88pLn7hjqR8lAGK0=
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id
 x6-20020a0565123f8600b0044af5bfec9amr2858830lfa.490.1652955204839; Thu, 19
 May 2022 03:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
 <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
 <YoPAMBxU5zuQ5xDk@yuki>
 <CAASaF6xNHMV+xgf7M=-iY-i+Hjgqu3jA1zVHu_XfgrgErCB6oQ@mail.gmail.com>
 <YoYVimPcOcphuVIF@yuki>
In-Reply-To: <YoYVimPcOcphuVIF@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 May 2022 12:13:09 +0200
Message-ID: <CAASaF6wRX26Dt1O7VNjeOb8aAOeK4mfhWQPi_TRcbL3edt-0wA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_find_backing_dev: match mount point if
 major/minor can't be found
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

On Thu, May 19, 2022 at 11:59 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > Sure, we can do that. Would you ack this for release as well?
> > This has been failing for quite a while on fedora (which uses btrfs).
>
> Sure, either way this version looks good.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

pushed


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
