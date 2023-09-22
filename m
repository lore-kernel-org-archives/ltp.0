Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F64E7D0D6
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 07:11:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DD373CB576
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:11:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC7233CA017
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:11:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C680D201116
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:11:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB6921D31;
 Fri, 22 Sep 2023 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695366676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klpKR0QiycndzOGieGPgDoBxPu2tv5Yy86lcyZwFZTE=;
 b=BViQYl9PqCrujbebzKZCZ9bsLM5qhtXi8Yd7ZDvjDFfEnCsSYRHcq7gAO9Za/p5tYS8u6a
 RJc+AoKGqiOG/AlknlHuuvDPUpeaM4J9NG1V+X2x7JJFkuCSmnC3NMMaeF38SrUJ/4St+u
 tX6+nnRER4OqX5K1m7Gr/Yq1EsWRChU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695366676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klpKR0QiycndzOGieGPgDoBxPu2tv5Yy86lcyZwFZTE=;
 b=dBEPw/6Jc1X56Nvquo0TW7oh6WrDk0/sfrGiMn0+UPBSxs13xGjBLfWPudMLfDLsmUlslz
 FjaZOuap1iHKSZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BAE513A64;
 Fri, 22 Sep 2023 07:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OFnfHBQ+DWWkFgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 22 Sep 2023 07:11:16 +0000
Message-ID: <0ab54ee2-e305-cbb7-7c4d-1f142dbaa0d1@suse.cz>
Date: Fri, 22 Sep 2023 09:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20230921140721.11382-1-chrubis@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230921140721.11382-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Fix lockdown detection on
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

Hi,
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 21. 09. 23 16:07, Cyril Hrubis wrote:
> The lockdown detection function reports -1 when secure boot sysfs file
> is not present, which is later mistakenly interpreted as secure boot
> enabled in tst_test.c.
> 
> This causes regression in *_module sycall tests executed on systems when
> secureboot is not compiled-in or supported at all.
> 
> Check properly if secure boot is enabled by checking that the return
> value from these functions is positive.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tst_test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2e58cad33..e2c195645 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1163,10 +1163,10 @@ static void do_setup(int argc, char *argv[])
>   	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>   		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
>   
> -	if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
> +	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
>   		tst_brk(TCONF, "Kernel is locked down, skipping test");
>   
> -	if (tst_test->skip_in_secureboot && tst_secureboot_enabled())
> +	if (tst_test->skip_in_secureboot && tst_secureboot_enabled() > 0)
>   		tst_brk(TCONF, "SecureBoot enabled, skipping test");
>   
>   	if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())

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
