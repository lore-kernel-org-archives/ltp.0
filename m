Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7254CD4921F
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 12:28:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4EEF3C83CF
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 13:28:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8D9C3C3360
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 13:28:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3021F600AD1
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 13:28:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB0FD338B1;
 Fri, 12 Dec 2025 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765542510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzf2xa/ZeazOXTaITcNwlc+00Yd2KIIPXrIZkJ5iVrY=;
 b=RmqzqtQwYwIb3NfD1t3wVbRrui8JcmGPAotXp1ZfUEBp1mneafFiyvPZH5pxP067iS8bp0
 5nD4lI2lpCNkG2YhGPFB2ec0LsEz8vMcUfkSgXGJC/mby8GlmslUd/ZT1zDE+mRf0WK7wq
 wv2q2W1JIxnp7X8Wg1rLQhFSadyJz8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765542510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzf2xa/ZeazOXTaITcNwlc+00Yd2KIIPXrIZkJ5iVrY=;
 b=fzEyHekW0rCpP530MzCBDNk6JFRWmQdWiRHGDmGtyaTScidALsVVk76r0FT5Hj3+9Sj6OO
 KiPp3dqvLy2aWYCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765542509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzf2xa/ZeazOXTaITcNwlc+00Yd2KIIPXrIZkJ5iVrY=;
 b=DQcA5QcJxWWzWaatSsgylSIiov6sT+c1Ty8OwL2iIv4ggGL13OzNyATYbXA3J5VsfuM2Vf
 4kD5mE3kEkXeSRg+oNnzOFtXBpvFj1Di4b3/i0PRVyDusAuXBTWLETyKdBMRTVi0vhkJ9c
 kchGzB9bmwHS19F7z3kbKSTP6J4exbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765542509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzf2xa/ZeazOXTaITcNwlc+00Yd2KIIPXrIZkJ5iVrY=;
 b=NMXK/8KuHwDIpI0xtq9BuXnceCYa4ME69O/OEVhlr9/wI+bPImHrc+AJP/2doIWe4Y9XRL
 bwCiyEStcU/gbHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB203EA63;
 Fri, 12 Dec 2025 12:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T53EDG0KPGlcUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 12:28:29 +0000
Date: Fri, 12 Dec 2025 13:28:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251212122827.GC125889@pevik>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212115244.2027-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

...
> -#ifndef HAVE_STRUCT_MNT_ID_REQ
> -struct mnt_id_req {
> +struct mnt_id_req_fallback {
>  	uint32_t size;
> -	uint32_t spare;
> +	uint32_t mnt_ns_fd;
>  	uint64_t mnt_id;
>  	uint64_t param;
>  	uint64_t mnt_ns_id;
>  };
> +
> +#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
Shouldn't be !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
!defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) ?

Also, this patchset introduces compilation error on old systems:

In file included from listmount03.c:13:0:
listmount.h:20:4: error: 'struct mnt_id_req' has no member named 'mnt_id'
   .mnt_id = mnt_id,

Obviously some definition is wrong.

https://github.com/pevik/ltp/actions/runs/20166087670/job/57889711762

(CI does not work, therefore I pushed you patchset.)

> +typedef struct mnt_id_req_fallback mnt_id_req;
> +#else
> +typedef struct mnt_id_req mnt_id_req;
>  #endif

...
> +static void setup(void)
> +{
> +	if (tst_kvercmp(6, 18, 0) >= 0) {
> +		tcases[4].exp_errno = EBADF;
> +		tcases[4].msg = "invalid mnt_id_req.mnt_ns_fd (EBADF)";

Hardcoding array index is asking for problems in the future.

That's why I suggested more complicated code in previous version.
https://lore.kernel.org/ltp/20251211115111.GA63924@pevik/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
