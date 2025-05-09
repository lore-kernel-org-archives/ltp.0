Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76223C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:21:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C14083CC194
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 11:21:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5904E3CBC58
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:20:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C99291A00FED
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:20:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFA031F394;
 Fri,  9 May 2025 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746782446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNypxccPCPvrziDX6kFwE5s0zzYYX747e6MVgvVnwrg=;
 b=RQ+hwdq9IB6qQdgXT7OFrxL0uWaobP65GmIG4aj16KAeM27AvJMw+0tJQN50OkwxaTrapQ
 tqeJuLIVfotHTOuBbVBSi92rvdEC6aRI0KvLmiuxrxMqOK2I0+wtK7BX7011lnEWzJYowu
 nmZ+j7epfpNu1REaEkuRo/p+gbvcY6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746782446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNypxccPCPvrziDX6kFwE5s0zzYYX747e6MVgvVnwrg=;
 b=i9zqdagRfJf7o0+tGWflduMNXX1EjO8WapxcTbqYiPk9u2cPNa8evRyseyOKBORo7OEeo8
 E3A8sXwvcqlpk7Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3I33upeY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k6owcDRY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746782445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNypxccPCPvrziDX6kFwE5s0zzYYX747e6MVgvVnwrg=;
 b=3I33upeY0pN3rP4xNApuCbozhlhmvaijggims+a3zJVgpILVJHMJLui9yHi13RaN6TJfj0
 aqrV9lKskCOEFetnojFg/dKxQQjLUwAoqE71LdJX2dqNX47Peu7dKUWbVWE+xYElyX6E0t
 NA3Q0I/aCuoxQdkGXjlUkMypncY8TFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746782445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNypxccPCPvrziDX6kFwE5s0zzYYX747e6MVgvVnwrg=;
 b=k6owcDRYavrodr+H1mOyCYTfjcPkAqHqsfFvnNgvoh7yFZrN1Kh/NZUuN4oApZwsH53AlA
 jk1l9f8/Y8E8TCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6450139D0;
 Fri,  9 May 2025 09:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hj1VL+3IHWicawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 09:20:45 +0000
Date: Fri, 9 May 2025 11:21:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aB3JFz8PK2okhULz@yuki.lan>
References: <20250505105310.15072-1-mdoucha@suse.cz>
 <aBts4kDaqLKLJUuw@yuki.lan>
 <3ff8ee4c-881a-435d-a416-8bd32c35a17e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ff8ee4c-881a-435d-a416-8bd32c35a17e@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFA031F394
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
> > Here we depend on the fact that process memory has been properly
> > accounted for when it starts running its code. Are you sure that we can
> > rely on this or does this just happen to work?
> 
> Actually, my commit message is slightly misleading because the existing 
> process memory does not get migrated to the new cgroup. But the cgroup 
> itself may already have non-zero memory usage even when empty, likely 
> for internal kernel structures. Any new allocations of kernel structures 
> should also be finished when the process migration completes. So unless 
> the migration behavior changes in the near future, we can rely on this.

I suppose that the cgroup is charged for the memory it needs to track
the resources, that makes sense. I wonder if we can read that once at
the start of the test when we create the cgroups and use that value
later on.

> This sentence in the commit message:
> "Account for process size as reported by cgroup memory stats before..."
> should be changed to:
> "Account for existing cgroup memory usage before..."

That sounds better. I suppose that we can get this merged with this
change.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
