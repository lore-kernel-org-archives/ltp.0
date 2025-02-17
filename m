Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D703AC021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 07:44:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17E5F3C9BA2
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:44:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 812333C92B5
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:44:17 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DCE891A05C71
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:44:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D41C521175;
 Mon, 17 Feb 2025 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739778255;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAPdzO0oo+odXL/8WwQZV4ZyxA5Pm9cTtU/JFObkyaw=;
 b=ARZBHR18xSRa9Pt0rFrh9rZ2UFTZTLEbSXW6XK8CWPtx9ntEm/z82PvzOIIxXSLa6lon2S
 cf+CtASQwk3ca6T67hKwYAdF4frO6XAA2Vj+wRH1LCz4ZdSrzxQbZo+IrXtEr6lq1cI9+t
 yzm08TceRqXbG3OYLll+Ry3ug+X0cTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739778255;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAPdzO0oo+odXL/8WwQZV4ZyxA5Pm9cTtU/JFObkyaw=;
 b=WfAfu8x+ptuPYAIPgeTPTKMoC/UunAeFVCdyIs3Pnv0b28CSaP6ebHZNFfjgsSGFXccjqY
 iTsqzrDOtC5DKkAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qh0eOhY7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qsIRCXPq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739778254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAPdzO0oo+odXL/8WwQZV4ZyxA5Pm9cTtU/JFObkyaw=;
 b=Qh0eOhY78bEiny3BSu9GAQTQvYAYOAXEtXQ7W88ndPSaP8JGN05gd7gU5eKDm7tWwYtBws
 Bg4zRNL72wnie2p8JpYPqj5xe8EYB0jJap+m96o/kdmLLrxWAp/kwtoNsY7UKocfqEjaoO
 EHanK3Y6aWu2eD8aKcxtsUAISt4JjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739778254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xAPdzO0oo+odXL/8WwQZV4ZyxA5Pm9cTtU/JFObkyaw=;
 b=qsIRCXPqQoO8hDzT6RKDWgS4F0arsVUPKhagD4UdyTseF6emXzZ9Goax3UBUjdX/s6Z/Da
 rifTO79Ap3isnAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD7D1133F9;
 Mon, 17 Feb 2025 07:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d1h8LM7osmcRGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 07:44:14 +0000
Date: Mon, 17 Feb 2025 08:44:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250217074413.GA2350499@pevik>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250214112135.18947-3-chrubis@suse.cz>
X-Rspamd-Queue-Id: D41C521175
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

could we get check for file existence, the same way it's done in metaparse.c?

Also, I'd prefer if both tools exit 1 in case of missing file (so that CI
notifies the problem).

Kind regards,
Petr

+++ metadata/metaparse-sh.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <libgen.h>
+#include <unistd.h>
 
 #include "data_storage.h"
 
@@ -46,6 +47,11 @@ static void parse_shell(char *path)
 	FILE *f = fopen(path, "r");
 	enum state state = NONE;
 
+	if (access(path, F_OK)) {
+		fprintf(stderr, "file %s does not exist\n", path);
+		return;
+	}
+
 	while (fgets(line, sizeof(line), f)) {
 		/* Strip newline */
 		line[strlen(line)-1] = 0;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
