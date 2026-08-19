Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C3BC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 20:21:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8218C3CD638
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 22:21:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C31213CD537
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 22:20:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EE902000E6
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 22:20:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 779903E58
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787170843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ebi3hLvrxweJkgN3xgu8d0npo1s+IXfvQo9X5UjFZ1M=;
 b=0UgCOJd4OByfKv/BfRjSYZvLXeIQY+ULq6861hGwWWpId95gWsodoz2xVuUex4zdRZpzMc
 4r3o134+jYkJd96rhJZfUf3M0xhkZ+gA7fwnKg7nKEaIcIolChDZ7nxxdTNk1NBNmUs/GA
 2aYGxd337bEU5ENERETtDKNUsU+1bYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787170843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ebi3hLvrxweJkgN3xgu8d0npo1s+IXfvQo9X5UjFZ1M=;
 b=GRh6UU+JPEN/fJXHxk1ufbdvkx7D8LHb3DTHsn+jejTPMSMoDOJMC9JWtW2tpClASJm8FH
 U0W7CIqQcItZHAAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Yfv/SGDy";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5wcM7IGy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787170839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ebi3hLvrxweJkgN3xgu8d0npo1s+IXfvQo9X5UjFZ1M=;
 b=Yfv/SGDykFsOKibuvuizMaZ3KFv3e3J+T/+eUPCG/oLDWFZVrXeGDRmDCIeSDdsd31vZLb
 /8qO5fhkXVG1BbUkDY/4ASG5nJYjafxWiSFwh4QWrSmf21qgieqWRSlnpbfZpeuLfW1qZy
 Y2TQ5lAUeTHFEcMPPX7gba5i4Atfnqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787170839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ebi3hLvrxweJkgN3xgu8d0npo1s+IXfvQo9X5UjFZ1M=;
 b=5wcM7IGycIUcYjfbbsI8kvHPoJph/35S1g1b0gxOeXTlHNxbiKAmLu/BXAVrRjWpcI9a1m
 OPRPVPBPwwSV+6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63EDD2F81
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 20:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZOl4FxcQhmp0XgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 20:20:39 +0000
Date: Wed, 19 Aug 2026 22:20:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <aoYQG3C-x9viqK6m@yuki.lan>
References: <20260819161634.1341577-1-chrubis@suse.cz>
 <20260819161634.1341577-24-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260819161634.1341577-24-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 779903E58
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 23/31] testcases: sysfs: Add sys_net04
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
And this one needs:

diff --git a/testcases/kernel/sysfs/class/net/sys_net04.c b/testcases/kernel/sysfs/class/net/sys_net04.c
index c1eda1329..562bd45b0 100644
--- a/testcases/kernel/sysfs/class/net/sys_net04.c
+++ b/testcases/kernel/sysfs/class/net/sys_net04.c
@@ -61,7 +61,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <linux/if.h>
+#include <net/if.h>
 #include <linux/if_tun.h>

 #include "tst_test.h"


To compile on openSUSE 42.2

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
