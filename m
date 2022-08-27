Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D496ECAAD2
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 07:32:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163D13CA4D8
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 09:32:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11DD83C70D9
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 09:32:02 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E7C6600738
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 09:32:02 +0200 (CEST)
Received: by mail-vs1-xe2d.google.com with SMTP id w188so3640750vsb.10
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=uxlS8kPAiA+cCTrsW98ax0oL2fx+runF+1qrAdn4RlA=;
 b=fGl4c6oE7psqtw2ov/SaeYgg1r8LMtQdGhR3qCr4AR3U6AYhKx/3OpJRX0eHXgVDfa
 uiI2GPSwe8dcTd/NDSBqey9WHRgrzyji9kQsaW/vyzTk0Tvfy2dd5B41jTFU164ym/Hl
 syLG8mH9CW5fb+vpkIRWDc97NWvpAenrz+cg6REvM1srenYo/Rzm+F7rvtbw1KQPv0M/
 hBSk+lRpNkT38pUrlYmqzvV8bLFS1PvV39j8kDQy0h5+c+smaIdQ4E2Qg19T5GkT1dy7
 r8xbce+uGvr5gthxgomd9pbbaSpAvUl9BmuB00acWneJLxRNhU7moyoatuahNM7uq6Vb
 gGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=uxlS8kPAiA+cCTrsW98ax0oL2fx+runF+1qrAdn4RlA=;
 b=kKHinTEt08EYDE5mvEMyfo4ESnlNY5M7uER1H9FlFaVTRinK+ssBImkrF0xTt5Xsuz
 MZtfcC1V8YZLldKtAYFIL7J2Oj67yQVYa7RJi6z0zvrovMXpUyM6RnBTejGEsITAMTSs
 gxAELUfl1XarqLMUAmPCq9OSEaZXB3WSKCt6O2BklGhgOiuZ54JdptuQnwQAGOrDIFCq
 wLnqpu0U4XGMB36A0FrCfWf0vK4KuQYvgUQZ94FB2m8z83yj9x/T7o95XrCF0t7MnPWJ
 bqi1UjVYgEyipa0L2nVCeZgQtguYzt92nge/tKN+z04kwillvaOK4pm/2EGf0nwZsc3X
 AQvw==
X-Gm-Message-State: ACgBeo0OgHL3CSZKKTjoRmKsVtTzps1nMb4pw93gLA50QnUnNUFjVt57
 70hzP9W7NCLx1/IuVueoJjOj5kHIV0C4ALZxOoo=
X-Google-Smtp-Source: AA6agR4stRa33apOiT+xA9yxGGG2ZdRJ/8noeVceBqqL5un93gELkrCf/LS/IywJrZUpBuwIsf+Eglb2t1g/DjUE52s=
X-Received: by 2002:a05:6102:7:b0:390:3c74:936b with SMTP id
 j7-20020a056102000700b003903c74936bmr841003vsp.72.1661585520904; Sat, 27 Aug
 2022 00:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220825140306.7150-1-jack@suse.cz> <YwjGrvqYEv4cn+/A@pevik>
 <20220826141933.fiy7mohz4ca6s5se@quack3>
 <CAOQ4uxgH+Q+R=YdnjkBAytB3GLwCEZzg3MYuqpwTyAuShBnw2g@mail.gmail.com>
 <YwlEfZ7FuU2jIPKC@pevik>
In-Reply-To: <YwlEfZ7FuU2jIPKC@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Aug 2022 10:31:49 +0300
Message-ID: <CAOQ4uxjMo-sm060G-80ic-+p1UvwUpzFJsO3ecOKVRKyoQ_wxg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: Matthew Bobrowski <repnop@google.com>,
 Dominique Leuenberger <dimstar@opensuse.org>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Aug 27, 2022 at 1:09 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Fri, Aug 26, 2022 at 5:19 PM Jan Kara <jack@suse.cz> wrote:
>
> > > On Fri 26-08-22 15:12:14, Petr Vorel wrote:
> > > > Hi Jan, all,
>
> > > > > In some setups evictable marks tests are failing because the inode with
> > > > > evictable mark does not get evicted. Make sure we sync the filesystem
> > > > > before we try to drop caches to increase likelyhood the inode will get
> > > > > evicted.
>
> > > > Merged with minor changes to keep checkpatch.pl happy.
>
> > > Thanks!
>
> > > > Given on previous discussion the behavior on ext2 vs. xfs:
> > > > would it make sense to transform the test to use .all_filesystems = 1 ?
>
> > On the contrary.
> > We want the inode reclaim to be as predictable as possible.
> > That is why I suggested to force the test to use ext2
> > because xfs has some specialized inode reclaim
>
> Ah right! Could you please send a patch with .dev_fs_type = "ext2"
> That should be enough I guess.
>

Petr, I don't think there is a need for that.
I was only pointing out the different fs can have different inode
reclaim behaviors.
I had not encountered issues when testing fanotify10 on xfs myself.

Jan's patch should be enough and then the test can run
on the user's choice of filesystem, which is always better than
unneeded restrictions.

If we see issues on xfs we can reconsider .dev_fs_type = "ext2".

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
