Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65637CFC274
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 08:32:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859423C66F6
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 10:32:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 553053C278C
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:32:13 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3A1AD14391E1
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:32:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC65C1FB95
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728981130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNP8o9fCj/zgYXXIgDgW0xkYh8YrLiq5JRjtVKIa+6o=;
 b=SQ3qTrzsczcdVIlJ5RlZV3U6Z1DVNRfLQzT5AGlpVjp7ixI9BhrRN1kkUmsQu6Q5YhoxPP
 Kg9LVcp1/3UyzIkrxLIkXapIY5P9fBvX8qR+2AjUPH57n+niMe1Jtd//VpYaLjzFgcxScC
 Gj8JLF03AeQaT6HOIPOiOz/Z23Qi+wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728981130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNP8o9fCj/zgYXXIgDgW0xkYh8YrLiq5JRjtVKIa+6o=;
 b=0bSLGEU0T/Alwde2ko2ieVfFDE4ogqBTFNlw+yFMvZC6s5clRmdcAItc5B+b9eVabMW0cn
 76/SKOdpLnlnd+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728981129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNP8o9fCj/zgYXXIgDgW0xkYh8YrLiq5JRjtVKIa+6o=;
 b=haYZkQx2Mp3NfyLfTvZDHL0lgrO7F32DL63We7gz+taiYso8UCJTndS1wcGukl/UtEIGd5
 k7E72vIvKOVGL+40LNY/leRVsn0j3e2r772mr03OG0Ci0mL1ReThDfMD2CfAwgGUYjqNIA
 4o9uLo0n+hTYSYMAVVShKP7s41XeSdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728981129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNP8o9fCj/zgYXXIgDgW0xkYh8YrLiq5JRjtVKIa+6o=;
 b=IlVq6KPwSYoWMxoQvAZkYfui8eNNuHhtEwAm0eY08aA2u/r2Y5X8/QRGaKr4YjL65EHTel
 8pBfnuwdxkzByZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF33113A53
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 08:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4fcgMokoDmcSEQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 08:32:09 +0000
Message-ID: <c90a86a7-81c5-4284-9ee3-b3ffbf999724@suse.cz>
Date: Tue, 15 Oct 2024 10:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
References: <20241014160217.28824-1-mdoucha@suse.cz>
Content-Language: en-US
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20241014160217.28824-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
Subject: Re: [LTP] [PATCH 1/3] cve-2015-3290: Make stack selector and CPU
 flags check more verbose
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
I forgot to mention that I've tested these changes on kernel v3.16 
affected by the CVE and the kernel bug was still reproducible.

On 14. 10. 24 18:02, Martin Doucha wrote:
> The original reproducer reported all errors in signal handler and
> triggered INT3 to signal itself. Pass stack selector and CPU flags
> values to C variables and report any discrepancies using standard
> LTP functions.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   testcases/cve/cve-2015-3290.c | 39 ++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
> index 143c98230..4185c22a7 100644
> --- a/testcases/cve/cve-2015-3290.c
> +++ b/testcases/cve/cve-2015-3290.c
> @@ -177,6 +177,8 @@ static greg_t *csptr(ucontext_t *ctx)
>   }
>   #endif
>   
> +#define LDT_SS 0x7
> +
>   static volatile long expected_rsp;
>   static int running = 1;
>   
> @@ -220,6 +222,8 @@ static void set_ldt(void)
>   
>   static void try_corrupt_stack(unsigned short *orig_ss)
>   {
> +	unsigned long flags = 0, new_ss = 0;
> +
>   #ifdef __x86_64__
>   	asm volatile (
>   	      /* A small puzzle for the curious reader. */
> @@ -227,6 +231,7 @@ static void try_corrupt_stack(unsigned short *orig_ss)
>   
>   	      /* Save rsp for diagnostics */
>   	      "mov    %%rsp, %[expected_rsp] \n\t"
> +	      "xorq   %%rax, %%rax    \n\t"
>   
>   	      /*
>   	       * Let 'er rip.
> @@ -255,16 +260,14 @@ static void try_corrupt_stack(unsigned short *orig_ss)
>   
>   	      "subq   $128, %%rsp \n\t"
>   	      "pushfq	 \n\t"
> -	      "testl  $(1<<9),(%%rsp)   \n\t"
> +	      "movq   (%%rsp),%%rdx	 \n\t"
>   	      "addq   $136, %%rsp \n\t"
> -	      "jz 3f      \n\t"
> -	      "cmpl   %[ss], %%eax    \n\t"
> -	      "je 4f      \n\t"
> +	      "jmp    4f      \n\t"
>   	      "3:  int3	   \n\t"
>   	      "4:	     \n\t"
> -	      : [expected_rsp] "=m" (expected_rsp)
> -	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
> -		 : "rax", "rcx", "rdx", "rbp", "r11", "flags"
> +	      : [expected_rsp] "=m" (expected_rsp), "+d" (flags), "+a" (new_ss)
> +	      : [ss] "n" (LDT_SS), [orig_ss] "r" (orig_ss)
> +		 : "rcx", "rbp", "r11", "flags"
>   	);
>   #else
>   	asm volatile (
> @@ -274,6 +277,7 @@ static void try_corrupt_stack(unsigned short *orig_ss)
>   
>   	      /* Save rsp for diagnostics */
>   	      "mov    %%esp, %[expected_rsp] \n\t"
> +	      "xorl   %%eax, %%eax    \n\t"
>   
>   	      /*
>   	       * Let 'er rip.
> @@ -303,18 +307,25 @@ static void try_corrupt_stack(unsigned short *orig_ss)
>   	      "mov    (%[orig_ss]), %%ss \n\t"  /* end corruption */
>   
>   	      "pushf	  \n\t"
> -	      "testl  $(1<<9),(%%esp)   \n\t"
> +	      "movl   (%%esp), %%edx \n\t"
>   	      "addl   $4, %%esp   \n\t"
> -	      "jz 3f      \n\t"
> -	      "cmpl   %[ss], %%eax    \n\t"
> -	      "je 4f      \n\t"
> +	      "jmp    4f      \n\t"
>   	      "3:  int3	   \n\t"
>   	      "4:  mov %%esi, %%ebp   \n\t"
> -	      : [expected_rsp] "=m" (expected_rsp)
> -	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
> -		 : "eax", "ecx", "edx", "esi", "ebp", "flags"
> +	      : [expected_rsp] "=m" (expected_rsp), "+d" (flags), "+a" (new_ss)
> +	      : [ss] "n" (LDT_SS), [orig_ss] "r" (orig_ss)
> +		 : "ecx", "esi", "ebp", "flags"
>   	);
>   #endif
> +
> +	if (!(flags & (1 << 9))) {
> +		tst_res(TFAIL, "Interrupt flag is disabled (0x%lx)", flags);
> +	}
> +
> +	if (new_ss != LDT_SS) {
> +		tst_res(TFAIL, "Wrong stack selector 0x%lx, expected 0x%x",
> +			new_ss, LDT_SS);
> +	}
>   }
>   
>   static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,

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
