Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C2DC0219B
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94463C98C4
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:44:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70A7C3C98BB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:44:00 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFB74100F6F6
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:43:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E22121184;
 Mon, 10 Feb 2025 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739202239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1x2OAEBSxf33mD9PHtUbvn+gTGV7bfSFUMc0hMBIHaM=;
 b=P0g61SbzkdwJ40BSHGN8JQN67EnvMPMYBkyNPZQ53ScBYboFv9Rgd+TDKvnWNiQedFHCaQ
 z14F3d6Qr7/OgN5cVe9BVZ9H9MGU4/Hzz/6NltnnRiLBNkvV3R/Z9nuR4qMhHzsaFWoT4g
 pGxQ00/dY5GCGy3Lfsz0dnD18TMsTjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739202239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1x2OAEBSxf33mD9PHtUbvn+gTGV7bfSFUMc0hMBIHaM=;
 b=PEZGSpESrszI+H+JQWL5ew2CVRJKuG4+6bFImah73Gl6/ZSlNuUWbgxZsEBzA7ir7YGZya
 jETTgN37jQSM3NCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739202239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1x2OAEBSxf33mD9PHtUbvn+gTGV7bfSFUMc0hMBIHaM=;
 b=P0g61SbzkdwJ40BSHGN8JQN67EnvMPMYBkyNPZQ53ScBYboFv9Rgd+TDKvnWNiQedFHCaQ
 z14F3d6Qr7/OgN5cVe9BVZ9H9MGU4/Hzz/6NltnnRiLBNkvV3R/Z9nuR4qMhHzsaFWoT4g
 pGxQ00/dY5GCGy3Lfsz0dnD18TMsTjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739202239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1x2OAEBSxf33mD9PHtUbvn+gTGV7bfSFUMc0hMBIHaM=;
 b=PEZGSpESrszI+H+JQWL5ew2CVRJKuG4+6bFImah73Gl6/ZSlNuUWbgxZsEBzA7ir7YGZya
 jETTgN37jQSM3NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F34F513A62;
 Mon, 10 Feb 2025 15:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d3NfO74eqmcdPQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 15:43:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 619BBA095C; Mon, 10 Feb 2025 16:43:43 +0100 (CET)
Date: Mon, 10 Feb 2025 16:43:43 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <yvpm5aiigldl2ftkatepoddjitxs64r6n2igcatetyukpbp3re@35yc3muudqdf>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210151316.246079-4-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.77 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.998]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.17)[-0.867]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 10-02-25 16:13:15, Amir Goldstein wrote:
> Fork the test fanotify24 from test fanotify03, replacing the
> permission event FAN_ACCESS_PERM with the new pre-content event
> FAN_PRE_ACCESS.
> 
> The test is changed to use class FAN_CLASS_PRE_CONTENT, which is
> required for FAN_PRE_ACCESS and this class also enabled the response
> with cutomer error code FAN_DENY_ERRNO.
> 
> Unlike FAN_ACCESS_PERM, FAN_PRE_ACCESS is also created on write()
> system call.  The test case expected results are adjusted to
> respond with the default error (EPERM) to open() and write() and
> to respond with custom errors (EIO, EBUSY) to read() and execve().
> 
> Not all fs support pre-content events, so run on all filesystems
> to excercise FAN_PRE_ACCESS on all supported filesystems.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. I was just wondering whether some bits like
generate_events(), mark setup, child setup, main test loop could not be
factored out into a helper functions used by both old and new tests?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
