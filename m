Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71010CA5FEF
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 06:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768804073; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aVPMb//v9H4t3/8j3eaMvSXfeyihoxeszOgR/dm7/9M=;
 b=NyTespaMKeURsH0RJ5+4ElYd7HPlvSIi0jMt+oIqteIbWrf3J24y54HYJhsueTco9Pq8w
 X+gLiiEVXTxSKacgTxs9S0X37Dmv+2jwm0AfFxgt3fzj3Ab1nhgoIrVRYcal5N0xiEl5NFl
 S+N1CWvLGzuCfMnyrrqPIvdi1SUtRwU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5293C6994
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 07:27:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2533C4C2A
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 07:27:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C9FA60080B
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 07:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768804044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2tbFW3b+ET+KdOeeFmiJLHzdPFLwMMT5Fj1LbsRU3E=;
 b=Rdt0v+pqn/+IRzYy97gXD+0YaG2ob/R9W8oYo5pQXmxWYDAKrAGEo3+BQO6jhwkLqnqDA9
 y8UhtI50k1mS4lYMxi3k1PPcxoeRGJDzD4jzY4loBiXnP0zMjYXgoiAc9UBxIaERJqM8dA
 LEAhhvBlLF3A0fAhnefdbFW95mqWoSQ=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-2ewBBDWtOh6WV55xuHY_fw-1; Mon, 19 Jan 2026 01:27:22 -0500
X-MC-Unique: 2ewBBDWtOh6WV55xuHY_fw-1
X-Mimecast-MFC-AGG-ID: 2ewBBDWtOh6WV55xuHY_fw_1768804042
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ac363a9465so4770320eec.0
 for <ltp@lists.linux.it>; Sun, 18 Jan 2026 22:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768804040; x=1769408840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2tbFW3b+ET+KdOeeFmiJLHzdPFLwMMT5Fj1LbsRU3E=;
 b=bVMVB3EJvocIoT4F7B643cGXXgdxsUo3k7Ep2AzRd9KWjE4NS2XTk706l8sJD6D6Xn
 Kvd8/ngnUAPKeyvQaQ0icqM5xWDhRajYngOczMQqIF8uGhP19R3PRCRQuHfeWYMcu+Hn
 nEbYVIm8zsX4Iqk0+MrI5LeeiZVMPth9fzzdRUJvdKJsBxYIvvVHWoU74um4BlP9BmvJ
 JQkYBWClcM3TiHKGlbVAJfGjvhfkLG2uETtaRYLFnU7lzWRIjhQgOcXZ1By1are57zLH
 534HQ1UOr2DtE7lYwkaLiln6BG3YTAtQlfqI19BhREzzpSLgfS6x4QwlrLs3jwu6Oug3
 Tmkg==
X-Gm-Message-State: AOJu0YxEnk3S91X0MXiDamKO4XJ+a4D/9FVr6vCJnBatys2iBDQIwCqR
 WD71QrL7xbvLZSuWI/FaC76pbxyVHVAZ7okKa0M05TQ2hTFaIFDmBJ9hQdPIdrBmRd3soe/vtnC
 GThX/x3syQY7diz+ohwSF8kbA30UjLrgJ4ndXc//15h3BTJqGBcvC/gkK62dBD88WoBhtj0wR6T
 XzAWilLOuoByRdzUSL1NbGNvYwK0LkINPY9nSpcQ==
X-Gm-Gg: AY/fxX6/t+ZCuP5ZIMvSrzLL4qYKlBfZFmyUZVUwnVaptIoXHd+L6BUryZ0piUhEfmp
 HLeo1Xlxljlof8SbvTlFONpomi8KoJCV5ROMNeBr8jJUbqsAwrkTdU09nkORwQKYbLEaPRH64Qt
 2T2Je6GO+XNC/Bom3pEXf1y3rb9aCuKXc7M6mq8WXw2S2gyK6RF29oTO0kCXpYutKHguI=
X-Received: by 2002:a05:7301:3e07:b0:2ac:4db:9481 with SMTP id
 5a478bee46e88-2b6b4034d87mr8436056eec.19.1768804040165; 
 Sun, 18 Jan 2026 22:27:20 -0800 (PST)
X-Received: by 2002:a05:7301:3e07:b0:2ac:4db:9481 with SMTP id
 5a478bee46e88-2b6b4034d87mr8436041eec.19.1768804039693; Sun, 18 Jan 2026
 22:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-4-wegao@suse.com>
 <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
 <aWuLke3rmststr0n@autotest-wegao.qe.prg2.suse.org>
 <CAEemH2f2s+LyRk_viTEhra989Ko5aeeHEUM5vULopyZE0bMvVw@mail.gmail.com>
 <aW3CWarQjleohiw3@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aW3CWarQjleohiw3@autotest-wegao.qe.prg2.suse.org>
Date: Mon, 19 Jan 2026 14:27:08 +0800
X-Gm-Features: AZwV_Qh8YMVOxLsgjSMJ-jkOPIKl3pgcB2wM0autEsEwAZTaekUGD8ras7by78o
Message-ID: <CAEemH2dLMQE1VikqvwPS4cM0TQxpnCPncfhdSH=8FFMAnK5wsg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKiU_iI7Zp6EdDikLYl5PchTWEQaH_dbYukqSt6oH7Q_1768804042
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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

Wei Gao <wegao@suse.com> wrote:

> > > > Can we just reuse the 'tst_test->needs_cmds.present' result?
> > > >
> > > You cannot access tst_test->needs_cmds.present directly as if it were a
> > > single variable,
> > > because needs_cmds is an array (a list) of structures. To get the status
> > > of a specific command
> > > like "parted", you must iterate through that list to find the entry
> > > matching that name.
> > >
> >
> > So how about using:  tst_test->needs_cmds[0].present?

> Yes, i think direct indexing is more efficient, but helper function is more readable
> and extensible(If someone add more entry into .needs_cmds it possible break the
> test case).

Yes, but not entirely, once we have the function tst_cmd_present(),
we need to manually write the "commands" again, and easy to typo.

Even if we plan to add this feature, perhaps it's better not to
place it in tst_test.h or tst_test.c, as that may not be the best fit.

We should respect the principle of high cohesion and low coupling.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
