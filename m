Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3011606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hvjfNm2b;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ii2/I6UO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RQZGL/Uh;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=prtxl/JE
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B4BB3E92D4
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 08:55:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2CE53C9DEB
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 08:55:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E53EF1400C5D
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 08:55:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76CEC1F7B3;
 Thu, 19 Nov 2026 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795074930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHN/mdZp3PbmffZu6weHc9Umq2eWNpcNUEfqMip0xcQ=;
 b=hvjfNm2btFNb/7zlVcmHM/zdGGiFTYogEz7ug6A50wHRaIxjd72TavqBaKawN+mOEQ6mtb
 eHQGuhnvaUBfgUyFam8eH9rYvTy4/56nAQsi0EwdSxnTVaIovsmOMgqBOt/Fi2cwWOJBzh
 X5+5s411eAcIO4WFMVrtS1gj17vqCeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795074930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHN/mdZp3PbmffZu6weHc9Umq2eWNpcNUEfqMip0xcQ=;
 b=Ii2/I6UO/Whajgt4u6tU7mPN7xVU0MpXS0TpUoDvR4VumQbD/+8oD/Dft77kiXfK+1WAJB
 fGFND8IK67GwFFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795074929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHN/mdZp3PbmffZu6weHc9Umq2eWNpcNUEfqMip0xcQ=;
 b=RQZGL/Uh2hHOLEUKBPd8nlwLNX+04cRWZeYZbEblV39Iajn+6gcyMJ1lhvSEEA9YjyRlc0
 asQDV5ZzKQRg6VRsqUccn5WKmWpEgwfpj5Go1+Giue+jI/52QBm8L+GxHwhgYraiKs/m+X
 7aluTvvYkzsdW/Juw0iBb8fUIjgfcrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795074929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHN/mdZp3PbmffZu6weHc9Umq2eWNpcNUEfqMip0xcQ=;
 b=prtxl/JELbFhbBciSKRzaadxZFXNXoltrhVDOzSAm6D4sNw4r2PAW+eImVF+BiSX4DQr1+
 kpJoKj7Hp2Y8QHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DE801334C;
 Thu, 19 Nov 2026 07:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BRpHA3Gr/momcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Nov 2026 07:55:29 +0000
Date: Thu, 19 Nov 2026 08:55:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <av6rijAJdAToOmET@yuki.lan>
References: <20261117235848.2975548-1-wakel@google.com>
 <20261118044914.3815-1-linuxtestproject.agent@gmail.com>
 <av16AqIo5sj10FEv@yuki.lan>
 <20261118131808.682117-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118131808.682117-1-wakel@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-17.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -17.30
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_rtc01: Report TCONF on system time mismatch when
 STA_UNSYNC is set
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Hmm, I guess that the logic should be the other way, if STA_UNSYNC is
> > not set the clock was modified by NTP and the test should be skipped:
> 
> I think the logic in 3d11e5dd622e as applied is the right way around;
> inverting it would bring back the failure this patch fixes.

I was thinking about this yesterday and I think that we should redesign
the test to make it simpler and more robust. I will send a patch that
changes the test so that it samples rtc and monotonic timer for a while
and checks that they increase in the same steps. That removes the
absolute offset and the test stops being dependend on time being in
sync.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
