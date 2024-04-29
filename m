Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E58BC4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 15:03:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 388843C8213
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 17:03:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D77A3C18A9
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 17:03:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 613F0140006B
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 17:03:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D438F3387A;
 Mon, 29 Apr 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714402992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBZUhk3VikfUo3rZ8b0jtHrL1DY4KWbEcPlmaRWEfz0=;
 b=ct3vodZlMEZN8/fKEFNYKiFBb77FcbfQ1V4ZaB3FbITQCwzN8M/8tzoWvc5YFB5IuKlHL6
 Ap6kCdBQQM/WXzwoRmqUmVAFqaCX2ayXQdbVL7deym1tfogSdj2KaEaOf0QubC/eXbORv5
 5epB7jBSapQSovLfPgQ0fxk2pvHbKfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714402992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBZUhk3VikfUo3rZ8b0jtHrL1DY4KWbEcPlmaRWEfz0=;
 b=t6tojIxHW/hJF3sKqPCU1Eyh8gdZZpX+xSH0mo8Ssi4B5ivftw3MIZ1Qdp1/R9D91OsAqX
 QtRby7N/9+Bpb5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714402992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBZUhk3VikfUo3rZ8b0jtHrL1DY4KWbEcPlmaRWEfz0=;
 b=ct3vodZlMEZN8/fKEFNYKiFBb77FcbfQ1V4ZaB3FbITQCwzN8M/8tzoWvc5YFB5IuKlHL6
 Ap6kCdBQQM/WXzwoRmqUmVAFqaCX2ayXQdbVL7deym1tfogSdj2KaEaOf0QubC/eXbORv5
 5epB7jBSapQSovLfPgQ0fxk2pvHbKfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714402992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBZUhk3VikfUo3rZ8b0jtHrL1DY4KWbEcPlmaRWEfz0=;
 b=t6tojIxHW/hJF3sKqPCU1Eyh8gdZZpX+xSH0mo8Ssi4B5ivftw3MIZ1Qdp1/R9D91OsAqX
 QtRby7N/9+Bpb5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA92138A7;
 Mon, 29 Apr 2024 15:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VRDjLLC2L2ZEFgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 15:03:12 +0000
Date: Mon, 29 Apr 2024 17:02:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <Zi-2fSTi09PpfUeg@yuki>
References: <20240419070717.2506101-1-lufei@uniontech.com>
 <20240428074457.2629906-1-lufei@uniontech.com>
 <20240428074457.2629906-2-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240428074457.2629906-2-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add case about arch_prctl syscall.
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
And it looks that limiting the test to x86 or x86_64 CPUs is not enough
for it to run, we will have to check that the CPU has
X86_FEATURE_CPUID_FAULT flag set. Looks like we can actually get that
from the flags field from /proc/cpuinfo, if cpuid_fault is there the
prctl is supposed to work, if not these calls should return ENODEV.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
