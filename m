Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B8C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4213E2A41
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:43:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9533E1F82
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:43:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE9D410008FB
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:43:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC02977D80;
 Tue, 14 Jul 2026 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784018589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=159cI3PlLVbvDxalTJMu0zNyMAXIm7us2YKO9NHh9G8=;
 b=ALcyqG2U2GO4G57s1JKpcTwDplmVtlcOBYN7i7Bk09hs8WqU1oeAZ8OFvW7NR4SXk5YGy5
 3HkXhvwbBqOYZEm+CrPVzlJpdOEEYZduGQXRpFk+w0aHJgGP2iJ1AOYVljSbgD61C+7vts
 AUavHJCkhPzrLP7XR/JE5309jUNJ3Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784018589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=159cI3PlLVbvDxalTJMu0zNyMAXIm7us2YKO9NHh9G8=;
 b=9vbXiH3yQIOTI0HZL5QV4YxhNOcy76TlFINcGL4jkl7CzXiYh9ciEN4TZrOClLqvosumeC
 ZCI8hXGLB5mHUKDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IN4UoJfq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="T/2myQA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784018588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=159cI3PlLVbvDxalTJMu0zNyMAXIm7us2YKO9NHh9G8=;
 b=IN4UoJfqNXcjTJDxboC1qE222QPhrEWUtl2iuTsGPP5N+zq8avLyloc/QkgRnGFAvVj0cP
 MiyGiQ84CSfTuVxDHANXbHKFpEzAjwwZ9ClD4KkS6obItlJys5zc+Soocft4ka33dUNqW+
 taFzuuS/I9Ss6rBwUz+WqKPHdR82KXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784018588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=159cI3PlLVbvDxalTJMu0zNyMAXIm7us2YKO9NHh9G8=;
 b=T/2myQA9OfhU9qJa/CZmFQVZ4DwHvZ5GNlU2OrlY7tA7+VchPQ3I3kjS2QmQYTVcakvbNH
 Tazd5KX82UrcYLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7AB6779AE;
 Tue, 14 Jul 2026 08:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /oG2Lpz2VWpgPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jul 2026 08:43:08 +0000
Date: Tue, 14 Jul 2026 10:43:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <alX2lMoWc2tdNut0@yuki.lan>
References: <alDtz7CMmysJtlAp@rei>
 <6a510c80.fc4d87c3.115da4.55fa@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a510c80.fc4d87c3.115da4.55fa@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC02977D80
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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
> > Thinking of it once more, I wonder what exactly fails in the
> > systemd-coredump case. I guess that it may delay the test execution a
> > bit but the crashed process should eventualy quit and the test wait()
> > call should collect it. If that wasn't the case systemd-coredump would
> > break one of the fundamentals of UNIX process management.
> 
> Let's forget about systemd for a second.
> 
> The problem is that by using `pause()` that is not draining the buffer we
> never ends the piped user-space helper. The default behaviour for a piped
> helper is that kernel collect the coredump until helper drains the pipe.

Which would mean that the system this is failing on is mis-configured at
best. I've tested this on Leap 16.0 that uses systemd-coredump and
everything works fine there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
