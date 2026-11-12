Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCB606A327
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3EmuKgAN;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c3cAwa/5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3EmuKgAN;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c3cAwa/5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BA6E3E94EB
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 11:44:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC1F03E94DA
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:44:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4BA786002FC
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:44:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37F9921BEF;
 Thu, 12 Nov 2026 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794480274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLZkCNdzKni40Lj/gLwTPZK3z15IvMmuK87uhMMECaM=;
 b=3EmuKgANyssXbD1BGSKmXIm7nHvPcD4TR2Du6Sx7LbflWucsV/aNAqjFCxGbfOARX1hAlh
 JJVlxqqkwY89wBwQ6uT+u+UA/TLQG2O46w636A0elhNPNJo3YifukyaBke5qbdFp6ujZw2
 UU2my5GmIFmEHtj+ZSfRYS8wqSMq2wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794480274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLZkCNdzKni40Lj/gLwTPZK3z15IvMmuK87uhMMECaM=;
 b=c3cAwa/56RDPHXlotTfpHtyJ24SWiRQShE+W/oH1dapjK7JQm0bxQtd3BZYaT92dqM1Dxf
 EGsjK2jnPOnIgZCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3EmuKgAN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="c3cAwa/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794480274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLZkCNdzKni40Lj/gLwTPZK3z15IvMmuK87uhMMECaM=;
 b=3EmuKgANyssXbD1BGSKmXIm7nHvPcD4TR2Du6Sx7LbflWucsV/aNAqjFCxGbfOARX1hAlh
 JJVlxqqkwY89wBwQ6uT+u+UA/TLQG2O46w636A0elhNPNJo3YifukyaBke5qbdFp6ujZw2
 UU2my5GmIFmEHtj+ZSfRYS8wqSMq2wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794480274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLZkCNdzKni40Lj/gLwTPZK3z15IvMmuK87uhMMECaM=;
 b=c3cAwa/56RDPHXlotTfpHtyJ24SWiRQShE+W/oH1dapjK7JQm0bxQtd3BZYaT92dqM1Dxf
 EGsjK2jnPOnIgZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0FC13432;
 Thu, 12 Nov 2026 10:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZpPkNZGY9WrmVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Nov 2026 10:44:34 +0000
Date: Thu, 12 Nov 2026 11:44:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <avWYppFIwRoUX-qk@yuki.lan>
References: <20261111081150.15101-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261111081150.15101-1-wegao@suse.com>
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 37F9921BEF
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapon04: Settle udev after mkswap to prevent
 tmpfs hole filling
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
> index de95849e3..141456442 100644
> --- a/testcases/kernel/syscalls/swapon/swapon04.c
> +++ b/testcases/kernel/syscalls/swapon/swapon04.c
> @@ -138,6 +138,7 @@ static void verify_swapon(unsigned int n)
>  	struct stat st;
>  	blkcnt_t blocks_before, blocks_after;
>  	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
> +	const char *const udevadm_argv[] = {"udevadm", "settle", NULL};
>  
>  	tst_res(TINFO, "Testing swapon(%s, %s)", loop_dev, tc->desc);
>  
> @@ -148,6 +149,7 @@ static void verify_swapon(unsigned int n)
>  	SAFE_CLOSE(fd);
>  
>  	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", 0);
> +	tst_cmd(udevadm_argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
>  
>  	SAFE_STAT(BACKING_FILE, &st);
>  	blocks_before = st.st_blocks;

The udevadm has to be added to .needs_cmds as well:

diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
index de95849e3..15a7c1063 100644
--- a/testcases/kernel/syscalls/swapon/swapon04.c
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -195,6 +195,7 @@ static struct tst_test test = {
        },
        .needs_cmds = (struct tst_cmd[]) {
                {.cmd = "mkswap"},
+               {.cmd = "udevadm"},
                {}
        },
        .needs_kconfigs = (const char *[]) {


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
