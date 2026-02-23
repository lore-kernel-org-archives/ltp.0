Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE16AEA4FD8
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 15:45:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52A403D0F51
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 16:45:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C16D3D0F49
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 16:44:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B627460007A
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 16:44:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 257785BE62;
 Mon, 23 Feb 2026 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771861489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9ueqlXL+HTRkJpT/U4QHjE//Xjkc2zacj5A6EFG6z4=;
 b=DMzS/b7WCBC0W1KPsa6t5rQPaGFqWV+Hv3Yn2Lae1/qf9TFoIHjiFA595wM0iOLQynxLZm
 4OTpaY8KBUBVVAuIlbpJ4i/X6Mx8juxTqszKjGZiO7ML1ss8l4vjm56PZnG5Sx3yU70bao
 rXC8n9KUuKEAryulFcr67JVjT3IYuqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771861489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9ueqlXL+HTRkJpT/U4QHjE//Xjkc2zacj5A6EFG6z4=;
 b=05xhvMu3V+HfAkkciBA4x/kkkrl7jihXf0u8RFaY8gjNMOJJyYGJgx/ZYDVSNspP3u6Rt9
 IYaPkvvNmMBvsIAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771861489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9ueqlXL+HTRkJpT/U4QHjE//Xjkc2zacj5A6EFG6z4=;
 b=DMzS/b7WCBC0W1KPsa6t5rQPaGFqWV+Hv3Yn2Lae1/qf9TFoIHjiFA595wM0iOLQynxLZm
 4OTpaY8KBUBVVAuIlbpJ4i/X6Mx8juxTqszKjGZiO7ML1ss8l4vjm56PZnG5Sx3yU70bao
 rXC8n9KUuKEAryulFcr67JVjT3IYuqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771861489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9ueqlXL+HTRkJpT/U4QHjE//Xjkc2zacj5A6EFG6z4=;
 b=05xhvMu3V+HfAkkciBA4x/kkkrl7jihXf0u8RFaY8gjNMOJJyYGJgx/ZYDVSNspP3u6Rt9
 IYaPkvvNmMBvsIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C5FD3EA68;
 Mon, 23 Feb 2026 15:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CSXkGvB1nGnhRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Feb 2026 15:44:48 +0000
Date: Mon, 23 Feb 2026 16:44:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260223154446.GA19338@pevik>
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz>
 <aZQytH7k6pVXqdsz@yuki.lan> <20260219202051.GB341772@pevik>
 <aZhJ7h0toQVUzHnf@yuki.lan> <20260220153410.GA392516@pevik>
 <aZiNbmssVOrwSsiV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZiNbmssVOrwSsiV@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.com,redhat.com,lists.yoctoproject.org,gmail.com,linuxfoundation.org,sony.com,linaro.org];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: Tim Bird <Tim.Bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> Ah, that's a bit confusing then because in shell script # is a comment.
> I usually prefix commands that needs root with sudo instead. So what
> about "$ sudo make install" ?

patchset merged with agreed diff (below). LTP is now without runltp.
Thanks a lot for a review.

Kind regards,
Petr

+++ INSTALL
@@ -104,10 +104,10 @@ Quick Start
 	$ cd ltp
 	$ ./configure
 	$ make all
-	# make install
+	$ sudo make install
 
 *NOTE:
-- For running tests use kirk [1], individual test you can run directly.
+- For running tests use kirk [1].
 - LTP assumes the existence of the nobody, bin, and daemon users and their
 groups.  If these IDs do not exist, certain tests will fail. The respective
 user and group IDs should be the same, i.e. if `nobody's' user ID is 99, then


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
