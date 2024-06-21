Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6DC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ED943D0EB1
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 13:09:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C0673D0C8B
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 13:09:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04B21208DEC
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 13:09:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 246011FB6C;
 Fri, 21 Jun 2024 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718968170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqAq/qSFjMCrCQQ/1jjA4WS8JELKv/b052gRhoc3DvA=;
 b=pb9/OC47jhYvfUmtCKOKMQAnzfnbqqkJ3OW0y9gkLMJ6Bugk7nlcFIATWlTtw5uXYT/1UG
 ILsyYu798M41tOW7p7VzbtoTxVJ+3XzA+zQuX2Sm/DfFY2Uq9wqSl9HhNQTxmL4AE3MA1s
 HYet5++DPZ+Ue11xtgXBHZPXiVNEZzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718968170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqAq/qSFjMCrCQQ/1jjA4WS8JELKv/b052gRhoc3DvA=;
 b=s6lV/rlxkHDEUoBk5bDOpfNmwIihOugIgwQa4vDx3XcEPUsxq0NCRXsHOgp9H3vucHAqJB
 wrJ8k9RcxdnlMWDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718968170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqAq/qSFjMCrCQQ/1jjA4WS8JELKv/b052gRhoc3DvA=;
 b=pb9/OC47jhYvfUmtCKOKMQAnzfnbqqkJ3OW0y9gkLMJ6Bugk7nlcFIATWlTtw5uXYT/1UG
 ILsyYu798M41tOW7p7VzbtoTxVJ+3XzA+zQuX2Sm/DfFY2Uq9wqSl9HhNQTxmL4AE3MA1s
 HYet5++DPZ+Ue11xtgXBHZPXiVNEZzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718968170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqAq/qSFjMCrCQQ/1jjA4WS8JELKv/b052gRhoc3DvA=;
 b=s6lV/rlxkHDEUoBk5bDOpfNmwIihOugIgwQa4vDx3XcEPUsxq0NCRXsHOgp9H3vucHAqJB
 wrJ8k9RcxdnlMWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0BE813AAA;
 Fri, 21 Jun 2024 11:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lw0yMWlfdWYQYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 11:09:29 +0000
Date: Fri, 21 Jun 2024 13:09:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <20240621110924.GA672386@pevik>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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

Hi Nobuhiro,

> memfd_secret is a syscall added since 5.14. On earlier kernels, tests such
> as accept03, readahead01 and splice07 that use memfd_secret fail.
> This adds a kernel version check to the tst_fd library when running tests using
> memfd_secret.

Cyril's suggestion to add fallback definitions sounds to me as a good idea:

https://lore.kernel.org/ltp/ZnVCcU6jOU98DYek@yuki/

	I guess that the best fix is to add fallback definitions for
	memfd_secret into include/lapi/syscalls/*.in files. That way we should
	get -1 and EINVAL properly even when kernel does not support the
	syscall.

Could you please try that first?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
