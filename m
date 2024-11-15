Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D23D68BC8
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 16:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA5433D7806
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 17:06:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EA803D7502
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 17:06:07 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6026D62DC4F
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 17:06:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40F4B1F443;
 Fri, 15 Nov 2024 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731686765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ezuoan85N+cd1LFoNR/BpAQY5KXrVH4C8I78AjEIYIc=;
 b=O6KGlWj0/3k46gVzWDhBKeYc7Lu/Nf54/rah9cpdNSW/0g2lXlZn6x3aKvBybl5Lf71ay1
 7uoEwuE8dyMSvkjk421PWmRGUDuH62NgjO6DYzqFZOHzrKE9/XRKhNSJ1yCLdyQwLkzGeb
 8zUgCTtIGyHU1TEAjQSaOYDF015I2H4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731686765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ezuoan85N+cd1LFoNR/BpAQY5KXrVH4C8I78AjEIYIc=;
 b=KOTKCO8Kk7PdXgHX6Su24PNtDDPpGOnTpGPPcVgMDQKnzcQXSUYKUTN3jqFL8ywHmrlccU
 jfSikU9yW8Yw9qCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O6KGlWj0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KOTKCO8K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731686765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ezuoan85N+cd1LFoNR/BpAQY5KXrVH4C8I78AjEIYIc=;
 b=O6KGlWj0/3k46gVzWDhBKeYc7Lu/Nf54/rah9cpdNSW/0g2lXlZn6x3aKvBybl5Lf71ay1
 7uoEwuE8dyMSvkjk421PWmRGUDuH62NgjO6DYzqFZOHzrKE9/XRKhNSJ1yCLdyQwLkzGeb
 8zUgCTtIGyHU1TEAjQSaOYDF015I2H4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731686765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ezuoan85N+cd1LFoNR/BpAQY5KXrVH4C8I78AjEIYIc=;
 b=KOTKCO8Kk7PdXgHX6Su24PNtDDPpGOnTpGPPcVgMDQKnzcQXSUYKUTN3jqFL8ywHmrlccU
 jfSikU9yW8Yw9qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E6F134B8;
 Fri, 15 Nov 2024 16:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Og9eC21xN2ebSAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 15 Nov 2024 16:06:05 +0000
Message-ID: <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
Date: Fri, 15 Nov 2024 17:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
References: <20241115154434.39461-1-mdoucha@suse.cz>
Content-Language: en-US
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20241115154434.39461-1-mdoucha@suse.cz>
X-Rspamd-Queue-Id: 40F4B1F443
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Revert "pkey01: Adding test for
 PKEY_DISABLE_EXECUTE"
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

Sorry, I forgot to CC Li in the patch.

On 15. 11. 24 16:44, Martin Doucha wrote:
> This reverts commit d2b8a476c29d52c484b387454082bbc906b0b4f8.
> 
> Remove the PKEY_DISABLE_EXECUTE subtest. The function_size() code
> is broken in a way that I cannot easily fix. The function tries
> to calculate the size of a function by finding the first RET
> instruction. However, in 32bit LTP builds, the code gets compiled
> to this:
> 
> 0804b690 <function_size>:
>   804b690:       8b 4c 24 04             mov    0x4(%esp),%ecx
>   804b694:       0f b6 01                movzbl (%ecx),%eax
>   804b697:       83 c0 3e                add    $0x3e,%eax
>   804b69a:       3c 01                   cmp    $0x1,%al
>   804b69c:       76 1a                   jbe    804b6b8 <function_size+0x28>
>   804b69e:       89 c8                   mov    %ecx,%eax
>   804b6a0:       83 c0 01                add    $0x1,%eax
>   804b6a3:       0f b6 10                movzbl (%eax),%edx
>   804b6a6:       83 c2 3e                add    $0x3e,%edx
>   804b6a9:       80 fa 01                cmp    $0x1,%dl
>   804b6ac:       77 f2                   ja     804b6a0 <function_size+0x10>
>   804b6ae:       29 c8                   sub    %ecx,%eax
>   804b6b0:       83 c0 10                add    $0x10,%eax
>   804b6b3:       c3                      ret
>   804b6b4:       8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
>   804b6b8:       b8 10 00 00 00          mov    $0x10,%eax
>   804b6bd:       c3                      ret
>   804b6be:       66 90                   xchg   %ax,%ax
> 
> If you look closely enough, you'll notice a C2 byte in add $0x3e,%edx
> instruction on address 804b6a6. The function will assume this byte is
> a RET instruction, return a size that's 22 bytes too short and then
> the code execution inside the executable buffer will run past the end
> of buffer, resulting in a segfault.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/pkeys/pkey01.c | 52 ++----------------------
>   1 file changed, 3 insertions(+), 49 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
> index c041cbcfd..e49e48846 100644
> --- a/testcases/kernel/syscalls/pkeys/pkey01.c
> +++ b/testcases/kernel/syscalls/pkeys/pkey01.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (c) 2019-2024 Red Hat, Inc.
> + * Copyright (c) 2019 Red Hat, Inc.
>    */
>   
>   /*\
> @@ -41,7 +41,6 @@
>   #define PATH_VM_NRHPS "/proc/sys/vm/nr_hugepages"
>   
>   static int size;
> -static int execute_supported = 1;
>   
>   #define PERM_NAME(x) .access_rights = x, .name = #x
>   static struct tcase {
> @@ -51,26 +50,14 @@ static struct tcase {
>   } tcases[] = {
>   	{PERM_NAME(PKEY_DISABLE_ACCESS)},
>   	{PERM_NAME(PKEY_DISABLE_WRITE)},
> -	{PERM_NAME(PKEY_DISABLE_EXECUTE)} /* keep it the last */
>   };
>   
>   static void setup(void)
>   {
> -	int i, fd, pkey;
> +	int i, fd;
>   
>   	check_pkey_support();
>   
> -	pkey = pkey_alloc(0, PKEY_DISABLE_EXECUTE);
> -	if (pkey == -1) {
> -		if (errno == EINVAL) {
> -			tst_res(TINFO, "PKEY_DISABLE_EXECUTE not implemented");
> -			execute_supported = 0;
> -		} else {
> -			tst_brk(TBROK | TERRNO, "pkey_alloc failed");
> -		}
> -	}
> -	pkey_free(pkey);
> -
>   	if (tst_hugepages == test.hugepages.number)
>   		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>   	else
> @@ -144,17 +131,6 @@ static char *flag_to_str(int flags)
>   	}
>   }
>   
> -static size_t function_size(void (*func)(void))
> -{
> -	unsigned char *start = (unsigned char *)func;
> -	unsigned char *end = start;
> -
> -	while (*end != 0xC3 && *end != 0xC2)
> -		end++;
> -
> -	return (size_t)(end - start + 1);
> -}
> -
>   /*
>    * return: 1 if it's safe to quit testing on failure (all following would be
>    * TCONF, O otherwise.
> @@ -165,13 +141,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   	char *buffer;
>   	int pkey, status;
>   	int fd = mpa->fd;
> -	size_t (*func)();
> -	size_t func_size = 0;
> -
> -	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE)) {
> -		tst_res(TCONF, "skip PKEY_DISABLE_EXECUTE test");
> -		return 1;
> -	}
>   
>   	if (!tst_hugepages && (mpa->flags & MAP_HUGETLB)) {
>   		tst_res(TCONF, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
> @@ -183,11 +152,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   
>   	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
>   
> -	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
> -		func_size = function_size((void (*)(void))function_size);
> -		memcpy(buffer, (void *)function_size, func_size);
> -	}
> -
>   	pkey = pkey_alloc(tc->flags, tc->access_rights);
>   	if (pkey == -1)
>   		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
> @@ -210,10 +174,6 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   			tst_res(TFAIL | TERRNO,
>   				"Write buffer success, buffer[0] = %d", *buffer);
>   		break;
> -		case PKEY_DISABLE_EXECUTE:
> -			func = (size_t (*)())buffer;
> -			tst_res(TFAIL | TERRNO, "Execute buffer result = %zi", func(func));
> -		break;
>   		}
>   		exit(0);
>   	}
> @@ -238,16 +198,10 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   		tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
>   	break;
>   	case PROT_READ | PROT_WRITE:
> +	case PROT_READ | PROT_WRITE | PROT_EXEC:
>   		*buffer = 'a';
>   		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
>   	break;
> -	case PROT_READ | PROT_WRITE | PROT_EXEC:
> -		func = (size_t (*)())buffer;;
> -		if (func_size == func(func))
> -			tst_res(TPASS, "Execute buffer success, result = %zi", func_size);
> -		else
> -			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func(func));
> -	break;
>   	}
>   
>   	if (fd >= 0)

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
