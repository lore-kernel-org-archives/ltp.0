Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C772EE77180
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 08:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92AE3E60C8
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 09:30:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6876C3E5A94
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:30:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 515B7651765
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 09:30:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 000C71F38E;
 Thu, 12 Dec 2024 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733992226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
 b=ES+Sl2bAqYwphsg/lbBDaMGUDaBWrcjpZiBOyPM/u7BDULVe6a8w303fHIvTRtnkKJXRwy
 iS7eAH3CqX6gKOQ7zB+sDXqKa8aS9UMgDsP2OZ70FPepdLR+r+tb0nD9HgNL18x5Dw15J9
 j0mAT77iVSAUHhNsEhvHQQAWLGyvrlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733992226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
 b=F92mETQy90eZLVGijQF5Qd5wIxOq0l23y14UkfwJPSzW8QQe6G/t0msaCucCGpI1TLVaQk
 vYcPx3S+hzfwJeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733992226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
 b=ES+Sl2bAqYwphsg/lbBDaMGUDaBWrcjpZiBOyPM/u7BDULVe6a8w303fHIvTRtnkKJXRwy
 iS7eAH3CqX6gKOQ7zB+sDXqKa8aS9UMgDsP2OZ70FPepdLR+r+tb0nD9HgNL18x5Dw15J9
 j0mAT77iVSAUHhNsEhvHQQAWLGyvrlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733992226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NkeoeouqUUw3Ci/tp/lucSrFw7eV8sdxet8Wm++Cfyo=;
 b=F92mETQy90eZLVGijQF5Qd5wIxOq0l23y14UkfwJPSzW8QQe6G/t0msaCucCGpI1TLVaQk
 vYcPx3S+hzfwJeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86D213508;
 Thu, 12 Dec 2024 08:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mm5EOCGfWme0egAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 08:30:25 +0000
Date: Thu, 12 Dec 2024 09:30:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20241212083024.GA1463264@pevik>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-4-pvorel@suse.cz>
 <b6464e2c5c0195ffd882e6cc484b2f12e7383349.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6464e2c5c0195ffd882e6cc484b2f12e7383349.camel@linux.ibm.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] ima_{kexec, keys,
 selinux}: Set minimal kernel version
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> On Tue, 2024-11-26 at 18:38 +0100, Petr Vorel wrote:
> > The functionality IMHO was not backported to the enterprise kernels.

> > This helps to avoid false positive in ima_kexec.sh:
> > ima_kexec 1 TWARN: policy not readable, it might not contain required
> > policy '^measure.*func=KEXEC_CMDLINE'
> > ima_kexec 1 TBROK: unable to find a correct measurement

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Looks good.

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks a lot, this patch merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
