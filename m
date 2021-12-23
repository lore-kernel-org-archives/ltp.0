Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EC2C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 02:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68E363C9293
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 03:13:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5A283C222C
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 03:13:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBB5B601F12
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 03:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640225625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ui5bNJHwkheu7sHd7nhwOvZ9zehDN41i4sfXzKXERYY=;
 b=WV0rxliLhUFfAUEzSeXBlled8TaSKeiw1Vg9LwuvEu/RuOySX7BctlaMwfrEb+PFZkO3Af
 eu+KIcZDqAv5O+OdQxdC1jhn4TyjuIBfLM8J1vDTGWdqckakkm20UZRap6SghpmD8mXLg6
 y5usO1pSP8kjGPZCDzmH8dOTbXoLbbk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-c9MQs4FDOSiaUvJkKsRmKA-1; Wed, 22 Dec 2021 21:13:43 -0500
X-MC-Unique: c9MQs4FDOSiaUvJkKsRmKA-1
Received: by mail-yb1-f198.google.com with SMTP id
 h5-20020a255f45000000b005ffd939127bso7416129ybm.10
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 18:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ui5bNJHwkheu7sHd7nhwOvZ9zehDN41i4sfXzKXERYY=;
 b=VpKGGP4BmTDRod9IjQ5PJ0mnghmSWDAsvEiIjbXixeG+++1PvqoepUGcFFJdPMEbvX
 sBTWHxAMBeuiclW5xkQK1BpUVr2X5VDd/6IzmFqZp5OmkuCBZNnYFlx3zP2jFzbP0HAN
 B3l82adqwIdV6ehW0W6jgshAspz0DrxfPiRDYIWBpa4x9VAZzJVHMQK4FU60T2goWpYS
 LM3+I4TvjuSSDHgcOWtaBh/zyJUh3HdMOluxBj2XOK7C4PPo5aq4jfFrxm/l7JTNRJ31
 4Pw6SyBau0k1UI0To6EJevrNwAb+1wIPzAfz2zp632ll4QWYsBTs74zaVk2qYMvMJk0A
 qZYQ==
X-Gm-Message-State: AOAM530Avsr0km4izVhai51Pzv5zJsZ5qGVrVZEsTZ196yNY5iaEZGLJ
 eXTzu+V2bBYWV8YYrTXA/Im/2GjbLNMDNlu6JvbM1IoBCQS8lVpiQERo3IJUvzwBY/6TNGYdAUH
 wCV8HeIOEh6Qnckgpp5KPBwpKtZM=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr627194ybi.102.1640225623044;
 Wed, 22 Dec 2021 18:13:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCKVBiWLbuFyzyMibsmMIzxgWDpj/8z97mv/DcngAu6pQ26yLHsrADLKiknL9wNdAq3CzD4IiEwC7ZUCMt+7w=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr627174ybi.102.1640225622793;
 Wed, 22 Dec 2021 18:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20211222135234.30025-1-chrubis@suse.cz> <YcMwRIZcQNH94xhe@pevik>
 <61C3CE33.5010105@fujitsu.com>
In-Reply-To: <61C3CE33.5010105@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Dec 2021 10:13:29 +0800
Message-ID: <CAEemH2di0818vNoByrpUeEfZi-T58fNMg131=HZFeF2W6Be0Ng@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Do not fail a test if oom score cannot be
 adjusted.
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

 Hi All,

On Thu, Dec 23, 2021 at 9:17 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:

> >> Setting value<  0 in /proc/*/oom_score_adj requires CAP_SYS_RESOURCE or
> >> CAP_SYS_ADMIN.
> Here will mislead user.
> Since the default oom_score_adj value is 0, so we can not set a value < 0.
>
> The value of /proc/<pid>/oom_score_adj may be reduced no lower than the
> last value set by a CAP_SYS_RESOURCE process. To reduce the value any
> lower requires CAP_SYS_RESOURCE.

Good to know this, thank you Xu!

From the man page, CAP_SYS_RESOURCE gives:

"
        CAP_SYS_RESOURCE
              ...
              * set /proc/[pid]/oom_score_adj to a value lower than
the value last set by a process with CAP_SYS_RESOURCE.
"

I will send a V3 base on Petr and Cyril's work to speed up merging this fix.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
