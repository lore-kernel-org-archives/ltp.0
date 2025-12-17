Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EF1D65C47
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 13:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B86A93D03CA
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 14:19:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5197B3D03BC
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 14:19:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8FB7B10009A2
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 14:19:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D45C5BCF4;
 Wed, 17 Dec 2025 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765977540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/whDjhF4s5hJE8ptYmWNBnLoQs2/4J13hy/uAoki40=;
 b=g8I6/cr7mYVapd5sMtwLYivlydgt4JLINKLJdt1lMkxLMY6o2hiI8xXvUdg+e7Uh5hEvks
 e0kZipqIEHtPEtoPLUTcvi4GqlLVqDY+wUooKqtjbVY0y6ovy/jX5P72KR5J9BFj0ZHJyW
 8jbLEOKo/NybIku557/RTWcfwjyBsJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765977540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/whDjhF4s5hJE8ptYmWNBnLoQs2/4J13hy/uAoki40=;
 b=2rA3AmMe41Y9W9wunVDj90uYo5Z/ECL0Mt/NBDGq8DTzP/e1y7IU3az6Dca9Hlsq84YokH
 aX3AF0vvhn4hiOBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765977539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/whDjhF4s5hJE8ptYmWNBnLoQs2/4J13hy/uAoki40=;
 b=kIKiApZO3Jpyb2OXMwq6gmf5X3X16YrDLLGm7O5V1pmhZVvlFXrmbeQbviilxbs9j7yYkN
 CVzptvf+otp3Ty0j7XvOoSI5oLOpI/ji0eVQRuBjNex/6+guLOW9v1F/yU7ZS6I5dx1VND
 NesugfJNYYPFTZyS68ZLMqZ3KWXrZQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765977539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/whDjhF4s5hJE8ptYmWNBnLoQs2/4J13hy/uAoki40=;
 b=/vj+In8wJ8kwLcxe0R93SOd15lFBYSL4exKe1QRRRAty0gByq+ya6Uho9sBhFYEFZhQ/IQ
 GS9lPDJHG6rCoJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22ECE3EA63;
 Wed, 17 Dec 2025 13:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dyb6BsOtQmnTSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 13:18:59 +0000
Date: Wed, 17 Dec 2025 14:18:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251217131853.GB56642@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
 <20251212111618.GA125889@pevik>
 <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
 <20251215093639.GA236929@pevik>
 <aT_qF7YR65J9PbEg@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aT_qF7YR65J9PbEg@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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

> > Hi Wei,

> > ...
> > > > Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
> > > > is about changing .needs_cmds from char array (string) to struct tst_cmd.
> > > > Therefore it could be in a separate commit. We don't have to be too strict, but
> > > > given how many tests needed to be adapted adding tst_cmd_present() is somehow
> > > > buried with other changes.

> > > Thanks all for detail feedback. Let's me give some explaination why skip
> > > tst_brk in above function:
> > > tst_cmd_present will be used in latest ioctl_loop01.c and it should not
> > > use tst_brk otherwise we will brk out of test in setup() too early.
> > > The new support needs_cmds.optional in current patch is used for support 
> > > tst_cmd_present scenario in ioctl_loop01.c.
> > > Correct me if any mistake.

> > Sure, I noticed tst_cmd_present() usage in a later commit :).

> > My point was (while this patchset is also about ideal feature change split into
> > commits) that if you touch many files with struct tst_cmd change, adding
> > unrelated change (tst_cmd_present()) will hide this change. I would personally
> > move adding tst_cmd_present() to a separate commit. It's not that important,
> > just to make review easier.
> Thanks, i get your point now.
> @Petr @Cyril
> If we have are agree with following changes then i can sent next patch:
> 1) Just move the declaration and definition of tst_cmd_present to a separate commit without any functional content changes.
> 2) Modify function comments such as add ref:`...`

+1, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
