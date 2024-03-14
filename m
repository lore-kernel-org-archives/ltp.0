Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4DDC5475B
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 11:25:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0825A3D018D
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 12:25:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456583C06A6
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 12:25:37 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7383C144214D
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 12:25:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D3B121D23;
 Thu, 14 Mar 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710415534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cX+t/YBNvDezcqamjWVrXVdSbSEchpvuJH5cCXrBO5M=;
 b=Xd+yA5HLeV7Vby98NaHdWjHA19fgiTaiKNcbKOBS2AshXZIzjje9tVUst1dV7myW9/830g
 96xqhzPi3BPk9f3ocLPa8e7h3EY9LK1BxZmLqFx+iTMfuX8uhRq8UUnmRaUOsi0gWY+CZF
 F/6xTANlgfZVUWOqLXAOWwyhss1R/SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710415534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cX+t/YBNvDezcqamjWVrXVdSbSEchpvuJH5cCXrBO5M=;
 b=aTS5dzX4z2lm4KHDZ1WfATP9Sdux1B31D0A+iVNBeO1amXS4eRi2jPfod9svAM3CHIGdHS
 nTDI/QjrToJapLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710415534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cX+t/YBNvDezcqamjWVrXVdSbSEchpvuJH5cCXrBO5M=;
 b=Xd+yA5HLeV7Vby98NaHdWjHA19fgiTaiKNcbKOBS2AshXZIzjje9tVUst1dV7myW9/830g
 96xqhzPi3BPk9f3ocLPa8e7h3EY9LK1BxZmLqFx+iTMfuX8uhRq8UUnmRaUOsi0gWY+CZF
 F/6xTANlgfZVUWOqLXAOWwyhss1R/SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710415534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cX+t/YBNvDezcqamjWVrXVdSbSEchpvuJH5cCXrBO5M=;
 b=aTS5dzX4z2lm4KHDZ1WfATP9Sdux1B31D0A+iVNBeO1amXS4eRi2jPfod9svAM3CHIGdHS
 nTDI/QjrToJapLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 391F11386E;
 Thu, 14 Mar 2024 11:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dPQODa7e8mXvYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 14 Mar 2024 11:25:34 +0000
Date: Thu, 14 Mar 2024 12:24:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZfLecCIWbfNQ4WTa@yuki>
References: <20240308023312.25449-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308023312.25449-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xd+yA5HL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aTS5dzX4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[45.98%]
X-Rspamd-Queue-Id: 4D3B121D23
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] memcontrol03: Using clean page cache to avoid
 dependency on IO rate
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
> Bad IO situation(storage bandwidth ~10MB/sec) will lead background
> writeback has uncertain progress for dirty page. So system can not
> reclaim enough memory for new process and finally lead a unexpected
> OOM.
> 
> memcontrol03.c:218: TPASS: Expect: (A/B/E memory.current=0) ~= 0
> memcontrol03.c:116: TPASS: Child 1918 killed by OOM
> memcontrol03.c:224: TPASS: Expect: (A/B memory.current=52588544) ~= 52428800
> memcontrol03.c:129: TFAIL: Expected child 1944 to exit(0), but instead killed by SIGKILL

This is strange the order of messages here does not make any sense. the
last line in the log shouldn't be there at all, the test should have
ended with the "Expect: (A/B memory.current=52588544) ~= 52428800"

Can you please send the whole log?

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol03.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index 9c6c808e0..9903ba82b 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -201,6 +201,7 @@ static void test_memcg_min(void)
>  		sleep(1);
>  	}
>  
> +	sync();
>  	alloc_anon_in_child(trunk_cg[G], MB(148), 0);
>  
>  	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
> @@ -217,6 +218,7 @@ static void test_memcg_min(void)
>  	TST_EXP_EXPR(values_close(c[2], 0, 1),
>  		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
>  
> +	sync();
>  	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
>  
>  	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
