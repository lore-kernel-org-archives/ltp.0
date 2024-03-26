Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E27CD11DD
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 12:42:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6DF3D0ED4
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 13:42:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CB6A3C136F
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 13:42:12 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C8322009A5
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 13:42:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A33C037BBF;
 Tue, 26 Mar 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711456930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXT10U0pn9XWT+Cx1P5PHHjqUn5qNanPMsSymOL37bk=;
 b=IjfqV7DT6YrDoIh0YgdajjpYgRpAnysqA0BP+nMXy9JUcix+kf+KsOq4CKyhE1im2QeWQG
 vl08Dr5LwuX+jnzOCkSaGaapPq03XiWIx3EflX2ryEuYTAZ3u/SvXGptTcRXZh/cKxrV3C
 O6Ap9pEJ2A7nZehZSpaemar0MU8+TNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711456930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXT10U0pn9XWT+Cx1P5PHHjqUn5qNanPMsSymOL37bk=;
 b=Mi1CkD6tsXqefvT+xyPbQVlZMGDTkrHE0SHp0inHRFKXvroTZVwr5WA3OL09ON27dwaheC
 o3KWpQ6okcusZMAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711456930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXT10U0pn9XWT+Cx1P5PHHjqUn5qNanPMsSymOL37bk=;
 b=IjfqV7DT6YrDoIh0YgdajjpYgRpAnysqA0BP+nMXy9JUcix+kf+KsOq4CKyhE1im2QeWQG
 vl08Dr5LwuX+jnzOCkSaGaapPq03XiWIx3EflX2ryEuYTAZ3u/SvXGptTcRXZh/cKxrV3C
 O6Ap9pEJ2A7nZehZSpaemar0MU8+TNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711456930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXT10U0pn9XWT+Cx1P5PHHjqUn5qNanPMsSymOL37bk=;
 b=Mi1CkD6tsXqefvT+xyPbQVlZMGDTkrHE0SHp0inHRFKXvroTZVwr5WA3OL09ON27dwaheC
 o3KWpQ6okcusZMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D58413306;
 Tue, 26 Mar 2024 12:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7u68IaLCAmYBIwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 12:42:10 +0000
Date: Tue, 26 Mar 2024 13:41:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZgLCb2g9KJjPDcux@yuki>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-4-pvorel@suse.cz> <ZgKmScOuuiobsEdj@yuki>
 <20240326115356.GD715328@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240326115356.GD715328@pevik>
X-Spamd-Result: default: False [-0.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[46.16%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @Cyril, @Li: How about add 2 macros with '_SIZE' in the name?
> (TST_EXP_FAIL_ARR_SIZE and TST_EXP_FAIL2_ARR_SIZE, see diff at the end).

Maybe just _SZ instead of full _SIZE?

Also the TST_EXP_FAIL_ARR() is rarely used so we may as well to change
it to include the size argument explicitly, the worst case is that user
would have to pass down ARRAY_SIZE(errnos), which is just one more
argument. The macro is used by a single test at the moment so it's easy
now. Doing that would at least slown down the combinatoric explosion of
the test macros.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
