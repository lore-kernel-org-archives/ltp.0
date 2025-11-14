Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3770BCE7AEF
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 14:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A543CF838
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 15:37:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E5853CF838
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 15:37:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 759D36002EC
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 15:37:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4C91F7DE;
 Fri, 14 Nov 2025 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763131033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hF0K2a8YRfNV2X5DZzXRBeCbPDCHlaQmYpHjZ597fj4=;
 b=xxjwvgADYnhBo6OxhBKKFPh64krYIQfc0TX5myA/HZC+TtFrnl3c7PxdCfcTxYJq0jA+bd
 q8rOFbOctieageDpObZO+3RMmhgWIc5YkEn0yYtgKhbLxmUzepHQ1DARZ1GYSaFCo6Qhbi
 aSuFQYy/9KoI/oBANYOJCkiqAUphxGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763131033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hF0K2a8YRfNV2X5DZzXRBeCbPDCHlaQmYpHjZ597fj4=;
 b=6N5Jx3h+AtiR1fBuw/OBNRkxhKpweZJDu16Rsfdn+wmGLJY3YpLffTBE4RwQmqNwqUHa2t
 ygx9sSiDmmKijgAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xxjwvgAD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6N5Jx3h+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763131033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hF0K2a8YRfNV2X5DZzXRBeCbPDCHlaQmYpHjZ597fj4=;
 b=xxjwvgADYnhBo6OxhBKKFPh64krYIQfc0TX5myA/HZC+TtFrnl3c7PxdCfcTxYJq0jA+bd
 q8rOFbOctieageDpObZO+3RMmhgWIc5YkEn0yYtgKhbLxmUzepHQ1DARZ1GYSaFCo6Qhbi
 aSuFQYy/9KoI/oBANYOJCkiqAUphxGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763131033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hF0K2a8YRfNV2X5DZzXRBeCbPDCHlaQmYpHjZ597fj4=;
 b=6N5Jx3h+AtiR1fBuw/OBNRkxhKpweZJDu16Rsfdn+wmGLJY3YpLffTBE4RwQmqNwqUHa2t
 ygx9sSiDmmKijgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 493773EA61;
 Fri, 14 Nov 2025 14:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t3fTEJk+F2ldAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Nov 2025 14:37:13 +0000
Date: Fri, 14 Nov 2025 15:38:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRc-y_W0StnungVp@yuki.lan>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-6-pvorel@suse.cz>
 <12777454.O9o76ZdvQC@thinkpad> <20251114102457.GC52218@pevik>
 <aRcEIpgvi9C8NKLd@yuki.lan> <20251114120937.GD43654@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251114120937.GD43654@pevik>
X-Rspamd-Queue-Id: 5C4C91F7DE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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
> Do you mean to use full swap file path from /proc/mounts, i.e.
> /tmp/LTP_swaNzeMJr/mntpoint/testswap, /tmp/LTP_swamEVVAc/mntpoint/testswap03,
> ... (example from run which created /tmp/LTP_swamEVVAc with all swap files,
> cleanup interrupted by ctrl+C and following one which created /tmp/LTP_swaNzeMJr
> single swap file only):

If we make the swapfile names unique enough we can match just that
instead. I think one of the patches did just that by including the test
name in the swap filenames. If we want to be extra sure we can take last
directory component of the test temporary directory as well. What I'm
trying to point out is that the $TMPDIR part of the test temporary
directory is not adding anything unique to the path since that is prefix
that is used by all LTP tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
