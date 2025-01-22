Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E21BC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 20:50:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6768C3C311A
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 21:50:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F183C3C2BB9
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 21:50:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79E812264AF
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 21:50:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F5C321164;
 Wed, 22 Jan 2025 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737579026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwgkmyAT9oEdwIPAae6/v0wBGyPrDPHRZU9ZpJ/WIOg=;
 b=e/xR1WybonY224cCVT9XGKpngVLKszACE7JkTTpx0TSaodEos2d5H9HCjYp1fPhP/1D8Vc
 +7iThIkOStGhJzHqv6TnKaYxxiX+WuJKiBNEidhVAJq/vwKHtzVeyry+Z80nnmcVBrZ/tL
 b7R764m39CaU+kvr1IyszOQ2xmEEdUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737579026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwgkmyAT9oEdwIPAae6/v0wBGyPrDPHRZU9ZpJ/WIOg=;
 b=GkegdX+bAf+QDYLNLADQUKOQzU0g18QiKR5Q7cCEzOkAnwR6mQAVu8U0Cv13Z38hZnWHyK
 JU3WjOoDjKy0kICw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="e/xR1Wyb";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GkegdX+b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737579026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwgkmyAT9oEdwIPAae6/v0wBGyPrDPHRZU9ZpJ/WIOg=;
 b=e/xR1WybonY224cCVT9XGKpngVLKszACE7JkTTpx0TSaodEos2d5H9HCjYp1fPhP/1D8Vc
 +7iThIkOStGhJzHqv6TnKaYxxiX+WuJKiBNEidhVAJq/vwKHtzVeyry+Z80nnmcVBrZ/tL
 b7R764m39CaU+kvr1IyszOQ2xmEEdUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737579026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwgkmyAT9oEdwIPAae6/v0wBGyPrDPHRZU9ZpJ/WIOg=;
 b=GkegdX+bAf+QDYLNLADQUKOQzU0g18QiKR5Q7cCEzOkAnwR6mQAVu8U0Cv13Z38hZnWHyK
 JU3WjOoDjKy0kICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF53136A1;
 Wed, 22 Jan 2025 20:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jTtsDhFakWdzeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Jan 2025 20:50:25 +0000
Date: Wed, 22 Jan 2025 21:50:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250122205023.GA48906@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 1F5C321164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.70 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.961]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> Hi all,

> Following tests for fanotify code in v6.13.

> 1. The new test case in fanotify13 fails as follows on kernels v6.6..v6.12:

> fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)
> fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)
> fanotify13.c:282: TFAIL: handle_bytes (180003) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)

> The fix was already backported to v6.12.10.
> It was also backported to v6.6.72,
> but then reverted due to a backport bug in v6.6.73
> and it now staged again for v6.6.74.


> 2. The new variant of fanotify21 is skipped on kernels <= v6.12

> This variant tests the new feature flag FAN_REPORT_FD_ERROR, which is
> not effectively a bug fix.

> Because this feature was added as a consequence of a bug report,
> it was auto backported to v6.12.5 and to v6.6.66, but I do not
> feel comfortable with adding a fix tag to force distros to backport
> this feature.

We have git freeze before new release. But IMHO this should go in.
It works well on v6.13, I'll retest it on SLES kernels.

Kind regards,
Petr

> Thanks,
> Amir.

> Amir Goldstein (5):
>   fanotify13: Verify that we did not get an extra event
>   fanotify13: Add test case for FAN_DELETE_SELF
>   fanotify05: Test reporting overflow event with FAN_REPORT_FD_ERROR
>   fanotify21: Test reporting event with RDWR fd on RO mount
>   fanotify21: Test reporting fd open errors with FAN_REPORT_FD_ERROR

>  include/lapi/fanotify.h                       |  4 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |  1 +
>  .../kernel/syscalls/fanotify/fanotify05.c     | 18 +++-
>  .../kernel/syscalls/fanotify/fanotify13.c     | 90 ++++++++++++++++---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 89 ++++++++++++++++--
>  5 files changed, 177 insertions(+), 25 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
