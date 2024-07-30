Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485FDC3DA49
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:15:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCCFE3D1D80
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 11:15:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 625743D1D2C
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 11:15:03 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52B9F601CCE
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 11:15:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC6B121BAC;
 Tue, 30 Jul 2024 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722330899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syhZdfN58NK5sGkbxES1Ff3wH6JD2yZsu2G+YnjKf0A=;
 b=cGrC5qc4AYKHsnlLynVbEpdoBs0y6w8Ay8Y7KKPKDMrjlLfYMQct7Zz68Tt+24fjBrfgYS
 1vGw5Qzb5Qb3vMACQ30Kzcj3eV65f6JmOuY4T+fTeEkkGirekRHnKa7eXgPO/QJavTB1sH
 w6mL5abORvIbDJXOqAQ4weOkX3hLNsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722330899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syhZdfN58NK5sGkbxES1Ff3wH6JD2yZsu2G+YnjKf0A=;
 b=ekEiRljmuOQKZ7CnAaFYXMwF3RsgkClzg2mMV8FFOQmBLSVOLBOsh19q1NJBUIq2CFX887
 j856Bw+FSW82TVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722330898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syhZdfN58NK5sGkbxES1Ff3wH6JD2yZsu2G+YnjKf0A=;
 b=XQsoQTyawpcq7aggZyxRUmEK5qMBzOb8eNNuLPULw5pJebiUpUJgaTFvfkcTruC4KZTwRp
 JtNw5tToakes4yAnM04T0tGWFt+A3Gn1HyUXvCnSoXbrED7wQkkY/rNajMTCP7BXs1lmbB
 wDwC3e7xK+Ks0H9Ok+QnZKiKUTghSiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722330898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syhZdfN58NK5sGkbxES1Ff3wH6JD2yZsu2G+YnjKf0A=;
 b=J4ds1evphfxx7JcsAubU9Xg7iNM85ifOefDjYfwNHS3qUCGBbVtvnExjBtWZsZ6uzNvJ/t
 k4z5kMRz9RiJ26Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0D8E13983;
 Tue, 30 Jul 2024 09:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vErNMRKvqGb3DwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 09:14:58 +0000
Date: Tue, 30 Jul 2024 11:14:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240730091458.GB1337464@pevik>
References: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
 <20240724-fchmodat2-v3-3-1dc7cfc634b8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240724-fchmodat2-v3-3-1dc7cfc634b8@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] Add fchmodat2 fallback definition
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

...
> +static inline int fchmodat2(
> +	int dfd, const char *filename, mode_t mode, int flags)
IMHO more consistent is:
static inline int fchmodat2(int dfd, const char *filename, mode_t mode, int flags)

But more important, you need to have as first two params: const char *file,
const int lineno, e.g.:

#define SAFE_FCHMODAT2(path, mode) \
	safe_access(__FILE__, __LINE__, (filename), (mode), (flags))

static inline int fchmodat2(const char *file, const int lineno, int dfd, const
	    char *filename, mode_t mode, int flags)
{
...
#

This way instead of this:
../../../../include/lapi/stat.h:239: TBROK: fchmodat2(3,symlink,416,256) error: EOPNOTSUPP (95)
we get file and line of the test (common approach, see lib/tst_safe_macros.c
include/tst_safe_macros.h).

Kind regards,
Petr

> +{
> +	int ret;
> +
> +	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
> +			__func__, dfd, filename, mode, flags);
> +
> +	return ret;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
