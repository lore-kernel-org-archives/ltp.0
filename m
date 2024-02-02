Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BEFC48291
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 17:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2BC53CDB67
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 18:17:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B0D83CDB67
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 18:17:28 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37DA161662B
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 18:17:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D30A220AA;
 Fri,  2 Feb 2024 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706894247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5lnwZKeVw7iH6MZpaQv4DEUCgAE6YxciA1tj+JnWCkE=;
 b=CKnTGe+AIgAHcZeLG1N6sjf+wtTO2fk2IIuJJgu38XIEAjKjdPLzVovm+Hc+A430YBkZch
 9ymH96em2KBAqn9biAYkpzLxbYm0efXnkHc1vxltIzDnVvenM9Hydx9W+//IALvCSB7KsY
 ouUEr3MgSYBRHUxmurWfPvwA6KFnnjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706894247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5lnwZKeVw7iH6MZpaQv4DEUCgAE6YxciA1tj+JnWCkE=;
 b=7ByrV+AmAXKRIK2U8ypt9zrMjJtByWyQpkZMS2cuORSBY+CEFzjNRpSowC+ncgR1KY+1l9
 1Zq7hDChKOP9E1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706894247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5lnwZKeVw7iH6MZpaQv4DEUCgAE6YxciA1tj+JnWCkE=;
 b=CKnTGe+AIgAHcZeLG1N6sjf+wtTO2fk2IIuJJgu38XIEAjKjdPLzVovm+Hc+A430YBkZch
 9ymH96em2KBAqn9biAYkpzLxbYm0efXnkHc1vxltIzDnVvenM9Hydx9W+//IALvCSB7KsY
 ouUEr3MgSYBRHUxmurWfPvwA6KFnnjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706894247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5lnwZKeVw7iH6MZpaQv4DEUCgAE6YxciA1tj+JnWCkE=;
 b=7ByrV+AmAXKRIK2U8ypt9zrMjJtByWyQpkZMS2cuORSBY+CEFzjNRpSowC+ncgR1KY+1l9
 1Zq7hDChKOP9E1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1343139AB;
 Fri,  2 Feb 2024 17:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DHkOKYjvWUTTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 Feb 2024 17:17:26 +0000
Date: Fri, 2 Feb 2024 18:17:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zb0jtL90aF5K0258@yuki>
References: <20240119085939.11801-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119085939.11801-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CKnTGe+A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7ByrV+Am
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.63 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,linux.it:url];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.62)[92.58%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 1D30A220AA
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add chdir05 test
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
> + * This test verifies that chdir() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +
> +static void test_chdir(void)
> +{
> +	char *symname = "my_symlink0";
> +
> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
> +	TST_EXP_PASS(chdir(symname));
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_chdir_no_path(void)
> +{
> +	char *symname = "my_symlink1";
> +
> +	SAFE_SYMLINK("bc+eFhi!k", symname);
> +	TST_EXP_FAIL(chdir(symname), ENOENT);
> +
> +	SAFE_UNLINK(symname);
> +}

This two should go to chdir01.c and possibly chdir01 should be split
into positive cases and negative cases when you are at it.

> +static void test_chdir_loop(void)
> +{
> +	char *symname = "my_symlink2";
> +
> +	TST_EXP_PASS(symlink(symname, symname));
> +	TST_EXP_FAIL(chdir(symname), ELOOP);
> +
> +	SAFE_UNLINK(symname);
> +}

This is already in chdir01.c

> +static void run(void)
> +{
> +	test_chdir();
> +	test_chdir_no_path();
> +	test_chdir_loop();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
