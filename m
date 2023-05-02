Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69666C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 00:39:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63D8B3CD941
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 02:39:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A7493CB920
 for <ltp@lists.linux.it>; Tue,  2 May 2023 02:39:36 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF05760029B
 for <ltp@lists.linux.it>; Tue,  2 May 2023 02:39:35 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1aad5245632so18890025ad.3
 for <ltp@lists.linux.it>; Mon, 01 May 2023 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682987974; x=1685579974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PwZqPVfdD98RGGdgHpZ/AzPHiqQjK6f8LQEk0yK0Zco=;
 b=rXB2JJkiTu4hICfIG4uv6uiV1xCmwftlY++WfORFpcseumSePfSrV6GkobqFSHMGwv
 8/tpLOL92wN+ea7V0SyV5Ii94EIkMav2jlegjcBELANssj3Pipph2H4zlGaxwGf7Hdeq
 68cNQbVzn0FzlED8v4yh64p+FSuSyIxT+qzvBELLjIN931Fbf3YldkX/kcuaTCqrlRrI
 SSoU2QOTcLaRumrJXi/l1SXAZtQe5kqbWQlBpfLchglrMzK07fHyGMlJZ6ynuT4ogAaq
 ki07HzmGoiWXrYJ24DoIkzdTa3STAn9BxEXosx7z/sC79gcMuK5PvmPM3PgbLd2lIIs5
 RQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682987974; x=1685579974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwZqPVfdD98RGGdgHpZ/AzPHiqQjK6f8LQEk0yK0Zco=;
 b=MTIF81o9Mo4K7r0dBrRe8wj/MBrkXAduVL7TVVgBp6H1zt80+FqVug4dTTGc3q2w5q
 6yKau8V1I8RyKk5GDAM/ZaF/XNYqgRFQ/r1l39/ZGBpvUpeqL4sWPGWr/r8ulQ0zPY3R
 ESTnyyLIudg3T8JnPdvpbmG9zOoK/bi8+YJZJGPyN3Kp8qo60UsMqV4XMtLuy0xA8u+J
 aW3o0Tkxnf0aZfHtYCu8P9Vt9NjbICp3whWCF6p8jR15K4RpCtkawlTR6/vwkO3NhxqY
 G5CRGdxfz8kZNkXX1FkHFnVeGroL0rfxvHD/Bs3W9/kbALxRngkoiaxyfNR9wXF+I6uK
 snEw==
X-Gm-Message-State: AC+VfDw1hSk7EDWLZDupU49OL1n7oSlVrHgEdMjge4QSQvJnSXsuF7hy
 kggwzDxwgo4fr0CVXQqfPFoCcg==
X-Google-Smtp-Source: ACHHUZ5rNxN5VmHZ5p3Ayr0pXCHpUS5ZR8fFEU6KCZl5Ev01KAbw9hBMo2NXzR3u23sSG+cU9T+h5Q==
X-Received: by 2002:a17:902:f78a:b0:1a9:b62f:9338 with SMTP id
 q10-20020a170902f78a00b001a9b62f9338mr14109356pln.45.1682987974087; 
 Mon, 01 May 2023 17:39:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au.
 [49.181.88.204]) by smtp.gmail.com with ESMTPSA id
 j2-20020a17090adc8200b0024dfb08da87sm2614399pjv.33.2023.05.01.17.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 17:39:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1pte3F-00AG9K-Tc; Tue, 02 May 2023 10:39:29 +1000
Date: Tue, 2 May 2023 10:39:29 +1000
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <20230502003929.GG2155823@dread.disaster.area>
References: <202305012130.cc1e2351-oliver.sang@intel.com>
 <0dc1a9d7f2b99d2bfdcabb7adc51d7c0b0c81457.camel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dc1a9d7f2b99d2bfdcabb7adc51d7c0b0c81457.camel@kernel.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [jlayton:ctime] [ext4]  ff9aaf58e8: ltp.statx06.fail
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
From: Dave Chinner via ltp <ltp@lists.linux.it>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, May 01, 2023 at 12:05:17PM -0400, Jeff Layton wrote:
> On Mon, 2023-05-01 at 22:09 +0800, kernel test robot wrote:
> The test does this:
> 
>         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
>         clock_wait_tick();
>         tc->operation();
>         clock_wait_tick();
>         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> 
> ...and with that, I usually end up with before/after_times that are 1ns
> apart, since my machine is reporting a 1ns granularity.
> 
> The first problem is that the coarse grained timestamps represent the
> lower bound of what time could end up in the inode. With multigrain
> ctimes, we can end up grabbing a fine-grained timestamp to store in the
> inode that will be later than either coarse grained time that was
> fetched.
> 
> That's easy enough to fix -- grab a coarse time for "before" and a fine-
> grained time for "after".
> 
> The clock_getres function though returns that it has a 1ns granularity
> (since it does). With multigrain ctimes, we no longer have that at the
> filesystem level. It's a 2ns granularity now (as we need the lowest bit
> for the flag).

Why are you even using the low bit for this? Nanosecond resolution
only uses 30 bits, leaving the upper two bits of a 32 bit tv_nsec
field available for internal status bits. As long as we mask out the
internal bits when reading the VFS timestamp tv_nsec field, then
we don't need to change the timestamp resolution, right?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
