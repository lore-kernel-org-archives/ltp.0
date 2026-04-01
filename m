Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCADFD35171
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 10:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 270BE3E5BDB
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 12:44:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AA593CAFF3
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 12:44:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9268E600633
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 12:44:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF8E85BCC4;
 Wed,  1 Apr 2026 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775040243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoDxmbjQnsElhcnxY5OxB6UiaP/6ZSDgxUA8Ww6Bg0=;
 b=M6QgEY/Q1LjTMufv6HGa2pTQdKcIMM8SDUyDNOSJ1V2O39pgillnLLPFJI/UtzkQAYpTPw
 nP2Mlj+YkpcNYtPBIkbzdx2hl3dBTPeIAvoe0xKTgz+vkQg+yi4cITzfdIxhOBWb0Emml5
 ooUSfk8JCt4++TSqJbueYYAmGTwJ93s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775040243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoDxmbjQnsElhcnxY5OxB6UiaP/6ZSDgxUA8Ww6Bg0=;
 b=GqYWUVXIKxvixasT2mEq5wnOQx/YmXmTIg6WkRGj3hDectVbF93NZWiInnDHHH2ynbnokW
 V47O7tCG6Bl7MABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775040243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoDxmbjQnsElhcnxY5OxB6UiaP/6ZSDgxUA8Ww6Bg0=;
 b=M6QgEY/Q1LjTMufv6HGa2pTQdKcIMM8SDUyDNOSJ1V2O39pgillnLLPFJI/UtzkQAYpTPw
 nP2Mlj+YkpcNYtPBIkbzdx2hl3dBTPeIAvoe0xKTgz+vkQg+yi4cITzfdIxhOBWb0Emml5
 ooUSfk8JCt4++TSqJbueYYAmGTwJ93s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775040243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoDxmbjQnsElhcnxY5OxB6UiaP/6ZSDgxUA8Ww6Bg0=;
 b=GqYWUVXIKxvixasT2mEq5wnOQx/YmXmTIg6WkRGj3hDectVbF93NZWiInnDHHH2ynbnokW
 V47O7tCG6Bl7MABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17444A0B0;
 Wed,  1 Apr 2026 10:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3+BkLvP2zGlMFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 01 Apr 2026 10:44:03 +0000
Date: Wed, 1 Apr 2026 12:44:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <acz2-zdwe7K58lzW@yuki.lan>
References: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
 <20260330102909.863484-3-vasileios.almpanis@virtuozzo.com>
 <acz1ZwkNHRFjnJ1_@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acz1ZwkNHRFjnJ1_@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] memcg: scale memcontrol03 checkpoint timeouts
 for slow kernels
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
> > +#define CHECKPOINT_TIMEOUT_MS (tst_multiply_timeout(10) * 1000)
> 
> Wouldn't it make more sense to use the tst_multiply_timeout() directly
> in the checkpoint library and hide that complexity from the tests?

If I'm not missing something it should be as easy as:

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index f2faf6563..82f6ab87c 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -37,6 +37,8 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
                return -1;
        }

+       msec_timeout = tst_multiply_timeout(msec_timeout);
+
        timeout.tv_sec = msec_timeout/1000;
        timeout.tv_nsec = (msec_timeout%1000) * 1000000;

@@ -61,6 +63,8 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
                return -1;
        }

+       msec_timeout = tst_multiply_timeout(msec_timeout);
+
        for (;;) {
                waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
                                 INT_MAX, NULL);


And with that ALL checkpoints timeouts will be increased on slow
machines.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
