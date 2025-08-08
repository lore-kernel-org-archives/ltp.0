Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6991BC87FD3
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 08:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B21AC3CA395
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 10:22:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450BA3C0294
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 10:21:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54ACD200111
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 10:21:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F57F33DFA;
 Fri,  8 Aug 2025 08:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754641303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ofjYTgfYXnW7HfB/BLLZpwYPzsN/NiONCm5Ong1R6Y=;
 b=RIKfGcGGH+UMpKtlE+p5SPG1AuicqkrJezWWx+lKYp+TolTG5ed83JrAFPOfwXqJ+9TwIM
 s70YbJ4x/vJs4EOHMJfhn9hk5ml+pQWK090wzi8EMER4a42kuIh6NUKlvRcpEX4xA8vNVJ
 sKp0iDJWq/wjLX8vz8z0hnh/Zz4w6mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754641303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ofjYTgfYXnW7HfB/BLLZpwYPzsN/NiONCm5Ong1R6Y=;
 b=d01uxiJIIviRY3hIDaP+LrY0jwFi1DsqipgcTsW0mmHlncR5nDd2kncJLIzzErpN5leIx4
 skB6LQk2qTkyopDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RIKfGcGG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d01uxiJI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754641303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ofjYTgfYXnW7HfB/BLLZpwYPzsN/NiONCm5Ong1R6Y=;
 b=RIKfGcGGH+UMpKtlE+p5SPG1AuicqkrJezWWx+lKYp+TolTG5ed83JrAFPOfwXqJ+9TwIM
 s70YbJ4x/vJs4EOHMJfhn9hk5ml+pQWK090wzi8EMER4a42kuIh6NUKlvRcpEX4xA8vNVJ
 sKp0iDJWq/wjLX8vz8z0hnh/Zz4w6mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754641303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ofjYTgfYXnW7HfB/BLLZpwYPzsN/NiONCm5Ong1R6Y=;
 b=d01uxiJIIviRY3hIDaP+LrY0jwFi1DsqipgcTsW0mmHlncR5nDd2kncJLIzzErpN5leIx4
 skB6LQk2qTkyopDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F60313A7E;
 Fri,  8 Aug 2025 08:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMimCpezlWgnPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 08:21:43 +0000
Date: Fri, 8 Aug 2025 10:21:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20250808082133.GC410227@pevik>
References: <20250630122719.12948-1-chrubis@suse.cz>
 <20250807063916.GA349310@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250807063916.GA349310@pevik>
X-Rspamd-Queue-Id: 4F57F33DFA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.69 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: Fix mountflags handling for FUSE
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

merged, thank you both!
https://github.com/linux-test-project/ltp/commit/52a981056de255d6f30cf2b1f0b5c809419cbdc9

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
