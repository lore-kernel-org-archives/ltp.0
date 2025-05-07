Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB94C3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 13:44:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44C4A3CBE00
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:44:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4881F3C6641
 for <ltp@lists.linux.it>; Wed,  7 May 2025 15:43:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83291600BCE
 for <ltp@lists.linux.it>; Wed,  7 May 2025 15:43:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7711F211FA;
 Wed,  7 May 2025 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746625424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PolZKJWDvhG5GGhsHNS2VNbCCA5hlPtKzU97vP/FawY=;
 b=v00JgQ1z0gRLrxY8ZK8qNUZkvSKILdBu7P5RoIAFBAzE5HhPbDdcyl03oSzFl/aDpz6hPI
 3W7dl+D/3y4i6PW9FUl1CK5zf9MwgKwHuVENaoD4Kz7ruMM8ScLOUCz/5qZirRHHLsHpRE
 FTkOgsW9Kdgu3QAHzEkyhk4hovT/7og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746625424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PolZKJWDvhG5GGhsHNS2VNbCCA5hlPtKzU97vP/FawY=;
 b=9I0wdLChyVdgOe/u+kRnwjDxQHXY3OsJXN9Uvy8VIZ7CPZpdSIr3EYeRsxKpe/Fx98vs+k
 ae1RFB6cpp1UxrAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v00JgQ1z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9I0wdLCh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746625424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PolZKJWDvhG5GGhsHNS2VNbCCA5hlPtKzU97vP/FawY=;
 b=v00JgQ1z0gRLrxY8ZK8qNUZkvSKILdBu7P5RoIAFBAzE5HhPbDdcyl03oSzFl/aDpz6hPI
 3W7dl+D/3y4i6PW9FUl1CK5zf9MwgKwHuVENaoD4Kz7ruMM8ScLOUCz/5qZirRHHLsHpRE
 FTkOgsW9Kdgu3QAHzEkyhk4hovT/7og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746625424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PolZKJWDvhG5GGhsHNS2VNbCCA5hlPtKzU97vP/FawY=;
 b=9I0wdLChyVdgOe/u+kRnwjDxQHXY3OsJXN9Uvy8VIZ7CPZpdSIr3EYeRsxKpe/Fx98vs+k
 ae1RFB6cpp1UxrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38F9C13882;
 Wed,  7 May 2025 13:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q1vUCpBjG2iuSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 May 2025 13:43:44 +0000
Date: Wed, 7 May 2025 15:43:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250507134336.GA131933@pevik>
References: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
 <725822be-fb0a-4e6c-9497-ef84dbec3412@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <725822be-fb0a-4e6c-9497-ef84dbec3412@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7711F211FA
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038
 Problem on 32-bit Systems
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
Cc: jiaying.song.cn@windriver.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

> I noticed that stime01 is equivalent to settimeofday01 when tst_variant=2.
> So I'm wondering if it makes sense to keep that variant, considering that it
> creates issues in 32bit systems. In my opinion, we should probably remove
> the usage of settimeofday inside stime01 and to keep settimeofday01 instead.

> @Petr @Cyril WDYT?

IMHO it's not the same. settimeofday01.c calls settimeofday() libc wrapper,
but stime01.c in tst_variant=2 calls __NR_settimeofday raw syscall.

Kind regards,
Petr

> Kind regards,
> Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
