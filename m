Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5530C433F5
	for <ltp@archiver.kernel.org>; Sat, 20 Nov 2021 10:44:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6B73C8AA1
	for <ltp@archiver.kernel.org>; Sat, 20 Nov 2021 11:44:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60A103C6A0B
 for <ltp@lists.linux.it>; Sat, 20 Nov 2021 11:44:11 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C45D41000961
 for <ltp@lists.linux.it>; Sat, 20 Nov 2021 11:44:10 +0100 (CET)
Received: by mail-il1-x12f.google.com with SMTP id l19so12804792ilk.0
 for <ltp@lists.linux.it>; Sat, 20 Nov 2021 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5SpO5spxTcSzoLsZFFqEN0XD8XHtKSnd+Zt6F79jc6M=;
 b=cVxA1UZL6Oi5s5Mkz+5Hyi4BuZdP3Ek/tBwNTOMLCNBsV8+JSYfEskFw83grAZgb5M
 KT+0y2VKMJmwse15Iwa0Kxv7+5Gs1Jm3K5WG5VA8WfXoLuZkjVuUN6mamP1yTNAdJlWp
 GRgJVC4M+4vYM9qCLsHzOY5e4KZpCBveFvGD1iaRHYsVtWZynPnjMTBHJU41aBZt7Owy
 jNzM5wZPSGmRjplIEzrIW4Ee3GiqvN9Fld/Lq6mhcsHigXtrKhxpiFBqPxiwAzafUzv9
 e6tUeCAtxAt34dSYZZMU0S6ED1s+PTZ7BN3QmRyYKOFXx4KEhG5eve8h3QkTdTcjBtDr
 c/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SpO5spxTcSzoLsZFFqEN0XD8XHtKSnd+Zt6F79jc6M=;
 b=lu/uNAKTD+YzTtVbnoUOBvLJr2cJaMjmIfk+8TBrdrlBJAS5CfuPY4h+JsowgPiGDb
 kBVbR68g5zdTJKmtZep0zvq3H0QqE/V1fD3J4bmx41WVlJdaq438/XeMYl0S04keLJU/
 1Rr6y3b+CEs1j/SVS4K5++M1QBiFz8jTJ4zG/g/6K+Z3xvZrrzg6orGKT7308nTHNU3J
 WgP9g/CSKEhzkKOos3eX6nUUBA5/yG1h1PXZXIZsNmwiD9BQ8WA+UZEW3O8MBOqIJHb1
 wCwjWUHXQRTYMUI2jM2jg86Ap8Rr87OGWqPMX7wNVL98a2FOv+lKzOlvACrC8iomMA2I
 V+gQ==
X-Gm-Message-State: AOAM533sNgd4Q++tDp2Ui7EqfSobYc04oytx5FSRnIFlEPuP4su+A09o
 XaiefomTXUzMCkqJ9UMzongrRxv7i/h7gisO2EE=
X-Google-Smtp-Source: ABdhPJxKotlZK6PZWiQlANS6i7fUvmkubzuyHmR1DF7uxbNrU4eog4am/1bAHv5RSsZ/tSftR7lETMSm0Qw41CPZH4k=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id
 n6mr9663312ili.254.1637405049441; 
 Sat, 20 Nov 2021 02:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
In-Reply-To: <8735nsuepi.fsf@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 20 Nov 2021 12:43:58 +0200
Message-ID: <CAOQ4uxg0EfxefoGZr35C5HQR2Ac7BZ_HnTCq1eipvUa=iuQRWg@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: kernel@collabora.com, Matthew Bobrowski <repnop@google.com>,
 Khazhismel Kumykov <khazhy@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> >> A proper manpage description is also available on the respective mailing
> >> list, or in the branch below:
> >>
> >>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
> >>
> >> Please, let me know your thoughts.
> >>
> >
> > Gabriel,
> >
> > Can you please push these v4 patches to your gitlab tree?
>
> Hi Amir,
>
> I have pushed v4 to :
>
> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>

Thanks. I've based my fan_rename ltp branch on this.
I would like to do the same for the man-page update branch.
However, Matthew's man page updates for v5.15 are conflicting
with your changes, so after Matthew posts v2 of his man page patch,
please rebase your changes on top of his branch.

Ideally, you could have waited until Matthew's changes are merged
upstream, like you did for ltp before rebasing, but man-pages maintainers
are quite behind on merging updates, so we will need to collaborate
between us in the meanwhile.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
