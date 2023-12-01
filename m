Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19EAC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 17:46:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3CC73CF63F
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 18:46:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F06373CD3FB
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 18:46:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 710F520111C
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 18:46:27 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6F1521C9A;
 Fri,  1 Dec 2023 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701452785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qY0808JwIUtbk1kMUjA4ca2dWTMMybH2kqanlZ7h/qM=;
 b=Cmmo4+f0ilyFDQxuD5IMBQZqe04edsgf4V/z47/EZvVPcQHr+0hpGqDxsE7ukwSy8uqowC
 d56Wv3UARkl2oC8t9wczhjnXiKGFYQq52U53Ra7is+B++ZJKFlVXAaNz93u2aRD85CLMQr
 Nfyj/N4othX15xusXbiZ8eiYT813ifU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701452785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qY0808JwIUtbk1kMUjA4ca2dWTMMybH2kqanlZ7h/qM=;
 b=+NSpgUHln73hNAaiLZVEPjW8Koe87CgJPkIcyA0zqTCu5Fx6EadSM9ILviFmwGQllnxDy9
 HUA0GDAwvap642Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B4613928;
 Fri,  1 Dec 2023 17:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id hwqAC/EbamWddQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 17:46:25 +0000
Date: Fri, 1 Dec 2023 18:46:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Wang, Xin" <Xin.Wang@windriver.com>
Message-ID: <20231201174623.GD2829815@pevik>
References: <20231018014915.1632280-1-Xin.Wang@windriver.com>
 <CO1PR11MB4979520F15EBFB02E28BD64C95DDA@CO1PR11MB4979.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4979520F15EBFB02E28BD64C95DDA@CO1PR11MB4979.namprd11.prod.outlook.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(3.00)[1.000];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[38.96%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xin,

> Hello,
> > Subject: [LTP][PATCH v2 1/1] enable fsx-linux.c running on VxWorks user space
> > and add measurement of execution time

Also, the subject suggests (and the code changes how I understand it), that
you're changing two things:
1) fixes for VxWorks 2) add measurement of execution time

If I'm correct, it would make sense to split changes into two commits.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
