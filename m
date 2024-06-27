Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C06DC2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605803D1407
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:49:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84A673D13EB
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:49:29 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77F5F6022AD
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:49:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 870321FBB4;
 Thu, 27 Jun 2024 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719481766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTE2oTEH7errqYfDN4xLR7w3+i3C4g0p/oHMfaQVIZ8=;
 b=P9GI5evvfbw4csgEQjX76R8z6bFq8lUJV/Y/vXCecU4gvXLnETLvENVSq1U+Gh4xfWNb+X
 dx7BtROdYXJpkdSLKYrJ+U3+z/REutG5yqqHnCXt2LwUHAYSB0wSEnmAkdaSTbS3Dz1H58
 JLAWZMrlnlyRfvad74PpPW9zdZ6qxts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719481766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTE2oTEH7errqYfDN4xLR7w3+i3C4g0p/oHMfaQVIZ8=;
 b=rgzrs8RT4Ybi3eyoZD4KuxAs2yWS3K46UK6U9spwvqxaMJgmtcC2Hxy/iIxchibjqNmO4F
 IctOedVa+jsOeiAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P9GI5evv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rgzrs8RT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719481766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTE2oTEH7errqYfDN4xLR7w3+i3C4g0p/oHMfaQVIZ8=;
 b=P9GI5evvfbw4csgEQjX76R8z6bFq8lUJV/Y/vXCecU4gvXLnETLvENVSq1U+Gh4xfWNb+X
 dx7BtROdYXJpkdSLKYrJ+U3+z/REutG5yqqHnCXt2LwUHAYSB0wSEnmAkdaSTbS3Dz1H58
 JLAWZMrlnlyRfvad74PpPW9zdZ6qxts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719481766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTE2oTEH7errqYfDN4xLR7w3+i3C4g0p/oHMfaQVIZ8=;
 b=rgzrs8RT4Ybi3eyoZD4KuxAs2yWS3K46UK6U9spwvqxaMJgmtcC2Hxy/iIxchibjqNmO4F
 IctOedVa+jsOeiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6874E137DF;
 Thu, 27 Jun 2024 09:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5wlDGKY1fWa4IQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 09:49:26 +0000
Date: Thu, 27 Jun 2024 11:49:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zn01m4CWFTQtL07t@yuki>
References: <20240220133254.16057-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220133254.16057-1-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: 870321FBB4
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add open15 test
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
> --- /dev/null
> +++ b/testcases/kernel/syscalls/open/open15.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that open() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +
> +#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
> +
> +static char myfile_path[PATH_MAX];
> +
> +static void test_open_symlink(void)
> +{
> +	int fd;
> +	int str_size;
> +	char buff[128];
> +	char *symname = "my_symlink0";
> +
> +	str_size = strlen(BIG_STRING);
> +
> +	SAFE_SYMLINK(myfile_path, symname);
> +
> +	fd = SAFE_OPEN(symname, O_CREAT | O_RDWR, 0777);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, BIG_STRING, str_size);


> +	SAFE_LSEEK(fd, 0, 0);
> +	SAFE_READ(1, fd, buff, str_size);
> +	SAFE_CLOSE(fd);
> +	TST_EXP_EXPR(!strncmp(buff, BIG_STRING, str_size),
> +		"symlink generated file can be opened to write data");
> +
> +	SAFE_UNLINK(symname);
> +	remove(myfile_path);

Here as well, SAFE_UNLINK()

> +}
> +
> +static void test_open_compare(void)
> +{
> +	int fd_file, fd_symlink;
> +	int str_size;
> +	char buff_file[128];
> +	char buff_symlink[128];
> +	char *symname = "my_symlink1";
> +
> +	str_size = strlen(BIG_STRING);
> +
> +	fd_file = SAFE_OPEN(myfile_path, O_CREAT | O_RDWR, 0777);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd_file, BIG_STRING, str_size);
> +
> +	SAFE_SYMLINK(myfile_path, symname);
> +
> +	SAFE_LSEEK(fd_file, 0, 0);
> +	SAFE_READ(1, fd_file, buff_file, str_size);
> +
> +	fd_symlink = SAFE_OPEN(symname, O_RDWR, 0777);
> +	SAFE_LSEEK(fd_symlink, 0, 0);
> +	SAFE_READ(1, fd_symlink, buff_symlink, str_size);
> +
> +	TST_EXP_EXPR(!strncmp(buff_file, buff_symlink, str_size),
> +		"file data is the equivalent to symlink generated file data");
> +
> +	SAFE_CLOSE(fd_file);
> +	SAFE_CLOSE(fd_symlink);
> +
> +	SAFE_UNLINK(symname);
> +	remove(myfile_path);

Here as well, SAFE_UNLINK()

> +}
> +
> +static void setup(void)
> +{
> +	int size;
> +	char *tmpdir;
> +
> +	tmpdir = tst_get_tmpdir();
> +	size = strlen(tmpdir);
> +
> +	myfile_path[size] = '/';
> +	memcpy(myfile_path, tmpdir, size);
> +	memcpy(myfile_path + size + 1, "myfile.txt", 6);

Here as well. This may overflow.

> +}
> +
> +static void run(void)
> +{
> +	test_open_symlink();
> +	test_open_compare();
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
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
