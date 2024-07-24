Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7288BC3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 20:04:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EAF03D1C3D
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 22:04:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42EE3D1C32
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 22:04:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28C811A0091B
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 22:04:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD1721998;
 Wed, 24 Jul 2024 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721851471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5lxtSp0iepZoD/nS/jU0dRWOwKMcrymgzZ+zEYXFYs=;
 b=0cOBre+YnLgcGK+ym+ijH8hcvvCpu3GdjIMMfkY4uxtz/xMTr0NJTcGx0m0JuqznC3jFBY
 ylQGTVSAsP4Gq9dTBOGMxIMy317SghBIKn74TJhIRIzi3ql14Sv9p11rKVZI7PsvcBaQ6b
 XXNzynAzwbT0arungRZ5JDXzrlKfQ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721851471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5lxtSp0iepZoD/nS/jU0dRWOwKMcrymgzZ+zEYXFYs=;
 b=Ay3vXOaAMWQZjO69bjeT4AbWycKmgic67VVv6dAb3b7jiSWA4vn0tKHy+swzX25u1uIvYa
 281UjwN43zxwgYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721851471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5lxtSp0iepZoD/nS/jU0dRWOwKMcrymgzZ+zEYXFYs=;
 b=0cOBre+YnLgcGK+ym+ijH8hcvvCpu3GdjIMMfkY4uxtz/xMTr0NJTcGx0m0JuqznC3jFBY
 ylQGTVSAsP4Gq9dTBOGMxIMy317SghBIKn74TJhIRIzi3ql14Sv9p11rKVZI7PsvcBaQ6b
 XXNzynAzwbT0arungRZ5JDXzrlKfQ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721851471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5lxtSp0iepZoD/nS/jU0dRWOwKMcrymgzZ+zEYXFYs=;
 b=Ay3vXOaAMWQZjO69bjeT4AbWycKmgic67VVv6dAb3b7jiSWA4vn0tKHy+swzX25u1uIvYa
 281UjwN43zxwgYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535271324F;
 Wed, 24 Jul 2024 20:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9NAJE09eoWbnewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 20:04:31 +0000
Date: Wed, 24 Jul 2024 22:06:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZqFe4Qxw78uMJZGC@rei>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-7-33075bbc117f@suse.com>
 <ZqEg7SD35ejRYCsX@yuki>
 <3c2626c4-5c26-4112-9c74-4cf9b4ecc3e0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c2626c4-5c26-4112-9c74-4cf9b4ecc3e0@suse.com>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] Add ioctl_ficlone04 test
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
> I can't understand what's the best way to test all the combinations. As 
> you can see there are many flags, which means the amount of permutations 
> is big.
> Most of those flags are handled (indeed) in the wrong way, since most of 
> their permutations return EXDEV. The point is that the syscall has many 
> error codes, so it's complex to write a code that covers all possible 
> results.
> 
> My idea would be to have an array of errors to give to 
> TST_EXP_FAIL2_ARR() and to avoid any statement around fd_src/fd_dst, 
> because the amount of if/switch-case might explode with the number of 
> permutations.

The purpose of the tst_fd iterator is mainly to hammer syscalls with
different kinds of file descriptors and trigger code paths in the kernel
that are not excercies under normal circumstances. So it's fine to have
a single array with a few sensible errno codes and pass that in all the
cases.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
