Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5D8C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 06:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE4F23CDB41
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 08:41:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7391C3C81B3
 for <ltp@lists.linux.it>; Tue,  7 May 2024 08:41:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 69E76140EBFD
 for <ltp@lists.linux.it>; Tue,  7 May 2024 08:41:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C112F33A52;
 Tue,  7 May 2024 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715064070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=no0Wyhn+FyieX6hroAMAwjZh0taxl8mxxjvXP+h8Ah8=;
 b=oiq18PnQan0RRYIpWGqkIOBDFu2qvAHmMbqfYyjAJQm9BN9nlrORzD8iKx5jcPYblsIfYY
 KBgw6aDDjpA7FDvAYgNbk1q9YgQmp/DBdG85LoPSEE2ATMQ7f1Jvj+G7q/51oRl4LVAJBJ
 IZpA03WtCjCneVRR/CRW3xaGjRINkEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715064070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=no0Wyhn+FyieX6hroAMAwjZh0taxl8mxxjvXP+h8Ah8=;
 b=EfbFnfdjGxkOl1q0Bnp5GRyzezsuNo/7UQpB2mDT9FDzJY8Tc+GinkVRrDHKHjiJOwzjtp
 ugOOG4fOdTsqtlAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oiq18PnQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EfbFnfdj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715064070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=no0Wyhn+FyieX6hroAMAwjZh0taxl8mxxjvXP+h8Ah8=;
 b=oiq18PnQan0RRYIpWGqkIOBDFu2qvAHmMbqfYyjAJQm9BN9nlrORzD8iKx5jcPYblsIfYY
 KBgw6aDDjpA7FDvAYgNbk1q9YgQmp/DBdG85LoPSEE2ATMQ7f1Jvj+G7q/51oRl4LVAJBJ
 IZpA03WtCjCneVRR/CRW3xaGjRINkEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715064070;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=no0Wyhn+FyieX6hroAMAwjZh0taxl8mxxjvXP+h8Ah8=;
 b=EfbFnfdjGxkOl1q0Bnp5GRyzezsuNo/7UQpB2mDT9FDzJY8Tc+GinkVRrDHKHjiJOwzjtp
 ugOOG4fOdTsqtlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81BFA139CB;
 Tue,  7 May 2024 06:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EOZUGwbNOWY5EwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 06:41:10 +0000
Date: Tue, 7 May 2024 08:41:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20240507064109.GA84245@pevik>
References: <20240411044645.29938-1-wegao@suse.com>
 <20240418142202.GA100561@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418142202.GA100561@pevik>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C112F33A52
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] zram01.sh: Increase timeout for
 check_read_mem_used_total
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,
> Hi all,

> > Signed-off-by: Wei Gao <wegao@suse.com>
...
> > diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> > index 0c100b706..959dab217 100755
> > --- a/testcases/kernel/device-drivers/zram/zram01.sh
> > +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> > @@ -155,7 +155,7 @@ zram_fill_fs()
> >  			continue
> >  		fi

> > -		TST_RETRY_FUNC "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0
> > +		TST_RETRY_FN_EXP_BACKOFF "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0 10

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Sounds ok for me to avoid timeout.
> @Cyril, @Li WDYT? Or do you smell bug we try to cover?

FYI merged. Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

> >  		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
> >  		tst_res TINFO "mem_used_total: $mem_used_total"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
