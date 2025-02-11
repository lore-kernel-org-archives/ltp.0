Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73472C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:59:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D40EE3C999E
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 22:59:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D170F3C9972
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:59:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B38EC2082A8
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:59:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AE971F7DC;
 Tue, 11 Feb 2025 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739311159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iXPjmdes7bJPphV2c3XazbznN5Evq0vg9FE2SRoWiw=;
 b=1GPibZDWuKkmAhew4H5cydOQ2wFH5ER5R1Qzk1xYi4wlC/5gnUFd6unT+ypsTr8OfyNV7Q
 /vE5fNmvjBHY0XGzMt0QA/bYe2m9HcoG+Ujtt4YZP64UO1z7z5aIsI0TNdzEyS2TH4nHfs
 z+ca50X5t+P8GhCgXoZRr/DEkGeqlqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739311159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iXPjmdes7bJPphV2c3XazbznN5Evq0vg9FE2SRoWiw=;
 b=FhwoMKVCHmCEhVETc9SB1+vEr/fv0fAx5I4IWsbiQUImyjpu1HGAwBsux9RsC6bJ2Az1e7
 S3/qp7ng4vqIfVBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1GPibZDW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FhwoMKVC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739311159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iXPjmdes7bJPphV2c3XazbznN5Evq0vg9FE2SRoWiw=;
 b=1GPibZDWuKkmAhew4H5cydOQ2wFH5ER5R1Qzk1xYi4wlC/5gnUFd6unT+ypsTr8OfyNV7Q
 /vE5fNmvjBHY0XGzMt0QA/bYe2m9HcoG+Ujtt4YZP64UO1z7z5aIsI0TNdzEyS2TH4nHfs
 z+ca50X5t+P8GhCgXoZRr/DEkGeqlqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739311159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iXPjmdes7bJPphV2c3XazbznN5Evq0vg9FE2SRoWiw=;
 b=FhwoMKVCHmCEhVETc9SB1+vEr/fv0fAx5I4IWsbiQUImyjpu1HGAwBsux9RsC6bJ2Az1e7
 S3/qp7ng4vqIfVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B1AC13715;
 Tue, 11 Feb 2025 21:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KuetEjfIq2d8XAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 21:59:19 +0000
Date: Tue, 11 Feb 2025 22:59:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20250211215917.GA1954123@pevik>
References: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
X-Rspamd-Queue-Id: 9AE971F7DC
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] semctl08: Convert docs to docparse
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

Hi Ma, Andrea,

> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * Description:
>   * Cross verify the _high fields being set to 0 by the kernel.

@Ma merged, thank you!

@Andrea: I merged this and msgctl05 change even we are discussing [Description].
Because /*\ is good to be added and if we agree on the conversion it will need
to be scripted on whole tree.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
