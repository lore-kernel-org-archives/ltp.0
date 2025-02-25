Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A32DC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 10:25:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE643C9B2E
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 11:25:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2EF43C054A
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 11:25:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3BC24140DF7A
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 11:25:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FE2C1F44F;
 Tue, 25 Feb 2025 10:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740479121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJMQJP2a2SWkNzDs/iNKeTVgs60KIuptI87pRcIGxS4=;
 b=mtMo/e0bfH6cncV08n9lncz04rVxm9DYGAHJWCVkaBwndEqTb3jdsZxSoHqM04+fXe0WhY
 2CHlfFQLsGBKlaGYAu781w/IPRN2Z783AecU6PRf1hsx1PB1zAZQmwu1kQngXCtoL/UqPQ
 mgjjV7Csd/QydNp0k/CCAqejDSsj/e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740479121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJMQJP2a2SWkNzDs/iNKeTVgs60KIuptI87pRcIGxS4=;
 b=tkK/usxAApg52sEp067ccXrQWkfktmnhPRex0UxLUnRepBxDQ1IO/pKmZfKDhy/uUs8iVE
 7vT8BQa5vXAhO6Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mtMo/e0b";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tkK/usxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740479121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJMQJP2a2SWkNzDs/iNKeTVgs60KIuptI87pRcIGxS4=;
 b=mtMo/e0bfH6cncV08n9lncz04rVxm9DYGAHJWCVkaBwndEqTb3jdsZxSoHqM04+fXe0WhY
 2CHlfFQLsGBKlaGYAu781w/IPRN2Z783AecU6PRf1hsx1PB1zAZQmwu1kQngXCtoL/UqPQ
 mgjjV7Csd/QydNp0k/CCAqejDSsj/e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740479121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJMQJP2a2SWkNzDs/iNKeTVgs60KIuptI87pRcIGxS4=;
 b=tkK/usxAApg52sEp067ccXrQWkfktmnhPRex0UxLUnRepBxDQ1IO/pKmZfKDhy/uUs8iVE
 7vT8BQa5vXAhO6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD6913888;
 Tue, 25 Feb 2025 10:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ASeuCZGavWecJwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 25 Feb 2025 10:25:21 +0000
Date: Tue, 25 Feb 2025 11:25:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z72anBFr2n4REM3E@yuki.lan>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-3-chrubis@suse.cz>
 <20250217074413.GA2350499@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217074413.GA2350499@pevik>
X-Rspamd-Queue-Id: 3FE2C1F44F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shell lib: Add support for test cleanup
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
> could we get check for file existence, the same way it's done in metaparse.c?
> 
> Also, I'd prefer if both tools exit 1 in case of missing file (so that CI
> notifies the problem).

Will do.

> +++ metadata/metaparse-sh.c
> @@ -6,6 +6,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <libgen.h>
> +#include <unistd.h>
>  
>  #include "data_storage.h"
>  
> @@ -46,6 +47,11 @@ static void parse_shell(char *path)
>  	FILE *f = fopen(path, "r");
>  	enum state state = NONE;
>  
> +	if (access(path, F_OK)) {
> +		fprintf(stderr, "file %s does not exist\n", path);
> +		return;
> +	}

I guess that I should check the f instead:

	if (!f) {
		fprintf(stderr, "Failed to open '%s': %s", path, strerror(errno));
		exit(1);
	}

>  	while (fgets(line, sizeof(line), f)) {
>  		/* Strip newline */
>  		line[strlen(line)-1] = 0;

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
