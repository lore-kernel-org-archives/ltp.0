Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B31CCA476
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 14:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6F403CE4C4
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 16:35:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218313C2B90
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:34:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 68DB51A00903
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:34:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64CBA1F44F;
 Tue,  7 Oct 2025 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759847684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi9aVrvw4kUY/Z/9f1T9lkR6YofAoMcg9Jxl1GX4AO8=;
 b=YwkmWhnoWe/cKKGBmQDfF8QUbxpZ8YGHP0yusGaXc0mB/21uHtb15VYaPNE8KWHvmTRCGI
 ELyPxNFqsj8/2x6FetKP0hVip34o3C32P7txAsVbazHHSq8BqL3zHNNoYYL0IczEdiVFQj
 3tqU5UHXJwWbLKPN2bX5dSXHefgW1d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759847684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi9aVrvw4kUY/Z/9f1T9lkR6YofAoMcg9Jxl1GX4AO8=;
 b=aceAK30QosJ/BGkLQmhY1YLjHmHxvQp574mx6wyVWaiIWggBn1kr885kBjCHrSScP8NZwF
 sY/ud31NvHte/WCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759847684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi9aVrvw4kUY/Z/9f1T9lkR6YofAoMcg9Jxl1GX4AO8=;
 b=YwkmWhnoWe/cKKGBmQDfF8QUbxpZ8YGHP0yusGaXc0mB/21uHtb15VYaPNE8KWHvmTRCGI
 ELyPxNFqsj8/2x6FetKP0hVip34o3C32P7txAsVbazHHSq8BqL3zHNNoYYL0IczEdiVFQj
 3tqU5UHXJwWbLKPN2bX5dSXHefgW1d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759847684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wi9aVrvw4kUY/Z/9f1T9lkR6YofAoMcg9Jxl1GX4AO8=;
 b=aceAK30QosJ/BGkLQmhY1YLjHmHxvQp574mx6wyVWaiIWggBn1kr885kBjCHrSScP8NZwF
 sY/ud31NvHte/WCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5438913AAC;
 Tue,  7 Oct 2025 14:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VrMkEwQl5WgnPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Oct 2025 14:34:44 +0000
Date: Tue, 7 Oct 2025 16:35:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aOUlNrZj7O0yFDBP@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-3-bf458fa66358@suse.com>
 <aOUHqfyqp8IVne7S@yuki.lan> <DDC49J0CRCSN.3K67TAS5U4VES@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDC49J0CRCSN.3K67TAS5U4VES@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/10] setxattr01: add setxattrat variant
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
> > Can we please, in a subsequent patch, convert this part to our standard
> > approach where we check for the availability in the test setup and
> > expect the syscalls to be present if kernel is new enough?
> 
> What do you think it's the best way? Some of these tests have multiple
> syscalls related to *xattrat and in this test in particular we are
> testing 2 syscalls.

The same what we do for the rest of the syscalls, introduce a
setxattrat_supported() helper into a shared header that would call
tst_brk(TCONF, "") if kernel is older than the version the syscall was
added to and we got ENOSYS.

We actually have to handle a few cases here:

For setxattrat:
  - ENOSYS -> kernel too old
  - EOPNOTSUPP -> filesystem does not support extended attributes
                  (e.g. vfat)

And as for filesystem support, it looks like TMPFS has
CONFIG_TMPFS_XATTR option so it could be enabled or disabled, however
they should be supported for native Linux filesystems such as ext, btrfs
or xfs.

And we have to handle EOPNOTSUPP for setxattr() as well, so the test
setup would look like:

	if (tst_variant)
		setxattrat_supported();
	else
		setxattr_supported();

At the moment the ENOSYS branch would be covered by the fallback
function since it calls tst_syscall() but once the function gets added
to libc the check would no longer happen, so we need to eventually
handle the ENOSYS in the foo_supported() function as well.

> Maybe the best way would be to check for HAVE_FUNC_* declarations in
> this case, but then fallback function would fail anyway.

No this does not work, the only way how to find out if a syscall is
supported is to call it and check the return value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
