Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8589CCD184
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 09:49:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEDF93CF047
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 11:49:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 045523CEC80
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 11:49:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F00ED1400C78
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 11:49:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88D9E1F38E;
 Tue, 21 Oct 2025 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761040172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwFJfNfaNWb9zgbYENxhGgH/mkDL58DM/aQECfyKPro=;
 b=3c3zB9xLfTB/UHHXdge8dvFiP2SCh1JDrNDvFloY4SKzzIc3ro4BbinrGGdUcuiAweB4Vf
 SmzEtefmNs/ZpHa5/Dek5w6xWafI2Ja6odGmQib56281ASN35n8D5Y3aEGrZ4NlCXNJUDX
 /WdKqOTAw8095FDJ3naQGK+jxnNHisk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761040172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwFJfNfaNWb9zgbYENxhGgH/mkDL58DM/aQECfyKPro=;
 b=5N7fLMmA+keO3vZheDUa6MOybF6FxkmqkwVNTrDcrM6Q35cQRK9ka7eGAkDQEkjCqeGvUR
 gptE8I/OTGIy0tDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761040168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwFJfNfaNWb9zgbYENxhGgH/mkDL58DM/aQECfyKPro=;
 b=MoKDhaLtbFvlUdAZtYEiLppUg0+UubA3RC9kzi4MrSCZsDAd3MKLLuM40r5Wfs6jH/+lDN
 OuG7uge3KWVlXz3lvgz5NpOun3vSBt4SL+0cUi4js2JA7ALXh9+Fa71LVTvI/OClm9b8au
 TU8oJdl2oLQN+hZfWHlXa7xjDtVtnRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761040168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwFJfNfaNWb9zgbYENxhGgH/mkDL58DM/aQECfyKPro=;
 b=08sRI9uKq30D6hIgVtqnSZAtwywNKJnGhwk82DyXehc5pGgBlRxB/L1kIgn8JjHZF1ZFzb
 bH/0YsY80503p1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DFCC139B1;
 Tue, 21 Oct 2025 09:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Auj8HShX92gZXQAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 09:49:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 3BC7DA0990; Tue, 21 Oct 2025 11:49:20 +0200 (CEST)
Date: Tue, 21 Oct 2025 11:49:20 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <m6rrbhwvmhldmi7x2qtthffnj73qmbtyhb34fhlfx3appr7fo6@vjjgycbtuisw>
References: <20251017161639.2088158-1-amir73il@gmail.com>
 <20251020202231.GA416401@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251020202231.GA416401@pevik>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[9]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,arm.com,redhat.com,kernel.org,oracle.com,lists.linux.it];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify24: Verify expected count/offset info in
 pre content events
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
Cc: Kiryl Shutsemau <kas@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 20-10-25 22:22:31, Petr Vorel wrote:
> Hi Amir, all,
> 
> > To test fix commit 28bba2c2935e2 ("fsnotify: Pass correct offset to
> > fsnotify_mmap_perm()"), diversify the offsets and count used for mmap()
> > write() and read() and verify that the FAN_PRE_ACCESS events report the
> > expected count/offset.
> 
> > For the FAN_PRE_ACCESS events generated by execve(), we cannot
> > anticipate the exact ranges, so we set 0 count to skip this verification.
> 
> > Also add prints of path of the fd passed with the event (not verified
> > against expected path).
> 
> > Make sure that we take the expected error value for an operation
> > (e.g. read) from a matching event type (e.g. FAN_PRE_ACCESS).
> 
> Thanks for the update.  LGTM, but it'd be great if some of kernel developers
> also had look into it. Few minor notes below.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

The changes look good to me as well (modulo some of of the style issues
you've pointed out) so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
