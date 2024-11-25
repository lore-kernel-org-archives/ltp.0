Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C29D58D64
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 16:21:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 527313DACBB
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 17:21:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C573DA93A
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 17:20:57 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22E09663F65
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 17:20:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B0CB1F442;
 Mon, 25 Nov 2024 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732551654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1+dLZYNU7LqYbX5DhtBpv0IcDLVMF6fnCY/JuSoywfg=;
 b=Pp/WIyCAdUGY9DGJ6N8UWxG9hipcf8W2I+ZjgMQiT05B0WqC5h2upUywD6eSVGZsuWVrik
 4x5pG6Mqpk90bTp0HfjkkfNOofOtEv5ZT9R24WRcq70AYFlTS/tFImivuz+0ZizF1lgExG
 r1eryDFNthhECVYwbTcTXyzWCg4tSBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732551654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1+dLZYNU7LqYbX5DhtBpv0IcDLVMF6fnCY/JuSoywfg=;
 b=atRFv2vCtdmcn6gCs8nLLBzxKOzuhXJYXmqArOigCHTXZnQcGyfeIv5aPrgBrdotYNBz2C
 xK01BLscpQIIusCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732551654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1+dLZYNU7LqYbX5DhtBpv0IcDLVMF6fnCY/JuSoywfg=;
 b=Pp/WIyCAdUGY9DGJ6N8UWxG9hipcf8W2I+ZjgMQiT05B0WqC5h2upUywD6eSVGZsuWVrik
 4x5pG6Mqpk90bTp0HfjkkfNOofOtEv5ZT9R24WRcq70AYFlTS/tFImivuz+0ZizF1lgExG
 r1eryDFNthhECVYwbTcTXyzWCg4tSBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732551654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1+dLZYNU7LqYbX5DhtBpv0IcDLVMF6fnCY/JuSoywfg=;
 b=atRFv2vCtdmcn6gCs8nLLBzxKOzuhXJYXmqArOigCHTXZnQcGyfeIv5aPrgBrdotYNBz2C
 xK01BLscpQIIusCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FF2C13890;
 Mon, 25 Nov 2024 16:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gNIiE+ajRGdQbwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 25 Nov 2024 16:20:54 +0000
Message-ID: <19be9834-c6cd-4bb6-a468-aaf36cc05919@suse.cz>
Date: Mon, 25 Nov 2024 17:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
 <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pkeys01: use a dummy function instead of
 function_size
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
I've successfully tested your patch on both x86 (both 32 and 64bit) and 
PPC64. The extra alignment should ensure that the dummy function doesn't 
get split between two pages so this is a good fix. There's just one 
minor printf formatting issue at the end that can be fixed during merge.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 19. 11. 24 16:47, Jan Stancek wrote:
> As Martin found:
>    The function_size() code
>    is broken in a way that I cannot easily fix. The function tries
>    to calculate the size of a function by finding the first RET
>    instruction. However, in 32bit LTP builds, the code gets compiled
>    to this:
> 
>    0804b690 <function_size>:
>     804b690:       8b 4c 24 04             mov    0x4(%esp),%ecx
>     804b694:       0f b6 01                movzbl (%ecx),%eax
>     804b697:       83 c0 3e                add    $0x3e,%eax
>     804b69a:       3c 01                   cmp    $0x1,%al
>     804b69c:       76 1a                   jbe    804b6b8 <function_size+0x28>
>     804b69e:       89 c8                   mov    %ecx,%eax
>     804b6a0:       83 c0 01                add    $0x1,%eax
>     804b6a3:       0f b6 10                movzbl (%eax),%edx
>     804b6a6:       83 c2 3e                add    $0x3e,%edx
>     804b6a9:       80 fa 01                cmp    $0x1,%dl
>     804b6ac:       77 f2                   ja     804b6a0 <function_size+0x10>
>     804b6ae:       29 c8                   sub    %ecx,%eax
>     804b6b0:       83 c0 10                add    $0x10,%eax
>     804b6b3:       c3                      ret
>     804b6b4:       8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
>     804b6b8:       b8 10 00 00 00          mov    $0x10,%eax
>     804b6bd:       c3                      ret
>     804b6be:       66 90                   xchg   %ax,%ax
> 
>    If you look closely enough, you'll notice a C2 byte in add $0x3e,%edx
>    instruction on address 804b6a6. The function will assume this byte is
>    a RET instruction, return a size that's 22 bytes too short and then
>    the code execution inside the executable buffer will run past the end
>    of buffer, resulting in a segfault.
> 
> Use a dummy function and copy entire page, similar to what we do
> in mprotect04.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/pkeys/Makefile |  2 ++
>   testcases/kernel/syscalls/pkeys/pkey01.c | 31 ++++++++++--------------
>   2 files changed, 15 insertions(+), 18 deletions(-)
> 
> Notes:
> 
> This could be an alternative to reverting PKEY_DISABLE_EXECUTE test.
> I haven't tested it yet on 32bit, but since it doesn't rely on any
> instruction codes I don't expect it to break. An important test
> would also be ppc64le.
> 
> diff --git a/testcases/kernel/syscalls/pkeys/Makefile b/testcases/kernel/syscalls/pkeys/Makefile
> index 9ee2c2ea57b0..814593f3c720 100644
> --- a/testcases/kernel/syscalls/pkeys/Makefile
> +++ b/testcases/kernel/syscalls/pkeys/Makefile
> @@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
>   
>   include $(top_srcdir)/include/mk/testcases.mk
>   
> +pkey01: CFLAGS += -falign-functions=64
> +
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
> index c041cbcfd969..b10760b5bd2f 100644
> --- a/testcases/kernel/syscalls/pkeys/pkey01.c
> +++ b/testcases/kernel/syscalls/pkeys/pkey01.c
> @@ -144,15 +144,9 @@ static char *flag_to_str(int flags)
>   	}
>   }
>   
> -static size_t function_size(void (*func)(void))
> +static long __attribute__ ((noinline)) dummy_func(void)
>   {
> -	unsigned char *start = (unsigned char *)func;
> -	unsigned char *end = start;
> -
> -	while (*end != 0xC3 && *end != 0xC2)
> -		end++;
> -
> -	return (size_t)(end - start + 1);
> +	return 0xdead;
>   }
>   
>   /*
> @@ -165,8 +159,11 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   	char *buffer;
>   	int pkey, status;
>   	int fd = mpa->fd;
> -	size_t (*func)();
> -	size_t func_size = 0;
> +	long (*func)(void) = 0;
> +	uintptr_t page_mask = ~(getpagesize() - 1);
> +	uintptr_t offset_mask = (getpagesize() - 1);
> +	uintptr_t func_page_offset = (uintptr_t)&dummy_func & offset_mask;
> +	void *page_to_copy = (void *)((uintptr_t)&dummy_func & page_mask);
>   
>   	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE)) {
>   		tst_res(TCONF, "skip PKEY_DISABLE_EXECUTE test");
> @@ -184,8 +181,8 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   	buffer = SAFE_MMAP(NULL, size, mpa->prot, mpa->flags, fd, 0);
>   
>   	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
> -		func_size = function_size((void (*)(void))function_size);
> -		memcpy(buffer, (void *)function_size, func_size);
> +		memcpy(buffer, page_to_copy, getpagesize());
> +		func = (long (*)(void))(buffer + func_page_offset);
>   	}
>   
>   	pkey = pkey_alloc(tc->flags, tc->access_rights);
> @@ -211,8 +208,7 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   				"Write buffer success, buffer[0] = %d", *buffer);
>   		break;
>   		case PKEY_DISABLE_EXECUTE:
> -			func = (size_t (*)())buffer;
> -			tst_res(TFAIL | TERRNO, "Execute buffer result = %zi", func(func));
> +			tst_res(TFAIL | TERRNO, "Execute buffer result = %ld", func());
>   		break;
>   		}
>   		exit(0);
> @@ -242,11 +238,10 @@ static int pkey_test(struct tcase *tc, struct mmap_param *mpa)
>   		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
>   	break;
>   	case PROT_READ | PROT_WRITE | PROT_EXEC:
> -		func = (size_t (*)())buffer;;
> -		if (func_size == func(func))
> -			tst_res(TPASS, "Execute buffer success, result = %zi", func_size);
> +		if (dummy_func() == func())
> +			tst_res(TPASS, "Execute buffer success, result = %ld", dummy_func());
>   		else
> -			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func(func));
> +			tst_res(TFAIL, "Execute buffer with unexpected result: %zi", func());

The format here should be %ld.

>   	break;
>   	}
>   

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
