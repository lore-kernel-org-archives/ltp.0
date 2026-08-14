Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2FBC5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 10:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D253C74CC
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:09:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B813C72A1
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:08:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 43EAB1A008B3
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:08:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6528B82E0F;
 Fri, 14 Aug 2026 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786702133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAg7Kcifv0ewVRZIc9sxsO3/6VsSRahZo7sHl6BFBNA=;
 b=pYqwA6mwM4nY2rezIZYDGSB1Ymzz2vt2w4PH9VVyENUp8Y2a+tKBa3PA3XvB8P7/bT/Ctw
 dfg2oLnIz9OETi9+kE+LfAkkBp21CO99ng7VzisNUOsNp6H3pdb5USNVhftUTd8LHP9Tqk
 Tnq92hOhHITp54luc7LB74nheF6lKfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786702133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAg7Kcifv0ewVRZIc9sxsO3/6VsSRahZo7sHl6BFBNA=;
 b=ZoJz33NOObW16cfTgQvd+RTeS7nxUn2w9U0iOJi7jB0bNPXbGpZPZPsPbEuJhEpZcsHNW5
 MqHNWYBDA7L8IqAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U5C9GWWC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/J2/Ah+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786702129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAg7Kcifv0ewVRZIc9sxsO3/6VsSRahZo7sHl6BFBNA=;
 b=U5C9GWWC8SEQtWoey8k1v5yXrnYcu7tv4hftbeomJkG7dUt6gxzDLrbzWaqPEjeFiU4CO0
 vVpCNAaZyP4Men3ANWFmKzx5CBQxOEvWygCi0HJe5szM1wIsdbkkq9yGctSztI/amhSV9K
 xw9H4vOQvmi44P9OxG94IM5No847lFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786702129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAg7Kcifv0ewVRZIc9sxsO3/6VsSRahZo7sHl6BFBNA=;
 b=/J2/Ah+fqJAwhME25fpM6EHGme9ggR+ueOI2lWYXmoI7YvegBBk6RkhoII2jql+9jHN9sS
 mDvnPuoVmR0tGTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56C887830D;
 Fri, 14 Aug 2026 10:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cnBSFDHpfmrmEgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Aug 2026 10:08:49 +0000
Date: Fri, 14 Aug 2026 12:08:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <an7pLCWfdgEPV6G1@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTyVyeeMo6EQfG@yuki.lan> <20260812130025.GB1758016@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260812130025.GB1758016@pevik>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 6528B82E0F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> You're probably right. When I started this there were 3 tests and I thought there
> would be more. I also thought this would be useful info in the metadata.  But
> in later versions it turn out 2 of them are to be removed. Now I double checked
> "tst_kvercmp >" code and it looks like none of them applies to .max_kver usage.
> I agree that a single test is not enough as a reason to have it in the metadata.
> Maybe there will be more in the future, but really just a few.

I would set the threshold at at least two tests needs this. If the
functionality is used only by one test, it's likely not worth adding the
API.

> => I should probably send yet another version where I implement the skip in the
> setup. Could you please comment these 2 commits (I would not resend them)?

Which ones?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
