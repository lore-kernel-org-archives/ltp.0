Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E559C25B7E
	for <ltp@archiver.kernel.org>; Tue,  4 Jun 2024 11:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46E093D094C
	for <ltp@archiver.kernel.org>; Tue,  4 Jun 2024 13:44:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54D353D00B8
 for <ltp@lists.linux.it>; Tue,  4 Jun 2024 13:44:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73E5F2010FC
 for <ltp@lists.linux.it>; Tue,  4 Jun 2024 13:44:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1A2C21A11;
 Tue,  4 Jun 2024 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717501471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkMIL8YsCXpJ9EvLukyd2TrVgbLJyNl2watFD8YWXqg=;
 b=2++fG7qX2EjXbAd6nK65j3Qax9Cty9HdKbYtgobptReZCXDOM2csNFOhfnXcOz2+K4y0NP
 Nu8rBLQjtWmQyMvA0Q13FFg/Su9rIfkL/1O5NZUCGuy0Selo5J3x5yNuh1pelmDjAz+S+S
 L3DdcwBTc64oFSf6mFp+G04cVVaNlnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717501471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkMIL8YsCXpJ9EvLukyd2TrVgbLJyNl2watFD8YWXqg=;
 b=hopCjddK3qEHw64mP5dB1oVki+3rrSm5MDynUPRyNJjYZriSfJ3BrV8CEZ1MzUfM+gBF7B
 vSjeVzAexiTbsLCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717501471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkMIL8YsCXpJ9EvLukyd2TrVgbLJyNl2watFD8YWXqg=;
 b=2++fG7qX2EjXbAd6nK65j3Qax9Cty9HdKbYtgobptReZCXDOM2csNFOhfnXcOz2+K4y0NP
 Nu8rBLQjtWmQyMvA0Q13FFg/Su9rIfkL/1O5NZUCGuy0Selo5J3x5yNuh1pelmDjAz+S+S
 L3DdcwBTc64oFSf6mFp+G04cVVaNlnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717501471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkMIL8YsCXpJ9EvLukyd2TrVgbLJyNl2watFD8YWXqg=;
 b=hopCjddK3qEHw64mP5dB1oVki+3rrSm5MDynUPRyNJjYZriSfJ3BrV8CEZ1MzUfM+gBF7B
 vSjeVzAexiTbsLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CE7C13AB8;
 Tue,  4 Jun 2024 11:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vDq0JB/+Xma1WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jun 2024 11:44:31 +0000
Date: Tue, 4 Jun 2024 13:44:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zl7-FehzfYbRxhcy@yuki>
References: <20240528121715.436013-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240528121715.436013-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.73 / 50.00]; BAYES_HAM(-2.93)[99.70%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sparse-ltp: Fix bogus warning
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
> tst_tmpdir.c:347:6: warning: Symbol 'tst_purge_dir' has no prototype or
> library ('tst_') prefix. Should it be static?

Actually this is a correct check. The idea is a bit different, we are
trying to make sure that there is a prototype in the headers for the
function. If that is true, the sym->same_symbol points to that symbol
instance and the check exists before it reaches that warning.

So the actuall problem here is that the prototype is in a strange place,
i.e. tst_device.h which is not included into tst_tmpdir.c.

Obvious fix would be including tst_device.h into tst_tmpdir.c however
I'm not sure that the function to purge the directory belongs to the
tst_device.h to begin with. Maybe we should add just tst_tmpdir.h with
that function and include it into right places, i.e. tst_test.h and
tst_tmpdir.c.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
