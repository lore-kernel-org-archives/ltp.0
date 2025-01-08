Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF764E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 09:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13AB63C1ADA
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 10:18:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385E13C180F
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 10:18:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E09865065A
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 10:18:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00BC4210FB;
 Wed,  8 Jan 2025 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736327909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FU+MbkRiTO2k7kn8jANa+TJJ9YvEd4rmlmYdzOmaniE=;
 b=lkEB0mHaw3kRFPmZYpzhSZ3LYZsjjSycxVd1pWYcjpafMn2FhThCw1JYtO4p+KYctEsmBU
 CTTNkO2+uMkkfis6ox/RWzIl1KW6/zX/oBzbBsJZJoWcNgOi9BGG+kq0WWVAQpJVYOfcpU
 dsXzae7Cu4euA9BAy4vntFoV3Y7h9AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736327909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FU+MbkRiTO2k7kn8jANa+TJJ9YvEd4rmlmYdzOmaniE=;
 b=2YGEes5KBHd+irfjmfmaJoYN3NiPb9+3d0zfDoI2Xa3Zy2p6HF6uf2xEOsBlFqj82QEmZr
 dNDaSwvt3OgKP1Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lkEB0mHa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2YGEes5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736327909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FU+MbkRiTO2k7kn8jANa+TJJ9YvEd4rmlmYdzOmaniE=;
 b=lkEB0mHaw3kRFPmZYpzhSZ3LYZsjjSycxVd1pWYcjpafMn2FhThCw1JYtO4p+KYctEsmBU
 CTTNkO2+uMkkfis6ox/RWzIl1KW6/zX/oBzbBsJZJoWcNgOi9BGG+kq0WWVAQpJVYOfcpU
 dsXzae7Cu4euA9BAy4vntFoV3Y7h9AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736327909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FU+MbkRiTO2k7kn8jANa+TJJ9YvEd4rmlmYdzOmaniE=;
 b=2YGEes5KBHd+irfjmfmaJoYN3NiPb9+3d0zfDoI2Xa3Zy2p6HF6uf2xEOsBlFqj82QEmZr
 dNDaSwvt3OgKP1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E436C137DA;
 Wed,  8 Jan 2025 09:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o/vrNuRCfmcCYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jan 2025 09:18:28 +0000
Date: Wed, 8 Jan 2025 10:18:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z35C00m6FwH8P8BI@yuki.lan>
References: <20250108071201.26984-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250108071201.26984-1-liwang@redhat.com>
X-Rspamd-Queue-Id: 00BC4210FB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Key Concepts:
> 
>  timeout: Represents the time allocated for setup, cleanup, or other
>           non-runtime parts of the test.
> 
>  runtime: The maximum runtime of the test's main execution loop. If
>           exceeded, the test will exit early.

This is not entirely correct. I guess that we still didn't understand
each other. Let me try to explain once more.

The runtime is supposed to be used only in tests that call
tst_remaning_runtime() in the main loop to limit the test duration based
on runtime. This means that the test function execution time is always
the same (plus minus some rounding errors).

And the timeout is supposed to be upper bound for everything in the test
minus the part that is limited by the runtime.

So for the tests that use tst_remaining_runtime() the timeout guards the
setup and cleanup, but for tests that does not use
tst_remaining_runtime() the timeout limits the whole test run.

The reasoning behind this is that if for example we have a test where
the test function does I/O that is known to take up to 10s we want to
multiply this in the case of the debug kernel because the test function
may be slower.

On the other hand test function that has a loop that checks the remaning
runtime will do less iterations on debug kernel but the duration will be
the same. And we do not want to multiply this value because it will make
the test even slower on debug kernels.

The changes mostly looks okay, but some of the tests below that had
.max_runtime should replace that with .timeout instead. And we also
need tst_set_timeout() function for the testcases that try to figure out
the upper bound for the test duration in the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
