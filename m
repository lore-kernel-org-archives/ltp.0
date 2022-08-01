Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C1C00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 12:49:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A260D3C919E
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:49:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DE4C3C8216
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 14:49:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8015F1A004FE
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 14:49:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA76366EC7;
 Mon,  1 Aug 2022 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659358174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mnHx9LdVMN40M4C4fKnP1Xs/r6uMgKwM2C2/VuU/yk=;
 b=TF5xp3nB2WY56fOeaCb1hGtQXvsU+jl3maABxJ364YubNKsepHhMAvxmB6ZzJhvN+fnPeN
 ia0TCXR149YojoAX5msy+y99/olMT+AmaK+HE8MJIETe4iP9Pyyhl6DvLFczp8nMeU4eNC
 bQc4RTVCbfdIWAG+Mem14d/YaJr21pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659358174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mnHx9LdVMN40M4C4fKnP1Xs/r6uMgKwM2C2/VuU/yk=;
 b=6jD9TGBQwvXt/is39ycStrmb5V382Qa3rley0GZT0jiB9b0WuBQE7SYDcfiHlBg4beRPHW
 Sb8l7GmwLGDRH+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B02F913A72;
 Mon,  1 Aug 2022 12:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S4qDKd7L52I5KgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 01 Aug 2022 12:49:34 +0000
Date: Mon, 1 Aug 2022 14:51:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YufMST1r0+ciz2c4@yuki>
References: <20220729153246.1213-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220729153246.1213-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This helps to replace macros like:
> 
>     #define TEST_APP "userns06_capcheck"
> 
>     static const char *const resource_files[] = {
> 	TEST_APP,
> 	NULL,
>     };
> 
> $ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ ../testcases/kernel/containers/userns/userns06.c
> Before:
>    "resource_files": [
>      "TEST_APP"
>     ],
>     ...
> 
> After:
>    "resource_files": [
>      "userns06_capcheck"
>     ],
>     ...
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> This is a reaction on patch
> https://patchwork.ozlabs.org/project/ltp/patch/20220722083529.209-1-chenhx.fnst@fujitsu.com/
> First: I was wrong, inlining arrays does any change in the docparse output.
> BTW I'd be still for inlining for better readability.
> 
> I'm not sure if this is not good idea, maybe some of the constants should be
> kept unparsed, e.g.:
> 
> Orig:
>    "caps": [
>      "TST_CAP",
>      "(",
>      "TST_CAP_DROP",
>      "CAP_SYS_RESOURCE",
> 
> Becomes:
>    "caps": [
>      "TST_CAP",
>      "(",
>      "TST_CAP_DROP",
>      "24",
> 
> CAP_SYS_RESOURCE is replaced because it's a string, but IMHO it'd be better to keep it.
> TST_CAP{_DROP,} aren't replaced because they aren't a plain strings.
> Maybe replace only non-numerc values?

That really depends on the context, we do have many cases where we have
a macro that expands to numeric that should be expanded, runtime would
be one of the prime examples of that.

I guess that the only solution would be an explicit list of macro
prefixes that should not be expanded, e.g. do not expand if macro starts
with "CAP_".

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
