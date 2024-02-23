Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E2EC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 11:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67C63CF658
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:10:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A87813CCBD1
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:09:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD78314044BA
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 12:09:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12B261F802;
 Fri, 23 Feb 2024 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708686584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZo3nGX6fyQoLG/SaFP0C7DmPXjfvy9SJV0PBl8QNE8=;
 b=AIK9Ie6UsX9r0MosrT20UXbvZP0pNOUxhko3YB2VCs/l8ayh5ae6/Gc2TITyA9jIlc8Jdh
 Ys7ruosUTpNjvBKce2RvffCg9aQ3LA4YD9tef7jcYxzY06qPUNEGzzBJAykUZRDQGoaer8
 SqLQEn6xIG1TBSQl5r58mAkJetY/w+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708686584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZo3nGX6fyQoLG/SaFP0C7DmPXjfvy9SJV0PBl8QNE8=;
 b=AjFpNndrvrtjKJu+9qpvR3sg3Z4kgPEsWDo3m9L6SoaAME8wgLYT0Z0xltlBIZfL6w8vuh
 lX11GRTFxtIitWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708686583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZo3nGX6fyQoLG/SaFP0C7DmPXjfvy9SJV0PBl8QNE8=;
 b=zdh2XoBgVKXqDISOgkkdEjH+rMKLTSFMygxJaFtxGZfkpJcoPolg1STbd1S9992Pkc/LPK
 TkvzUCkLxQMMjxCOTrNMuY5ZPfBvr31ToCOCdjkKN6N+oCJlM8AqQSz4l7hjICt4OgOmy4
 eB8hRV7rfa/T/38hufBzgZnBCLc9Eok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708686583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZo3nGX6fyQoLG/SaFP0C7DmPXjfvy9SJV0PBl8QNE8=;
 b=Z0Pt2YnkrH8O+aoUGS/DU41eRtV06AxUN4HbwlKbWx0OXZ2RuH31+QRjDO4ut4us8X4hjs
 XzbFB2rJvHQ2sdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21D713ABA;
 Fri, 23 Feb 2024 11:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ilmMOvZ82GUNYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 11:09:42 +0000
Date: Fri, 23 Feb 2024 12:08:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zdh8tICfdo5Y79Qp@yuki>
References: <20240222153217.1046-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240222153217.1046-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.25 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.45)[78.91%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add more testcases in mkdir03
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
> +#include <paths.h>
> +#include <stdlib.h>
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -19,6 +21,10 @@
>  #include "tst_test.h"
>  
>  #define TST_EEXIST	"tst_eexist"
> +#define TST_PIPE	"tst_pipe"
> +#define TST_FOLDER	"tst_folder"
> +#define TST_SYMLINK "tst_symlink"
> +#define TST_NULLDEV	_PATH_DEVNULL

I would just hardcode the "/dev/null" here, this has potential to
explode on alternative libc implementations, possibly Android.

Hmm looking around the file seems to exists on Android and Musl however
_PATH_DEVNULL is just "/dev/null" everywhere anyways.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
