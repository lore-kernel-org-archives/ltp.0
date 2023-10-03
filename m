Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BE0E75435
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 08:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05ADD3CDCCE
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 10:54:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32EC73CD0AB
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 10:53:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 455641A00E0B
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 10:53:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED6961F891;
 Tue,  3 Oct 2023 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696323235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqU03JScy/6NgnIjeCLAKwuArpwotQEgUrAdxcDxERY=;
 b=nYoYjh4rReYGdBiG3KrHfBgCHg/6hNwaiuz1xSr3LCWJ5PG8qtxUhqvAodN0CHMt+VyCO0
 RTQKG+1hA5dR5wUV8tWsw5wxpsQHvaHy4HbKbEr+zauREJorfNf7PAhj83jFyYG9lnmYEM
 p5GyCMz7D//dPhivvBYoCmgaAKZUOyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696323235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqU03JScy/6NgnIjeCLAKwuArpwotQEgUrAdxcDxERY=;
 b=/YopUKesUs7xYowezs8qbG09X8zUZzpIVknxbxFpRTX+m3OnnKOvGKZu2S+3qEMrB0zGkw
 n1lgUR/xjNqbJpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9589139F9;
 Tue,  3 Oct 2023 08:53:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v/4FNKPWG2XOPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 Oct 2023 08:53:55 +0000
Date: Tue, 3 Oct 2023 10:54:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZRvWzv6evdbq8H2H@yuki>
References: <20230901144433.2526-1-chrubis@suse.cz> <87cyxx2tna.fsf@suse.de>
 <ZRqk47qqtquBw3XQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRqk47qqtquBw3XQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hmm, so I guess that with LSM we are able to open these files R/W but we
> can stil get EPERM from the write() right? I'm reluctant to add wildcard
> TCONF on any errno, but I guess that we can add a TST_EXP_FAIL macro
> version that would have one errno for PASS and one errno for TCONF.

I was thinking about this yesterday and maybe best solution would be to
introduce a global switch (env variable) that would switch the
TST_EXP_FAIL() macros to a more forgiving mode so that EINVAL and EPERM
and possibly a few more errnos would be converted into TCONF
automatically. What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
