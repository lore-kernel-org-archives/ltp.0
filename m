Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C5DC3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 20:33:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA4E63D15BA
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 22:33:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DFC83C2220
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 22:33:04 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBA751402F9C
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 22:33:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4FD221A8D;
 Thu, 11 Jul 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B638136AF;
 Thu, 11 Jul 2024 20:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AtlyHH5BkGZPdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 20:33:02 +0000
Date: Thu, 11 Jul 2024 22:32:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240711203256.GB85696@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-6-c7b0e9edf9b0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240711-landlock-v3-6-c7b0e9edf9b0@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E4FD221A8D
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 06/11] Add landlock02 test
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

Hi Andrea,

Thanks for whole testsuite, generally LGTM.

For this one:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>
(Li added his RBTs in v1, you moved it to v2 but forget to add to v3)

...
> +static struct tcase {
> +	int *fd;
> +	enum landlock_rule_type rule_type;
> +	struct landlock_path_beneath_attr **attr;
> +	int access;
> +	int parent_fd;
> +	uint32_t flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		&ruleset_fd,
> +		0,
> +		&path_beneath_attr,
> +		LANDLOCK_ACCESS_FS_EXECUTE,
> +		0,
> +		1,
> +		EINVAL,
> +		"Invalid flags"
> +	},
nit: we've been talking about it in other tests - using designated initializers
would make things more readable and allows avoid to specify zeros (feel free to
ignore, sure no need for yet another version).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
