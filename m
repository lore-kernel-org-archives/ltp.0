Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E6C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:48:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBF63D1C5F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:48:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBA883D1C4E
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:47:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53D34200279
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:47:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D55C221BB5;
 Wed, 24 Jul 2024 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721814467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4NZ8WasjIJsEsD+CHALBzIZB8xyYkJ2W4jaFoEsWsA=;
 b=ijhYzllE9ES/hlwEnH0cMDfQftFoFIBzAfeQ54UomoIqFvKu5o6irvnjkh/rgszQscUYKQ
 lUCFvsf+HYDYO+kUhGh2ZWuB08G6jrwW+rj3ZKkBedRr4Cohgg/HNWI8afg+5vbg/VXQZJ
 VmyPCgvTsfoxVQssrKlMB+kHdOxF8KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721814467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4NZ8WasjIJsEsD+CHALBzIZB8xyYkJ2W4jaFoEsWsA=;
 b=aztxMdkPhuRkdYrvtv63pQp8s4R3NiLc2ToRPvbQSeiiV+X5OcAmfpEGp5SC5n6t1N6dne
 DJWbzC1nR4Fc1WAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721814466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4NZ8WasjIJsEsD+CHALBzIZB8xyYkJ2W4jaFoEsWsA=;
 b=Z/XTcK3b7s6u+5LYqajZrZv9wZwzpFSnnaezWxgop676wKWg4S3pExX1ltJADUQRW8TbSe
 414vpDAhllj3qdILa/2wpHyOAN6/tat+xYqnxCtRV4fUWZ/4KJcLUWfpPRJcphBXJxjKTR
 nvUVNmtlu4WLYJ8jp14dCS3IF4SgeZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721814466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4NZ8WasjIJsEsD+CHALBzIZB8xyYkJ2W4jaFoEsWsA=;
 b=v7vAdXtrGFSvjpVmVjYyN8gbTpTWlaLwF4HYRlVZ86hrfoGXzZOPF+ns2+GJnf/g6/CJah
 G88ARA6p6UU2VbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C59E813411;
 Wed, 24 Jul 2024 09:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8tU6L8LNoGaXWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 09:47:46 +0000
Date: Wed, 24 Jul 2024 11:47:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZqDNpfMzFbmmQlxa@yuki>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
X-Spamd-Result: default: False [-3.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> The exit command above will ignore any other result flags already set 
> during the test. You could modify tst_res_ to return the correct exit 
> code and then call it like this:

It does not work like this. The tst_res helper modifies the shm memory
that the test library uses, so all test results are propagated once the
tst_res helper returns.

Only the TBROK flag is not propagated via the shared memory in the new
test library which I consider a mistake when I designed the new test
library and we should move it to the shared memory...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
