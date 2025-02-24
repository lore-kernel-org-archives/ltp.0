Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D24C021BB
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 15:41:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87D83C99E3
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 16:41:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0DC83C9948
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 16:40:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 71C9B142F7E4
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 16:40:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5E7621194;
 Mon, 24 Feb 2025 15:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740411653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wu1244+JfWrvFnbV+R+LuHtmuAtEAeWE+jC6da+ek14=;
 b=a6/GX8dsdRMiUWRbuJW3scUQwgcWGg1whdlLlbmeT24QEBGOowf47Om8skZbejFr2o94mq
 4lX9L9386pIGVpGBcBOOIka8FoB0gLQ3BJe4CKnMmRNy6z2eER+PAKfDCKmSQSjLLegSjj
 azDASDIeL2qzdAnIXgIvoEyQwqCgOEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740411653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wu1244+JfWrvFnbV+R+LuHtmuAtEAeWE+jC6da+ek14=;
 b=9LHpNC/rxIActDU5p3mJhymIeBPawhY4L07fqq8Z5IUjwP1ebSislUQmhKJ6l26WfQroDe
 AYJ82vdW42A9SZBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="a6/GX8ds";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9LHpNC/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740411653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wu1244+JfWrvFnbV+R+LuHtmuAtEAeWE+jC6da+ek14=;
 b=a6/GX8dsdRMiUWRbuJW3scUQwgcWGg1whdlLlbmeT24QEBGOowf47Om8skZbejFr2o94mq
 4lX9L9386pIGVpGBcBOOIka8FoB0gLQ3BJe4CKnMmRNy6z2eER+PAKfDCKmSQSjLLegSjj
 azDASDIeL2qzdAnIXgIvoEyQwqCgOEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740411653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wu1244+JfWrvFnbV+R+LuHtmuAtEAeWE+jC6da+ek14=;
 b=9LHpNC/rxIActDU5p3mJhymIeBPawhY4L07fqq8Z5IUjwP1ebSislUQmhKJ6l26WfQroDe
 AYJ82vdW42A9SZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60F613707;
 Mon, 24 Feb 2025 15:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9zCpKwWTvGdvXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Feb 2025 15:40:53 +0000
Date: Mon, 24 Feb 2025 16:41:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z7yTEEf-BR3qnpz9@yuki.lan>
References: <CAASaF6xJkkE8NEnDRwYEqs_abZxJqiuMnou+d=mYxmLRPddNKg@mail.gmail.com>
 <b70ade709f93e94f8219b5d18e1ce7be0578f183.1740396133.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b70ade709f93e94f8219b5d18e1ce7be0578f183.1740396133.git.jstancek@redhat.com>
X-Rspamd-Queue-Id: C5E7621194
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/utime03: use realtime clock for upper
 bound check
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
Cc: ltp@lists.linux.it, chhrubis@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test rarely fails with recent kernels (after 6.13-rc1):
>   tst_test.c:1833: TINFO: === Testing on ext4 ===
>   tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
>   mke2fs 1.47.2 (1-Jan-2025)
>   tst_test.c:1182: TINFO: Mounting /dev/loop0 to /tmp/LTP_uti42UpHj/mntpoint fstyp=ext4 flags=0
>   utime03.c:74: TPASS: utime(TEMP_FILE, NULL) passed
>   utime03.c:80: TFAIL: utime() did not set expected atime, mintime: 1738291930, maxtime: 1738291930, st_atime: 1738291931
>   utime03.c:85: TFAIL: utime() did not set expected mtime, mintime: 1738291930, maxtime: 1738291930, st_mtime: 1738291931
> 
> Since 4e40eff0b573 ("fs: add infrastructure for multigrain timestamps"),
> filesystem can use more precise clock to update the inode.
> 
> Relax the check by using realtime clock for upper bound check.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/utime/utime03.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
> index 564e1de3dd77..56eb9e722896 100644
> --- a/testcases/kernel/syscalls/utime/utime03.c
> +++ b/testcases/kernel/syscalls/utime/utime03.c
> @@ -55,6 +55,7 @@ static void run(void)
>  	struct utimbuf utbuf;
>  	struct stat statbuf;
>  	time_t mintime, maxtime;
> +	struct timespec ts;
>  
>  	utbuf.modtime = time(0) - 5;
>  	utbuf.actime = utbuf.modtime + 1;
> @@ -70,7 +71,8 @@ static void run(void)
>  	SAFE_SETEUID(user_uid);
>  	mintime = tst_get_fs_timestamp();
>  	TST_EXP_PASS(utime(TEMP_FILE, NULL));
> -	maxtime = tst_get_fs_timestamp();
> +	tst_clock_gettime(CLOCK_REALTIME, &ts);
> +	maxtime = ts.tv_sec;
>  	SAFE_SETEUID(root_uid);
>  	SAFE_STAT(TEMP_FILE, &statbuf);

There are six testcases that use tst_get_fs_timestamp() is this the only
one that fails?

Also if we are going to do this, we should at least put the code to the
library and introduce two different functions one for the start
timestamp and one for the end timestamp and make use of that in all the
test

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
