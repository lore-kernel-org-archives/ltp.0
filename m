Return-Path: <SRS0=YPcq=OZ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37402C433F5
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 22:17:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CA660FF2
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 22:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15CA660FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C03643CAE8C
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 00:17:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 465333C80C0
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 00:16:55 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F5E6600972
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 00:16:54 +0200 (CEST)
Received: by mail-pj1-x102d.google.com with SMTP id
 ls14-20020a17090b350e00b001a00e2251c8so773171pjb.4
 for <ltp@lists.linux.it>; Tue, 05 Oct 2021 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uGxQNDN7HGHMH2vtYe08SepUk6Zt3B8k07HSpAmYyjw=;
 b=tjNj4JZ2ITldcns6IcTOsrZ18ARRVeBa0fcsBoqsfcqJEzo1GvYFU3gxBoZ3r2TdBh
 Vey9DOPbL5+Hl2SQN6zs9Q0tv2sfwDCtTzp4rDJ7mmGtv6TyiX0JdPg5IWl9waGtnTTp
 R/TNvcuRAHkl/naFp3ulWz1TwPS2SQjc3zDbY5q0PGVhm5+3vWjHqDVbeEwYOHwZhYBc
 tA9Z2jF9mU05VzVELDZspVu0dZe0VxuNq9ddW9vNt2n/smJH0uizr/E7r/Zk4kCFR3+W
 i+STZ8T3yd/4yHya7FAm+I5wrGWTwPYzgjqaAEZbot3AdGtgriH/UKfOIbq4epWPSjk/
 BcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGxQNDN7HGHMH2vtYe08SepUk6Zt3B8k07HSpAmYyjw=;
 b=WQGMewSWJ0MqnJ/tQdwhKa4lw0Jueke6UuH7I8EVbb9StzO0zLWqc+uBZTaWO8B5sD
 XK0GRh3wLiigvMUDD4cLxAj9Rq/sGfTXHuNM6sLoTlGsNIh5ZUN3Z8UL//k2Clo+EwjM
 d0fI1+/txex/U+cjChe8l3tiJXipEAxqDhyo4QXQGYcNVXT2jQ/orQNn0BSvg7rp1p46
 8cxi/yz38QKjq6fJbzcOz1W79RxXW6AioPTBxTu9zvlr5v3nXdWxTbQHIEZxHv/RDqIm
 4EH5I6hdgzfqmg3YJv0sTTZRo/um1zdBOc2hYGnKLD/6TtzMdcsbsKBCJfPjwrH95rq+
 j6oA==
X-Gm-Message-State: AOAM5325uEKHphTvDXmf6EQBK46tzc3WFf62z5b1/DPg5trxsIx/ZkMd
 LBjmc1fXYEIHpIcUMbH2Bl0F9A==
X-Google-Smtp-Source: ABdhPJw6JmCQgeViKc18T5M2cvZO770J+lZ5zHqbtLB3m8yyWzhxPLjXRRcPQkMzTgxjCVqQh/vFtQ==
X-Received: by 2002:a17:90b:1a85:: with SMTP id
 ng5mr6754135pjb.45.1633472212693; 
 Tue, 05 Oct 2021 15:16:52 -0700 (PDT)
Received: from ?IPv6:2607:fb90:3f21:961:33f3:673f:3df8:7e33?
 ([2607:fb90:3f21:961:33f3:673f:3df8:7e33])
 by smtp.gmail.com with ESMTPSA id d7sm18615186pfq.43.2021.10.05.15.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 15:16:52 -0700 (PDT)
To: Petr Vorel <petr.vorel@gmail.com>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
 <YVtBt+WeskISn5+9@pevik> <2a6a43e1-25da-7eef-f212-bfe0371275d3@google.com>
 <YVy0fTqiKM3lCCQj@pevik>
Message-ID: <188176b2-65f9-87a2-72f2-d6536c8be53b@google.com>
Date: Tue, 5 Oct 2021 15:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVy0fTqiKM3lCCQj@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
From: Steve Muckle via ltp <ltp@lists.linux.it>
Reply-To: Steve Muckle <smuckle@google.com>
Cc: Sandeep Patil <sspatil@google.com>, Martin Doucha <martin.doucha@suse.com>,
 ltp <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 10/5/21 1:24 PM, Petr Vorel wrote:> Hi Steve, Martin, Sandeep, Cyril,
> 
> @Steve, I'm very sorry, I didn't interpret the changelog correctly. As Martin
> notified me, since his patchset [1][2] merged as dc84a2490~..7d4fdf3bb the only
> groups queried by name are "users" and "daemon" (these in
> SAFE_GETGRNAM_FALLBACK()). He actually removed all references to "nobody" and
> "nogroup" in the patchset, tests now use tst_get_gids(), getgid() or get the
> primary group through getpwnam("nobody"). Thus there is no need to create group
> "nogroup", please close that internal aosp ticket.

Thanks for letting me know.

> Looking into tst_get_{g,u}ids() implementation it "The function will fill the
> remaining (size-start) entries with unique UID/GID values.". But the problem is
> that it expect there are no gaps in UID/GID values. While this is true for
> traditional linux distros (not sure about embedded distros), it's definitely not
> true for aosp, see AID_ definitions in libcutils source [1].
> 
> e.g. tst_get_gids(test_groups, 0, 2) (from setregid03.c) returns GID 1 and 2.
> But on aosp getpwuid(1) and getpwuid(2) fails (I verified that by running code
> on aosp 8). There is GID AID_DAEMON 1 ("daemon") and AID_BIN 2 ("bin"), which
> has been added for aosp 9 (8e8648463d7 ("libcutils: Add "daemon" and "bin" users
> for testing only")) and IMHO no use of tst_get_gids() so far does require higher
> GID that 2, but once higher ID is needed it will break (and even adding GID
> "nobody" would help much).
> 
> Fix would be to actually try to run getpwuid(with expected id) until
> it's found, but next GID for aosp is AID_SYSTEM 1000, thus it wouldn't scale.
> But it would work with aosp < 9 (not sure if anybody cares for old aosp).

I'm personally not worried about aosp < 9. As this will be an issue on 
Android if a test uses tst_get_gids() for more groups, I'll repurpose 
the bug I filed to work on that, if and when we can get time for it.

> 
> Back to tests which use SAFE_GETGRNAM_FALLBACK() (used in chmod07.c, fchmod02.c).
> With current implementation, it'd be possible to replace it with tst_get_gids().
> 
> Kind regards,
> Petr
> 
> [1] https://cs.android.com/android/platform/superproject/+/master:system/core/libcutils/include/private/android_filesystem_config.h;l=43?q=AID_

thanks,
Steve

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
