Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A0C54FB3
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 12:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1E83C2B8F
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 14:59:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B33A3C068B
 for <ltp@lists.linux.it>; Mon, 26 May 2025 14:59:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93C7B1000AE9
 for <ltp@lists.linux.it>; Mon, 26 May 2025 14:59:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EC5F1F797
 for <ltp@lists.linux.it>; Mon, 26 May 2025 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748264350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=romURx8P9v9S94IFylWLRyiokscN3/iwgU6pVV1cddU=;
 b=UoWVDNUoD0QfRqH5l1Tk3/o6J4muWZOSjTWxEltN3ZF1Buh76M1ur+V3/ksnxyENkog4xk
 cfQFV5t96BtLk3AwbCxk6DTh9UaBDfPpdQNx8xLU2niGnSL254RG7bCCAimoOwrYhGaWXV
 LRCEb68pQDrhwpGs6Y2nNxmir9kkGRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748264350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=romURx8P9v9S94IFylWLRyiokscN3/iwgU6pVV1cddU=;
 b=VPxLetp1+p9Kx49tFYTJ+nfsYgd0qWy1xMHdIRx7s1dtgKz/EoUoPRzJlLBNix7b6kUx6l
 n+ZcMqVzMfuvZbCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748264349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=romURx8P9v9S94IFylWLRyiokscN3/iwgU6pVV1cddU=;
 b=x1aR2CgH0fy0xDYlUh7MF0nr0/cCFiiZ9GRzCZUS1Xv8k6NUicCo7yCecIaa7Uj8vrvoyE
 Bmvp+kv4zsFq7Lnmezs29csVWea7hhl3VWZxs5S76cSv05xUeGgOP4OZtR8aFjbFLcT9Em
 I8U0HnIlMj0LD/3Xn77QPD1AVqF2W48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748264349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=romURx8P9v9S94IFylWLRyiokscN3/iwgU6pVV1cddU=;
 b=goI6qNUYX4fpO5uauZBVQTMi/ngESfxs8cyiiV+9DL2ce9VJIzJOsXfnWIhK6fk/UeB3TF
 es5LXhh9hew0aoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A85313964
 for <ltp@lists.linux.it>; Mon, 26 May 2025 12:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0uQcBp1lNGi0LgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 26 May 2025 12:59:09 +0000
Date: Mon, 26 May 2025 14:59:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aDRlsOSIJB2Lbi51@yuki.lan>
References: <20250526104501.17373-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250526104501.17373-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  
> -		if (sup)
> +	for (i = 0; fs_type_whitelist[i]; i++) {
> +		if (fs_could_be_used(fs_type_whitelist[1], skiplist, skip_fuse))
                                                       ^
						   I did a very dumb
						   typo here, will send
						   v3.
-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
