Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A27C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 14:10:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C003C98D0
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 15:10:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2752E3C9732
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 15:10:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C8A7200AD7
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 15:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643811046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=782/lRE3fUhNkZwGYyd0WzZ82QBZ3rM9P2vMEJcLYOI=;
 b=LkhMjC+rFCjChX/5mb+/KW8Zcd4PQpYrAXEL4e0ktdzveoz30DUzzd4taoXLghtyZ82v+f
 Bqiokestgdm8lnoGzOA28nuQeeMmzvGwKEvIMKepMBobMNr/3fmpLEaUxyWYdXiBWCbYbx
 q8JmcqxzyPR3n94YAo/Kt8RiYYHKwq0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-Aa_y5-nWOiuvVCtkgyuFWw-1; Wed, 02 Feb 2022 09:10:43 -0500
X-MC-Unique: Aa_y5-nWOiuvVCtkgyuFWw-1
Received: by mail-ot1-f71.google.com with SMTP id
 c22-20020a9d6856000000b005a0f193edf0so11047236oto.16
 for <ltp@lists.linux.it>; Wed, 02 Feb 2022 06:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=782/lRE3fUhNkZwGYyd0WzZ82QBZ3rM9P2vMEJcLYOI=;
 b=b0XAuoVYR94KAIjoDoZM+lD6J41KO1wq440ROpfI9OPVJ16ONmMlHNXc0YNjfr8Mt9
 PsSuDT9B+LRwpIfvsipI+bgPjSPXwhU1IX2K1K5CyCAjY8WavKs7AXkRKcjNfKcTZy0c
 yY0CPV+7Z4L2hSUvKPU3LXFPiRIO33wJrbZ1VWnTh+Y6+jBxNBnaZTilJPijtSYpqjol
 1zyGaIptshIGfc4cSeLTTu1M0taVABMqQWvSH0TURgjEs3CEZxsN2hQg0dS2NltLeF1d
 YWpwdtGZMK+h7oL7rJYP2mfs3/YM4qMehSwqJ42Un7pVB1U1IbcS6uMdeegw2q8feG5C
 nFSQ==
X-Gm-Message-State: AOAM533x86oPfCY+Y9H4dtELi+r05EE68gcaUqto3wCjTqsZlhUdfLit
 N5c2osLmFHT2L3FgDRNaudxrdMQZPM1huY/icoykIJ+Z0SscFmPztiVYxTGymVxjedFWfJxAHnP
 utaq/kf/JP+vPIQk78Wcb5T09Kb4=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr4301016oiw.227.1643811042553; 
 Wed, 02 Feb 2022 06:10:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEJOKTTNDUjrzOHmYM4ezH7OH6gCg5O1InQqQahXj1oYmpelFygsQivjrRRjlHDRik7ihAfQPCXBRBZvgaRj0=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr4301006oiw.227.1643811042396; 
 Wed, 02 Feb 2022 06:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 2 Feb 2022 15:10:26 +0100
Message-ID: <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: Ext4 <linux-ext4@vger.kernel.org>, Matthew Bobrowski <repnop@google.com>,
 Khazhismel Kumykov <khazhy@google.com>, Jan Kara <jack@suse.com>,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 2, 2022 at 2:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi all,
> >
> > v5.16 released => patchset merged.
> > Thanks!
> >
>
> Guys,
>
> Looks like we have a regression.

agreed, "abort" option stopped working:
https://gitlab.com/cki-project/kernel-tests/-/issues/945

Lukas pointed out this patch that didn't make it in yet:
https://lkml.org/lkml/2021/12/21/384
This should be new version:
https://lore.kernel.org/linux-ext4/YcSYvk5DdGjjB9q%2F@mit.edu/T/#t

> With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
> because the expected ECORRUPTED event on remount,abort is never received.
> The multiple error test cases also fail for the same reason.
>
> Gabriel,
>
> Are you aware of any ext4 change that could explain this regression?
>
> In any case, Petr, I suggest adding a short timeout to the test
> instead of the default 5min.
> Test takes less than 1 second on my VM on v5.16, so...
>
> Thanks,
> Amir.
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
