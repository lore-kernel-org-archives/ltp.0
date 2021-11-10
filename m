Return-Path: <SRS0=1g5g=P5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C5C433F5
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 16:31:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C9961205
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30C9961205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39F33C5935
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 17:31:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227D73C22BC
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 17:31:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40FF51001276
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 17:31:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56143218F6;
 Wed, 10 Nov 2021 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636561900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OL2k+xsurpD0lWcx/Z+Pm1niY5WBQKs3PyiciK2jeNs=;
 b=aD047RVDPcdQd8LKjILe1dE9lu4jMWwk4Mt5IOH4yxbyJNw8R4JTlBL7FDDtqANIGDKaLr
 QDQwtc0RRVxS4+pkKKceEH4WrsytpozeHXr7G9qAW6mVcwfrH8/1HTQ6gt9pNQwzfVRdOT
 pWy91bxi6hb5ZnU6108PESE4405DjqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636561900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OL2k+xsurpD0lWcx/Z+Pm1niY5WBQKs3PyiciK2jeNs=;
 b=MmFzvqNQJfoWmH7ButmDktafAyAfjlxVFwGmpgjwq99qII65tfm2fFCr5tIccX+BRO6j4Y
 yZPfCf4kn9hmorBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C67113CAF;
 Wed, 10 Nov 2021 16:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cDmdDezzi2E7BwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Nov 2021 16:31:40 +0000
Date: Wed, 10 Nov 2021 17:32:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YYv0Kn16GGGgJpIn@yuki>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
> +	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
> +	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
> +	if (rc != 3)
> +		tst_res(TWARN, "Unable parse version number");
> +	else if (major * 10000 + minor * 100 + patch < 14300)
> +		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota option, test skipped");
> +	pclose(f);

Ideally this should be added to the .needs_cmds instead so that we get
the minimal version in the test metadata too.

I wonder how this should be done.

One possibility would be adding support for version in the needs_cmds
strings as:

"mkfs.ext4 >= 1.43"

Then we would have to add a table of version checks to the library as
well so that we could lookup a function based on the command name.

Something as:

static long mkfs_ext4_version_parser(void)
{
	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
	pclose(f);
	if (rc != 3) {
		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
		return -1;
	}

	return major * 10000 * minor * 100 + patch;
}

static struct version_parser {
	const char *name,
	long (*parser)(void);
} version_parsers[] = {
	{.cmd = "mkfs.ext4", .parser = mkfs_ext4_version_parser},
	{},
};

Then the library would do:

	struct version_parser *p;
	size_t cmd_len;
	long version;
	char *str, *version;

	str = strchr(cmd, ' ');
	if (!str)
		return;

	version = strchr(str, ' ');
	if (!version)
		tst_brk(TBROK, "Missing version in %s", cmd);

	//TODO: check that the string between str and version is a
	//correct operator

	cmd_len = str - cmd;

	for (p = *version_parsers; *p; p++) {
		if (strlen(p->name) != cmd_len)
			continue;

		if (!strncmp(p->name, cmd, cmd_len))
			break;
	}

	if (!p->name)
		tst_brk(TBROK, "No version parser for %s implemented!");

	long ver = p->parser();
	if (ver < 0)
		tst_brk(TBROK, "Failed to parse %s version", p->name);

	/* now we have to parse the version from the version variable
	 * and compare it with the ver variable */

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
