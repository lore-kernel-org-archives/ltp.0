Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04398EDF058
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 08:48:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE263CF18A
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:48:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EBC73CCAB2
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:48:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9839A1400262
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:48:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 012015BD96;
 Thu, 12 Feb 2026 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770886090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xmJcK7ZEp67HKY599Ja+jjxrTmfUVOCqnDeeDPSGmQ=;
 b=UlgLUM7KimqFUnPmlgM/pkVXu1Q1hgmTNFe+Hs0LqrkixxfY2hvKJtc6NG/f5S2hBxyFeO
 Z0SlYcoAB9TLRIKwcS7wPkBGThp3slJiDOdk7Q+ZS2PtXMQHd/iahcq7BBQTd3J/7HfVFh
 G1Pl8vT6Pwh2IK67RWkKVn9nfAcMKYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770886090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xmJcK7ZEp67HKY599Ja+jjxrTmfUVOCqnDeeDPSGmQ=;
 b=J5ZBT8JyCl0BOLbR6wtv3EEif7F2d/z9jeJJzz3Ex3cGOLrb+qIG0/o5VmYfPCfGhsgbA3
 5WGlGV/QCdCiuuAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UlgLUM7K;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J5ZBT8Jy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770886090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xmJcK7ZEp67HKY599Ja+jjxrTmfUVOCqnDeeDPSGmQ=;
 b=UlgLUM7KimqFUnPmlgM/pkVXu1Q1hgmTNFe+Hs0LqrkixxfY2hvKJtc6NG/f5S2hBxyFeO
 Z0SlYcoAB9TLRIKwcS7wPkBGThp3slJiDOdk7Q+ZS2PtXMQHd/iahcq7BBQTd3J/7HfVFh
 G1Pl8vT6Pwh2IK67RWkKVn9nfAcMKYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770886090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xmJcK7ZEp67HKY599Ja+jjxrTmfUVOCqnDeeDPSGmQ=;
 b=J5ZBT8JyCl0BOLbR6wtv3EEif7F2d/z9jeJJzz3Ex3cGOLrb+qIG0/o5VmYfPCfGhsgbA3
 5WGlGV/QCdCiuuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5C823EA62;
 Thu, 12 Feb 2026 08:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sRltL8mTjWkSTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Feb 2026 08:48:09 +0000
Date: Thu, 12 Feb 2026 09:48:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260212084804.GA5659@pevik>
References: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
 <aYyrcqnGWKhsIUej@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYyrcqnGWKhsIUej@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 012015BD96
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix documentation build with latest
 setuptools
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!
> > Force setuptools to version 81.0.0, which is the last one where linuxdoc
> > still can be installed. Also, from python 3.12 setuptools is not
> > available anymore when creating a new virtualenv, so we need to force
> > its installation to ensure that documentation will be built.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

+1, higher setuptools version is probably better as it's still working on the
oldest distros (than 68 version I added in my patchset). IMHO it'd be good to
add (before merge) a comment to requirements.txt that it's just a temporary
workaround (once linuxdoc is released I'd upgrade it and remove the dependency).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
