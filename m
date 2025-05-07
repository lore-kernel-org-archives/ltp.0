Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FAFC3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 14:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBF0C3CBDA0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 16:23:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0E8A3CBD49
 for <ltp@lists.linux.it>; Wed,  7 May 2025 16:22:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FAF2200BB9
 for <ltp@lists.linux.it>; Wed,  7 May 2025 16:22:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07CB22121E;
 Wed,  7 May 2025 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746627771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IfQSt6fP9THWhkizfyFpl9ivT444+KOe0clSrMCMQE=;
 b=RgfFBERoIbTsRPE+JrURIBhfg8Mbw5FmaWSdo4ExVO8DM0TuBaaSMLsOOahDv86JIJDCrZ
 k5v3qh3eO+rTsqTQggwsvDu0wFHlo1PkSPIApc8s4wdHuR2fJQckadHrYc8o7ISEWXusc0
 jJvjePfSO5g5LLfKZNmqzJyzaV2cUow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746627771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IfQSt6fP9THWhkizfyFpl9ivT444+KOe0clSrMCMQE=;
 b=g5pZ9KdkU51+m3tL2ILzsKk1nchP09g1s6omYRMlnnHdZttpq4G88rWspVGfSBoMcxfwkS
 I/H6s1Tzna6ohABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746627770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IfQSt6fP9THWhkizfyFpl9ivT444+KOe0clSrMCMQE=;
 b=Xg9pOgWTo36T3SXpCElM3/gUYqmfcT0RpJOGQNdpukeRrCmFxSiIPCS916eO2R8oMbJEQm
 w0xm9eV/+bdourSoksqz/IZBcfrcjrcOLx+iGAbOrnwB3K41pVh2IEzeRJHIr06o1YIvL4
 I16C26P25HJ2ahkZWP9XOocJ+tNplr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746627770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IfQSt6fP9THWhkizfyFpl9ivT444+KOe0clSrMCMQE=;
 b=KHWQw0SXnIEtg+e9C2aEbRrVpuVr8vrglJb7eUslTMR1TL0b1gCvpne9sng7barKkcY0rh
 Ky7oQy9o7OqO/nAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDDB0139D9;
 Wed,  7 May 2025 14:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAAqNrlsG2hlVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 May 2025 14:22:49 +0000
Date: Wed, 7 May 2025 16:23:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aBts4kDaqLKLJUuw@yuki.lan>
References: <20250505105310.15072-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250505105310.15072-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
> The first trunk_G allocation has 2MB safety margin to avoid triggering
> OOM killer. However, on systems with 64K pagesize, this may not be enough.
> Account for process size as reported by cgroup memory stats before
> allocating memory in child processes.

Is there a reason to keep the 2MB safety after this patch?

Or can we do:

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index b5bbb9954..e7f126880 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -200,7 +200,7 @@ static void test_memcg_min(void)
                sleep(1);
        }

-       alloc_anon_in_child(trunk_cg[G], MB(148), 0);
+       alloc_anon_in_child(trunk_cg[G], MB(150), 0);

        SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
        TST_EXP_EXPR(values_close(c[0], MB(50), 5),

> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -94,17 +94,23 @@ static void cleanup_sub_groups(void)
>  }
>  
>  static void alloc_anon_in_child(const struct tst_cg_group *const cg,
> -				const size_t size, const int expect_oom)
> +	size_t size, const int expect_oom)
>  {
>  	int status;
>  	const pid_t pid = SAFE_FORK();
> +	size_t cgmem;
>  
>  	if (!pid) {
>  		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> +		SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
> +		size = size > cgmem ? size - cgmem : 0;

Here we depend on the fact that process memory has been properly
accounted for when it starts running its code. Are you sure that we can
rely on this or does this just happen to work?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
