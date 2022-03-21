Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CE4C433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 15:27:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3AD03C788C
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 16:27:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E30E53C061B
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 16:27:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B0E410007AD
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 16:27:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 209EC210E2;
 Mon, 21 Mar 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647876420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMABLox8yap/biqNGDo9WicLI1luSQPbooereG+WCLI=;
 b=z6kJg8QomqHL0vcitucHE2787NgC7FwBonIAB9bzaM7xIHywoBf3Yb+8+OnLcbK4l7VToG
 h0Pucu/dah2aWk7tVA7sAH9yVjRESjhOiRhvfUc16l8lQIJkkvRnnLogagaYJh/G+NlFiQ
 q9w5T+E4SgYNHpzQmj6Og75z3SbMjAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647876420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMABLox8yap/biqNGDo9WicLI1luSQPbooereG+WCLI=;
 b=15TySS1u92lvtLcepUCPfti7gU2iImZtgi5zGZsrjnvm3LQFR9txmJXtR4urnAn3WzuuDD
 tXJk6ZiFS5xR0DDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF4CB133B6;
 Mon, 21 Mar 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o0PALkOZOGLKEwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 21 Mar 2022 15:26:59 +0000
Date: Mon, 21 Mar 2022 16:29:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YjiZzFPvjC+PcMyq@yuki>
References: <20220321133849.14924-1-chrubis@suse.cz> <87ils7corb.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ils7corb.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitid10: Fix when coredumps are piped
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
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> 
> BTW I thought that division by zero actually just resulted in zero or
> INT_MAX on some platforms? (e.g. ARM)
> 
> It's undefined behaviour, so I fail to see how this test has ever worked
> on some architectures. Perhaps we should dereference a null/invalid
> pointer instead?

That wouldn't work since we are trying to get SIGFPE not SIGSEGV.

See:

http://patchwork.ozlabs.org/project/ltp/patch/20220310105533.3012-1-chrubis@suse.cz/

Also if you can review this patch as well...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
