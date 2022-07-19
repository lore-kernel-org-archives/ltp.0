Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D73C43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:44:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 472A73C95D0
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 13:44:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48A913C0780
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:44:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6257860070E
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:44:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C30441FA88;
 Tue, 19 Jul 2022 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658231041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xubOc+zqLSKSiEbeeep8A7fSbFMatb+Ex+1I9yKtIMk=;
 b=HTO0NiFnY8g+kOUEyn4ljeaRlmtOcAncgSBKnF4ylIBBNqs3qy9wi0TD1ihUzFg0Sq/0/T
 f7CjN4qE15mHIO1Qkkzc/3fsCOyK/BSaB+59cc47UyYoRb1Mdv32o8hmmxVltNt7i6KVW3
 DJUStbu85RQHnMjCgAXh045iuUOf9P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658231041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xubOc+zqLSKSiEbeeep8A7fSbFMatb+Ex+1I9yKtIMk=;
 b=w8UvPvvmlhKp0XbiFvW0JNUCVfsd+w+msVzn1467XtiF2zKJd2x1o7dUx3G2jUWpIBQZse
 +cJ08GLdd8W9EyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD83B13A72;
 Tue, 19 Jul 2022 11:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2b3HKAGZ1mJKKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Jul 2022 11:44:01 +0000
Date: Tue, 19 Jul 2022 13:45:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <YtaZSygV7SkAcNsM@rei>
References: <1658228710-37206-1-git-send-email-zhanghongchen@loongson.cn>
 <1658228710-37206-2-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1658228710-37206-2-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] syslog11: save and restore console log
 level
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
Cc: ltp@lists.linux.it, Lingling Li <lilingling@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Lingling Li <lilingling@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  testcases/kernel/syscalls/syslog/syslog11.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
> index 8a19a2a..e60bd2b 100644
> --- a/testcases/kernel/syscalls/syslog/syslog11.c
> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
> @@ -57,6 +57,10 @@ static void run(unsigned int n)
>  
>  static struct tst_test test = {
>  	.test = run,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"!/proc/sys/kernel/printk", NULL},
> +		{NULL, NULL}

I've changed this {NULL, NULL} to just {} in order to fix warnings
reported by 'make check-syslog11' and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
