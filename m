Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C787ACCD199
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 13:10:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 375583CEE18
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 15:10:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6BF3CEB66
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:09:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0ED0E1400C6E
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:09:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E294C1F899;
 Thu, 16 Oct 2025 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760620194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dDYTW1L3VStF3ekIwMWhWnc1V0cL8Yls5UBKW7JRiJA=;
 b=ZI9VXBasgcYWH3V7n+0EpidB+kLiVtMvGa0Bz9LbTv+AG03wBabkKk++G+kcrhRtIOCqGk
 O7QMnzUNeh8O5M8PJ4FJMvu/EQ74ct2skMpyy3FvyX6vZZJsAYdrvAM6L8VWZVy/b8S1ZE
 rScqMhWbNM31zBakw9FiZuG1RTyzYhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760620194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dDYTW1L3VStF3ekIwMWhWnc1V0cL8Yls5UBKW7JRiJA=;
 b=eb+LA/WfHUbnFKzq8Y75y2+KTvwIH7yY5uPhOnp5AAZVPvQTv3us/QATzJn2pb4SKmOHQ1
 yRDQxWQ7LmGoh8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760620194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dDYTW1L3VStF3ekIwMWhWnc1V0cL8Yls5UBKW7JRiJA=;
 b=ZI9VXBasgcYWH3V7n+0EpidB+kLiVtMvGa0Bz9LbTv+AG03wBabkKk++G+kcrhRtIOCqGk
 O7QMnzUNeh8O5M8PJ4FJMvu/EQ74ct2skMpyy3FvyX6vZZJsAYdrvAM6L8VWZVy/b8S1ZE
 rScqMhWbNM31zBakw9FiZuG1RTyzYhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760620194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dDYTW1L3VStF3ekIwMWhWnc1V0cL8Yls5UBKW7JRiJA=;
 b=eb+LA/WfHUbnFKzq8Y75y2+KTvwIH7yY5uPhOnp5AAZVPvQTv3us/QATzJn2pb4SKmOHQ1
 yRDQxWQ7LmGoh8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3BC31376E;
 Thu, 16 Oct 2025 13:09:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ikDYKaLu8GhDMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 13:09:54 +0000
Date: Thu, 16 Oct 2025 15:09:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251016130952.GA281409@pevik>
References: <20250917102737.GA336745@pevik>
 <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
 <20250929083156.GA199802@pevik> <aPDlzuox-54oxTtp@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPDlzuox-54oxTtp@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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

> Hi!
> > Short term solution will be Jan's suggestion to write simple "sudo" binary or
> > even just let testers to fix the setup (i.e. fix it for us in openQA).

> I guess that having a small helper to execute commands as a selected
> user would be reasonable. We already have tst_sleep because the sleep
> commands in different shells behaves differently.

> Adding tst_sudo that would take an user and command to execute does make
> sense here I suppose. 

OK, I can write it unless Jan plans to work on it (Jan, please let me know).

I propose to have the usual LTP approach to have functionality used by C API
(e.g. lib/tst_sudo.c) and reused by thin wrapper available for shell API
(testcases/lib/tst_sudo.c).

Few C API tests would use it (prctl06 and other mentioned previously [1] as 3)),
in shell API only these 2 IMA tests.

> And I think that the question if we need a separate user for LTP testing is
> orthogonal.

Agree. I just brought these two topics together as they are related.
So, as a separate topic/effort, do you see any room for C API functions for 1)
and 2) in [1]?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20251006094837.GC66983@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
