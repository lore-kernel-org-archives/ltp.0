Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E078C52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 15:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2F153D226B
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 17:07:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192BC3D0A6D
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 17:06:58 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F37A61A00A27
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 17:06:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1846A21B39;
 Wed, 21 Aug 2024 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724252815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYL0uNaggkHU3xH6ULmXikTn600AJGvB1XF5x3eyC9s=;
 b=vrf+Gp5CzJ0meo9obBDss/6pz0z+IdxYppxP9EhCrdg9NvpRjbh++CxIKmckn2IeWpGaMC
 8zc3pC5XpcboCXmMtuqHieB2xsveK+w4hA7icVmHL7V13orT0fI3W+fPnf8Z5J84dxJJms
 hwmUaGt35yCRYTXzDAOPKSzOMpdBSXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724252815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYL0uNaggkHU3xH6ULmXikTn600AJGvB1XF5x3eyC9s=;
 b=3HDs8eeEsEHjJU88zj0D8GLaFwANZwokEZFOowEeywUcrNNs2EZZc8yskyox+qQt6sR7HF
 OxUqMmlym9noo4Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724252815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYL0uNaggkHU3xH6ULmXikTn600AJGvB1XF5x3eyC9s=;
 b=vrf+Gp5CzJ0meo9obBDss/6pz0z+IdxYppxP9EhCrdg9NvpRjbh++CxIKmckn2IeWpGaMC
 8zc3pC5XpcboCXmMtuqHieB2xsveK+w4hA7icVmHL7V13orT0fI3W+fPnf8Z5J84dxJJms
 hwmUaGt35yCRYTXzDAOPKSzOMpdBSXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724252815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYL0uNaggkHU3xH6ULmXikTn600AJGvB1XF5x3eyC9s=;
 b=3HDs8eeEsEHjJU88zj0D8GLaFwANZwokEZFOowEeywUcrNNs2EZZc8yskyox+qQt6sR7HF
 OxUqMmlym9noo4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D38C113770;
 Wed, 21 Aug 2024 15:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zOIUMo4Cxma5QgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Aug 2024 15:06:54 +0000
Date: Wed, 21 Aug 2024 17:05:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZsYCTZ9XTw5KdCWn@yuki.lan>
References: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
 <20240821-landlock_houdini-v3-2-15fc43055d02@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240821-landlock_houdini-v3-2-15fc43055d02@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add landlock07 test
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
> More information at:
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                |   1 +
>  testcases/kernel/syscalls/landlock/.gitignore   |   1 +
>  testcases/kernel/syscalls/landlock/landlock07.c | 109 ++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fea0c9828..a9fc8c432 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -706,6 +706,7 @@ landlock03 landlock03
>  landlock04 landlock04
>  landlock05 landlock05
>  landlock06 landlock06
> +landlock07 landlock07
>  
>  lchown01 lchown01
>  lchown01_16 lchown01_16
> diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
> index 315ac1dca..db11bff2f 100644
> --- a/testcases/kernel/syscalls/landlock/.gitignore
> +++ b/testcases/kernel/syscalls/landlock/.gitignore
> @@ -5,3 +5,4 @@ landlock03
>  landlock04
>  landlock05
>  landlock06
> +landlock07
> diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
> new file mode 100644
> index 000000000..68045da3b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/landlock/landlock07.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/**
> + * [Description]
> + *
> + * CVE-2024-42318
> + *
> + * Test to check if sysem is affected by Landlock Houdini bug:
                          ^
			  t


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
