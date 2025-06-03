Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B852C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 10:31:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7EE3C9F9A
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 12:31:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B74D03C9DCF
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 12:31:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C14CB60067B
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 12:30:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4A4D21255;
 Tue,  3 Jun 2025 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748946658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=wj2wsL6fzgRhMz3mu2FvctPJ2ULdPUHqSJN5aPH0yHk01x+hwDwwIX898FM7oQeu6k80p/
 vNPR+m1eNUJ8zlWsOB0j55TNXRjO/m+u3fQpqCUcy8QUqecqBv93sjx6L44xv06+1tXqR8
 hq6hwkNKm0GNqDx29DXO3st9E82SGDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748946658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=BU6KIXMlaKAMQYbwcH1ZkVph2Bxk/e82WehxpoGjcZ2m4WDlkr213mJKiXWlynDmfOdFVe
 1xNO/MVGCXrx1cCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748946658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=wj2wsL6fzgRhMz3mu2FvctPJ2ULdPUHqSJN5aPH0yHk01x+hwDwwIX898FM7oQeu6k80p/
 vNPR+m1eNUJ8zlWsOB0j55TNXRjO/m+u3fQpqCUcy8QUqecqBv93sjx6L44xv06+1tXqR8
 hq6hwkNKm0GNqDx29DXO3st9E82SGDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748946658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=BU6KIXMlaKAMQYbwcH1ZkVph2Bxk/e82WehxpoGjcZ2m4WDlkr213mJKiXWlynDmfOdFVe
 1xNO/MVGCXrx1cCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A05C413A1D;
 Tue,  3 Jun 2025 10:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LTsPJuLOPmgYUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Jun 2025 10:30:58 +0000
Date: Tue, 3 Jun 2025 12:31:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aD7PAa_Juheq7eb4@yuki.lan>
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
 <20250602-lsm-v5-4-5c0dd01df3c4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250602-lsm-v5-4-5c0dd01df3c4@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] Add lsm_get_self_attr03 test
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
