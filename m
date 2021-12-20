Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81ACC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 11:49:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 198193C9171
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 12:49:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE5CB3C282E
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 12:49:08 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59B0B200DD6
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 12:49:08 +0100 (CET)
Received: by mail-io1-xd32.google.com with SMTP id m9so12926119iop.0
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ol2NZaQ06boKcIwHQi4WmQVOiEUH/6bxWgiZDz0xGKA=;
 b=m6dRPO0fFnMOUk9MhocTz0+04kmj8yfccgmEXkcvJFd67GJ4nlbx31rM9z5uXOHPNV
 n0BV1xDYtywamhC3f3kFvLdTRrDFPgNBgakm6UPVrV+pYPzy+vLKodzlxZhdwaEWCNhK
 n/uS78u6dZdHYx6Y7+0cRNwOGO8mxzv4ksTcE2UKFX/V9G/rQHdJoEvvsDWNMdgMv8Sm
 RPw+oSfdpQIAU8UtxMikZEk/RqjivcqoNELiISswfwlJSqUqGszI0wtOW+3g2S6LGY98
 hY9ZK0CKIK83fKiPEaYXx6PplBh/t1c5VnDXdl+eGEUZyMXPlQiYhuwudVSt0PJC5m39
 dbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ol2NZaQ06boKcIwHQi4WmQVOiEUH/6bxWgiZDz0xGKA=;
 b=kuaxYGOhQxQ5gq3soJyVoUTPmeUvqBKvpWxuyBAXcSuJKogmcQyw7czz3X56HpZSvG
 4IGkGgMxxX+yay8fObeiLWktCeb162yrJjVVp558VLA2qBZmom/Hwq39+ouZ3iJr0m/b
 8TQETgn9m0xtWo5Ui1C4TzJ8T0curzx6cxyPLsVd1emHD9cLUL0s7LumdXLJS8qKRNma
 MhzwIZ51xnqqEe+RBFT8TNAgGK0mYFEuRS+tGL+rwpa/oSHSkoruYGYXyBbXzsj7nTMZ
 LztbtxZqzN8y9bkWcuAgWrdcy4WYGN3fjwg4FNbxtQkYwlHl8fM3GceeC3fw8F+H91L/
 HP/Q==
X-Gm-Message-State: AOAM531+BypRVgk4SrzlPjTQYLTXTgjAs3e2cqnQxzjpJZxCYC4oHnNn
 QwarB1sGGxXVtrXZJc4tsEUpejzZANz5cnPWCYY=
X-Google-Smtp-Source: ABdhPJzXuWfW2X4Q3eFornjCyRY6vAcO+HcNjJ39EbsuaBOMZwnVbZsC1jG08VEl2PJSpGaSQa1TUnXtA618AP9Q6w8=
X-Received: by 2002:a05:6638:358b:: with SMTP id
 v11mr9008705jal.53.1640000947005; 
 Mon, 20 Dec 2021 03:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com> <YZtLDXW01Cz0BfPU@pevik>
 <YZ4Wf3d+J36NPMfS@pevik>
In-Reply-To: <YZ4Wf3d+J36NPMfS@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Dec 2021 13:48:56 +0200
Message-ID: <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 24, 2021 at 12:40 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> <snip>
> > > Hi Amir,
>
> > > I have pushed v4 to :
>
> > > https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>
> > FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> > fanotify_event_info_pidfd check")
>
> > https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes
>
> FYI I removed branch from official LTP repository and put it to my fork
> https://github.com/pevik/ltp.git -b fan-fs-error_v4.fixes
>

Hi Petr,

Are you waiting with this merge for after release of v5.16?
or is it just waiting behind other work?

Just asking out of curiosity.
I've based my tests for fan_rename (queued for v5.17) on top of your branch.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
