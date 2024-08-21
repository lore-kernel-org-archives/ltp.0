Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED8C52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 10:31:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FEAA3D2279
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 12:31:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1145B3CC2E6
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 12:31:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0295200C22
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 12:31:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A978C20062;
 Wed, 21 Aug 2024 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724236292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOLNf8MJIl6QWG7nEI8STgqayL/ywHAQfFqF+8JkAMQ=;
 b=daR2EvwglLu6w28pDNvJHvtlpjOHZ3Vz8wUO2usElo5CqnFE4mzmBX+LoEui6j3QpH0dv5
 Kc611HATJb9TsOZ324KsWpu1CsZafX5bnreeZF//ph/Ecgy46U31kmq4tX9VAFMTaHbfWW
 7anBDsTOPoKh6Ue2FhM/mEMIW+OTZBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724236292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOLNf8MJIl6QWG7nEI8STgqayL/ywHAQfFqF+8JkAMQ=;
 b=Zp+/cGUPO971ZYOuapTZMlWaqkyebK6R3561FeeuXkd0hqUoKuDzDx/dnITXiQdUVtDw40
 tvRSiwHIdgup3QBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724236291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOLNf8MJIl6QWG7nEI8STgqayL/ywHAQfFqF+8JkAMQ=;
 b=WlchWG12jZklYLSTsQZghVqCBcsVgPs7CQq4mAofKJvcgzz0sYP06ydYaH6V2Jb2FaIZ5Q
 aH/n44nb1KKY6/0sldZqidcMri3q12P7Ex9r/cTPuV5htpWlq/3Nf679zd4t9+RZD2tOqm
 A04Hb7KbgZGOW2ZD3wBsPyrkS6fKMls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724236291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOLNf8MJIl6QWG7nEI8STgqayL/ywHAQfFqF+8JkAMQ=;
 b=wFhmRpvhBeOOE4MYP+LRSS2U+ZybhPr5qeZrbrHnQGW85PgwlRBoGAG8fYVVrnKNSCn8cy
 7MKwo9e2gz4Md4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9791413770;
 Wed, 21 Aug 2024 10:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zRf1IwPCxWZAZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Aug 2024 10:31:31 +0000
Date: Wed, 21 Aug 2024 12:30:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZsXBxlFZGy4ETPa8@yuki.lan>
References: <20240416080141.22616-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240416080141.22616-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] execve: Add negative test for execve
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
> +/*\
> + * [Description]
> + *
> + * Verify that execve(2) fails with
> + *
> + * - ELOOP when too many symbolic links are encountered in filename
> + */
> +
> +#include "tst_test.h"
> +
> +#define TEST_ELOOP "test_eloop"
> +#define TEST_ELOOP2 "test_eloop2"
> +
> +static struct test_case_t {
> +	char *filename;
> +	int expected_errno;
> +	int user;
> +	char *desc;
> +} tcases[] = {
> +	{TEST_ELOOP, ELOOP, 0,
> +		"too many symbolic links are encountered in filename"},
> +};
> +
> +static void setup(void)
> +{
> +	SAFE_SYMLINK(TEST_ELOOP, TEST_ELOOP2);
> +	SAFE_SYMLINK(TEST_ELOOP2, TEST_ELOOP);
> +}
> +
> +static void verify_execve(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +	char *argv[2] = {tc->filename, NULL};
> +
> +	TST_EXP_FAIL(execve(tc->filename, argv, NULL), tc->expected_errno,
> +		"%s", tc->desc);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_execve,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};

Any reason why this isn't added to execve03.c instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
