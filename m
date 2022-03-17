Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65EBC433FE
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 12:01:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C014C3C9421
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 13:01:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72E933C6355
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 13:01:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6F551400066
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 13:01:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2587B1F37F;
 Thu, 17 Mar 2022 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647518467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC/8v4BwW+C27HDY0P6XYZPHx4wfUG5jHeYRxxzWQQE=;
 b=GI+vJyJzv+/9Lad9VE6+DL6YkmMYCMpOH9GWWPKdSWe5stMBicn/Nq1uhyN+pD/y73bMK2
 nnl4/IrIiXnAdgBfbOeIzW5g0YtrgKIS+a/cg5RsYzb4z2zsMn4FSD7f52zJOlklVlqun1
 y/JYWC5Y6nNE52pINOlVj38pli53/04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647518467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC/8v4BwW+C27HDY0P6XYZPHx4wfUG5jHeYRxxzWQQE=;
 b=Ob8i5MXwhKN8eFbCgXkyBfXKu+HF0N72QDvQBy+lOec5uhozXp39Ncm4xoiCwfDL6VCSqj
 TQWJADKDefDBCqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09CC113B4B;
 Thu, 17 Mar 2022 12:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHgBAQMjM2JsZwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 17 Mar 2022 12:01:07 +0000
Message-ID: <cd942f2c-27db-c174-570a-cd2fd836bfe4@suse.cz>
Date: Thu, 17 Mar 2022 13:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Yang Xu <xuyang2018.jy@fujitsu.com>, pvorel@suse.cz
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/quotactl04: Use correct min_kver
 version check
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

Hi,
this should have been sent as two separate patches but otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 16. 03. 22 4:32, Yang Xu wrote:
> Ext4 supports project quota since kernel 4.5 instead of 4.10.
> Also Q_GETNEXTQUOTA is supported since kernel 4.6, so add
> a check for this command like quotactl01 does.
> 
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/quotactl/quotactl04.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index fdd1c9b50..3eb6e4a34 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -47,6 +47,7 @@ static struct dqinfo res_qf;
>  static int32_t fmt_buf;
>  
>  static struct if_nextdqblk res_ndq;
> +static int getnextquota_nsup;
>  
>  static struct tcase {
>  	int cmd;
> @@ -125,6 +126,11 @@ static void setup(void)
>  	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>  	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>  	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +
> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, PRJQUOTA), tst_device->dev,
> +		test_id, (void *) &res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
>  }
>  
>  static void cleanup(void)
> @@ -145,6 +151,11 @@ static void verify_quota(unsigned int n)
>  
>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>  
> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, PRJQUOTA) && getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support this cmd");
> +		return;
> +	}
> +
>  	TST_EXP_PASS_SILENT(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr),
>  			"do_quotactl to %s", tc->des);
>  	if (!TST_PASS)
> @@ -166,7 +177,7 @@ static struct tst_test test = {
>  		"quota_v2",
>  		NULL
>  	},
> -	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
> +	.min_kver = "4.5", /* commit 689c958cbe6b (ext4: add project quota support) */
>  	.test = verify_quota,
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.setup = setup,


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
