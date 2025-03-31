Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DBAC36010
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 11:39:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35A643CABC3
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:39:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 380F23CAB4F
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:39:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1C56A600BE6
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:39:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A2401F38D;
 Mon, 31 Mar 2025 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743421141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tk4lEM51ceMkxLn4o+hcxUMwhfooZHQ83r9EQzcv/S4=;
 b=CltvPisDrhA03AOGusdJsmxlsTY/C5FBL2PiClKTEdMC5sZ7VZnYu7jMjmyx0WLGysFemB
 nBG0vDDtA2NXNCy8L+s1ieYbaWMU2V1j6Kj9rOumdvRZOB6++GERoYttmqStX9YXb4LLk7
 h+E4aHnan7yXT1JhN/Twcrj9YDnMP5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743421141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tk4lEM51ceMkxLn4o+hcxUMwhfooZHQ83r9EQzcv/S4=;
 b=tTtXcNHwGt57htUgLph/iiMOagVScDL4xDwG2dBkPIvcl/bAlTKcogk6z9m/Nl+pgSwBDB
 nKJ7Rz566bAFSqBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CltvPisD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tTtXcNHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743421141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tk4lEM51ceMkxLn4o+hcxUMwhfooZHQ83r9EQzcv/S4=;
 b=CltvPisDrhA03AOGusdJsmxlsTY/C5FBL2PiClKTEdMC5sZ7VZnYu7jMjmyx0WLGysFemB
 nBG0vDDtA2NXNCy8L+s1ieYbaWMU2V1j6Kj9rOumdvRZOB6++GERoYttmqStX9YXb4LLk7
 h+E4aHnan7yXT1JhN/Twcrj9YDnMP5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743421141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tk4lEM51ceMkxLn4o+hcxUMwhfooZHQ83r9EQzcv/S4=;
 b=tTtXcNHwGt57htUgLph/iiMOagVScDL4xDwG2dBkPIvcl/bAlTKcogk6z9m/Nl+pgSwBDB
 nKJ7Rz566bAFSqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A5C713A1F;
 Mon, 31 Mar 2025 11:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P5oVAdV+6md3ewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Mar 2025 11:39:01 +0000
Date: Mon, 31 Mar 2025 13:39:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <Z-p-7Q8OIJYai2Xp@yuki.lan>
References: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
X-Rspamd-Queue-Id: 2A2401F38D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty: Update slave device permission check to allow 0600
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
> Systemd changed the default permissions for PTY slave devices from 0620
> to 0600 in response to CVE-2024-28085.  Allow either 0620 or 0600 as
> valid permissions.
>
> Link: https://security-tracker.debian.org/tracker/CVE-2024-28085
> Link: https://github.com/systemd/systemd/commit/a4d18914751e687c9e44f22fe4e5f95b843a45c8
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> 
> diff --git a/testcases/kernel/pty/common.h b/testcases/kernel/pty/common.h
> index 51760b1d39fa..7cda16096d4d 100644
> --- a/testcases/kernel/pty/common.h
> +++ b/testcases/kernel/pty/common.h
> @@ -54,7 +54,8 @@ static inline int open_slave(const int masterfd)
>  			st.st_uid, uid);
>  	}
>  
> -	if (st.st_mode != (S_IFCHR | 0620)) {
> +	if (st.st_mode != (S_IFCHR | 0620) &&
> +	    st.st_mode != (S_IFCHR | 0600)) {
>  		tst_brk(TBROK, "unexpected slave device permission: %o",
>  			st.st_mode);
>  	}

Looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
