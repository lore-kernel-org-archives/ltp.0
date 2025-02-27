Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B6C19F2E
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 13:39:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43D3F3C9DEF
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 14:39:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35E33C9DD7
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 14:38:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DED6A615F1F
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 14:38:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 028141F38F;
 Thu, 27 Feb 2025 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740663537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KjOdZYKJA0GPsNkeCQoZF51N18UM2019O3ppF+G1js=;
 b=uN8uvtIWfLWOmonrjU7tOaoCjccvPdjebIkZvBZY9E4eG191KXSwo0hA+CkHrc72m0sAaq
 ydhhVBfkpVhpVK83j86sEN3W6lGJMc35lHNDcfhx7YSTMcV0vOGoDfzFp7j6LFu0aUcPjY
 RPVeUwYFzraYU9NyusAmNuWzwQubu+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740663537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KjOdZYKJA0GPsNkeCQoZF51N18UM2019O3ppF+G1js=;
 b=omrEtGA1y9F778hWCKeUc2LaUFtL7uhcCqGVqV8QsVBLvSg2epEeJD55nt6apTYFp8EBG7
 G5XPQrre0c4m3+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740663537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KjOdZYKJA0GPsNkeCQoZF51N18UM2019O3ppF+G1js=;
 b=uN8uvtIWfLWOmonrjU7tOaoCjccvPdjebIkZvBZY9E4eG191KXSwo0hA+CkHrc72m0sAaq
 ydhhVBfkpVhpVK83j86sEN3W6lGJMc35lHNDcfhx7YSTMcV0vOGoDfzFp7j6LFu0aUcPjY
 RPVeUwYFzraYU9NyusAmNuWzwQubu+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740663537;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KjOdZYKJA0GPsNkeCQoZF51N18UM2019O3ppF+G1js=;
 b=omrEtGA1y9F778hWCKeUc2LaUFtL7uhcCqGVqV8QsVBLvSg2epEeJD55nt6apTYFp8EBG7
 G5XPQrre0c4m3+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD51A1376A;
 Thu, 27 Feb 2025 13:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VYToNPBqwGf4ZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 13:38:56 +0000
Date: Thu, 27 Feb 2025 14:38:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250227133851.GA3067784@pevik>
References: <18cb6752b375941581aa66617e52edad0913344e.1740650948.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18cb6752b375941581aa66617e52edad0913344e.1740650948.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: sem_timedwait: replace sleep with
 tst_process_state_wait3
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

Hi Jan,

> This makes the test faster and also avoids a small race - when the
> time is very close to starting new second, this makes the test use
> timeout that's effectively just slightly over one second, because
> nanosecond portion is always set to 0. And previously child would
> sleep roughly one second.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I also wonder if other tests with sleep(1) are relevant. e.g.

conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c

(There are more sleep() uses, but I suppose others aren't relevant.)

Also, some tests (e.g conformance/interfaces/clock_nanosleep/1-3.c updated few
years ago) did not updated sleep() in docs comment.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
