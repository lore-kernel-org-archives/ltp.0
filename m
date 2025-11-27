Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF72D11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:20:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8046B3CC1EE
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 09:20:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB0633CA7DF
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:19:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E797200759
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:19:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99B2E5BCC5;
 Thu, 27 Nov 2025 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764231593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XI8PGoINqGI3S9W/v/X9QHDINuvrTXHS3NLrL2NYmzI=;
 b=BseGl7WS3yDFCzOkWx69PIWDbJ1h5bA1BLX3hAfyb7jUStiMH5dCIucvz8RdKYnoZgFJGs
 QoOlh71FdLzzDU7Sm7rD7q5LiUbPuuDjo8ZobpNdLrg2PdD1EhAgz3rVXuY6OzEK8lxn23
 8RpmtZaE+KIrQ8l3l7/KFxsKMc2vMDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764231593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XI8PGoINqGI3S9W/v/X9QHDINuvrTXHS3NLrL2NYmzI=;
 b=+LfIGr6M+iegDvMb6hyWGVyWUOkcWtwfIfaUtqxvYHbJecxDdqfdQyBtsmXi82ZUp+Eg9U
 ZcpwICWajtKGiHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764231593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XI8PGoINqGI3S9W/v/X9QHDINuvrTXHS3NLrL2NYmzI=;
 b=BseGl7WS3yDFCzOkWx69PIWDbJ1h5bA1BLX3hAfyb7jUStiMH5dCIucvz8RdKYnoZgFJGs
 QoOlh71FdLzzDU7Sm7rD7q5LiUbPuuDjo8ZobpNdLrg2PdD1EhAgz3rVXuY6OzEK8lxn23
 8RpmtZaE+KIrQ8l3l7/KFxsKMc2vMDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764231593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XI8PGoINqGI3S9W/v/X9QHDINuvrTXHS3NLrL2NYmzI=;
 b=+LfIGr6M+iegDvMb6hyWGVyWUOkcWtwfIfaUtqxvYHbJecxDdqfdQyBtsmXi82ZUp+Eg9U
 ZcpwICWajtKGiHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84B8C3EA63;
 Thu, 27 Nov 2025 08:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AlSDH6kJKGk5IAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:19:53 +0000
Date: Thu, 27 Nov 2025 09:19:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <20251127081952.GA216010@pevik>
References: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
 <20251127072231.2104445-2-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251127072231.2104445-2-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Adding magic definition required for
 hugemmap40.
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

Hi Pavithra,

...
> +++ b/include/tst_fs.h
> @@ -33,6 +33,7 @@
>  #define TST_FUSE_MAGIC     0x65735546
>  #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
>  #define TST_EXFAT_MAGIC    0x2011BAB0UL
> +#define HUGETLBFS_MAGIC	   0x958458f6

Could you please use "TST_" prefix for that definition (i.e.
TST_HUGETLBFS_MAGIC) as it is used for other LTP specific definitions?
That way we avoid constant redefinition in case of including <linux/magic.h>.

With that you may add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
