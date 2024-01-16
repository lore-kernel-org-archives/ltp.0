Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C4C47DA2
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 15:19:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FD1A3CF0AD
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 16:19:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38BD3C8B4E
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 16:18:56 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9DE73601111
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 16:18:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21D18220BE;
 Tue, 16 Jan 2024 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705418334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYgq4W1+MHf3X4/0ND7knzNN9UH8HuGHsl/QIG2vVyc=;
 b=zzNXhlvpf/xNaWWXmCbR//d49w28TN/ik2/wXGzVHio/7C1v2TsjuFayHsOnpbcCSGwZYg
 38vi7bMg7Zt84dwrr7DXXzF8Vj9Hu2iZL3CciCOrPernPG/TAv8FaQAJdRQPRGudOnq1Jk
 PKbssvSDeBzsih2lVJamY5rm/mFKvQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705418334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYgq4W1+MHf3X4/0ND7knzNN9UH8HuGHsl/QIG2vVyc=;
 b=w0uJIHK8+xDLAfBy+pvGcSdnJ6txXPEzuZB2ZThc1mWKS+KBvcpUYMLL+yABUGBihEqdRH
 MGJXYgNRjPMn6sBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705418334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYgq4W1+MHf3X4/0ND7knzNN9UH8HuGHsl/QIG2vVyc=;
 b=zzNXhlvpf/xNaWWXmCbR//d49w28TN/ik2/wXGzVHio/7C1v2TsjuFayHsOnpbcCSGwZYg
 38vi7bMg7Zt84dwrr7DXXzF8Vj9Hu2iZL3CciCOrPernPG/TAv8FaQAJdRQPRGudOnq1Jk
 PKbssvSDeBzsih2lVJamY5rm/mFKvQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705418334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYgq4W1+MHf3X4/0ND7knzNN9UH8HuGHsl/QIG2vVyc=;
 b=w0uJIHK8+xDLAfBy+pvGcSdnJ6txXPEzuZB2ZThc1mWKS+KBvcpUYMLL+yABUGBihEqdRH
 MGJXYgNRjPMn6sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED8FC13751;
 Tue, 16 Jan 2024 15:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p24XN12epmVhfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 16 Jan 2024 15:18:53 +0000
Date: Tue, 16 Jan 2024 16:19:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZaaeZmg8mi2dWVPn@yuki>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-2-chrubis@suse.cz>
 <20240115230952.GA2535088@pevik> <20240116003219.GD2535088@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240116003219.GD2535088@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zzNXhlvp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w0uJIHK8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.96 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.95)[86.58%]
X-Rspamd-Queue-Id: 21D18220BE
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add tst_fd iterator
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In file included from ../include/lapi/io_uring.h:17:0,
>                  from tst_fd.c:21:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
>    MS_RDONLY = 1,  /* Mount read-only.  */
>    ^

Looks like the best solution for now is:

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index a63741a08..03c45190e 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -14,7 +14,6 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <stdlib.h>
-#include <linux/fs.h>

 #include "lapi/syscalls.h"


As far as I can tell the only reason this header is included is the
__kernel_rwf_t definition which has a fallback definition just a few
lines below.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
