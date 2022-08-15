Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A9C25B0E
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 15:28:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95D53C96B7
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 17:28:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23D43C95D9
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 17:28:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5CB8600811
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 17:28:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC0642036D;
 Mon, 15 Aug 2022 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660577319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7SKjyH2e6gcGKrrKSXuTmKCgBQnXjcQFMIalnwa43F4=;
 b=tXhnp1b4hqA1UJtA/xGbxH1FK/1OqfqVShQ6PR4lnwuULtJYeDVN0nO3BY+FP+RNnr5jdY
 NdAT7YwoQ2TtSk3IAruQEgDV/DSV/d0oiT60p72X2zGu/t62qch0P4OFqdKFGoKEAX4CY9
 PkEhlMjr3l+6XQ2SwMdO7QeDeji014I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660577319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7SKjyH2e6gcGKrrKSXuTmKCgBQnXjcQFMIalnwa43F4=;
 b=Hv378oZOp/Tf/q6BiKbKn3dgCvXEz5RqWNBx8mTpkMS5qPYBn+7Xl0WA11GbuGkchSoVEh
 +atX2yb066psrSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9BDE13A93;
 Mon, 15 Aug 2022 15:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cYJtKSdm+mJLegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Aug 2022 15:28:39 +0000
Date: Mon, 15 Aug 2022 17:30:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvpmmrnIif0aIxzF@yuki>
References: <20220812122758.25605-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220812122758.25605-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] Refactor aiocp using new LTP API
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
> -static int dev_block_size_by_path(const char *path)
> +static void fill_with_rand_data(int fd, long long size)
>  {
> -	FILE *f;
> -	struct mntent *mnt;
> -	size_t prefix_len, prefix_max = 0;
> -	char dev_name[1024];
> -	int fd, size;
> +	int lower = 'a';
> +	int upper = 'z';
> +	int bufsize = 1024 * 1024;
> +	char buf[bufsize];
> +	long long i = 0, j;
> +	int start;
>  
> -	if (!path)
> -		return 0;
> +	srand(time(NULL));
>  
> -	f = setmntent("/proc/mounts", "r");
> -	if (!f) {
> -		fprintf(stderr, "Failed to open /proc/mounts\n");
> -		return 0;
> -	}
> -
> -	while ((mnt = getmntent(f))) {
> -		/* Skip pseudo fs */
> -		if (mnt->mnt_fsname[0] != '/')
> -			continue;
> +	for (j = 0; j < bufsize; j++)
> +		buf[j] = (rand() % (upper - lower + 1)) + lower;
>  
> -		prefix_len = strlen(mnt->mnt_dir);
> -
> -		if (prefix_len > prefix_max &&
> -		    !strncmp(path, mnt->mnt_dir, prefix_len)) {
> -			prefix_max = prefix_len;
> -			strncpy(dev_name, mnt->mnt_fsname, sizeof(dev_name));
> -			dev_name[sizeof(dev_name)-1] = '\0';
> -		}
> +	if (size <= bufsize) {
> +		SAFE_WRITE(0, fd, buf, size);
> +		return;
>  	}
>  
> -	endmntent(f);
> +	while (i < size) {
> +		if (!tst_remaining_runtime())
> +			tst_brk(TCONF, "Out of runtime!");
>  
> -	if (!prefix_max) {
> -		fprintf(stderr, "Path '%s' not found in /proc/mounts\n", path);
> -		return 0;
> -	}
> +		start = rand() % (bufsize / 2);
>  
> -	printf("Path '%s' is on device '%s'\n", path, dev_name);
> +		for (j = 0; j < start; j++) {
> +			buf[start - j] = buf[bufsize - start + j];
> +			i++;
>  
> -	fd = open(dev_name, O_RDONLY);
> -	if (!fd) {
> -		fprintf(stderr, "open('%s'): %s\n", dev_name, strerror(errno));
> -		return 0;
> -	}
> +			if (i > size)
> +				break;
> +		}

Huh, why do we change the buffer here at all?

What about much simpler:

#define SIZE (64 * 1024)

static void fill_with_rand_data(int fd, long long size)
{
	char buf[2 * SIZE];
	size_t i, off, to_write;

	for (i = 0; i < sizeof(buf); i++)
                buf[i] = (rand() % (upper - lower + 1)) + lower;

	do {
		if (!tst_remaning_runtime())
			tst_brk(TCONF, "Out of runtime!");

		off = rand() % SIZE;
		to_write = MIN(size, SIZE);

		SAFE_WRITE(1, fd, buf + off, to_write);

		size -= to_write;
	} while (size);

	SAFE_FSYNC(fd);
}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
