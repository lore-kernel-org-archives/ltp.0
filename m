Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA0CF0449
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E269E3C2C78
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:47:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C4D13C192B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 12:46:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51F5C20B0F2
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 12:46:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE55221F62;
 Wed,  9 Oct 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC205136BA;
 Wed,  9 Oct 2024 10:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qb28NB1fBmcfegAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 09 Oct 2024 10:46:53 +0000
Date: Wed, 9 Oct 2024 12:45:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwZe3LBHEVeII4Vk@yuki.lan>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
 <20241009-listmount_statmount-v7-16-d5ad31d47f68@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241009-listmount_statmount-v7-16-d5ad31d47f68@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: EE55221F62
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 16/16] Add listmount04 test
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
> +static struct tcase {
> +	int req_usage;
> +	uint32_t size;
> +	uint32_t spare;
> +	uint64_t mnt_id;
> +	uint64_t param;
> +	uint64_t *mnt_ids;
> +	size_t nr_mnt_ids;
> +	uint64_t flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		.req_usage = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EFAULT,
> +		.msg = "request points to unaccessible memory",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = 0,
> +		.mnt_id = LSMT_ROOT,
> +		.param = 0,
> +		.mnt_ids = NULL,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EFAULT,
> +		.msg = "mnt_ids points to unaccessible memory",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = 0,
> +		.mnt_id = LSMT_ROOT,
> +		.param = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = -1,
> +		.exp_errno = EINVAL,
> +		.msg = "invalid flags",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = 0,
> +		.spare = 0,
> +		.mnt_id = LSMT_ROOT,
> +		.param = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EINVAL,
> +		.msg = "insufficient mnt_id_req.size",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = -1,
> +		.mnt_id = LSMT_ROOT,
> +		.param = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EINVAL,
> +		.msg = "invalid mnt_id_req.spare",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = 0,
> +		.mnt_id = LSMT_ROOT,
> +		.param = STATMOUNT_PROPAGATE_FROM + 1,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EINVAL,
> +		.msg = "invalid mnt_id_req.param",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = 0,
> +		.mnt_id = 0,
> +		.param = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = EINVAL,
> +		.msg = "invalid mnt_id_req.mnt_id",
> +	},
> +	{
> +		.req_usage = 1,
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.spare = 0,
> +		.mnt_id = LSMT_ROOT - 1,
> +		.param = 0,
> +		.mnt_ids = mnt_ids,
> +		.nr_mnt_ids = MNT_SIZE,
> +		.flags = 0,
> +		.exp_errno = ENOENT,
> +		.msg = "non-existant mnt_id",
> +	},
> +};

We can omit setting spare, params and flags to 0 here, to make it
shorter, otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
