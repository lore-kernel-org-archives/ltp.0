Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1367606A326
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z+blBRw4;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mL6CN7f6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z+blBRw4;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mL6CN7f6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A6963C9C7E
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 21:14:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A1FB3C9B18
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 21:14:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 47D1D1400046
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 21:14:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 094D51FAD1;
 Tue,  3 Nov 2026 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793736853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMayGcvGMJ0gIOIAh0FP9O2BXLRMRnAMuFnrfgVc3aI=;
 b=Z+blBRw4vZFs4C/qqYq/mfgZBNeHrFnwxKScl+i61+r1EfECl2ZxirYhE58W/ZEY9fjvR2
 umghD+bgenETpXmWRB1kWG4t8nbiIax5V5vfPc1X16GJaGkTIZNC8tm6aq0sqxEbheJt3U
 UwuxTOEXxpe3rYXiInGxwBNWOihfkCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793736853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMayGcvGMJ0gIOIAh0FP9O2BXLRMRnAMuFnrfgVc3aI=;
 b=mL6CN7f6jEMdB9/sDQwjvRXbItH2bIB1G47M9eYGytVoR8uIwpwMjBL2Y7rOSMDMjE8Qbg
 OuGvn5zpWDU9cuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793736853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMayGcvGMJ0gIOIAh0FP9O2BXLRMRnAMuFnrfgVc3aI=;
 b=Z+blBRw4vZFs4C/qqYq/mfgZBNeHrFnwxKScl+i61+r1EfECl2ZxirYhE58W/ZEY9fjvR2
 umghD+bgenETpXmWRB1kWG4t8nbiIax5V5vfPc1X16GJaGkTIZNC8tm6aq0sqxEbheJt3U
 UwuxTOEXxpe3rYXiInGxwBNWOihfkCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793736853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMayGcvGMJ0gIOIAh0FP9O2BXLRMRnAMuFnrfgVc3aI=;
 b=mL6CN7f6jEMdB9/sDQwjvRXbItH2bIB1G47M9eYGytVoR8uIwpwMjBL2Y7rOSMDMjE8Qbg
 OuGvn5zpWDU9cuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0E6A134B8;
 Tue,  3 Nov 2026 20:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NoVlIJRA6moaZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Nov 2026 20:14:12 +0000
Date: Tue, 3 Nov 2026 21:14:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Attila Fazekas <afazekas@redhat.com>
Message-ID: <20261103201410.GB154873@pevik>
References: <20261102105704.1577364-1-afazekas@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261102105704.1577364-1-afazekas@redhat.com>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Attila,

> Currently, stress_child() allocates memory in an infinite loop without
> bounds. Under memory pressure, once the cgroup memory limit is reached
> and the parent's droppable pages are reclaimed, the child continues
> allocating non-droppable heap memory. This eventually exhausts the cgroup
> limit and triggers the cgroup OOM killer, terminating either the child or
> the test parent process.

> Fix this by bounding the child's allocation to CHILD_ALLOC_MAX
> (ALLOC_SIZE + 32MB). The total requested memory (128MB parent + 160MB
> child = 288MB) exceeds the 256MB cgroup limit by 32MB, which reliably
> forces the kernel to reclaim MAP_DROPPABLE pages. Once CHILD_ALLOC_MAX is
> reached, the child calls pause() to keep memory resident. Since 160MB is
> well below the 256MB cgroup limit, non-droppable memory alone cannot
> trigger an OOM.

LGTM, but it'd be nice if somebody else double check.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Assisted-by: Gemini CLI
> Signed-off-by: Attila Fazekas <afazekas@redhat.com>
> ---
>  testcases/kernel/syscalls/mmap/mmap22.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
> index 0b95c578f..16fcb6dd8 100644
> --- a/testcases/kernel/syscalls/mmap/mmap22.c
> +++ b/testcases/kernel/syscalls/mmap/mmap22.c
> @@ -26,6 +26,7 @@

>  #define MEM_LIMIT (256 * TST_MB)
>  #define ALLOC_SIZE (128 * TST_MB)
> +#define CHILD_ALLOC_MAX (ALLOC_SIZE + 32 * TST_MB)

>  static struct tst_cg_group *cg_child;
>  static pid_t child;
> @@ -33,13 +34,15 @@ static int page_size;

>  static void stress_child(void)
>  {
> -	for (;;) {
> +	for (size_t sz = 0; sz < CHILD_ALLOC_MAX; sz += page_size) {
>  		char *buf = malloc(page_size);

>  		if (!buf)
> -			exit(1);
> +			break;
>  		memset(buf, 'B', page_size);
>  	}
> +
> +	pause();
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
