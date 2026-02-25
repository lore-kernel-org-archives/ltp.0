Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316DAF4BB9A
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 10:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4D823C61A8
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:59:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3F533C61A8
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 11:58:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 027612009D1
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 11:58:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A0F73F837;
 Wed, 25 Feb 2026 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772017126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldOODVtuThp2rITcLuPJUxegTwInUyRRGVr5BwUC49M=;
 b=OBI/600wBLTr7KSbhMlreDK4hBqP2epvFIY5seE5zY/TOuqrx/D/lGn3Sifs6jT+oxe4pU
 +UZr4Nj9gSiaR8Yhh874N2qf8Pqwi9N7aGAwjku1zqJ1BA5Sx6Qd/xTfABPY+gM4xZ9KPP
 xturOsoov2hNR+ATmrdr4otVgIPTduw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772017126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldOODVtuThp2rITcLuPJUxegTwInUyRRGVr5BwUC49M=;
 b=s1pOY79eJ5IkNYkblmSzs/6gowuCAM3asBPT6J35GVUh97/ohC6HBlNvjD024StcmFSuUu
 wIjP4Dw7235F4mBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772017126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldOODVtuThp2rITcLuPJUxegTwInUyRRGVr5BwUC49M=;
 b=OBI/600wBLTr7KSbhMlreDK4hBqP2epvFIY5seE5zY/TOuqrx/D/lGn3Sifs6jT+oxe4pU
 +UZr4Nj9gSiaR8Yhh874N2qf8Pqwi9N7aGAwjku1zqJ1BA5Sx6Qd/xTfABPY+gM4xZ9KPP
 xturOsoov2hNR+ATmrdr4otVgIPTduw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772017126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldOODVtuThp2rITcLuPJUxegTwInUyRRGVr5BwUC49M=;
 b=s1pOY79eJ5IkNYkblmSzs/6gowuCAM3asBPT6J35GVUh97/ohC6HBlNvjD024StcmFSuUu
 wIjP4Dw7235F4mBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 400F03EA65;
 Wed, 25 Feb 2026 10:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7U4yDubVnmlxeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Feb 2026 10:58:46 +0000
Date: Wed, 25 Feb 2026 11:58:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aZ7V7XD6LIiZ4m0e@yuki.lan>
References: <20251125044057.20922-1-wegao@suse.com>
 <20260225015044.19233-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260225015044.19233-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
> @@ -183,8 +186,7 @@ static int purge_dir(const char *path, char **errptr)
>  			continue;
>  
>  		/* Recursively remove the current entry */
> -		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
> -		if (rmobj(dirobj, errptr) != 0)
> +		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
>  			ret_val = -1;
>  	}

Shouldn't we close(subdir_fd) here as well?

> @@ -192,63 +194,53 @@ static int purge_dir(const char *path, char **errptr)
>  	return ret_val;
>  }
>  

The rest seems to be fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
