Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8DCC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 11:32:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F7CA3C6643
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 12:32:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 726BD3C280D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:32:23 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA89B1BC09AC
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:32:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35CAE2117D;
 Thu, 20 Feb 2025 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740051142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihxmkhVtzjtAXWC4JKXtTw0MfUHfHV2RI6ciPf5Ti4I=;
 b=jEdjl/a6DKd+iCJ+1WtfmoB3khBnTsn6+jQVWEIHQ+lHoFmPFB0v/bGnIpV6QgB9/w2GcG
 +KGTjKaml6zQr9OCvGBQfHX+9rDTpNsk2oFOSpUu7/OxKxA021S7tR38fgL7Sxo9bailMg
 iIzVwOkdEt7zMI/NI4I6ks1EgdFuLj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740051142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihxmkhVtzjtAXWC4JKXtTw0MfUHfHV2RI6ciPf5Ti4I=;
 b=b73hoT3jliIk9eXSSmCpgBOqdAkvxDFkbUWa0N1ylE5628Zddn6sSXtBvI/om8PBC6a2q9
 +Y0pjrgW75qQ4uBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740051142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihxmkhVtzjtAXWC4JKXtTw0MfUHfHV2RI6ciPf5Ti4I=;
 b=jEdjl/a6DKd+iCJ+1WtfmoB3khBnTsn6+jQVWEIHQ+lHoFmPFB0v/bGnIpV6QgB9/w2GcG
 +KGTjKaml6zQr9OCvGBQfHX+9rDTpNsk2oFOSpUu7/OxKxA021S7tR38fgL7Sxo9bailMg
 iIzVwOkdEt7zMI/NI4I6ks1EgdFuLj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740051142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihxmkhVtzjtAXWC4JKXtTw0MfUHfHV2RI6ciPf5Ti4I=;
 b=b73hoT3jliIk9eXSSmCpgBOqdAkvxDFkbUWa0N1ylE5628Zddn6sSXtBvI/om8PBC6a2q9
 +Y0pjrgW75qQ4uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0137F13A42;
 Thu, 20 Feb 2025 11:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B4oLOsUSt2e3HgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 11:32:21 +0000
Date: Thu, 20 Feb 2025 12:32:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250220113220.GB2669224@pevik>
References: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix memory leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> setup_shared_mem() currently runs as part of run() function,
> and if it runs for too many iterations it can consume so much
> memory that OOM kills it.

> Move setup_shared_mem() along with the 2 checks for io_iter and
> num_threads to setup(). This way it runs only once and gets
> freed on test exit.

> As consequence setup_ious() also needs to be modified to no longer
> modify global variable 'aligned_buffer', because we don't re-initialize
> it on every iteration.

> And finally, at the end of run() function free also memory allocated
> by setup_ious().

Good catch, thanks!
Acked-by: Petr Vorel <pvorel@suse.cz>

nit: I would try to separate what can be separated (maybe free() calls?).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
