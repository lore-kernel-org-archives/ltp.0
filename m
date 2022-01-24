Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A7EC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 00:29:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A12E23C8D84
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 01:29:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCDF93C0F5D
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 01:29:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E7D560073B
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 01:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642984144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/BEHHwuSYKGQH1r40gKJiJlAmP06XyokUzCRRNFZO4=;
 b=PzLhobT1PNrmw0I3Sw/2ovPgkVUxXl0uoPRMnO4cWco37xm4zmJJe/RhZNJWPn94PXAKnW
 F7c1oOZsZwYevbQy8KLWOn/PzJhsQQyaAqVNzpGdcC+AfZIO8mKzfqGk2cipsritkseQNc
 fEbt9RfZEYSUhsy+F6oJ43L/Bnr/Bk0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-SXy-5oUAOEWXpBkmmZb5MQ-1; Sun, 23 Jan 2022 19:29:03 -0500
X-MC-Unique: SXy-5oUAOEWXpBkmmZb5MQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 b61-20020a25a243000000b006126ea65191so31281619ybi.19
 for <ltp@lists.linux.it>; Sun, 23 Jan 2022 16:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o/BEHHwuSYKGQH1r40gKJiJlAmP06XyokUzCRRNFZO4=;
 b=Ch2tE2b3l6LVudRJwkSFr3OXwaXlThDTetiqh/dkp1cf67GpU2RBynK28tFFJuC/mv
 qg0rWIZWEI9G9suLqMqtQJH3s6QzN7KyHdhGGNE7tal3iCl/S6ZTH0w+sn0xbw60JsJo
 ljrsFszc5yn2HAdOUpRPiYvUhxwT6pF+dxVKKKm70VWpZLQ73CqcPy6GI6HGSmkLXBeb
 O1ssqrcQFoW89UAyd2hpB/JClncG4kfosljRX1A/kJmmyO37ZYVKegAl8srD/MFr0MUE
 aharyq18+YiewcBFeb5bklnlfr3zoXcV8FcVBWtF+N9elIY8tTbJ9wRJBEuXuiQP2Xtr
 KHtg==
X-Gm-Message-State: AOAM532M051fk7ddW6woPmoRtRw7yNcb1hjEFF5SQyVOaGPQhW5rqSMO
 qFpG0IItYSNMkmakvU+j+oswQaeTRAsyE2RmsBrybfmwUGiGPhTjfKAFd4+WtPv35woyQ74er9r
 Z7gH7vyeXdC8pN36MufzdVBvJ4SU=
X-Received: by 2002:a25:f81c:: with SMTP id u28mr20099474ybd.728.1642984142571; 
 Sun, 23 Jan 2022 16:29:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZV8H+NPCW+0jgvjD+bP0K1Na7LQcror8/EFuuo6W3+k7j5cSGpjFCvjw9GGNp3abnKd2c8rF5Q/k5LruJixg=
X-Received: by 2002:a25:f81c:: with SMTP id u28mr20099458ybd.728.1642984142327; 
 Sun, 23 Jan 2022 16:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20220113123418.1911231-1-liwang@redhat.com>
 <YepDRN8mBjYqcORn@pevik>
In-Reply-To: <YepDRN8mBjYqcORn@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 08:28:46 +0800
Message-ID: <CAEemH2esgXuP=cCoHuo_CO7H0ikChFjx567hRkMZEk5EGiBVqw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: rewrite cgroup_find_ctrl with using
 for_each_ctrl
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Patch merged, thanks!

On Fri, Jan 21, 2022 at 1:23 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li,
>
> LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
