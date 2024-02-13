Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6989C48260
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 16:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4702F3C06AE
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 17:09:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFE3A3C06AE
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 17:08:51 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EB1B600682
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 17:08:50 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FFF021C42;
 Tue, 13 Feb 2024 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707840529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeD51mmGVJJXE9i+jj0ZQCTe5/Coti2XnnOF89MdKxU=;
 b=msRrpx3GwVSJphYei++U43J3rGmUlWIJEZkMt4Hyw//2MN32QlRc+qsbn+XiYJA0ue4IAb
 bkVilru4EWaIX0CK7ENz2uuvszIlbhvWqqi1Pp+uSpEFgenELKm8yt01ozdskfgoBgj1nH
 cXEoXf/MfNcX5CSRGJnevtWuJ/+KKoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707840529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeD51mmGVJJXE9i+jj0ZQCTe5/Coti2XnnOF89MdKxU=;
 b=nM+Ska0RAJCmt732KeAkuBNa6Gh5Qd+sxllwsXY6us+/JYiqkTVFgnHv6MTJHhui6otcVs
 +8s5wTqSnv427mCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707840529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeD51mmGVJJXE9i+jj0ZQCTe5/Coti2XnnOF89MdKxU=;
 b=msRrpx3GwVSJphYei++U43J3rGmUlWIJEZkMt4Hyw//2MN32QlRc+qsbn+XiYJA0ue4IAb
 bkVilru4EWaIX0CK7ENz2uuvszIlbhvWqqi1Pp+uSpEFgenELKm8yt01ozdskfgoBgj1nH
 cXEoXf/MfNcX5CSRGJnevtWuJ/+KKoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707840529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeD51mmGVJJXE9i+jj0ZQCTe5/Coti2XnnOF89MdKxU=;
 b=nM+Ska0RAJCmt732KeAkuBNa6Gh5Qd+sxllwsXY6us+/JYiqkTVFgnHv6MTJHhui6otcVs
 +8s5wTqSnv427mCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 28EDE1329E;
 Tue, 13 Feb 2024 16:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KaL0AhGUy2WXBgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 13 Feb 2024 16:08:49 +0000
Date: Tue, 13 Feb 2024 17:08:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240213160847.GA695961@pevik>
References: <20240209102244.24835-1-andrea.cervesato@suse.de>
 <20240209212758.GA351028@pevik>
 <4109ebbf-ed71-47bd-ba46-ba72d5739858@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4109ebbf-ed71-47bd-ba46-ba72d5739858@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.52 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.22)[72.22%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor mount01 test using new LTP API
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> On 09. 02. 24 22:27, Petr Vorel wrote:
> > Merged also with Martin's RBT.

> Please do *NOT* add patch review tags which I didn't send myself. Thank you.

I'm sorry, I will not do in the future.

The reason I added it was that you obviously spent time reviewing previous
version and I did not want you to credit your work, but I agree this is not a
approach.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
