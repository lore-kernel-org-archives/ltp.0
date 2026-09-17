Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E1AC982CF
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:50:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465493E7583
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 13:50:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4403C2E57
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:50:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AC0E1000A25
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:50:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E628C1FF68;
 Thu, 17 Sep 2026 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789645832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaiCa0n19JtEDTc4f72mvEFPmj/EQThlmWeeEYS5/g=;
 b=k/st6ybaHWf2ROtKsBYVpMfceXA9YptHHeqQdE6gx1Y9+Wa2KW2kekDpDA6I9665YoNf0c
 Ib54KfOHXZNYv0aap99DN3e2U6EvFOr0O7lazCvsLqk9xhMDU3NZ8IdCmjGl/20BYPOo/T
 IPDAt7Lx7VDICNIh4YIFiFVcoxSRCNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789645832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaiCa0n19JtEDTc4f72mvEFPmj/EQThlmWeeEYS5/g=;
 b=y2OT1+nl7hgNYka0DfgyV/0p51EdOfxBxnnGM/JJPY51aOdUUYyQnA3uUeKGGdbgn9JyTk
 wOZuPETaLH8cq6Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789645827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaiCa0n19JtEDTc4f72mvEFPmj/EQThlmWeeEYS5/g=;
 b=JoxnYVEReNIkOokGZJAG2DLWOOUZFVjW8RsHEenkAiTGp0AkZS452D/8+nAGw2bFJRovXw
 jqfF7XnAxGgNPx2yHfn4d/VLBbQGzQaH1huhSQF14KmD2sgv5ZYkEeIvDT7yXexT5eyOr6
 U3pv4Z/tcOtTV6b3zMFwqQ92qbcg49Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789645827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaiCa0n19JtEDTc4f72mvEFPmj/EQThlmWeeEYS5/g=;
 b=Gcu3J6eH6F0g1WUkOP4NQeG1JBpu6Vh1zCj3JsmIKwi3zCwBlM/G026FULdz0CBcXVoOpk
 vdbm2BWhj1mKDwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BEB1374A;
 Thu, 17 Sep 2026 11:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4WAUJAPUq2oUSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 17 Sep 2026 11:50:27 +0000
Date: Thu, 17 Sep 2026 13:50:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqvUDzAjzoEibVXu@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-10-pvorel@suse.cz>
 <aququIx31-BBNlnq@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aququIx31-BBNlnq@linux.dev>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/36] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Maybe refine it like below:
> 
> static void run(void)
> {
> 	int rc;
> 
> 	memset(buf, 0, sizeof(buf));
> 
> 	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
> 
> 	if (rc < 1) {
> 		tst_res(TFAIL, "returned %d, expected >= 1", rc);
> 		return;
> 	}
> 
> 	if (rc == 1) {
> 		if (buf[0] != '\0')
> 			tst_res(TFAIL, "empty label is not NUL terminated");
> 		else
> 			tst_res(TPASS, "no label set, empty string returned");
> 		return;
> 	}
> 
> 	if (buf[0] == '\0')
> 		tst_res(TFAIL, "non-empty label is NUL terminated");
> 	else
> 		tst_res(TPASS, "security label returned, full length %d", rc);
> }

Shouldn't we check that the security label is NUL terminated as well?

The algorithm description in the doc comment actually says what should
be done:


	if (rc == 0) {
		tst_res(TFAIL, "empty security label not NUL terminated");
		return;
	}

	if (rc > sizeof(buf)) {
		tst_res(TFAIL, "buffer too small");
		return;
	}

	if (buf[rc-1] != '\0') {
		tst_res(TFAIL, "security label not NUL terminated");
		return;
	}

	tst_res(TPASS, "Security label was NUL terminated");

And perhaps we can as well check that there is no NUL byte in the buffer
before rc as well:

	for (i = 0; i < rc; i++) {
		if (buf[i] == '\0')
			tst_res(TFAIL, "NUL in the middle of security label at %i", buf[i]);
	}


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
