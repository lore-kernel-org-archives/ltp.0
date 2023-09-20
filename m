Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB60C04AAA
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 15:50:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 123863CE411
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 17:50:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73643CA59A
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:50:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F9061400211
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:49:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED9422079;
 Wed, 20 Sep 2023 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695224997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJxBfjSZ0DmPag+LDakhg5eL5ssf8BF8GcbJXFbu89U=;
 b=ZAED/64RBpHJPkStr+7L6Al3EM/qXFYUCTTvhEAI/lGIU6GbVDz1/sIz7hyL1IhdG7/VlI
 O22tbbIOJbO6eANPWWwSqRI57P2xnW+8pjy8vFgm0VpQFGM6ttVmcRVcMAGvJ7ST4YzFgB
 RxYLwlS80fpTgqGuED1qUtb0QecUbQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695224997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJxBfjSZ0DmPag+LDakhg5eL5ssf8BF8GcbJXFbu89U=;
 b=9fIKOMEBqCSdo156QJdWOjRZWRguM9nTCHHmwvEdH2pExwHbTNxpcU6OrwLAjl9VTXXLYI
 oye5Aq00b2bqMfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB5DA1333E;
 Wed, 20 Sep 2023 15:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bfIqOKQUC2XuUQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 20 Sep 2023 15:49:56 +0000
Message-ID: <783bad35-1735-f5df-c50b-22d5949def37@suse.cz>
Date: Wed, 20 Sep 2023 17:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20230920154447.3165-1-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230920154447.3165-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: lockdown: Report lockdown as disabled on
 missing sysfs
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 20. 09. 23 17:44, Cyril Hrubis wrote:
> We currently report -1 when secure boot sysfs file is not present which
> is later interpreted as secure boot enabled. This causes regression in
> *_module sycall tests executed on systems when secureboot is not
> compiled-in or supported at all.

That's incorrect usage then. The tests should check 
tst_secureboot_enabled() > 0 instead. I think it will be useful to know 
whether the function found that secureboot is disabled, or could not 
check at all. We should just document it better.

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tst_lockdown.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 38d830886..7613092ec 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -29,7 +29,7 @@ int tst_secureboot_enabled(void)
>   
>   	if (access(SECUREBOOT_VAR, F_OK)) {
>   		tst_res(TINFO, "SecureBoot sysfs file not available");
> -		return -1;
> +		return 0;
>   	}
>   
>   	fd = open(SECUREBOOT_VAR, O_RDONLY);

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
