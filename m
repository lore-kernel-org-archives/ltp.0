Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA267C5B572
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 04:45:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86123D0F9B
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 06:45:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292F03C6EDD
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:44:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C0DB100095B
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:44:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7562F1F79E;
 Tue, 25 Aug 2026 04:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787633078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9skd5+9cIT/c7uRKuNm26Fhk4Fzs0mO6dfppmkjLXYQ=;
 b=1dULXNBz4zH913W4wUL4IUCWxQ4R9RgxYiAhIxYeLz79RFKZxvdo4r8gBKztyX8w3piMue
 AQP3Hpcd4RX6b+JXnIo/xl1/EYgYpwbqoNY5cgg48Zm+4I1a0NVDPmJFDVZbG2n6CygM70
 2k/0gPOX37jvgNcWwu+YGJXepzwnlyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787633078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9skd5+9cIT/c7uRKuNm26Fhk4Fzs0mO6dfppmkjLXYQ=;
 b=Z8JekwTpJ1NNzxIGt+KrAtJBmrUOHf8DumCETR0ZyPjnV/ePt5yz8wXzhKDNZmyWYUT1RG
 XssGLrmB5XPxIrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787633074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9skd5+9cIT/c7uRKuNm26Fhk4Fzs0mO6dfppmkjLXYQ=;
 b=DPtbjt5SX9hUkiyNGpFD5z49xCpbxd5HsFG2xLTBGg96QZt7CF1uOG2J/Y/7j7/zyxyniV
 j2+ZwY0rCnbjdiAXT5NkkHJSFsccQutA62WCt1lkyU1M1ltNpaiBOifsBCqmrgdJgsPXBj
 B5p8CgP7UMHwXhs/E+pIjdhYiYPfSb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787633074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9skd5+9cIT/c7uRKuNm26Fhk4Fzs0mO6dfppmkjLXYQ=;
 b=9gphUR2SqYea5DfgdmiUnv6kN6QLpY7F1njugPx5Lnc8M8x9Kk4M4yv5Lr625L1pj7qB8f
 SQ8j2VSU8aVU6xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54FE813331;
 Tue, 25 Aug 2026 04:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nlwHE7IdjWp3NgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 04:44:34 +0000
Date: Tue, 25 Aug 2026 06:44:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260825044433.GB22725@pevik>
References: <20260821200620.902699-1-zohar@linux.ibm.com>
 <20260821202613.4033-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260821202613.4033-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE
 is configured
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

Hi Mimi,

> Hi Mimi,

> On August 21, 2026, Mimi Zohar wrote:
> > ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE is configured

> > +		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
> > +			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"

I would suggest the same, it makes sense to use TCONF to make it visible that
it's not an error but OTOH it was not actually tested due
CONFIG_IMA_DISABLE_HTABLE not set. If you don't mind, I'd change TPASS to TCONF
before merge (or feel free to send v2 with this change yourself with my
Reviewed-by: Petr Vorel <pvorel@suse.cz>
).

Thanks for the fix!

Kind regards,
Petr

> Could this path report TCONF instead? Without duplicate records, test2 cannot
> compare the current enforcing state with a fresh measurement and returns
> before checking the remaining state fields. TPASS turns this untested
> configuration into a successful test result.

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
