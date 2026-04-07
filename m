Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8117EFEEF52
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 15:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3688C3E4D7A
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 17:00:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76C143E16E7
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 17:00:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFD5B140098C
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 17:00:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A0374E4BE;
 Tue,  7 Apr 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775573996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTEe5cIspkNlTLC+lCmtjJthkQk0XjKgMxUILU1bYZc=;
 b=d+ewOMLzFR5bWUoFYqjhqU3Q87PYg2HgJMHYLclWaT+Gra/CyOFxeVguw1xgUD+qKtwTGB
 HA7HtWEG2irE0MyqWHwByLnpSfhkEkkthTgGCdi72do8ZAr0Ui2LEkzDRPJb4q4uG7ymg1
 awqh4jE1QvKb+hsoPWWsBuqdG19Ff1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775573996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTEe5cIspkNlTLC+lCmtjJthkQk0XjKgMxUILU1bYZc=;
 b=O5m9wtMz59b2Ol36Xm2ZScYb9XLtcDOjqR29Ju1Q2QoHTnlxYZBeOVS+STW+TD50eAO6Jv
 j6QEmobIntFgXlAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775573996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTEe5cIspkNlTLC+lCmtjJthkQk0XjKgMxUILU1bYZc=;
 b=d+ewOMLzFR5bWUoFYqjhqU3Q87PYg2HgJMHYLclWaT+Gra/CyOFxeVguw1xgUD+qKtwTGB
 HA7HtWEG2irE0MyqWHwByLnpSfhkEkkthTgGCdi72do8ZAr0Ui2LEkzDRPJb4q4uG7ymg1
 awqh4jE1QvKb+hsoPWWsBuqdG19Ff1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775573996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTEe5cIspkNlTLC+lCmtjJthkQk0XjKgMxUILU1bYZc=;
 b=O5m9wtMz59b2Ol36Xm2ZScYb9XLtcDOjqR29Ju1Q2QoHTnlxYZBeOVS+STW+TD50eAO6Jv
 j6QEmobIntFgXlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FED14A0B0;
 Tue,  7 Apr 2026 14:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wNyTEuwb1Wm4LwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 14:59:56 +0000
Date: Tue, 7 Apr 2026 16:59:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <adUb7ot3vD82kQ1B@yuki.lan>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
 <20260304-stream_refactoring-v2-3-3e48ada8ff1a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304-stream_refactoring-v2-3-3e48ada8ff1a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; SINGLE_SHORT_PART(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] fs: rewrite stream02 test using new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
No change from v2?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
