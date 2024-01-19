Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF2C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99FAC3CE2D5
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 17:09:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6203CD01B
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:09:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AEE6E1A01146
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 17:09:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5D5021FDD;
 Fri, 19 Jan 2024 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705680548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqytRUvLV1qm70EpAFs0fWlJAW+Ze2UNyuGVcX0KwJQ=;
 b=OUJGShh+7FjHuQ+MDWPIyk3ZD0SdzqbPcgNrUIal4m4wfAFevrorHiD81jMQCwmOQ0Yn0B
 F9OTGwZxFHaIiacbAJp53+GoRVt2W/nDVq8UUXAcsiRbkRMDU3BACDdpneJUnpDdENcao/
 F9Xxd5VmH9pIU2WLwRJvVZ1H9D6/SEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705680548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqytRUvLV1qm70EpAFs0fWlJAW+Ze2UNyuGVcX0KwJQ=;
 b=XemBpSLM3WcT7EUjyU7eyn1yJdAm3MQYZeBSkXbHYitnVmps7mCYxeYOzy0BQT3bphep/l
 Je8CPR59y2x77LCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705680548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqytRUvLV1qm70EpAFs0fWlJAW+Ze2UNyuGVcX0KwJQ=;
 b=OUJGShh+7FjHuQ+MDWPIyk3ZD0SdzqbPcgNrUIal4m4wfAFevrorHiD81jMQCwmOQ0Yn0B
 F9OTGwZxFHaIiacbAJp53+GoRVt2W/nDVq8UUXAcsiRbkRMDU3BACDdpneJUnpDdENcao/
 F9Xxd5VmH9pIU2WLwRJvVZ1H9D6/SEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705680548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqytRUvLV1qm70EpAFs0fWlJAW+Ze2UNyuGVcX0KwJQ=;
 b=XemBpSLM3WcT7EUjyU7eyn1yJdAm3MQYZeBSkXbHYitnVmps7mCYxeYOzy0BQT3bphep/l
 Je8CPR59y2x77LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C61A21388C;
 Fri, 19 Jan 2024 16:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eT1YL6SeqmXhUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 16:09:08 +0000
Date: Fri, 19 Jan 2024 17:09:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zaqer3Jz4pvgOZvv@yuki>
References: <20231025083706.13767-1-wegao@suse.com>
 <20240109065904.18117-1-wegao@suse.com>
 <20240109065904.18117-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109065904.18117-3-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OUJGShh+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XemBpSLM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.41 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.40)[90.90%]
X-Rspamd-Queue-Id: D5D5021FDD
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] execl01.c: set stack to unlimited
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
> Signed-off-by: Wei Gao <wegao@suse.com>

The previous version was reviewed by Peter, so this should have included
his reviewed-by line...

> ---
>  testcases/kernel/syscalls/execl/execl01.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
> index 9268d4976..dfefd1fa8 100644
> --- a/testcases/kernel/syscalls/execl/execl01.c
> +++ b/testcases/kernel/syscalls/execl/execl01.c
> @@ -35,4 +35,8 @@ static struct tst_test test = {
>  	.forks_child = 1,
>  	.child_needs_reinit = 1,
>  	.test_all = verify_execl,
> +	.ulimit = (const struct tst_ulimit_val[]) {
> +		{RLIMIT_STACK, RLIM_INFINITY},
> +		{}
> +	},
>  };
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
