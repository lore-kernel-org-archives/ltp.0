Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B9AEB64DD
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 08:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10FEE3CECF7
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 10:09:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E81D3C0313
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:09:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51C47200906
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:09:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3817B22572;
 Wed, 12 Jul 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689149378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqySGfYcKUfpbBRj9d1Vxzt+VVJJegvGTCtCornxu7I=;
 b=1DzgvRPA60k21tKpUNdKGc/p/Xh7+7sztOlltAZvs9PoYXnqd7KehIVMfqOW6dVzRhPdrL
 D7NBvknoQ79G94D1bKcWupJ1aB0W0y2rjVXsi8d8oNfsVNSohmEuFQA/PyIZVdiEXRrQIi
 3aZ64Skv3L5gJQdWGCnaS1BnJ142NXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689149378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqySGfYcKUfpbBRj9d1Vxzt+VVJJegvGTCtCornxu7I=;
 b=CyrL0IeoL5Z9I/lcEVuZfqDgWOa2RtNbeu1Cd3kkTfzZ0VvhJGftdlx03V7M13RdGhv3rq
 +rPbqTOFwv8vCvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E62C13336;
 Wed, 12 Jul 2023 08:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RVYEAsJfrmTkPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jul 2023 08:09:38 +0000
Date: Wed, 12 Jul 2023 10:09:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <20230712080936.GA756025@pevik>
References: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] security/stack_clash: Add test for mmap()
 minding gap
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
Cc: Liam.Howlett@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Rick,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> This logic is somewhat x86_64 specific, but may work for other
> architectures. Make the test only run on x86_64 for now.
...
> v3:
>  - Use lapi/mmap.h (Petr Vorel)

> v2:
>  - Add fixes commit (Cyril Hrubis)
>  - Report placement test failure separately (Cyril Hrubis)
>  - Use SAFE_FILE_SCANF (Cyril Hrubis)
>  - Don't quit after failing placement test, so unmap the mapping that
>    caused the failure. (Cyril Hrubis)
>  - Drop CAN_DO_PLACEMENT_TEST (Cyril Hrubis)
> ---
>  testcases/cve/stack_clash.c | 81 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)

nit: You might want to add your copyright.

> diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
> index cd7f148c2..50a401e96 100644
> --- a/testcases/cve/stack_clash.c
> +++ b/testcases/cve/stack_clash.c
> @@ -18,11 +18,18 @@
>   * to infinity and preallocate REQ_STACK_SIZE bytes of stack so that no calls
>   * after `mmap` are moving stack further.
>   *
> + * If the architecture meets certain requirements (only x86_64 is verified)
> + * then the test also tests that new mmap()s can't be placed in the stack's
> + * guard gap. This part of the test works by forcing a bottom up search. The
> + * assumptions are that the stack grows down (start gap) and either:
> + *   1. The default search is top down, and will switch to bottom up if
> + *      space is exhausted.
> + *   2. The default search is bottom up and the stack is above mmap base
> + *
>   * [1] https://blog.qualys.com/securitylabs/2017/06/19/the-stack-clash
>   * [2] https://bugzilla.novell.com/show_bug.cgi?id=CVE-2017-1000364
>   */

Doc could be turned into our docparse format (to place text in our automatically
generated documentation), but I can do it afterwards.

...

> +static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
> +{
> +	void *map_test_gap;
> +
> +	force_bottom_up();
> +
> +	/*
> +	 * force_bottom_up() used up all the spaces below the stack. The search down
> +	 * path should fail, and search up might take a look at the guard gap
> +	 * region. If it avoids it, the allocation will be above the stack. If it
> +	 * uses it, the allocation will be in the gap and the test should fail.
> +	 */
> +	map_test_gap = SAFE_MMAP(0, MAPPED_LEN,
> +				 PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, 0, 0);
> +
> +	if (stack_addr - gap <= (unsigned long)map_test_gap &&
> +		(unsigned long)map_test_gap <= stack_addr) {
> +		tst_res(TFAIL, "New mmap was placed in the guard gap.");
> +		SAFE_MUNMAP(map_test_gap, MAPPED_LEN);
> +	}
> +}
> +
>  void do_child(void)
>  {
>  	unsigned long stack_addr, stack_size;
> @@ -179,6 +252,11 @@ void do_child(void)
>  	dump_proc_self_maps();
>  #endif

> +#ifdef __x86_64__
I wonder whether we should consider 32 bit as well:

#if defined(__x86_64__) || defined(__i386__)

Or is it really just for 64 bit?

> +	do_mmap_placement_test(stack_addr, gap);
> +#endif
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
