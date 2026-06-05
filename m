Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AABCD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:12:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 349523E547A
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 13:12:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7A353E300B
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 13:12:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 43FC8600136
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 13:12:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF460671CE;
 Fri,  5 Jun 2026 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780657954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi9OPMJZI78L/ugDfzZack4YTMGMHaNQCFgXoPQUaHg=;
 b=1SjAmUw1ksDhCfcsZ9QZ6LGQaWwwrrPmgLGRXbEE+nJmuPgWlXZwa+1i+r7uINinfzBu29
 /g/s/ZsOdBSHi2RawoVFwiwEoXajQLEBXTPM6sI8SHhvmg7x5cMhFUpNkFDi85/TWSD2/B
 kFPmIK9Pe2vnXvTZSbDbnylgpSRdUkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780657954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi9OPMJZI78L/ugDfzZack4YTMGMHaNQCFgXoPQUaHg=;
 b=3eU8LR0fkO5IwipxJUeGBOsqRBHWvT156ZZIIO9fR8DfgzouWKdFsUCFosGw1zzd0tlpVL
 V+3fKkOmDY+On9Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TWsO+NPK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="iQSQh/Tp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780657952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi9OPMJZI78L/ugDfzZack4YTMGMHaNQCFgXoPQUaHg=;
 b=TWsO+NPK489nS2uktU1Snd0sSCA3aC6MfOhs5jA4BcY4LAjViLzMHm70xp8Fd2j6O0E7Am
 tAMgHT9qScVwgf+Q1jJ0FmaFLzd3fqfcM7j4li+46ylPp26gv9zIG7sZG78ryAGXQvDBCh
 +H9XQd521iyFT/QmXZIb9o6+MawE6sA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780657952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi9OPMJZI78L/ugDfzZack4YTMGMHaNQCFgXoPQUaHg=;
 b=iQSQh/TpJHu03jyTI0RX0w3XbVbRtpbt3nP148X+2VjAUht1x+/nYtjlVMNN3GVwaZpWzt
 /GmRATJxMBrkV1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3EB6779A8;
 Fri,  5 Jun 2026 11:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2FXfJiCvImqNDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 05 Jun 2026 11:12:32 +0000
Date: Fri, 5 Jun 2026 13:12:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <aiKvHTvjmBjVD5V3@yuki.lan>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
 <20260604065417.25924-2-sachinp@linux.ibm.com>
 <aiFUB1QyVXZcM-ah@yuki.lan>
 <f280507d-41d9-4496-a90d-49ecc7fff8dd@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f280507d-41d9-4496-a90d-49ecc7fff8dd@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BF460671CE
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/8] fs/acl: Add ACL_USER_OBJ permissions test
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
> This is an excellent suggestion. This will avoid userspace 
> username-to-UID lookups
> and libacl dependency. It simplifies tests while maintaining full 
> coverage of kernel
> ACL functionality.
> 
> The existing create_file_as() helper already demonstrates the 
> fork+setuid pattern
> needed for testing with arbitrary UIDs.
> 
> The logic can be:
> - Use setxattr(path, "system.posix_acl_access", buf, size, 0) to set 
> ACLs directly
> - Build xattr buffers with raw UID/GID values (no username lookups needed)
> - Fork child processes that call setuid(uid) + setgid(gid) to match ACL 
> entries
> - Test file access in child to validate kernel ACL enforcement
> 
> Let me know if this approach is acceptable.

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
