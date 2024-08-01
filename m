Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F67CC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 09:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9E303D1F3F
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 11:41:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0095C3D1EB2
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 11:41:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 596851A00E4D
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 11:41:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D85771FB3E;
 Thu,  1 Aug 2024 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722505271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PBf3yvGj2Lbe5vDKu46czTj5OLzTRiJzLaXeHBIkXo=;
 b=sZA3j6a7QCr1hBPkIO0FIx5E6GdyJ9vPQAUIsMabi7DSTJV/7TuVNRJAP7wwG3YiNA8Dce
 sxcxM7awe6JHpKZ2orGuvKbWyaZZuUalQjfCuWON0kL4gVZn9yeFwkw9eqfytZ67zkWWP1
 8D4Wii+Ft/Y1ZKCLrZ5eJX3t9kIAiJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722505271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PBf3yvGj2Lbe5vDKu46czTj5OLzTRiJzLaXeHBIkXo=;
 b=8donM5o2YkdfCZ84QMXL3cL+M8tEaKVy0qw3lwxOcGoXFWZVSt70Rc94l1CUa4ESdVgDfD
 gLS7RPvRG0ZqiCCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722505271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PBf3yvGj2Lbe5vDKu46czTj5OLzTRiJzLaXeHBIkXo=;
 b=sZA3j6a7QCr1hBPkIO0FIx5E6GdyJ9vPQAUIsMabi7DSTJV/7TuVNRJAP7wwG3YiNA8Dce
 sxcxM7awe6JHpKZ2orGuvKbWyaZZuUalQjfCuWON0kL4gVZn9yeFwkw9eqfytZ67zkWWP1
 8D4Wii+Ft/Y1ZKCLrZ5eJX3t9kIAiJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722505271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PBf3yvGj2Lbe5vDKu46czTj5OLzTRiJzLaXeHBIkXo=;
 b=8donM5o2YkdfCZ84QMXL3cL+M8tEaKVy0qw3lwxOcGoXFWZVSt70Rc94l1CUa4ESdVgDfD
 gLS7RPvRG0ZqiCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB497136CF;
 Thu,  1 Aug 2024 09:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FnzCJzdYq2aaKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Aug 2024 09:41:11 +0000
Date: Thu, 1 Aug 2024 11:41:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240801094108.GB1487933@pevik>
References: <ZpfOqJaIO5mr__CW@rei>
 <20240718065532.20188-1-maxj.fnst@fujitsu.com>
 <20240729225700.GA1311523@pevik> <ZqtQCpA2MCZLeC-x@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqtQCpA2MCZLeC-x@rei>
X-Spamd-Result: default: False [-4.30 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu: Add testcase for EFAULT
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

> Hi!
> > > +static void run(void)
> > > +{
> > > +	unsigned int cpu_id, node_id = 0;
> > > +
> > > +	TST_EXP_FAIL(getcpu(tst_get_bad_addr(NULL), &node_id), EFAULT);
> > I'm not sure why, but I get SIGSEGV due tst_get_bad_addr(NULL) on various
> > kernels (SLES 5.14.21, Tumbleweed 6.5.1, 6.10, Debian 6.9, ...).

> > But the test works on SLES 4.4.180.

> If you are getting SIGSEGV that means that the address is used in
> userspace. Looking at man getcpu() it suggests that on some
> architectures it may be implemented as VDSO, which would explain it.

> So I suppose that the easies solution here would be to run the test in a
> child process and accepting SIGSEGV as a correct outcome as well.

Thanks, Cyril.

Ma Xinjian, could you please send another version?

You can get inspiration in:
testcases/kernel/syscalls/setrlimit/setrlimit05.c

Or in others:
$ git grep -l .forks_child $(git grep -l SIGSEGV)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
