Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5052EE4993
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 13:52:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3D1B3CC677
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9320F3C98FC
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:52:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D77EF600D6C
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:52:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFA0B2085D;
 Wed, 23 Aug 2023 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692798740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O++xvooO1ZZSUC+dq1pF60iXvny6jPilHlWzHnr9X9w=;
 b=sUqDteh2fsLzgaXVc2oKpLvUfF+ywarW1ZRdHHharwPVKG3L4E5UxcSxk7JuqHkaJ0re6B
 /Ej3ZbmjIOWEgjp9jwdKqobXitpb6sm9Qv0L5orhkjz+9tmd5HL2UgTfOwzIypxzlSOICI
 oZhZYBJw9yph3Nvdza+0NGi3KgRCNXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692798740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O++xvooO1ZZSUC+dq1pF60iXvny6jPilHlWzHnr9X9w=;
 b=uQmCK4XcXvD59W+MC2w2jiVhQBQJy+YNMkA3aTQr7HWzIK9Z2R3IgYB7zKsvhXa6ccS2J6
 vX2GeG691HjdzdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90C8B13458;
 Wed, 23 Aug 2023 13:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bgRSIxQP5mTNegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Aug 2023 13:52:20 +0000
Date: Wed, 23 Aug 2023 15:52:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: iob <ybonatakis@suse.com>
Message-ID: <ZOYPNYnSqc2geOmR@yuki>
References: <20230822101333.16993-1-rpalethorpe@suse.com>
 <ZOXZarakyIoZeqQ-@yuki> <87pm3deutt.fsf@anais.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pm3deutt.fsf@anais.suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add goals of patch review and tips
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +The following are examples and may not be appropriate for all tests.
> >> +
> >> +* Merge the patch. It should apply cleanly to master.
> 
> As a newbie with LTP I am still struggling to understand some things
> like this one. How is possible to merge to master in order to review?

Obviously you do that to your local git tree. This is basics of git
development nothing specific to LTP here.

> >> +## How to get patches merged
> 
> Again from my POV the description is more about what you should do as a
> reviewer than how to get a patch merged.

Isn't that the same? If you know what are developers doing in order to
catch common mistakes you can as well avoid doing them...

> >> +Once you think a patch is good enough you should add your Reviewed-by
> >> +and/or Tested-by tags. This means you will get some credit for getting
> >> +the patch merged. Also some blame if there are problems.
> >> +
> >> +If you ran the test you can add the Tested-by tag. If you read the
> >> +code or used static analysis tools on it, you can add the Reviewed-by
> >> +tag.
> >> +
> >> +In addition you can expect others to review your patches and add their
> >> +tags. This will speed up the process of getting your patches merged.
> >> +
> >> +## Maintainers Checklist
> >
> > Looks very nice, thanks for writing this out.
> >
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> >
> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> I feel that this is more an overview and reminder of already
> contributors. Not sure how helpful is it for new comers like myself

I think that there are different levels of newcommers. I do not think
that the documment is supposed to help newcommers that are already
familiar with how git based development works and only highlights
things that are specific to LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
