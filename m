Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F1CC433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 15:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6165F3CA60B
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 17:25:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDECB3CA2C5
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:25:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68AA960094C
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:25:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 843D0210E1;
 Thu, 14 Apr 2022 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649949938;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+FTCcPsAE3HvXLERE+cYgSsamwGVvE5TNRfIIds0QI=;
 b=q+QT4KSGCKh8t8IZR6KzdKhYYDXeXGYWgdHESEa4R1bbEOCG+znSqPzA+XWhDBMlpxopAi
 oQ/zY9CeT/d6T+fSbY/HAHV4J/8WdzYF3wDqDGwgicOhll6b2sn+MC8m/52ZDzA2+7fUdf
 lmm/VeQ0536MSIhyH6xu8/6LlA1CMYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649949938;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+FTCcPsAE3HvXLERE+cYgSsamwGVvE5TNRfIIds0QI=;
 b=v3c4Zszgpz5AKzZXmPvAyUOOwOA+Q0NmmVbLPYKGUQ57/E4i6YTNEx1lidkeH9G1++e2Ub
 uOpzWthW/emn6yCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58BB0132C0;
 Thu, 14 Apr 2022 15:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CTQiFPI8WGJ5cQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Apr 2022 15:25:38 +0000
Date: Thu, 14 Apr 2022 17:25:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ylg88D+B5FnMQjCl@pevik>
References: <20220413112405.48471-1-zhaogongyi@huawei.com>
 <Ylgkw1ZVsvgKWQXL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ylgkw1ZVsvgKWQXL@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv01: Correct assign and add cleanup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao, Cyril,

> Hi!
> > +static void cleanup(void)
> > +{
> > +	if (futex != NULL)
> > +		free(futex);

> free(NULL) is no-op, there is no reason to check for NULL before passing
> a pointer to free().

> The rest of the changes looks good to me.

Removed if check before free(futex) and merged with Cyril's Reviewed-by: tag.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
