Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A94C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5063E96D5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 12:16:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CD833DFDB3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:15:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 965E2600177
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:15:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 308CD21BDC;
 Mon, 31 Aug 2026 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788171340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2v1Dywy+Itd4QAAZ6kBRzUHlivKwDf2a28342xJqfI=;
 b=dsiPOP+ZL94Bt5bGWNqbRbH2jgXs6RFEkIL1ZnMgQnyvgEfNV6qesbh9Jy83Rx0iLppOqe
 n1oCkJSY0TH44S4oPQaAGW0pNXXKerAIU244PnDMyT121DZBtJJ6VnvC3p8bopZQWCquUF
 lnBxB6QP8DvRw/11BsJrTHHKm/IWILg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788171340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2v1Dywy+Itd4QAAZ6kBRzUHlivKwDf2a28342xJqfI=;
 b=Y8M17ayR3bQNsyqRy2twnYHMTEbfkAaThSV9WwHQmR6Z8nZRbM1GqzzyTVkTMnCJoxvR2Z
 VH7MmiIRi0nrhPBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SsxXqbGF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BKVpQetp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788171336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2v1Dywy+Itd4QAAZ6kBRzUHlivKwDf2a28342xJqfI=;
 b=SsxXqbGFqwzOyEyGFxAplb7ZPuTSJVkvXRq+wK6r0JMJJPjsJbmA48P2mq2zN6jFb6mFf2
 05ytbovsmVOfrRZofAmpY6VaWALnQmZeYAXY+4FpnClpNpyjPy++s181EZjwc+ika03f93
 SaUxhvAqJJVPkzilJZ8IQPJnl5c5UK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788171336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2v1Dywy+Itd4QAAZ6kBRzUHlivKwDf2a28342xJqfI=;
 b=BKVpQetpQO6aNV6Up+G7dzK9J/kGbmLnj4Aj24oZSarLyjaCrTPI5DEZh2tmvS3I3kYEWh
 6YY0M03hyAKnbWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030EB13682;
 Mon, 31 Aug 2026 10:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aVm5AEhUlWqsAQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Aug 2026 10:15:36 +0000
Date: Mon, 31 Aug 2026 12:15:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <apVUR0360UHO0KMt@yuki.lan>
References: <20260819093210.24342-1-avinesh.kumar@suse.com>
 <20260819103310.39525-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260819103310.39525-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 308CD21BDC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,codebrowser.dev:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Skip untestable optional
 behavior on Linux
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > openposix: timer_*/speculative: Skip untestable optional behavior on Linux
> 
> > +#ifdef __linux__
> > +	printf("Linux does not implement this optional behavior\n");
> > +	return PTS_UNSUPPORTED;
> > +#else
> 
> Could these branches be removed from all eleven tests? Linux 7.2 uses
> scoped_timer_get_or_fail() to return -EINVAL for invalid timer IDs in
> timer_gettime(), timer_getoverrun(), timer_settime(), and timer_delete().
> The installed man pages document the same EINVAL result.
> 
> More directly, every pre-patch test reports errno == EINVAL and returns
> PTS_PASS when built and run on Linux. The platform check therefore replaces
> working coverage with PTS_UNSUPPORTED, and the quoted runtime message is not
> accurate.

That's the kernel part, apparently it's more complex in libc.

Libc has two types of timer_t values, either it's a directly kernel
timer id (small int) or a pointer to a structure that holds the id.

The timer libc functions, before calling the kernel syscall, convert the
libc timer id into kernel timer id with:

static inline kernel_timer_t
timerid_to_kernel_timer (timer_t timerid)
{
  if (timer_is_sigev_thread (timerid))
    return timerid_to_timer (timerid)->ktimerid;
  else
    return (kernel_timer_t) ((uintptr_t) timerid);
}

The library does a bit of magic with the pointers:

https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/kernel-posix-timers.h.html

But overall it checks the MSB bit of the pointer to figure out if it's
kernel timer id which should be passed verbatim, or a structure that
needs to be dereferenced.

Looking at the timer_gettime/speculative/6-1.c we do pass a pointer to
the stack (instead of the invalid value) which on 32bit may be an
address with the MSB bit set. So this triggers undefined behavior, since
glibc thinks it's a pointer to it's internal data structure, but the
real pointer the glibc exports as the timer is bit-shifted. Hence we
access random and possibly invalid address. With some luck that address
is accesible and contains non-zero data and we end up passing invalid
timer ID to the kernel, but when I straced the test, the value was
pretty much random.

With that in mind, we can fix the test with passing the BOGUSID instead
of random stack pointer:

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index d09c2f709..c35dd816f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -21,8 +21,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
        timer_t tid;
        struct itimerspec its;
-       int tval = BOGUSTID;
-       tid = (timer_t) & tval;
+       tid = (timer_t) BOGUSTID;
        if (timer_gettime(tid, &its) == -1) {
                if (EINVAL == errno) {
                        printf("fcn returned -1 and errno==EINVAL\n");


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
