Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63049CE7B1F
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:32:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4BB83CE113
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 11:32:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B476F3C99D6
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:32:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC75460077D
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:32:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4CB4B21845
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695979919;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xyJz+vcZWen9xsHt2shcNu/7GgV5BQndPdvQzCzLbY=;
 b=iBGSIMFNfw+oQ1TKAifU8U6UkByX9IO0ZjGUN/CHWsCE3ZAOzgBzKahQKLBfBCAsFwd8PL
 WvGvVPj+0urATjGhWq/M5UEfqGJjhpXhl80Hus20n7RJ9rtyNrrS73XiT3o1L9mCpkeXin
 NekDeXYgZX5vDdfQntKymF5VWfjp4d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695979919;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xyJz+vcZWen9xsHt2shcNu/7GgV5BQndPdvQzCzLbY=;
 b=KS058PteJH6qDSN0RluByOQZ7ewRDA83XwfVBgQ0PBZzXEiMemghm8BQLBv32pm5EQRj3b
 rScoiY1zJw4bqpDg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E43852C142;
 Fri, 29 Sep 2023 09:31:58 +0000 (UTC)
References: <20230928104458.12115-1-rpalethorpe@suse.com>
 <20230928181124.GA309263@pevik> <87h6nde7hu.fsf@suse.de>
 <20230929081521.GA351787@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Sep 2023 10:15:04 +0100
Organization: Linux Private Site
In-reply-to: <20230929081521.GA351787@pevik>
Message-ID: <87cyy1e35e.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add simple Containerfile
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> >> RFC comments:
>> >>     * Add git clean -fdX which should remove any build artifacts
>> >>       this is different from the suggestion of just doing a check. I just
>> >>       found it easier to remove the build files.
>> > FYI what we do in release scripts, is to do a local clone to a different
>> > directory [2]:
>> > git clone ltp ltp-full-YYYYMMDD
>
>> > Not sure what is faster.
>
>> I guess that is something a script could also do then 'git clean'
>> becomes a null op. git clean -X will only remove untracked files so
>> pending changes should get picked up. Which is probably what people want
> "remove untracked files" - if you develop a new test, forget to add it with 'git
> add' and run the container, you will get disappointed :).

Possibly it is only files that are not tracked due to .gitignore. At
least that is how I interpret the Git help. Either way it's not such a
concern due to the below.

>
>> during development. Doing a fresh checkout is probably more like a hard
>> reset and clean.
>
> The benefit is that you have not only a clean git repo for the container,
> but also not touching your working copy directory. But unless nobody else
> raise any concern, I'm ok with your current proposal.

Ah I think I see your concern now. It does not touch the directory
outside the container. It copies everything in first (IDK if it actually
copies the data if you are doing a local build).

Note that I tried using a .dockerignore to stop build artifacts being
copied, but it's not as rich as the .gitignore(s) we have sprinkled
throughout the LTP.

>
>> AFAICT git clean is very quick, far faster than 'make distclean'.
>
>
>> >>     * Added seperate alpine and tumbleweed runtime scripts. Again it's
>> >>       different from the suggestion just because it's easier to add
>> >>       seperate scripts than adding a switch
>> > +1
>
>> > But maybe put it into container directory, because it's not used in
>> > GitHub CI?
>
>> I was thinking it could be used in CI. All we need is a CI that runs VMs
>> and we can do some testing. (e.g. srchut).
>
> Makes sense. Also, having scripts on two directories can lead to confusion,
> let's keep it in ci directory.
>
> ...
>> >> +#!/bin/sh -eux
>> > nit: out of curiosity, why -u (fail unset variables and parameters)?
>
>> I find it finds errors in shell scripts or when using them. E.g. typo's
>> in env variable names. I just include it wherever possible.
>
> +1, maybe we should add it to the current ci scripts as well (+ use params
> instead of setting it via set command, it should work in dash and busybox shell
> as well).

Yeah, I think it should be the default.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
