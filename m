Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F3C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:44:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831423CCBA8
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:44:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0F943CCB7C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:44:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6CEE66002DF
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:44:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6008D21D63;
 Wed, 25 Oct 2023 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698219880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNVMwszLGXxTU5s2RFxLQQ2ySzQ+o5AiWhCg9rlhhfM=;
 b=MfkJJ/OBpkzkB2cg4/Y+TnicKIsWrLls8IKp2qBglqDWSqg1sGXJwP6EMhCTv/v2Ho20yE
 hVXrPHBnY78w0F2O133hw9Hsjck9u6b8jaKJzqSPUKmDf/Ttus/Fe8isvCycEpbw6znTJT
 qV9/sN2KPHRP++Hzb7qgfjmWxlzFvJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698219880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNVMwszLGXxTU5s2RFxLQQ2ySzQ+o5AiWhCg9rlhhfM=;
 b=k4I+aIurZexq/lC8MzU8h2iHAoLaonAD7NxyRr6pOeg72QvWMBabjItm/OagrUBynh8h71
 Bl5cZbGz9wh/GpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15383138E9;
 Wed, 25 Oct 2023 07:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g00rA2jHOGVWZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 07:44:40 +0000
Date: Wed, 25 Oct 2023 09:44:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20231025074438.GA291692@pevik>
References: <20231018015016.1897021-1-edliaw@google.com>
 <20231024231429.GA282313@pevik>
 <CAG4es9XP8UWtR6Z4jx+Oe1H4FoL=Rb1PFkShctBsC2Jkp7kg0g@mail.gmail.com>
 <CAG4es9WSzgHp3iLmzf1zfWTE5-8+6BnvhZ08SFZaT_Y8550gJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9WSzgHp3iLmzf1zfWTE5-8+6BnvhZ08SFZaT_Y8550gJA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.32 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.02)[95.15%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp: Handle larger kernel version numbers
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

...
> >> I wonder why you need this change. Number > 256 is actually only the third
> >> number, but we haven't checked that so far. Do you plan to use it actually?


> > It was causing the minor rev of the kernel I was running to overflow into the major rev, so a test that had a min kver of 4.19 was running and failing on a 4.14.327 kernel.

> I remembered it incorrectly.  It was the mmap20 test with min_kver
> 4.15 that was failing on a 4.14.327 kernel.

Good to know, thank for info. It will be merged during this week,
once we solve CI issue (should be fairly soon).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
