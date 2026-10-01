Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F83CA5FD2
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 13:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 778CE3E5DB2
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 15:57:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ACC63E57FC
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 15:56:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1FCE21A010AC
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 15:56:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD36121DC5;
 Thu,  1 Oct 2026 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790862998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qSzjYyEW12Osr/q2OAk9FWsldKZdAwRcQYbTZ+BbBc=;
 b=VWfayV4lYlwctlh+Jm+cO7XJrrcNnAUJgmffgLWs2lfyrerErl8GGEnLhKcjlpbmioarKY
 rij5+j+7dBuo66qJ2vudxVAIlpGi5GrJq+0Sk1ZT19AOE44nzUIoqkg2oPOXHE4e5ooItj
 gSfAXjC0tPAcYR4V7TJmBJgn+XJWTEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790862998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qSzjYyEW12Osr/q2OAk9FWsldKZdAwRcQYbTZ+BbBc=;
 b=jPV6n//aAALL4Nj9JhmBq6r9CuiWTtjqh0iiwLPbd/B23rx9gWINy0mEV0zTV8nUYo0U1k
 8emkOo7ZXccMCUDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bvYWVxsh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="gzFGE/ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790862994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qSzjYyEW12Osr/q2OAk9FWsldKZdAwRcQYbTZ+BbBc=;
 b=bvYWVxshGjwkhLJHJzPPl4Qd5AWsi6DE2cdbVIaCglqDLdklBN8L6Gy4N8zweWQjqdRwWt
 O7MRhpc4wTchFLt/y2CNF38rtO/W3n6hTpETXFvlWYUMiZTE1NPtAHfLMZo5RSv1Eo84/R
 c9pBIn6QHYQjWet0fhylK8flBMAr6u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790862994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qSzjYyEW12Osr/q2OAk9FWsldKZdAwRcQYbTZ+BbBc=;
 b=gzFGE/ekQoCskUDoOPz2nPrWR7wbg+HqvJVLTUFDq87OOGSHolRAxApFinl/jbhTbI9y+1
 oJzX+RTjUm64OaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AEC013B7E;
 Thu,  1 Oct 2026 13:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MwtjFZJmvmq7TgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 01 Oct 2026 13:56:34 +0000
Date: Thu, 1 Oct 2026 15:56:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sushmitha <sushmita@linux.ibm.com>
Message-ID: <ar5mkkYlCp-Obadb@yuki.lan>
References: <20261001110953.32332-1-sushmita@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261001110953.32332-1-sushmita@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD36121DC5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_core02: modernize test using LTP cgroup API
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
> cgroup_core02 tests that when a task writes to an fd opened by a
> different task, the permission check uses the cgroup namespace of
> the opening task (regression test for CVE-2021-4197).
> 
> Modernize the test to align with current LTP coding standards:
> 
> - Replace TEST()/TST_RET/TST_ERR pattern with TST_EXP_FAIL(), which
>   provides cleaner error checking and better formatted test output.
> 
> - Replace manual tst_res(TFAIL,...) + exit(1) on clone/fd failure
>   with tst_brk(TBROK,...), which is the correct way to abort on an
>   unexpected infrastructure failure inside a forked child.
> 
> - Drop unused variable 'int status' and pass NULL to SAFE_WAITPID()
>   since the clone child exit status is not inspected.
> 
> - Remove redundant and unused headers: <stdlib.h>, <stdio.h>,
>   <sys/types.h> and "tst_safe_file_at.h".
> 
> - Expand the test header comment to use the [Description]/[Algorithm]
>   block format required by current LTP documentation standards.
> 
> - Fix minor whitespace issues: extra spaces in SAFE_CG_FCHOWN() calls,
>   struct initializer brace, and .needs_cgroup_ctrls array initializer.

While these changes does sound reasonable.

> No functional change to the test logic.
> 
> Signed-off-by: Sushmitha <sushmita@linux.ibm.com>
> ---
>  cgroup_core02.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 cgroup_core02.c

This patch is completely wrong, it just add new file with the
modifications. The patch should include only differencies between the
current code in git and the updated version.

So first of all you should learn how to checkout a git repository and
generate proper patches.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
