Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA889CCA470
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 09:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 424873CE71C
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 11:44:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43853CE70F
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 11:44:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F8DB140004E
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 11:44:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 503CB219D6;
 Wed,  8 Oct 2025 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759916647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA2hul1bsqSmk613N4mzVxdVztZvCOQ41eZ98JEW0QE=;
 b=lehHNqOFE9AD+ftws5MORBifYKGWnE3Tc71gykw+SJDxUJ0WQpux59GOXN2264RLqpynA6
 zlmLbQHe8QM0ut//NqpI3zWDUEVaHbMVBt4l9FseC2TPaqAsoB42nZTxFz3Y4x1mOgC6RQ
 +5PlSJbzWZlf57hP61yUvN+tuxe1YCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759916647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA2hul1bsqSmk613N4mzVxdVztZvCOQ41eZ98JEW0QE=;
 b=OVUc+wHDSPnYHxOd23gE57WG4p5U4uvfoJ3luCO+iKeYXUkw+/Cvo1PPzMvZdceIhnO3wM
 IPOSM2gLV8pnRlDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759916647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA2hul1bsqSmk613N4mzVxdVztZvCOQ41eZ98JEW0QE=;
 b=lehHNqOFE9AD+ftws5MORBifYKGWnE3Tc71gykw+SJDxUJ0WQpux59GOXN2264RLqpynA6
 zlmLbQHe8QM0ut//NqpI3zWDUEVaHbMVBt4l9FseC2TPaqAsoB42nZTxFz3Y4x1mOgC6RQ
 +5PlSJbzWZlf57hP61yUvN+tuxe1YCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759916647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA2hul1bsqSmk613N4mzVxdVztZvCOQ41eZ98JEW0QE=;
 b=OVUc+wHDSPnYHxOd23gE57WG4p5U4uvfoJ3luCO+iKeYXUkw+/Cvo1PPzMvZdceIhnO3wM
 IPOSM2gLV8pnRlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F11313A3D;
 Wed,  8 Oct 2025 09:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2CdUDmcy5mitBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Oct 2025 09:44:07 +0000
Date: Wed, 8 Oct 2025 11:44:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aOYymT7OSXseISoS@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-9-bf458fa66358@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007-xattrat-v2-9-bf458fa66358@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/10] Add setxattrat01 test
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
> +/*\
> + * [Description]
> + *
> + * Test if setxattrat() syscall is correctly following symlink, setting a
> + * xattr on a file.
> + *
> + * [Algorithm]
> + *
> + * - create a file and the symlink pointing to it
> + * - run setxattrat() on the symlink following the pointing file
> + * - verify that file xattr has been set
> + * - verify that symlink xattr has not been set

Shouldn't this be a variant of a setxattr() test?

> + * - run setxattrat() on the symlink with AT_SYMLINK_NOFOLLOW
> + * - verify that file xattr has not been set
> + * - verify that symlink xattr has been set
> + */

And this a variant of lsetxattr() test?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
