Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC01DC3DA59
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 17:27:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411A93D1AB5
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 19:27:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C91B83CC7C9
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 19:27:30 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3DD6200BAA
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 19:27:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4233421BE4;
 Tue, 16 Jul 2024 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721150848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjZ6tkaMmVFlg6ZZaNiEJkfyvUHqofOB7ApbIPa/duo=;
 b=YfAyafYrnBRrivkReCqR1SSutcM1aTtGvGe/HE5PMzKMfmFdAr7ihaSEKT+0veG1+Lk2xz
 FtAFYp2sLD7xJeyL8yGGFFqz5mtPgyibyETvbA4oZeZKFag7FQqMY61fnDplJ3SbH0quwm
 tqLISJYsEZVji6pP1dZ2EwzD53REtPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721150848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjZ6tkaMmVFlg6ZZaNiEJkfyvUHqofOB7ApbIPa/duo=;
 b=/WNpkTnURrCes4+TUSu58zBt7D/atdOnVs9By8n878DedRLGS5ZwF0v6elcmLzNP6iGTg+
 BHPwtQ6JMcyGwRBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721150848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjZ6tkaMmVFlg6ZZaNiEJkfyvUHqofOB7ApbIPa/duo=;
 b=YfAyafYrnBRrivkReCqR1SSutcM1aTtGvGe/HE5PMzKMfmFdAr7ihaSEKT+0veG1+Lk2xz
 FtAFYp2sLD7xJeyL8yGGFFqz5mtPgyibyETvbA4oZeZKFag7FQqMY61fnDplJ3SbH0quwm
 tqLISJYsEZVji6pP1dZ2EwzD53REtPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721150848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjZ6tkaMmVFlg6ZZaNiEJkfyvUHqofOB7ApbIPa/duo=;
 b=/WNpkTnURrCes4+TUSu58zBt7D/atdOnVs9By8n878DedRLGS5ZwF0v6elcmLzNP6iGTg+
 BHPwtQ6JMcyGwRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E607213795;
 Tue, 16 Jul 2024 17:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GclmNX+tlmYtNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jul 2024 17:27:27 +0000
Date: Tue, 16 Jul 2024 19:27:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240716172725.GC549165@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
X-Spamd-Result: default: False [0.50 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
> +static void enable_exec_libs(const int ruleset_fd)
> +{
> +	FILE *fp;
> +	char line[1024];
> +	char path[PATH_MAX];
> +	char dependency[8][PATH_MAX];
> +	int count = 0;
> +	int duplicate = 0;
> +
> +	fp = SAFE_FOPEN("/proc/self/maps", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, ".so") == NULL)
> +			continue;
> +
> +		SAFE_SSCANF(line, "%*x-%*x %*s %*x %*s %*d %s", path);
> +
> +		for (int i = 0; i < count; i++) {
> +			if (strcmp(path, dependency[i]) == 0) {
> +				duplicate = 1;
> +				break;
> +			}
> +		}
> +
> +		if (duplicate) {
> +			duplicate = 0;
> +			continue;
> +		}
> +
> +		strncpy(dependency[count], path, PATH_MAX);
> +		count++;
> +
> +		tst_res(TINFO, "Enable read/exec permissions for %s", path);
> +
> +		path_beneath_attr->allowed_access =
> +			LANDLOCK_ACCESS_FS_READ_FILE |
> +			LANDLOCK_ACCESS_FS_EXECUTE;
> +		path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
> +
> +		SAFE_LANDLOCK_ADD_RULE(
> +			ruleset_fd,
> +			LANDLOCK_RULE_PATH_BENEATH,
> +			path_beneath_attr,
> +			0);

Unfortunately, on 6.6.15-amd64 kernel (random Debian machine) it fails (after
fresh boot) with:

...
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1746: TINFO: === Testing on ext2 ===
tst_test.c:1111: TINFO: Formatting /dev/loop1 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1123: TINFO: Mounting /dev/loop1 to /tmp/LTP_lant6WbKJ/sandbox fstyp=ext2 flags=0
landlock_common.h:30: TINFO: Landlock ABI v3
landlock04.c:151: TINFO: Testing LANDLOCK_ACCESS_FS_EXECUTE
landlock04.c:123: TINFO: Enable read/exec permissions for /usr/lib/i386-linux-gnu/libc.so.6
landlock04.c:131: TBROK: landlock_add_rule(3, 1, 0xf7f13ff4, 0): EINVAL (22)
tst_test.c:1746: TINFO: === Testing on ext3 ===

It works on 6.10.0-rc7-3.g92abc10-default (Tumbleweed), 6.9.8-amd64 (Debian).

Any hint, what could be wrong?

Kind regards,
Petr

> +
> +		SAFE_CLOSE(path_beneath_attr->parent_fd);
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
