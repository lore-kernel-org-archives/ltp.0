Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72132C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 14:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51643C8EDA
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 15:14:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7812A3C53E9
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:14:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0A6F6418F0
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:14:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 956BD1F391;
 Mon,  3 Feb 2025 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738592050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH3li9mSHQfaIia+EB3SEm00UIa/HJ/A77BYZQ8YtsA=;
 b=uibtM8D4sraxW6wAFJFMM9vz0OZjxxCLSmoPrn3N+shMcbEicKFA8/FFa5XicAvQONrSnG
 NK5PRUPrd+iHFQwLL5weRoSYa8Z6yOZp7YLdObQe5tqEJ7MqyyqiqT4SBRlDhn2PCzxMAq
 +VY7PjxiIor2L2vquRYh5s2/5nY0kj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738592050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH3li9mSHQfaIia+EB3SEm00UIa/HJ/A77BYZQ8YtsA=;
 b=ssRYZZ/cMo0y8BC6gXtbPuE+/iXTbSePJDIGG7b0eo27wev7T10FF7yoxdLwSUz2Yc5Hoo
 HpIrS+wgZVh+JEBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uibtM8D4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ssRYZZ/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738592050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH3li9mSHQfaIia+EB3SEm00UIa/HJ/A77BYZQ8YtsA=;
 b=uibtM8D4sraxW6wAFJFMM9vz0OZjxxCLSmoPrn3N+shMcbEicKFA8/FFa5XicAvQONrSnG
 NK5PRUPrd+iHFQwLL5weRoSYa8Z6yOZp7YLdObQe5tqEJ7MqyyqiqT4SBRlDhn2PCzxMAq
 +VY7PjxiIor2L2vquRYh5s2/5nY0kj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738592050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH3li9mSHQfaIia+EB3SEm00UIa/HJ/A77BYZQ8YtsA=;
 b=ssRYZZ/cMo0y8BC6gXtbPuE+/iXTbSePJDIGG7b0eo27wev7T10FF7yoxdLwSUz2Yc5Hoo
 HpIrS+wgZVh+JEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4114413795;
 Mon,  3 Feb 2025 14:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0/C7CzLPoGdkPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Feb 2025 14:14:10 +0000
Date: Mon, 3 Feb 2025 15:14:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250203141408.GA1266486@pevik>
References: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
 <Z6CxekRPhvsSdfLc@rei>
 <7f6d9a5d-284a-4c25-b491-cfd7b15da2dd@suse.com>
 <4f163ac1-d282-4ea1-baa7-c574b342243c@suse.com>
 <Z6DBxBvFRXHvolkt@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z6DBxBvFRXHvolkt@yuki.lan>
X-Rspamd-Queue-Id: 956BD1F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add tests catalog page
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

> Hi!
> > I also have a question: what test configuration keys should be seen in 
> > the documentation tests list?
> > I.e. needs_forks, needs_kconfigs, etc.

> That's a good question. We should keep the information the tester is
> interested in, however we should add too much either.

> I guess that we want group the data somewhat like:

>  - options (because command line options may be useful there)

>  - min_kver, needs_kconfigs, min_cpus, needs_drivers, needs_cmds...
>    (because it may describe why tests are skipped)

>  - needs_cgroup_ctrls + cgroup knobs (for tests that use cgroups)
Also .needs_cgroup_ver, .needs_cgroup_nsdelegate

>  - all_filesystems, skip_filesystems, filesystems

>  - timeout, runtime         (here as well, run for longer)

>  - needs_root      maybe?
>  - needs_device    maybe?
IMHO both can be interesting - you can list tests you loose if you don't use
root or you don't have kernel with loop device configured.

Also there are more: .caps, .hugepages, .needs_hugetlbfs, .min_mem_avail,
.min_swap_avail, .dev_min_size, .needs_abi_bits, .needs_overlay (at least).

Why not to show all the info like it was previously? We never know what the
reader will be interested in.

If we are really not interested at all, I would just avoid few LTP true
internals, e.g.: .needs_checkpoints, .forks_child, .child_needs_reinit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
