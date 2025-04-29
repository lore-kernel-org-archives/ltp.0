Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0AC369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 05:23:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B7EB3CBBF6
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:23:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A005A3CA0E0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:22:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CE30600566
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:22:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D0E421216
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 05:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745904170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=BJL4tzWUKFx+Rbhblqnhp8cv08eih4CTeLXIGOd6uVo=;
 b=Poh5Zxd4fzZfn68CG2xUbdbuqpTRlXvHlSZMKjhkFsinVK5uFarJVjotVVm9gYHRcWN5Im
 mOMIZPRA2kINmZm/FzGmseCaQAA5GKI5haJnvn414pXFz5eAUPZW5v+OW6Znps/GCgoYR7
 QQa+mFYkzBBmsK3FR0qtj9JMxqNHrGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745904170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=BJL4tzWUKFx+Rbhblqnhp8cv08eih4CTeLXIGOd6uVo=;
 b=VMpaCFeBgW4Lijoe6zYdSNJ/mHcAvHu++vjSJfH8oIF9OJ07xbqHuFIRIWsKLfjsWBOtiz
 nem59sBzVDLVEtCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745904169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=BJL4tzWUKFx+Rbhblqnhp8cv08eih4CTeLXIGOd6uVo=;
 b=o7b3kWlgTeTM54ldnonKTWitFhuQzz1J/xwFjCURlrdJIdeI5qKAdVFhPXA9u4bFG9THOB
 o5s6m7lzn+U7eRn6L9lgHU3liGI/53+VqQLvMiJqfZEWKEo4wL8LEgD7CLjLXfy5Z4clas
 w9F74j+ITtt86m01KyF89E+6h46WCIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745904169;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=BJL4tzWUKFx+Rbhblqnhp8cv08eih4CTeLXIGOd6uVo=;
 b=tNhYGpOrbg1jDwHCB459teJZfiOJSKeXMRFUwMV5o1Uy7eBS1oGa5yQ6ABEAmmm/feTs7R
 DyGiRBFehhnoi0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A4A81340C
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 05:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a1EcGSliEGitTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 05:22:49 +0000
Date: Tue, 29 Apr 2025 07:22:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250429052247.GA144682@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP in valgrind :)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

in case you haven't read the news in LWN, LTP is now part of valgrind [1]:

	The Linux Test Project (ltp) is integrated in the testsuite try
	'make ltpchecks' (this will take a while and will point out various
	missing syscalls and valgrind crashes!)

FYI script they use [2]. They consider some test long running [3].

Kind regards,
Petr

[1] https://www.mail-archive.com/valgrind-users@lists.sourceforge.net/msg07691.html
[2] https://sourceware.org/git/?p=valgrind.git;a=blob;f=auxprogs/ltp-tester.sh;h=000cfaa7f336f8641f464d107a363af24f607614;hb=HEAD
[3] https://sourceware.org/git/?p=valgrind.git;a=blob;f=auxprogs/ltp-error-patterns.txt;h=ee5048bf42b652258fb469a632fb2d16afb72c38;hb=HEAD

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
