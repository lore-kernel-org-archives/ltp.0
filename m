Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24ACC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 08:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BC543D0323
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 10:37:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 773693CE955
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 10:37:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6E0D1A0154F
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 10:37:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B459E20879;
 Fri, 26 Apr 2024 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714120640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V5YziJG+M5ukxat6ZAftnfDSYEnKXTzYzEmKKZq5d+Y=;
 b=uMBMVG1W6I56pcWR1qGIAAMAuXmUxIZh1zV/EyA7O+4tXqgjPnxBbZ5ZCtWf0uovfUXOFo
 Xxzf+ChLGiuOB3X/MoNxn5jENbwBaNAqYk9Hsb6i1g7TUaP1pUpzkD21JNnIqHxkNb6EFJ
 oeO2J8vQApOdQi8j4byuNFBpJgCW1MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714120640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V5YziJG+M5ukxat6ZAftnfDSYEnKXTzYzEmKKZq5d+Y=;
 b=0XmUuheydgfRnGunwS7V9Cb+TEBTNEJ3PewKH5PKzi0/Ps2/KYtQ6k9c3inzbWqA9/cZR6
 pujPgKwXiFQin/Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714120639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V5YziJG+M5ukxat6ZAftnfDSYEnKXTzYzEmKKZq5d+Y=;
 b=HNUk6aMqzJRkeE+tp3hCrKVIh0tZvY6FoAa+2dbUwuH8t37U31Pz3aJvx5WPgjwUrfUHSs
 q0fSPZgwhPM+eDg5gn3nGrhBPDPGdGvaQhGBs/d6xwE6w8VEbGInLy1V/V0SkeEV91uNA4
 rrqbNSjQCI4Foj96tjfnlgT1Zbi9lOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714120639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V5YziJG+M5ukxat6ZAftnfDSYEnKXTzYzEmKKZq5d+Y=;
 b=YhLPMVfy1yVafYKTzR5mmt2+hL8jZpNkKAvxPzMLzJLxgreM9/A0+168UPyxcu+3ABJes5
 qhHwNrlDwj8BLjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A60591398B;
 Fri, 26 Apr 2024 08:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3axrJ79nK2YPGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Apr 2024 08:37:19 +0000
Date: Fri, 26 Apr 2024 10:36:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <Zitniv9NFio-HOGo@yuki>
References: <20240419070717.2506101-1-lufei@uniontech.com>
 <20240421071539.2547355-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240421071539.2547355-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.76 / 50.00]; BAYES_HAM(-2.96)[99.83%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] (no subject)
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
> Some of your point has been fixed. Some are not:
> 1. I'm using gcc (GCC) 11.4.1 20230605, `addr` without initialization would output some warnings.
> 2. I read the manpage of arch_prctl, the ARCH_GET_CPUID seems return the flag, instead of storing `addr`:
> ```
> ARCH_GET_CPUID (since Linux 4.12)
>               Return the setting of the flag manipulated by ARCH_SET_CPUID as the result of the system call (1  for  enabled,  0  for
>               disabled).  addr is ignored.
> ```

Ah right, if addr is ignored just pass NULL there instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
