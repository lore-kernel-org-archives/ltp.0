Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15272CAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A723CE08B
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:17:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04213CE08C
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:17:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 65DD0600045
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:17:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94B9823471;
 Fri, 26 Sep 2025 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758874650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2ORdCj3Yu46itEQVMxk6hMGQGSvTSZiEBj9NjAuwcw=;
 b=blg43xfOl+kytLrLStGA7+FaWIlArq7FaFMJFEx8egl8ZzSFNNBuUF4HpOp2chQiuotERH
 OeDXVsEqFWgLWl1SaGBIOeORXQ6O3ZneVPEuX5cgZ3otINXYjoRD7ROyDQThtLA2J9ACHB
 ldE/gCb0L1oxgseq4Qao+dq8Rksjxps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758874650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2ORdCj3Yu46itEQVMxk6hMGQGSvTSZiEBj9NjAuwcw=;
 b=GyoBv9VvlJCrr/aIm50O/KmQa8fpl/xEiRnQ7GZnyv7rd1P3HjO6Ux74/3Eluh7nOCbLcP
 cVsEX7t1Gyh+uBAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758874650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2ORdCj3Yu46itEQVMxk6hMGQGSvTSZiEBj9NjAuwcw=;
 b=blg43xfOl+kytLrLStGA7+FaWIlArq7FaFMJFEx8egl8ZzSFNNBuUF4HpOp2chQiuotERH
 OeDXVsEqFWgLWl1SaGBIOeORXQ6O3ZneVPEuX5cgZ3otINXYjoRD7ROyDQThtLA2J9ACHB
 ldE/gCb0L1oxgseq4Qao+dq8Rksjxps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758874650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2ORdCj3Yu46itEQVMxk6hMGQGSvTSZiEBj9NjAuwcw=;
 b=GyoBv9VvlJCrr/aIm50O/KmQa8fpl/xEiRnQ7GZnyv7rd1P3HjO6Ux74/3Eluh7nOCbLcP
 cVsEX7t1Gyh+uBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CFC1373E;
 Fri, 26 Sep 2025 08:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PpJ5HhpM1mh4cgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 08:17:30 +0000
Date: Fri, 26 Sep 2025 10:18:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aNZMRM3s7c5hyj3H@yuki.lan>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <d39802b7-6ab3-4c78-a660-34d7bc0a3dd3@suse.com>
 <aNZI_qWdLSLAz5pH@yuki.lan>
 <9da94554-faae-4864-8908-c1484ee55ac4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9da94554-faae-4864-8908-c1484ee55ac4@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Why not just using=A0 "#if!defined(HAVE_STRUCT_STATMOUNT) || =

> defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)" inside the statmount09 test =

> then? These LTP_HAVE_* wrappers are a bit weird because they are mixing =

> with internal LTP macros, also considering the fact we are not testing =

> "struct statmount.mnt_ns_id" anywhere else but in statmount09.

Works for me as well, I do not have a strong opinion here.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
