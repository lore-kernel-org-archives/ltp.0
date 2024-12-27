Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2169EE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 12:47:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B12183ED606
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 13:47:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AC4A3DA1D9
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 13:46:57 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 364B11BD5BDB
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 13:46:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2EF91FF8F;
 Fri, 27 Dec 2024 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735303614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvcfN4fwclil/KuaATAYw3716h/28aJk2yGj3HBN5sc=;
 b=nHrQ5tUecrtBJ3GAZXptool/99hZbKX3IAFygQ4jOxYHDTGbsrBdG/Zk4ifwE8/Frvppmg
 LzrztTDqmZYEKzNIgFWmZP9v8GtIxaB99/xxgj8Fe5iNOy8It//MAWaYORCGj2211hRtvK
 piuXtQI0Hk07ae/vAMLRyUf23HfSNek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735303614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvcfN4fwclil/KuaATAYw3716h/28aJk2yGj3HBN5sc=;
 b=14nzUvT6Vw65GiueAjZMs34rVUoJJCx5qSpAneU+qhnB0YRj6m3CPs3HFRc7kKn7eoZjSK
 hPqpCWn0UDdpmoCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735303614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvcfN4fwclil/KuaATAYw3716h/28aJk2yGj3HBN5sc=;
 b=nHrQ5tUecrtBJ3GAZXptool/99hZbKX3IAFygQ4jOxYHDTGbsrBdG/Zk4ifwE8/Frvppmg
 LzrztTDqmZYEKzNIgFWmZP9v8GtIxaB99/xxgj8Fe5iNOy8It//MAWaYORCGj2211hRtvK
 piuXtQI0Hk07ae/vAMLRyUf23HfSNek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735303614;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YvcfN4fwclil/KuaATAYw3716h/28aJk2yGj3HBN5sc=;
 b=14nzUvT6Vw65GiueAjZMs34rVUoJJCx5qSpAneU+qhnB0YRj6m3CPs3HFRc7kKn7eoZjSK
 hPqpCWn0UDdpmoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A641913A30;
 Fri, 27 Dec 2024 12:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LU05J76hbmeldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 12:46:54 +0000
Date: Fri, 27 Dec 2024 13:46:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20241227124653.GO317565@pevik>
References: <20241223041921.143620-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241223041921.143620-1-po-hsu.lin@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] {delete, finit,
 init}_module0[1-3]: Handle CONFIG_MODULE_SIG_FORCE
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

Hi Po-Hsu Lin,

> The patch adds parsing for CONFIG_MODULE_SIG_FORCE kernel config,
> which will make tests expect an EKEYREJECTED error like using the
> 'module.sig_enforce' parameter.

Thanks, merged!

> Patch tested on kernel with CONFIG_MODULE_SIG_FORCE=y and it's
> working as expected.

+1

We might want to refactor the code to single place (DRY), but that can be done
later (we have lib/tst_module.c, which is using an old API because shared
between old and new code, but it looks like all tests has been converted to new
API, thus lib/tst_module.c could be convert to new API as well and then add
these checks into).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
