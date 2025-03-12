Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36894C28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 15:20:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DDFC3CA483
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 16:20:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B6F33CA0D3
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 16:20:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A328100060D
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 16:20:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA95F1F394;
 Wed, 12 Mar 2025 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741792812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcMVA5ZO1l10kP+Eord7+h3K124A5Tk/yMwZXBFvKMs=;
 b=VEZHRH2QkGylcjeE0+OzK9uTLJaZN84UVtYFOQco9HN+9jpiSHtON7UtKtkmvn5hFxBwhH
 7NBcIXnVwvS5jCxF6K/Mx1F9w0DJWwualr7ILtRhZQPZ973CAkv6grqNevq7knUMUl3r0Z
 UdRHIhFx/vavbeyeQW030pqOW3T2JYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741792812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcMVA5ZO1l10kP+Eord7+h3K124A5Tk/yMwZXBFvKMs=;
 b=dEW2yAKhhp8mDfHq+Q6KEwuPi6e0uKrvhoEheyrYhwI35402Y4c5F104j67o32u1SAr5T7
 Bag3OaHllrzUyqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741792811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcMVA5ZO1l10kP+Eord7+h3K124A5Tk/yMwZXBFvKMs=;
 b=wFfpds42mEC6iLucPCw0RCH74APDo3w+Jh/jWcHfVHwlGpSRU/50okSy5XSy5J+MEt32e9
 iz/M3zUm1rdeldsvAAGi6d4zwkpdubuuL0h5TDZmW5OJuIvs2gVFvMhJ+MejV1agd94pg8
 kBcdQJQMKTOOWt2SmwK3fsl1smar2TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741792811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcMVA5ZO1l10kP+Eord7+h3K124A5Tk/yMwZXBFvKMs=;
 b=TB52b5WuMeNZOSZuvCcLbQRp0SrowfyXxhQSlLLwhkKNWQ5i/cUQHEKH1gmTbiVWI6fK0K
 gau3705rWONRmUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C91D9132CB;
 Wed, 12 Mar 2025 15:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j2HKMCum0WcdCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Mar 2025 15:20:11 +0000
Date: Wed, 12 Mar 2025 16:20:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250312152006.GA130182@pevik>
References: <20250114113239.611278-1-pvorel@suse.cz>
 <20250307102429.GA272497@pevik>
 <88e87da5b2d5d731e6ad4e2b4043d39e4221684d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88e87da5b2d5d731e6ad4e2b4043d39e4221684d.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] IMA: Remove evm_overlay.sh
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
Cc: Ignaz Forster <iforster@suse.de>, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, Ignaz,

> On Fri, 2025-03-07 at 11:24 +0100, Petr Vorel wrote:
> > Hi Mimi, Ignaz,

> > > Proof of concept, it was never fixed in the kernel.
> > > Instead we should have some basic EVM tests.

> > gently ping. Is evm_overlay.sh test useful for you?
> > Otherwise I'll delete it.

> Requiring the "ima_policy=appraise_tcb" default policy to run the tests limits
> its usefulness.  Perhaps REQUIRED_POLICY_CONTENT could be defined.  I'll let you
> know. For now, please don't remove the test.

Sure, I'll keep the test if you want. Also adding REQUIRED_POLICY_CONTENT would
help. But the reason why I wanted to delete the test is the fact, that it's a
proof of concept that

1) It's a reproducer for patchset which haven't been fixed.
2) It requires test setup first "ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix". [2]
3) I'm not sure if the test even work as expected.

But I try to test it again and test if it will work with
REQUIRED_POLICY_CONTENT.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/20190211165323.9369-1-iforster@suse.com/
[2] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/security/integrity/ima#evm-tests

> thanks,

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
