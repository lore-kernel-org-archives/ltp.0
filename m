Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C20C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:32:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7440D3CCC78
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 10:32:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C7C83C1CE9
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 10:32:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF6251400043
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 10:32:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D71CC1FB3F;
 Tue, 22 Jul 2025 08:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753173151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boXWKL7GWIHnoRsxVXkSfDPAVDIgPKFsUyTyeytbmqc=;
 b=Y6V8BuVzteRPVQXqnpUuB3jioeiu+f2gp4IK2M/oidWsj5bmztsm4FowwzLh5fb+B515yt
 9TOIMS2u5ALEectDA76D+wxzA4QP+4IVwxainK1X9fUHj8ymUz6aHpGA1P0zx+LAJFuxDE
 I5ZbHQ57owq0w9KzKT8kwRJWARIdBqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753173151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boXWKL7GWIHnoRsxVXkSfDPAVDIgPKFsUyTyeytbmqc=;
 b=Opm9//eOz8wAKPEcyEMBvxEDzlmnmXDEqxNpjCOo5tKpJ63XqFq0AyGdrB4hGLZ1sVXAuy
 UfvE9eLnDBYmvZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753173150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boXWKL7GWIHnoRsxVXkSfDPAVDIgPKFsUyTyeytbmqc=;
 b=ZLvBWoZiIkArlXIxhw/z90a/iDadtMaZQaMcjVgYaonD+a0pp2JJzoDo4qFoZA/jIyv3pJ
 1HltC0QZspObf8IHM1Yr7jzxDu0dsjfICX+9UPrDABDsYMts5SzaoRFpmHTwZSN8IoJ5xx
 bFoYlgv+x1/3qMdgA9+6UZ0NJmzi8Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753173150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boXWKL7GWIHnoRsxVXkSfDPAVDIgPKFsUyTyeytbmqc=;
 b=dSLYETvSd2o40+/eB1BZgnJhOiUdLnKya/A75VDYs+yjGfKMg4m6NTYgC1XI3BKpW+CVFd
 uG1qyxsN0qaCvwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2BAA132EA;
 Tue, 22 Jul 2025 08:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zR/wKZ5Mf2g/EAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 08:32:30 +0000
Date: Tue, 22 Jul 2025 10:32:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250722083221.GB19816@pevik>
References: <20250721154946.34223-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250721154946.34223-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open14: Rewrite to new API
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

Hi Martin,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - Added subtest info to test description
> - Added .needs_root = 1
Thank you!

...
> -#define _GNU_SOURCE
I also think that _GNU_SOURCE is not needed, hopefully this will not break some
non-glibc libc. But it looks to be ok for MUSL and uclibc-ng follows glibc API.

> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
> +/*\
> + * Check the functionality of O_TMPFILE flag for open() syscall:
Unfortunately, this requires a blank line otherwise the text in generated doc [1] will be inline:

Check the functionality of O_TMPFILE flag for open() syscall: 1) Creation and linking (naming) of a single temp file 2) Creation of multiple unlinked temp files in a hierarchy of directories 3) Access permissions of linked temp files match creation mode argument

I plan to modify doc/conf.py to add this blank line if it's missing. (I would
prefer this would be already in json generated metadata/metaparse.c but Cyril
wanted to be in the code which generates output from JSON.

[1] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#open14

> + * 1) Creation and linking (naming) of a single temp file
> + * 2) Creation of multiple unlinked temp files in a hierarchy of directories
> + * 3) Access permissions of linked temp files match creation mode argument
> + */
...

>  	for (i = 0; i < blocks_num; ++i)
> -		SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, buf, size);
> +		SAFE_WRITE(1, fd, buf, size);
Although SAFE_WRITE_ALL is ugly it's IMHO more descriptive than 1.
It's also more widely used in LTP tests than 1, but I'm ok with it.

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

If you don't mind I would amend the code before merge (diff below).

Kind regards,
Petr

+++ testcases/kernel/syscalls/open/open14.c
@@ -7,6 +7,7 @@
 
 /*\
  * Check the functionality of O_TMPFILE flag for open() syscall:
+ *
  * 1) Creation and linking (naming) of a single temp file
  * 2) Creation of multiple unlinked temp files in a hierarchy of directories
  * 3) Access permissions of linked temp files match creation mode argument
@@ -53,7 +54,7 @@ static void write_file(int fd)
 		SAFE_WRITE(1, fd, buf, size);
 }
 
-void test01(void)
+static void test01(void)
 {
 	struct stat st;
 	char path[PATH_MAX];

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
