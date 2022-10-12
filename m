Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519EEC43217
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 08:51:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4F933CAEBA
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 10:51:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66B613C9481
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:51:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81D5B14010F5
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:51:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A22BE1F461;
 Wed, 12 Oct 2022 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665564663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QvCDEwjwBNVGWFn6lqyGcg92XgZNYFU5MqFPgtXlJ0=;
 b=Uhoa9oOFIAmq/Af/TB6Xxn0VseY0TbpSeE8REhP9WsvQEjRBU6wdFdF5pB0BRYW5qHOmWw
 gnJ8qp80X9TIFRP2HMFYvPC+IdIKODAsufaRYB0e3vP330uY0X6EktPqkCmpi0bnzXI5dv
 ZfzX8YgwuQ5ignZ6xhbO7ueGNEwUI5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665564663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QvCDEwjwBNVGWFn6lqyGcg92XgZNYFU5MqFPgtXlJ0=;
 b=p0WOkJIUWg0vJsUTgr55jP5yFLmb68QEdOBXpelc6vLEsl//7j3f+F55bpyfVGq/JKxPvQ
 YS0iNkVujoqJwVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C77F13ACD;
 Wed, 12 Oct 2022 08:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WENaHvd/RmP/ZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 12 Oct 2022 08:51:03 +0000
Date: Wed, 12 Oct 2022 10:52:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y0aAYQ+C1aTfQMRv@yuki>
References: <20221011121607.55575-1-zhaogongyi@huawei.com>
 <20221011121607.55575-4-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221011121607.55575-4-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/madvise11: new test for
 madvise(MADV_DONTNEED)
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
> +static void run(void)
> +{
> +	char cmd[BUF_SIZE];
> +	char line[BUF_SIZE];
> +	char vm_area_addr[128];
> +
> +	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x)",
> +			addr, MAP_SIZE, MADV_DONTNEED);
> +	}
> +
> +	sprintf(vm_area_addr, "%p", addr);
> +	sprintf(cmd,
> +		"cat /proc/%d/smaps | grep %s -A 4 | grep Rss: | grep '0 kB'",
> +		getpid(), &(vm_area_addr[2]));

This is way too ugly and may break easily too.

If we are going to parse the file we should do it properly in C instead.
Why can't we just read the file line by line until we find the right
address at the start of the line and once we do look for the Rss?

> +	fp = popen(cmd, "r");
> +	if (!fp)
> +		tst_brk(TBROK, "popen failed");
> +
> +	if (fgets(line, sizeof(line), fp) != NULL) {
> +		if (strstr(line, " 0 kB"))
> +			tst_res(TPASS, "RSS is released");
> +		else
> +			tst_res(TFAIL, "RSS is not released");
> +
> +	} else
> +		tst_brk(TBROK, "There is no 'Rss:' in smaps?");
> +}
> +
> +static void setup(void)
> +{
> +	addr = SAFE_MMAP(NULL, MAP_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			-1, 0);
> +	memset(addr, 1, MAP_SIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (addr)
> +		SAFE_MUNMAP(addr, MAP_SIZE);
> +	if (fp)
> +		pclose(fp);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> --
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
