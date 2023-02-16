Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C679C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:32:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C0FB3CBECF
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:32:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 002313CB4A0
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:31:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A10F1400DE3
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:31:49 +0100 (CET)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64FBB3F4BA
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676543508;
 bh=JbEGWOhuLt3GD8t5TUaLCDEbE8LlbjCMsMPR+hwoyrk=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=qxy9QoPPooMEDn5MiF/Y7lGviXy9PXUlZ8GZemvsyfqCrbfGOBWrZyuNzwf2sAYV/
 ft+T1SVtZsvjoj6TztpXbT7ym+dM9TH0V6ACq8IU+Mwb9nseEHIjJ7MApP5N4JY/lH
 /nx5ot5NsqfOLKtp0argJsQaBApWGs7wgjhrh2nkig0oDSsb4k3/tRK0/qLK30OMCk
 bEgp3usUk/ZjDqZmpa7sWIHt885C7iQnQmQrweOmGXcb9uyQfEQ/3EmakPcSZtQePC
 LvkIdwU14zvMp+GsmSQicNWoc6cOit9LERoWpp2NTmuIjH7ORxZpgcLO7HnR1Neuoq
 cK1DfQAHiMPeQ==
Received: by mail-wm1-f71.google.com with SMTP id
 o42-20020a05600c512a00b003dc5341afbaso909445wms.7
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 02:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbEGWOhuLt3GD8t5TUaLCDEbE8LlbjCMsMPR+hwoyrk=;
 b=xsUayI2sCYKDyyWX6JG6m/2/hcq57PUI9cV1Ld5GOBBFTFmf0KNBiJDoWcyaNK//2l
 29Hx+y+ogbwTm455H9a/rSxq+Oihbzg1nqWceg6M09dxVIoOuihQF5WWZ5SW3u687a8B
 +oxTEyKXPCNqbOXtqARpi0ur6PhtASciEPH7u3nkkrgWhq+GmVwasaQ94XQ1NqAP3Qhs
 VhkjrMWT6GTJxeTUIQkTZWNZFyRT7FSpxPJ3WMpqeeeO/A9b6Fr7uwZTVdF01MdStnrz
 1H2sxHYdB+kAWL7o9VcCfLqn+Psx4ryC0ypHS7ERcO34KKqrJk6Vcer17VJp5Ld+eLv7
 PjIw==
X-Gm-Message-State: AO0yUKX4siDXx7SP04OByz+eeApvFBK80X0Rb/Sxd1UApGQ76M5zyHX7
 hMpvC13YrDjd5o0DR2yv6rir+pY6FBNKMnXY1R78gKAltORevhCCy5j1R0sM6UNHtLm77U4fTAP
 v4+cM1xvEbAevjSe2/sUCoA/ALU22uE4nnooPmtg=
X-Received: by 2002:a5d:4ecc:0:b0:2c5:54a7:3646 with SMTP id
 s12-20020a5d4ecc000000b002c554a73646mr4035050wrv.5.1676543507725; 
 Thu, 16 Feb 2023 02:31:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/el8fD9JYkc+X3EYopxzu2Sh+XZMpwBkCowoX5PTJTmMCHaR67R05r+G6hZUlhZxQ9BqT59g==
X-Received: by 2002:a5d:4ecc:0:b0:2c5:54a7:3646 with SMTP id
 s12-20020a5d4ecc000000b002c554a73646mr4035033wrv.5.1676543507446; 
 Thu, 16 Feb 2023 02:31:47 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 s5-20020adfeb05000000b002c54c0a5aa9sm1127256wrn.74.2023.02.16.02.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 02:31:47 -0800 (PST)
Date: Thu, 16 Feb 2023 10:31:45 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+4GEbRopmw5QA5r@qwirkle>
References: <Y+zcqqNE01cNcm1Y@qwirkle>
 <Y+38qMc2Kdh2DPA7@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+38qMc2Kdh2DPA7@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP fs_fill test on vfat - ENOSPC
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi. Thanks for your feedback.

On 23/02/16 10:51AM, Cyril Hrubis wrote:
> Hi!
> > There a couple of ways to deal with this:
> > 
> > 1. Force the filesystem creation in FAT32. This would be the best way
> > forward in my opinion, but I can't see anything that supports doing so on
> > a per-filesystem basis in LTP.
> > 2. Increase the minimal numbers of entries available in the root
> > directory via "-r ROOT-DIR-ENTRIES"[1]. This would only push the crash
> > on fewer systems.
> > 3. Use a subdirectory in the test setup. Something like /subdir/threadX.
> > If I'm not missing any support to do 1, this would probably be the
> > easiest to do.
> > 
> > I'm happy to go forward with a PR to fix this properly but looking
> > forward to your feedback on how to steer this.
> 
> For number 1 we could probably add a special case in the test library,
> something as (beware untested):
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 736324f04..0e6e9ebd1 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -50,6 +50,9 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
>                 return;
>         }
> 
> +       if (!strcmp(fs_type, "vfat"))
> +               argv[pos++] = "-F 32";
> +
>         snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
> 
>         if (fs_opts) {

I did consider this as well, but I haven't proposed it initially because
I didn't want to come with a solution that will switch all tests to
Fat32. This is a limitation for tests that create a large enough number
of directories in the root of the filesystem, so I wanted to keep the
scope there.

I have tested, and we will locally go with my proposed 3rd option for
now. Does that sound resonable for a push to upstrem too? 

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
