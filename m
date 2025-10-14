Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B2CCD184
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 15:29:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECB8B3CE6A8
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 17:29:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248123CDF40
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 17:29:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC15760074F
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 17:29:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24A2320252;
 Tue, 14 Oct 2025 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760455753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Cm62uKRIp88/Wiakc3t3NVtLtB5g15LzVsJHP4rd5E=;
 b=E/ryCZmptV9IF3Zr9GsUKW7p7nk0y0hOp8rhe2xsd/ds8jAkhW+TVTc2zzOWfBXvP7fOi1
 pzSBjImcxpVt8CRvn0uEmJ2zZjMdTLAWn5QUXhQ7Z/8Gda4M3cqevcTR5P1wzRxpTxMHnT
 T8/DawiqcjljJO8ZZuikPSY/4OKG2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760455753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Cm62uKRIp88/Wiakc3t3NVtLtB5g15LzVsJHP4rd5E=;
 b=Fimnv5fenjWtGdTe71AGYG/z7/fx+o+IlV5Q4AgA+/tofJtrydu7lG1yMdNLwuKTKrprB8
 4Qs5QpQPosJDpfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760455753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Cm62uKRIp88/Wiakc3t3NVtLtB5g15LzVsJHP4rd5E=;
 b=E/ryCZmptV9IF3Zr9GsUKW7p7nk0y0hOp8rhe2xsd/ds8jAkhW+TVTc2zzOWfBXvP7fOi1
 pzSBjImcxpVt8CRvn0uEmJ2zZjMdTLAWn5QUXhQ7Z/8Gda4M3cqevcTR5P1wzRxpTxMHnT
 T8/DawiqcjljJO8ZZuikPSY/4OKG2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760455753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Cm62uKRIp88/Wiakc3t3NVtLtB5g15LzVsJHP4rd5E=;
 b=Fimnv5fenjWtGdTe71AGYG/z7/fx+o+IlV5Q4AgA+/tofJtrydu7lG1yMdNLwuKTKrprB8
 4Qs5QpQPosJDpfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14F1C139B0;
 Tue, 14 Oct 2025 15:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zu+aA0ls7mhmOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Oct 2025 15:29:13 +0000
Date: Tue, 14 Oct 2025 17:30:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aO5sfcv7R9-LOK0x@yuki.lan>
References: <20251007112719.13289-1-chrubis@suse.cz>
 <CAEemH2dHYpXk+htRD1GkCjj8FJMXctrU2Y0iZpA6zb0Y2iCvJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dHYpXk+htRD1GkCjj8FJMXctrU2Y0iZpA6zb0Y2iCvJA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_detach_device_by_fd() set dev_fd to -1
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
> > Apparently I tend to forget that tst_detach_device_by_fd() closes the
> > file descriptor. This change makes it more obvious by chaning the fd to
> > a pointer and also sets the dev_fd to -1, which matches the SAFE_CLOSE()
> > behavior.
> >
> 
> It took me a while to think why we need to do this since we already had:
> https://github.com/linux-test-project/ltp/commit/c02d8ddc5f9d312ca5c384317141e213412a5c42
> 
> However, this patch makes sense because:
> 
> After the tst_detach_device_by_fd() call, dev_fd is silently closed,
> but the variable in the caller still retains its old value. If the caller
> attempts to use it again, getting use-after-close may cause problems.
> Therefore, reset it to -1 to prevent accidental use of a closed fd.

Yes it's about making the API more obvious and less dangerous.

> So maybe we could explicitly add the above explanation in the description
> when merging?

I've changed the function description to:

/*
 * Detaches a file from a loop device by a fd.
 *
 * The dev_fd needs to be the last file descriptor opened for the
 * device. Call to this function will close dev_fd and set it to -1 in
 * order to avoid incorrect usage after it's closed.
 *
 * @dev_path Path to the loop device e.g. /dev/loop0
 * @dev_fd An open fd for the loop device, set to -1 after the completion.
 * @return Zero on succes, non-zero otherwise.
 */

I hope that it makes it clearer.

> Anyway:
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed, thanks for the review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
