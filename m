Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BD4CA5FCB
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 15:04:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9B533E5B8F
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 17:04:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DB733E5B96
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 17:04:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A44A600351
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 17:04:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9500F21E01;
 Thu,  1 Oct 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790867042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0JlTv/tVZBexdPiQ7IWHZBzq3lCCepccAnjCuLcnbE=;
 b=kZzn+g8wD/kUNKhfYacc4rHg2bX5em5yragCidakJ7nDF5hFIWOV3By0Bzua/GyV4mfIfW
 S5fRPfnGQqEWAfw4AfVJqD7WipTiKJiLvMSCqEKdEakeRFaYbWkmXAMiE2GghuXwG1Iu/C
 dnA9GCPzIVKWmm8b56QsyitN+//H6Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790867042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0JlTv/tVZBexdPiQ7IWHZBzq3lCCepccAnjCuLcnbE=;
 b=Mnt7tS3sOQLAPlQxJtLzMTJmxs2snsvhFyd88PLHDQEiGrV7PiHiocisAJKrSXIXAK6CUW
 DgGCiXqT22zz8xBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790867038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0JlTv/tVZBexdPiQ7IWHZBzq3lCCepccAnjCuLcnbE=;
 b=Upn3Cqim1by3e26PNtRm4ow7vuzKvB8qkjumEN9QoQLdbT+vEK3O2/YgVI3ZUMrzTJuoKA
 C3DGN7nLhWMvbNJcAcTxUaBl8MgNkzPWAb2kZysTjQetAseM/z1DLT+ZfuNIcSZBPcV58O
 H+XxIY5gwQ5GrP62vWe1GSx1OMxeV0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790867038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0JlTv/tVZBexdPiQ7IWHZBzq3lCCepccAnjCuLcnbE=;
 b=QsXDi7BoAbkCVe4+4zSBeFQFbj+JejfS5ExaM4akVi/5dNJc3R1qS5oYi0Jqssri78jvwT
 ttdVYDiKfUt3uMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9383613B8D;
 Thu,  1 Oct 2026 15:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hC7YE112vmr7GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Oct 2026 15:03:57 +0000
Date: Thu, 1 Oct 2026 17:03:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20261001150341.GA3016304@pevik>
References: <20260930201430.1924463-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930201430.1924463-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_clone: Fix child detection on sparc
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

> On sparc the clone syscall returns the caller's thread id in the child,
> not 0. So the child thinks it is the parent.

> Compare with tst_gettid() in the clone fallback. clone3 returns 0, but
> sparc only has it since v7.0.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> v2 -> v3: use tst_gettid(), the kernel returns the caller's thread id
> to the child. And only get it in the clone fallback, as the AI review
> suggested.

> v1 -> v2: fixed the AI review comments, use tst_getpid() since glibc
> before 2.25 caches getpid(), and only check after clone, so the goto
> is gone.

>  lib/tst_clone.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index 296cd40ac0a0..a04c4042653b 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -35,6 +35,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)

>  	flags = args.exit_signal | args.flags;

> +#ifdef __sparc__
> +	pid_t tid = tst_gettid();

Unfortunately, we haven't realized that this will not work in the PID namespace
(CLONE_NEWPID). Agent's finding (run locally):

	- In the child, the old sparc clone puts current->pid into %o0
	  (arch/sparc/kernel/process_64.c:634, process_32.c:365). That is the
	  parent's global thread id.
	- tst_gettid() returns the thread id as seen inside the namespace
	  (kernel/sys.c:1007).
	- Inside a namespace the two numbers differ, so the child takes the parent's
	  code path.

And concrete way how this can be manifested is e.g.
testcases/kernel/containers/pidns/pidns05.c:

	pidns05: child_func() runs as pid 1 in a new namespace and calls
	SAFE_CLONE(). The grandchild sees a number other than 1, behaves as the
	parent and sits in pause() until the checkpoint times out.

Sounds reasonable, could you please verify it?

Agent suggests to check the second return value in %o1 instead (1 in the child,
0 in the parent), as glibc's sparc fork/clone wrappers do).

Looking into glibc sources there is indeed clone() sparc specific assembly:
sysdeps/unix/sysv/linux/sparc/sparc32/clone.S
sysdeps/unix/sysv/linux/sparc/sparc64/clone.S

Agent even suggested assembly which has similar fragments, but of course we'd
strive to avoid using it unless really necessary.

#ifdef __sparc__
/*
 * On sparc, clone() returns the parent's global thread id in %o0 in the
 * child, which cannot be compared with gettid() inside a pid namespace.
 * The kernel sets %o1 to 1 in the child and 0 in the parent, but syscall()
 * drops %o1, hence inline assembly.
 */
static pid_t sparc_clone(unsigned long flags, unsigned long pidfd)
{
	register long g1 __asm__("g1") = __NR_clone;
	register long o0 __asm__("o0") = flags;
	register long o1 __asm__("o1") = 0;
	register long o2 __asm__("o2") = pidfd;
	register long o3 __asm__("o3") = 0;
	register long o4 __asm__("o4") = 0;

	__asm__ __volatile__(
# ifdef __arch64__
		"ta 0x6d\n\t"
		"bcc,pt %%xcc, 1f\n\t"
# else
		"ta 0x10\n\t"
		"bcc 1f\n\t"
# endif
		" mov 0, %%g1\n\t"
		"mov 1, %%g1\n"
		"1:"
		: "+r" (g1), "+r" (o0), "+r" (o1), "+r" (o2), "+r" (o3), "+r" (o4)
		:
		: "cc", "memory");

	if (g1) {
		errno = o0;
		return -1;
	}

	return o1 ? 0 : o0;
}
#endif

Regard that use of tst_gettid() instead of tst_getpid() suggested for v2 by
agent [1]:

	the SPARC kernel returns the caller's TID (current->pid) in %o0 to the
	child, so use tst_gettid() instead of tst_getpid() to support multithreaded
	callers.

Sure, LTP has tests which use threads, but many of them use
pthread_create() instead of SAFE_CLONE()/tst_clone() (which you're trying to
fix).

IMHO there is only testcases/kernel/syscalls/fanotify/fanotify21.c, but even
that test is safe, because SAFE_CLONE() is call for a different test case than
pthread usage.

But of course it does not harm to have it.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260929111636.7777-1-linuxtestproject.agent@gmail.com/

> +#endif
> +
>  #ifdef __s390x__
>  	pid = syscall(__NR_clone, NULL, flags, args.pidfd, NULL, NULL);
>  #else
> @@ -44,5 +48,10 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	if (pid == -1)
>  		return -2;

> +#ifdef __sparc__
> +	if (pid == tid)
> +		pid = 0;
> +#endif
> +
>  	return pid;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
