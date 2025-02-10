Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BBBC0219E
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:07:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA8313C98CC
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 14:07:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2C893C00B1
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:07:01 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BBBA4141BE19
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:07:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2659E210FE;
 Mon, 10 Feb 2025 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739192819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpnkR/DklvK5wNwRC7xU5Y1Pnxcb3+E/LMe5SbwmiM=;
 b=vkvOYaC0Nb+z4bYSLI3/sUaMZQgjJnNSQSV6l4MtONn9VB6Au4m6YT9H6Omv0dLapATsxO
 5h+J7k8h8Wu86dpOQ6jmXwb8T75ZTdbBLkeDaKsmRqq93SpH9fMxNCm87O+3hJ/f4Sa1jx
 IIG9VERdNtz8CQyLJn4GBSnTL9Y1vPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739192819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpnkR/DklvK5wNwRC7xU5Y1Pnxcb3+E/LMe5SbwmiM=;
 b=MZ1QhFymID41jKYez5ob5qwjos7kFlxiyuDFJ8daYsnyJ2zwQh4LnMRdgS6Hn/qwFScYd3
 Yc2UGtp24IOcVtCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739192819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpnkR/DklvK5wNwRC7xU5Y1Pnxcb3+E/LMe5SbwmiM=;
 b=vkvOYaC0Nb+z4bYSLI3/sUaMZQgjJnNSQSV6l4MtONn9VB6Au4m6YT9H6Omv0dLapATsxO
 5h+J7k8h8Wu86dpOQ6jmXwb8T75ZTdbBLkeDaKsmRqq93SpH9fMxNCm87O+3hJ/f4Sa1jx
 IIG9VERdNtz8CQyLJn4GBSnTL9Y1vPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739192819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpnkR/DklvK5wNwRC7xU5Y1Pnxcb3+E/LMe5SbwmiM=;
 b=MZ1QhFymID41jKYez5ob5qwjos7kFlxiyuDFJ8daYsnyJ2zwQh4LnMRdgS6Hn/qwFScYd3
 Yc2UGtp24IOcVtCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A9F13707;
 Mon, 10 Feb 2025 13:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cPYcBPP5qWfsAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 13:06:59 +0000
Date: Mon, 10 Feb 2025 14:07:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: pvorel <pvorel@suse.de>
Message-ID: <Z6n59mHMpZxIMcZk@yuki.lan>
References: <20250210113212.29520-1-chrubis@suse.cz>
 <20250210113212.29520-3-chrubis@suse.cz>
 <01a16c47a0920ed4c60db277087f9ea7@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01a16c47a0920ed4c60db277087f9ea7@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/13] lib: Replace path_exist() with
 tst_path_exists()
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
> > Move and rename the path_exist() function from
> > testcases/kernel/mem/lib/ to the to level library.
> > 
> > This removes mem.h dependency from mem/cpuset/ test.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  include/tst_fs.h                       | 10 ++++++++++
> >  lib/tst_path_exists.c                  | 23 +++++++++++++++++++++++
> 
> The only thing I don't like is creating file for single functions.
> My long term plan was to have fewer files with more functions.
> I'm sorry I did not point this out in v1, thus feel free to ignore it.

Feel free to move this code to a file you find appropriate and merge the
patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
