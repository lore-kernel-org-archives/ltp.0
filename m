Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB73C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 11:57:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20D043CFB36
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 12:57:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 064683C7168
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 12:57:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22B9314094E3
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 12:56:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19B201FD55;
 Wed, 24 Jan 2024 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706097419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a1Jr9PB5LOf06No35EfstquqrjbRkYL6OIfM8dkxFBc=;
 b=EanoUAz+tMCNS1A9gb7qJUmhsoq8piUsuTCJUh9pcjZFlgKO6GF35qTMwYCGwWG5RAfwLE
 weWQ8Ehhf2lbRm2nt8K2a1weL02FTd2DC31QGthaaiwld2cJZA2V/uIoQKkbSJNCwc/mBb
 8c/Fpqz8we8Lobc+XrQhSmB37sdFkHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706097419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a1Jr9PB5LOf06No35EfstquqrjbRkYL6OIfM8dkxFBc=;
 b=/kzlnd9M6DfAFnD6h0aUZK0dh+TzEA9MMIVhGaBGu40vy1IlaAJwZkFGapzBV3ZF3muIFJ
 KKuuPrj79k3Ik+Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706097419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a1Jr9PB5LOf06No35EfstquqrjbRkYL6OIfM8dkxFBc=;
 b=EanoUAz+tMCNS1A9gb7qJUmhsoq8piUsuTCJUh9pcjZFlgKO6GF35qTMwYCGwWG5RAfwLE
 weWQ8Ehhf2lbRm2nt8K2a1weL02FTd2DC31QGthaaiwld2cJZA2V/uIoQKkbSJNCwc/mBb
 8c/Fpqz8we8Lobc+XrQhSmB37sdFkHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706097419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a1Jr9PB5LOf06No35EfstquqrjbRkYL6OIfM8dkxFBc=;
 b=/kzlnd9M6DfAFnD6h0aUZK0dh+TzEA9MMIVhGaBGu40vy1IlaAJwZkFGapzBV3ZF3muIFJ
 KKuuPrj79k3Ik+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C11E1333E;
 Wed, 24 Jan 2024 11:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b9QyAgv7sGVOKQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Jan 2024 11:56:59 +0000
Message-ID: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
Date: Wed, 24 Jan 2024 12:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20240123165539.32514-1-akumar@suse.de>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240123165539.32514-1-akumar@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04.c: Avoid vma merging
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
some comments below.

On 23. 01. 24 17:55, Avinesh Kumar wrote:
> We hit a scenario where new mapping was merged with existing mapping of
> same permission and the return address from the mmap was hidden in the
> merged mapping in /proc/self/maps, causing the test to fail.
> To avoid this, we first  create a 2-page mapping with the different
> permissions, and then remap the 2nd page with the perms being tested.
> 
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/mmap/mmap04.c | 49 +++++++++++++++----------
>   1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
> index f6f4f7c98..f0f87b7f5 100644
> --- a/testcases/kernel/syscalls/mmap/mmap04.c
> +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> @@ -17,28 +17,28 @@
>   #include "tst_test.h"
>   #include <stdio.h>
>   
> -#define MMAPSIZE 1024
> -static char *addr;
> +static char *addr1;
> +static char *addr2;
>   
>   static struct tcase {
>   	int prot;
>   	int flags;
>   	char *exp_perms;
>   } tcases[] = {
> -	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, "---p"},
> -	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED, "---s"},
> -	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, "r--p"},
> -	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED, "r--s"},
> -	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "-w-p"},
> -	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "-w-s"},
> -	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "rw-p"},
> -	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "rw-s"},
> -	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "r-xp"},
> -	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "r-xs"},
> -	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "-wxp"},
> -	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "-wxs"},
> -	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "rwxp"},
> -	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "rwxs"}
> +	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "---p"},
> +	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "---s"},
> +	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "r--p"},
> +	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "r--s"},
> +	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "-w-p"},
> +	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-w-s"},
> +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "rw-p"},
> +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "rw-s"},
> +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "r-xp"},
> +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "r-xs"},
> +	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "-wxp"},
> +	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-wxs"},
> +	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "rwxp"},
> +	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "rwxs"}

The MAP_FIXED flag doesn't belong in the testcases, it should be added 
in the mmap() call instead: SAFE_MMAP(..., tc->flags | MAP_FIXED, ...);
It's an implementation detail not related to the testcases themselves. 
You don't want to rewrite all the test cases again if we decide to not 
use MAP_FIXED for whatever reason in the future.

>   };
>   
>   static void run(unsigned int i)
> @@ -47,10 +47,21 @@ static void run(unsigned int i)
>   	char addr_str[20];
>   	char perms[8];
>   	char fmt[1024];
> +	unsigned int pagesize;
>   
> -	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
>   
> -	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
> +	/* To avoid new mapping getting merged with existing mappings, we first
> +	   create a 2-page mapping with the different permissions, and then remap
> +	   the 2nd page with the perms being tested. */
> +	if ((tc->prot == PROT_NONE) && (tc->flags == (MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED)))
> +		addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_READ, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +	else
> +		addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

This would be cleaner (just invert the shared/private flag):
int flags = (tc->flags & MAP_PRIVATE) ? MAP_SHARED : MAP_PRIVATE;
addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | flags, 
-1, 0);

> +
> +	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags, -1, 0);
> +
> +	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr2);

Why not merge the two sprintf()s into one?
sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);

>   	sprintf(fmt, "%s-%%*x %%s", addr_str);
>   	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
>   
> @@ -61,7 +72,7 @@ static void run(unsigned int i)
>   						tc->exp_perms, perms);
>   	}
>   
> -	SAFE_MUNMAP(addr, MMAPSIZE);
> +	SAFE_MUNMAP(addr1, pagesize * 2);
>   }
>   
>   static struct tst_test test = {

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
