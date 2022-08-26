Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43ABECAAD8
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 21:13:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4CB83CA4D4
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 23:13:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBCA33C8765
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 23:13:34 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17C9814004E3
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 23:13:34 +0200 (CEST)
Received: by mail-vk1-xa2c.google.com with SMTP id 134so1220719vkz.11
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=nMykWSDHJYWmultACRobeVt+gTdbL+bmfR5ua+lfxvA=;
 b=GFxYVHlqQ/tDvjgl9dZiC39PsVRh2pIK/yY4jeWvVlz/i9PFP31FvcUSookCCa4/zE
 1PTxuh89wcdwoXGVjSbJxKbFp66vwyMVWOY5zHWf0fILXyMZ+Hi1+VpHb9rO7rFKrbKW
 X6iz6+AYrWLEyz6LytXeWrCWwTCDWnatRnZtdMvg4WigMdmyBWAmYOXXdQrBRcF/ZIaH
 pr/5eHbdx5Am2dLPG9n46f8+BU7p4V3tM1Kx2bPtYJvN9YVnFTwooYwn/Wx+PAbaHzZS
 OzfkGxdru73E8qvQo35tVPtts8xvyBYn7wLRU4KH+bLOLuy1FXU9RivMpRDxauyLfyZE
 oG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=nMykWSDHJYWmultACRobeVt+gTdbL+bmfR5ua+lfxvA=;
 b=6+RkmAt8FB9V0ZHwpCarfiZ8BHtu4WK09ynJBcP47Eb1a4wK11F60wQfrgeHq8RPZP
 KxR0UjrWjaIQnINJXMgERV4MTIgy2l0p3lecXrPQdwMWcXjW1PqJSd/jIfhrKTMsCeDn
 AEH1tE/zaVb+1es7rXFo9L8M5Ympast4GhfVYXjt59+sBACK+SNykAkQBvLTlpQSL22B
 q6/t+nTzNflCI5ySNVVpfWvuo1dTBvf/vhMKTP63zUX4Ywo8xULPRD0niFw1PqXrrq2S
 nUcOuA2UrMjkNBhitGpHm05FcNdK8PLhgLu5v9vwbT+/ysnp6Kf8uuc6Bftbs1R3DPl6
 Vbog==
X-Gm-Message-State: ACgBeo0DAOMCYnLJIa6vo0CdMrLFLtZpY6lGGQEUbIfKbBtOK1por/fN
 NU/2/7uX4LR2sQAa/2HEaXfXyeVEeAz+g0NH3Mk=
X-Google-Smtp-Source: AA6agR5ZdL2JJC6aCcZtfGOEHLMPwQD7y/lgfLmbXc3W0zyc+lpz/qoCWZCakDFtJB7JSFgZmz0EvdL8KPF5156MjaY=
X-Received: by 2002:a05:6122:da8:b0:376:c611:9cdf with SMTP id
 bc40-20020a0561220da800b00376c6119cdfmr621306vkb.36.1661548412918; Fri, 26
 Aug 2022 14:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220825140306.7150-1-jack@suse.cz> <YwjGrvqYEv4cn+/A@pevik>
 <20220826141933.fiy7mohz4ca6s5se@quack3>
In-Reply-To: <20220826141933.fiy7mohz4ca6s5se@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Aug 2022 00:13:20 +0300
Message-ID: <CAOQ4uxgH+Q+R=YdnjkBAytB3GLwCEZzg3MYuqpwTyAuShBnw2g@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify10: Make evictable marks test
 more reliable
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 26, 2022 at 5:19 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 26-08-22 15:12:14, Petr Vorel wrote:
> > Hi Jan, all,
> >
> > > In some setups evictable marks tests are failing because the inode with
> > > evictable mark does not get evicted. Make sure we sync the filesystem
> > > before we try to drop caches to increase likelyhood the inode will get
> > > evicted.
> >
> > Merged with minor changes to keep checkpatch.pl happy.
>
> Thanks!
>
> > Given on previous discussion the behavior on ext2 vs. xfs:
> > would it make sense to transform the test to use .all_filesystems = 1 ?

On the contrary.
We want the inode reclaim to be as predictable as possible.
That is why I suggested to force the test to use ext2
because xfs has some specialized inode reclaim

>
> Well, I don't think it would improve test coverage in any interesting way.
> This test tests stuff in fsnotify layer & VFS. The differences in
> filesystem inode reclaim are not target of this test - we are just trying
> to check that fsnotify does not block inode reclaim by holding inode
> references and for that any filesystem works. Or did you mean something
> else?
>

Agree. I see no reason to change that.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
