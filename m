Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90305ECAAD4
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B2B73CA712
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:22:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AFD73C9413
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:22:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF244600211
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:22:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05FD421BF7;
 Wed, 31 Aug 2022 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661948533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPc4Ml6X1k6X016oS/FGvZqFjrNmGcJx/DwMoUS6mEI=;
 b=Kg9S1cTCJhxwwPOlAvrGSqYlmmsS9UFmh2rJqpMWiAJh/QV5OqZH/A9YSQfKW9cXpuvEMG
 0L/1MvHMhdu0/7SOdfnDekE+K7Y4SoYd7qPy5RrPzXW36wLmJIouSdQ9z6CS2YmSTAGPwD
 MKM8au6mL3GgmENFPwYINmJWHt/k4YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661948533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPc4Ml6X1k6X016oS/FGvZqFjrNmGcJx/DwMoUS6mEI=;
 b=qzgYKy8oZmKJef9LKOst2ZWSGE8+RFZQHMiX+FY3J3FyGXztxRNlVjqv+em6EDgiQIDh+P
 iFMStuHz7QV67FCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D56971332D;
 Wed, 31 Aug 2022 12:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cHGaMnRSD2NlGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 31 Aug 2022 12:22:12 +0000
Date: Wed, 31 Aug 2022 14:24:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yw9S7JmL6ON3k8+V@yuki>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-10-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220830135007.16818-10-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/10] request_key03: Add max_runtime
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
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/request_key/request_key03.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
> index 3f0c093f3..5cd9b319d 100644
> --- a/testcases/kernel/syscalls/request_key/request_key03.c
> +++ b/testcases/kernel/syscalls/request_key/request_key03.c
> @@ -182,6 +182,7 @@ static void do_test(void)
>  static struct tst_test test = {
>  	.test_all = do_test,
>  	.forks_child = 1,
> +	.max_runtime = 10,
>  	.options = (struct tst_option[]) {
>  		{"b:", &opt_bug,  "Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
>  		{}

First of all I would split the do_test() into three subtest by setting
.test and .tcnt = 3 so that we can apply the max_runtime per one call of
the test_with_key_type(). Then we can make the test_with_key_type()
runtime aware. I guess that we can just spin both of the children until
they consume a defined portion of runtime.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
