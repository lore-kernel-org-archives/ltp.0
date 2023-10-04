Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5913BE7B5E1
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 09:46:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC5C3CDB5E
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 11:46:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47E663CB94B
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 11:46:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7006B600159
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 11:46:30 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D019B1F45B
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696412788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7OlovN0p8uAuU397VcuX8SPocn3dbhqFXBPBJYeLFw=;
 b=O+HNG52BQ2sTDe4mh2FPUvc/uwJojdjME1v4MSV7cjPPYXgN0yn6zxMDSxow9h0cnpI/MA
 PRlNuO9kfKLEBsc7UYELFtYSb6YeUNxSnJkukY6ln1ToWQWjyjD0OcP9H0XwHQzb0/QrSm
 TY7rPtvGa+M3UubzgHY6Euq1N6+VOak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696412788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7OlovN0p8uAuU397VcuX8SPocn3dbhqFXBPBJYeLFw=;
 b=4idarNLrN9yQXzwM+Mqa97TOPmFA/3VHb+AbYN70SJaCSa5QxKV7zb8XnzabDm5fFBR+jl
 3/29kITjJPvGJrDA==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 772A02C142;
 Wed,  4 Oct 2023 09:46:28 +0000 (UTC)
References: <20230901144433.2526-1-chrubis@suse.cz> <87cyxx2tna.fsf@suse.de>
 <ZRqk47qqtquBw3XQ@yuki> <ZRvWzv6evdbq8H2H@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 04 Oct 2023 10:22:05 +0100
Organization: Linux Private Site
In-reply-to: <ZRvWzv6evdbq8H2H@yuki>
Message-ID: <87zg0y200c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched: add sched sysctl sanity test
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Hmm, so I guess that with LSM we are able to open these files R/W but we
>> can stil get EPERM from the write() right? I'm reluctant to add wildcard
>> TCONF on any errno, but I guess that we can add a TST_EXP_FAIL macro
>> version that would have one errno for PASS and one errno for TCONF.
>
> I was thinking about this yesterday and maybe best solution would be to
> introduce a global switch (env variable) that would switch the
> TST_EXP_FAIL() macros to a more forgiving mode so that EINVAL and EPERM
> and possibly a few more errnos would be converted into TCONF
> automatically. What do you think?

It sounds reasonable, I think it would also make sense to have an option
to allow any value in the full errno range.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
