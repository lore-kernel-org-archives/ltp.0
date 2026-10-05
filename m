Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924BFCA5FFC
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 14:57:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89AF43E9DB9
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 16:57:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEAD53E6B40
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 16:57:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 760FA20038B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 16:57:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D02651F7D9;
 Mon,  5 Oct 2026 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791212223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKQz0fGpRS0Mo+SOVGqWNO4Vdsig5dr+MAJ61Xa28Tw=;
 b=m1UpDj6oSgFDE1j8+W3DhqTTC4yPslH1AWWRgpaV49aLpxlhhEniVNd60v4yOunrEJDZ0s
 63G+GK5mLlWzADv96lJu0ROCmrX7dQZjzGtyHNGLr+jYw0X/kzwWq7t4tZiXyCIB3jIfC2
 7bVdhHe4zKSShKQcE6IK0uFyzEMmFHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791212223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKQz0fGpRS0Mo+SOVGqWNO4Vdsig5dr+MAJ61Xa28Tw=;
 b=ZgmDdS/cUZlup7t2sXV0/NSPSyJ1iWteMX7QGxfbZNow96mbIuquYGLTvFu5+Gz7vvQLmA
 5yD5+ZoI3JIBPpBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791212218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKQz0fGpRS0Mo+SOVGqWNO4Vdsig5dr+MAJ61Xa28Tw=;
 b=DUjKQG69oqws47SsrYMo9K8QPPyJ2ZZUVOHsbP2P86Rwk2OmCwoVK3Ym0ip+bZMEsbTWfv
 iQmzLJc7BAExR8zw3BUb/asMWOKdmtXjky0ExVVLfzuMcyUx8jNLSLBY/JdgjyIIlSrzwq
 vhoL8lh8MunZUyDm9ORDTNLa2R9XXZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791212218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKQz0fGpRS0Mo+SOVGqWNO4Vdsig5dr+MAJ61Xa28Tw=;
 b=85pybTIg0ggdREI0GxScM3sosRa0I8qsff17mquliyZ+sQ+w1/o0tdEc/ZtrPiRWpv76fi
 r3hAwC/hvw/LB7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A07E213688;
 Mon,  5 Oct 2026 14:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9RtTH7q6w2rOUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 05 Oct 2026 14:56:58 +0000
Date: Mon, 5 Oct 2026 16:57:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asO6ynlX_3aWz2BC@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-1-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-1-fec334ce8e80@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/15] ujson: Fix 4-byte UTF-8 sequence decoding
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
This has been fixed in ujson upstream actually:

https://github.com/metan-ucw/ujson/commit/cf30c1be12a06976d2c11ad2ccd3fd48ddf58e7d


I wonder if it would make more sense to route these into ujson library
first, then vendor fixed library into LTP. Or add it as a submodule.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
