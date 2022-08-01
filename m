Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43080C00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05DE23C812E
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 16:35:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35BEF3C6D89
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:35:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 518A41000437
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:35:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 540EE4DF2B;
 Mon,  1 Aug 2022 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659364527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzPoVXo/eN+CAZh7akQYfwNVkaFgpFdO5btoRyxgKuc=;
 b=oxvwQsVV86evhqdrbe1wfblF/NDvZknI/hWJZnv/aKZhmw6ThzVcUAr/3umo6xo6L4ifLl
 XQBCUJkuOVeNh1BQV1J1WN0d69H3+H/mJFcM2KsMEiCKAwvqGpJEMqe0CxNQ5vQl7X4xjF
 DphGF4m68eYeINAkZ09s7EutQ1DEsno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659364527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzPoVXo/eN+CAZh7akQYfwNVkaFgpFdO5btoRyxgKuc=;
 b=Jo/vlhjlChb1ty5mI/zEaU15l8lguzcqE6fALs4WtsJN/LPS168d4bAZetaoqaYVwsqfD2
 sLL/Y1Id2gp5DXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2201F13AAE;
 Mon,  1 Aug 2022 14:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6e9oBq/k52IOXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 01 Aug 2022 14:35:27 +0000
Date: Mon, 1 Aug 2022 16:35:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YufkrU5Z1GCsBhcU@pevik>
References: <20220729153246.1213-1-pvorel@suse.cz>
 <YufMST1r0+ciz2c4@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YufMST1r0+ciz2c4@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] metaparse: Replace macro also in arrays
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > This helps to replace macros like:

> >     #define TEST_APP "userns06_capcheck"

> >     static const char *const resource_files[] = {
> > 	TEST_APP,
> > 	NULL,
> >     };

> > $ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ ../testcases/kernel/containers/userns/userns06.c
> > Before:
> >    "resource_files": [
> >      "TEST_APP"
> >     ],
> >     ...

> > After:
> >    "resource_files": [
> >      "userns06_capcheck"
> >     ],
> >     ...

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > This is a reaction on patch
> > https://patchwork.ozlabs.org/project/ltp/patch/20220722083529.209-1-chenhx.fnst@fujitsu.com/
> > First: I was wrong, inlining arrays does any change in the docparse output.
> > BTW I'd be still for inlining for better readability.

> > I'm not sure if this is not good idea, maybe some of the constants should be
> > kept unparsed, e.g.:

> > Orig:
> >    "caps": [
> >      "TST_CAP",
> >      "(",
> >      "TST_CAP_DROP",
> >      "CAP_SYS_RESOURCE",

> > Becomes:
> >    "caps": [
> >      "TST_CAP",
> >      "(",
> >      "TST_CAP_DROP",
> >      "24",

> > CAP_SYS_RESOURCE is replaced because it's a string, but IMHO it'd be better to keep it.
> > TST_CAP{_DROP,} aren't replaced because they aren't a plain strings.
> > Maybe replace only non-numerc values?

> That really depends on the context, we do have many cases where we have
> a macro that expands to numeric that should be expanded, runtime would
> be one of the prime examples of that.
Yep.

> I guess that the only solution would be an explicit list of macro
> prefixes that should not be expanded, e.g. do not expand if macro starts
> with "CAP_".

Good idea, thanks! I was thinking about rewrite parsing to sparse, but you would
not like it as being slow. This is indeed a better solution.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
