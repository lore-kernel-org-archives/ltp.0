Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F32C001DE
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 08:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B042B3C8AC3
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 10:36:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ED283C01D0
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:36:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 54FAB100023D
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:36:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C28F21972;
 Fri, 28 Jul 2023 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690533384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1FsqE6gO+m6vXLqz3zx+KhHoIk+Qu7NjoXdKCtyFZo=;
 b=VsZkvnjnsOVYpLui9rfiejfX7f06IXsL0+QFWO5+w28yg2tbpsegiqlDnhoHBjZPFYlnzs
 SAbQtuHMV4XX0j4nnvCfNKilAoUACajjj1qnrTxZDcxhvvZ3HfBHHqsm2WiZCTlDA/7VV9
 n0QyF2e1DyPNw6tjEqe8NMUP/mjyEZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690533384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1FsqE6gO+m6vXLqz3zx+KhHoIk+Qu7NjoXdKCtyFZo=;
 b=k8pz7nUaWI3P7XbrddpRDxTekqWcpx4GJz1gpzdktHDu4QRKR2s5I7SuHRNkFw+BUi2oJ4
 G4Fe+4leo2t82vAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 211EE133F7;
 Fri, 28 Jul 2023 08:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wWALBwh+w2RCbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 08:36:24 +0000
Date: Fri, 28 Jul 2023 10:36:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230728083622.GA15664@pevik>
References: <20230727150013.31835-1-mdoucha@suse.cz>
 <20230727150013.31835-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230727150013.31835-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add test for CVE 2023-1829
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

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_VETH",
> +		"CONFIG_USER_NS=y",
> +		"CONFIG_NET_NS=y",
> +		"CONFIG_NET_SCH_HTB",
> +		"CONFIG_NET_CLS_TCINDEX",
Interesting, CONFIG_NET_CLS_TCINDEX has been removed in 8c710f75256b
(in v6.3-rc1), therefore the test is only for older kernels.

Kind regards,
Petr

> +		NULL
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "8c710f75256b"},
> +		{"CVE", "2023-1829"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
