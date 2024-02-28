Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61243C47DD9
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 13:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BB3C3D0347
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 14:28:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F4B93C86E2
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 14:27:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 510F4600F3C
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 14:27:57 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 188AE1F7BD;
 Wed, 28 Feb 2024 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709126875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0jhopSJdZFHXD9FaGbFY856aCCzzMLaoB22zg6LI2w=;
 b=wzDpw9M845iB25cl4v0OKDWTQgsnfCM2pMnpv+JhWDqitSlr/aoQgvlJWu6ILyT4ivncnA
 vWAz6PbHRsGPyuTw5jQjS0Glpq1aI5+5i6/EZlz5714wq92soN/s7g6aE71zhq02dXiY2D
 O7wcI4Qn2tWvTKGEo+Ym9Mln1fgIRew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709126875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0jhopSJdZFHXD9FaGbFY856aCCzzMLaoB22zg6LI2w=;
 b=BrXFeZDRA6XuMpEc+H5A/ifYCi2mQ8lx7xAux6JxThIQeGyXXX5CL4Lq5G/0oPqYQDmjG1
 5kYJugS48TcPbGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709126875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0jhopSJdZFHXD9FaGbFY856aCCzzMLaoB22zg6LI2w=;
 b=wzDpw9M845iB25cl4v0OKDWTQgsnfCM2pMnpv+JhWDqitSlr/aoQgvlJWu6ILyT4ivncnA
 vWAz6PbHRsGPyuTw5jQjS0Glpq1aI5+5i6/EZlz5714wq92soN/s7g6aE71zhq02dXiY2D
 O7wcI4Qn2tWvTKGEo+Ym9Mln1fgIRew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709126875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0jhopSJdZFHXD9FaGbFY856aCCzzMLaoB22zg6LI2w=;
 b=BrXFeZDRA6XuMpEc+H5A/ifYCi2mQ8lx7xAux6JxThIQeGyXXX5CL4Lq5G/0oPqYQDmjG1
 5kYJugS48TcPbGCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EEAF134FB;
 Wed, 28 Feb 2024 13:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id hdZgA9s032XhCAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 28 Feb 2024 13:27:55 +0000
Date: Wed, 28 Feb 2024 14:27:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240228132745.GA1602633@pevik>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
 <20240226135336.19733-6-xuyang2018.jy@fujitsu.com>
 <20240228072413.GB1581418@pevik>
 <965fe6c7-118f-4c76-b7f8-a83308cdd54c@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <965fe6c7-118f-4c76-b7f8-a83308cdd54c@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.66 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.04)[57.93%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 6/7] syscalls/swapon03: Simply this case
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

Hi Yang Xu,

> Hi Petr

> > Hi Yang Xu,

> >> By moving swapfile create stage from verify_swaopon and
> >> test EPERM error more accurate. Also use glibc wrapper by
> >> using swapon/swapoff instead of call syscall number directly
> >> because glibc/musl/binoic also support them since long time ago.
> > s/binoic/bionic/

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Thanks for your nice review. Sorry, when your review v4 patch, I don't 
> solve all comment in v5. So I did it in my own ltp fork branch named as 
> v5_max_swapfiles[1](such as swapfiles => swap file, snprint return 
> value, else branch....).

> ps: Only the 6th patch was modified, other patches aren't modified. If 
> you see no problem, I plan to merge this patchset today.

[2] looks good to me, please merge. Very nit (feel free to ignore):
snprintf(cmd_buffer, ...) is too long, renaming cmd_buffer just to buf would
shorten whole line.

Kind regards,
Petr

> [1]https://github.com/xuyang0410/ltp/commits/v5_max_swapfiles/

[2] https://github.com/xuyang0410/ltp/commit/9e83b1fb1d8f8631122c70a336aacd28f94d8343

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
