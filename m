Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C845CE71076
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 14:01:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7918C3CE3A9
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 16:01:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8ED63CA2AB
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:01:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2ACA206519
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:01:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18250338AC;
 Thu, 21 Sep 2023 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695304866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3QA6hKXdKJamXOYxTHRA8q2FlyKOWcHpMvjCca+Qa4=;
 b=ZTwipeWryWTRzzYU5kVpgda3gPHMrRqZ6JrBlbC1ApsZPZcqBIweUhgFUGE6bO10A5fiMq
 JxRYduqlL1WHhEYVnlB+IwsBFu6MOf4jUUliCZaGg03pGDYK9VVvoY2tfIdOLcEMs1pbWM
 Mfi9x09rokb7AkfW/1JJoWp21DQDZBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695304866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3QA6hKXdKJamXOYxTHRA8q2FlyKOWcHpMvjCca+Qa4=;
 b=BJTkO/Jszxqa5u2oepsyBIFglarQF/wfUYvxIcLoxSfTJOlIYiaz3gpGhliSpWclzhp2ac
 aizOtK30bFeIFsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 001E713513;
 Thu, 21 Sep 2023 14:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P/AZOqFMDGUUSgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 21 Sep 2023 14:01:05 +0000
Message-ID: <48a78178-8cdc-6227-fb50-9d70d7c80c9c@suse.cz>
Date: Thu, 21 Sep 2023 16:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230920154447.3165-1-chrubis@suse.cz>
 <783bad35-1735-f5df-c50b-22d5949def37@suse.cz> <ZQs3J6AUPWcRQZxJ@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZQs3J6AUPWcRQZxJ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 20. 09. 23 20:17, Cyril Hrubis wrote:
> Hi!
>>> We currently report -1 when secure boot sysfs file is not present which
>>> is later interpreted as secure boot enabled. This causes regression in
>>> *_module sycall tests executed on systems when secureboot is not
>>> compiled-in or supported at all.
>>
>> That's incorrect usage then. The tests should check
>> tst_secureboot_enabled() > 0 instead. I think it will be useful to know
>> whether the function found that secureboot is disabled, or could not
>> check at all. We should just document it better.
> 
> Yes, the functions do not seem to have any documentation.
> 
> So I guess that we need:
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2e58cad33..e2c195645 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1163,10 +1163,10 @@ static void do_setup(int argc, char *argv[])
>          if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>                  tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
> 
> -       if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
> +       if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
>                  tst_brk(TCONF, "Kernel is locked down, skipping test");
> 
> -       if (tst_test->skip_in_secureboot && tst_secureboot_enabled())
> +       if (tst_test->skip_in_secureboot && tst_secureboot_enabled() > 0)
>                  tst_brk(TCONF, "SecureBoot enabled, skipping test");
> 
>          if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())
> 

Yes, this is the correct fix.

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
