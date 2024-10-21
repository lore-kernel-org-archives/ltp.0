Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E1D15D9A
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 14:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B793C6F17
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 16:29:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB7D43C6ED6
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 16:28:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22D1C61959A
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 16:28:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 924431F7F3;
 Mon, 21 Oct 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729520931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=749ad4kekkP7Oan/MH1aleIFVQjzCMy1d/OciLHSIz4=;
 b=UWaodKSUBbvapyBq5tGvKuoz2Q8hkk9PkxkBKDrlpFWsHeURvZBo+ObT2L4LcBso2vPnkf
 Z+WCYr452CLgTxD/e7uasCbFGNqbThQH/nF1YBSmDlAazgdQJsr0t3q+LKYhmFbYQUgKvc
 OrW8Vqfl+MDfwwaTclus64fmS3Wdwq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729520931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=749ad4kekkP7Oan/MH1aleIFVQjzCMy1d/OciLHSIz4=;
 b=X1HtddTosDKFGT4grmGdfd4fJIVN/K24F54DQqk3PNWYesgqq6Fg06GdDhbEirFPbIyOUD
 74lKXVCE+vm9LkCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729520931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=749ad4kekkP7Oan/MH1aleIFVQjzCMy1d/OciLHSIz4=;
 b=UWaodKSUBbvapyBq5tGvKuoz2Q8hkk9PkxkBKDrlpFWsHeURvZBo+ObT2L4LcBso2vPnkf
 Z+WCYr452CLgTxD/e7uasCbFGNqbThQH/nF1YBSmDlAazgdQJsr0t3q+LKYhmFbYQUgKvc
 OrW8Vqfl+MDfwwaTclus64fmS3Wdwq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729520931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=749ad4kekkP7Oan/MH1aleIFVQjzCMy1d/OciLHSIz4=;
 b=X1HtddTosDKFGT4grmGdfd4fJIVN/K24F54DQqk3PNWYesgqq6Fg06GdDhbEirFPbIyOUD
 74lKXVCE+vm9LkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66BB4139E0;
 Mon, 21 Oct 2024 14:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nwewFiNlFmd2VgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Oct 2024 14:28:51 +0000
Date: Mon, 21 Oct 2024 16:28:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20241021142842.GA483032@pevik>
References: <20240416080237.22627-1-xuyang2018.jy@fujitsu.com>
 <1934768.7Z3S40VBb9@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1934768.7Z3S40VBb9@localhost>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] flock: Add negative tests for flock
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

Hi Yang Xu, Avinesh,

> Hi Yang Xu,


> When I am testing this by running multiple times, EINTR test is getting
> timed out randomly.

> tst_test.c:1625: TINFO: Timeout per run is 0h 00m 30s
> flock07.c:46: TINFO: Got SIGUSR1
> Test timeouted, sending SIGKILL!
> tst_test.c:1673: TINFO: Killed the leftover descendant processes
> tst_test.c:1679: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1681: TBROK: Test killed! (timeout?)

> In these cases I see that there are two locks (held or waiting) by the process
> even after SIGUSER1 signal is delivered, so somehow signal is being ignored.

> flock07         16520  FLOCK        WRITE* 0          0          0 /tmp...
> flock07         16519  FLOCK        WRITE  0          0          0 /tmp...


> And I feel we should add EWOULDBLOCK errno test to flock02.c file,
> and keep only EINTR testcase here. 

There are v2 and v3 sent by Avinesh, therefore I set this in patchwork as
"Changes requested". Please correct me if I'm wrong.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
