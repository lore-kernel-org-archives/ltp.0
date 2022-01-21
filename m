Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5692C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:38:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D11843C96E6
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:38:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 188183C922E
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:38:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AAAA0600D52
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:38:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F014D218E3;
 Fri, 21 Jan 2022 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642761514;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75uzvvOI/8+yl9f+TQ4s9qbHJn9e2SYsY5c+lYLcVw8=;
 b=1PYkvpdIkzGfsTivCTJslANQryo2Fv+6tbMe78aiLUtAfrUWBzJHan3PjSfgLl1rZ0U910
 Vb8P2OtTcMzM3hle4/dZXQNG8bRzZL5uPO3+p96vrAcxMfSgRIre3oAGaG38efbqaensg2
 mg7YOPS3NEkOzbhmfY5t1Ubo9uuyYjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642761514;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75uzvvOI/8+yl9f+TQ4s9qbHJn9e2SYsY5c+lYLcVw8=;
 b=YRzaE9dyu4iriuPFM93tlaMtXICwNPHi1bvCDAH8qOpDViiFe6ShAnmzRuS27Ot8A4gbTb
 NZ0L48IIcTlXVaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFB8313CFE;
 Fri, 21 Jan 2022 10:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /Ag9LSqN6mFhcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 10:38:34 +0000
Date: Fri, 21 Jan 2022 11:38:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YeqNKQghWJgna70b@pevik>
References: <20220121100604.1072-1-pvorel@suse.cz>
 <07fa4901-8384-bfb3-fcc8-eb408b120f5c@suse.com>
 <YeqMqtK0BziwRuNm@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeqMqtK0BziwRuNm@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

> Hi!
> > SAFE_MUNMAP should be called always, even if *run_child == 0 (which happens if run() completed successfully).

> This is actually if (run_child) not if (*run_child) and it fixes the
> case where the test is skipped even before the run_child has been
> mmaped.
Yes, that's needed for tmpfs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
