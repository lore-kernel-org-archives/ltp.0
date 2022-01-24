Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1CDC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 07:22:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E493C7B43
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 08:22:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CB203C6F26
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:22:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BA511400982
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643008930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHa1evGXRBJUzN2eaiiFyT+SqRTxRdCW+k+mUcIPiis=;
 b=KvM+WmU4TlNyjfHErHriff9fpOm+7zu6twEQruLB8Yunt55BKif9JMK7zTgqDdxTmzQByw
 dbz/i76lSQfbf/ZBqMZJiTqwMBnYp7YQp4iuJCe6wM5OMJkOCqXpLZXZ/3wi5OkXzHilC4
 AGy4UzdqrNGC7uSxooEsNypqo7c34bY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-1gYrj-UpOLy-5jKttOWBeQ-1; Mon, 24 Jan 2022 02:22:08 -0500
X-MC-Unique: 1gYrj-UpOLy-5jKttOWBeQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 d65-20020a256844000000b00614359972a6so24189823ybc.16
 for <ltp@lists.linux.it>; Sun, 23 Jan 2022 23:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LHa1evGXRBJUzN2eaiiFyT+SqRTxRdCW+k+mUcIPiis=;
 b=ARd3P7uyudH6Cw9tpXDLBdOVgPAtKsmcJ2flrJMePWKpKuwGM1CJXuTAufzmSUft/h
 9IRVVRYbAXf0evVvf+IVnG9++0I1Fyl9WoBQPW0x5bF701MXAwFOOC+DFxKabfEVrcXo
 Pn5iOsA8inQ2BrVOa4zabMbLB/sEk5yJEd4dGJfxmMrS4eUTS5bMpo/MvzRMTAsiJ/Qz
 DEUGwAw6ETZHp76UsLcJyS616LNWyhGaL3Vs7SEl5Nqfu80UW6WZePxEmhfeEQ/rct0E
 48VrzQHz3CX34zLBX6zK/dZDvwAlVK7eDFl2jNkxdHZF+ggbmZxsY9DpF/40a83hHC9D
 x0+Q==
X-Gm-Message-State: AOAM5337J8YFebtd0L5jcXHr0i/B2Q1Xj5QX0/D63pB2tgd1bm9Y+3SM
 RXEMP1qzMCJa1O1rcRRTelfVCGtEZY00QVTodlweWeW/DfAcIWvi0Osu4do0G1zE+afZ0SJ3J5J
 0RQy4FhrCQO74/1f+xvSwkRKYVaM=
X-Received: by 2002:a25:f81c:: with SMTP id u28mr21564919ybd.728.1643008927767; 
 Sun, 23 Jan 2022 23:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfZV8gwm4cBMcdZvr0E33S5YcVHKhKrSjZPZvDC3A3NoRBbvQmb+yu/vjcLIo+IB9+XpnWyJMUZfQ2Fq56T1o=
X-Received: by 2002:a25:f81c:: with SMTP id u28mr21564907ybd.728.1643008927595; 
 Sun, 23 Jan 2022 23:22:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2dBUSfn09+gAjH3tLDifoMevoaqDWNFa+hHKe_SDd7-5w@mail.gmail.com>
In-Reply-To: <CAEemH2dBUSfn09+gAjH3tLDifoMevoaqDWNFa+hHKe_SDd7-5w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 15:21:52 +0800
Message-ID: <CAEemH2dzrncQow=RnqxRj1rkSxYcycOY=+zhjxyiWr7k8+roFQ@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/16] API/cgroup: Add more controllers to
 tst_cgroup
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

Li Wang <liwang@redhat.com> wrote:

> > +static const struct cgroup_file pids_ctrl_files[] = {
> > +       { "pids.max", "pids.max", CTRL_PIDS },
> > +       { "pids.current", "pids.current", CTRL_PIDS },
>
> I'm afraid there is no "pids.max|current" in the cgroup V1 directory.

> > +static const struct cgroup_file rdma_ctrl_files[] = {
> > +       { "rdma.max", "rdma.max", CTRL_RDMA },
> > +       { "rdma.current", "rdma.current", CTRL_RDMA },
>
> Here as well, can you recheck them exist in V1?

Please ignore these two comments, I found them in subdirectories.
(sorry, I was dazzled on such many files :)

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
