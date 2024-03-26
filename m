Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B780EC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 08:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 149DF3CF037
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 09:26:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C413CE527
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 09:26:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B15951000A6E
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 09:26:40 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99C905CAB4;
 Tue, 26 Mar 2024 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711441599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Wtl67Q778dUSCCBnLkbm/q8BStlgxnQkaaXkorKfGU=;
 b=IYKdcxIffgBYXVS9gMHWxtJg+PzCd+yTU4ybAA2Fyq4OvqzSaFpaorCJjbtsgaDBGLmyiJ
 lFl0J73J/RjziSnfWuLZakAPgj9ACfuwkAttzaPGaZX0qRoMMo4FdJQeiw2Zbk02Sh4xBx
 tFoXuQabocjmwVm0ga6AFtIAwCY29uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711441599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Wtl67Q778dUSCCBnLkbm/q8BStlgxnQkaaXkorKfGU=;
 b=/lH/AKeQ/a5aObR0lT2OTkphNPvA80j67dxJcjnaY8nocZSrOvII5UTktvHLHj3oViqHaG
 dRygkeRF9s9ZsxBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711441599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Wtl67Q778dUSCCBnLkbm/q8BStlgxnQkaaXkorKfGU=;
 b=IYKdcxIffgBYXVS9gMHWxtJg+PzCd+yTU4ybAA2Fyq4OvqzSaFpaorCJjbtsgaDBGLmyiJ
 lFl0J73J/RjziSnfWuLZakAPgj9ACfuwkAttzaPGaZX0qRoMMo4FdJQeiw2Zbk02Sh4xBx
 tFoXuQabocjmwVm0ga6AFtIAwCY29uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711441599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Wtl67Q778dUSCCBnLkbm/q8BStlgxnQkaaXkorKfGU=;
 b=/lH/AKeQ/a5aObR0lT2OTkphNPvA80j67dxJcjnaY8nocZSrOvII5UTktvHLHj3oViqHaG
 dRygkeRF9s9ZsxBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4624D13215;
 Tue, 26 Mar 2024 08:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id zDMsDL+GAmaGdgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 08:26:39 +0000
Date: Tue, 26 Mar 2024 09:26:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240326082629.GA684723@pevik>
References: <fd34e495-75cd-4db2-bbf6-975f3697cd51@suse.com>
 <36d410f8-1946-4a0f-8c30-9810994954ed@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <36d410f8-1946-4a0f-8c30-9810994954ed@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[49.10%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 4th of April 09:00 UTC
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

Hi all,

> Hi all!

> Possible discussions for the meeting:
> - current project status
> - new LTP documentation website
> - API documentation

+1

> Please, feel free to add more topics :-)


> On 3/26/24 08:53, Andrea Cervesato wrote:
> > Hello everyone,

> > this is a friendly reminder for the LTP mailing list about monthly
> > meeting.
> > As previously discussed.

> > Next meeting will be on the 4th of April 09:00 UTC.
> > Platform: https://meet.google.com/jon-gytf-uei

FYI the meeting is not on Wednesday (as usually), but on Thursday
(Andrea does not have time on Wednesday). Hope it's ok for you.

Kind regards,
Petr

> > Thank you,
> > Andrea

> Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
