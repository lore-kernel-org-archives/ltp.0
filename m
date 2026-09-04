Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B11C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:21:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508263E937A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:21:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45CC13E20CA
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:21:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D2DA9600298
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:21:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F95D22522;
 Fri,  4 Sep 2026 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788513656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkDEo7DRftlztbA7An106v1Ptc/r3I+z7Weoc4IrDTA=;
 b=nX/pdipIbBQLhJnfNXQ/jOTAalqtWC8VL3bdUVxVkSQYbTwnZQasbfanfzjN8+73512J3w
 o21khgaw/BIaFVK06MhHsosAgJYRUWO+x370hLRB6AfxfMHP+21J/QSX0syn5ZkU2Hd6cc
 6iQy2XJitBuV3tTbpxUTziD3EmNVe1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788513656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkDEo7DRftlztbA7An106v1Ptc/r3I+z7Weoc4IrDTA=;
 b=sFXmHn1Q0NDYTbkYZ+zUROD5q+u5DomXLy9ZBv1cLcuez7CApW3j4alhnYvxjXUbGQn1hZ
 ETN9IJShDNJM3HBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788513652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkDEo7DRftlztbA7An106v1Ptc/r3I+z7Weoc4IrDTA=;
 b=W6ds5PRkcXgArckqRNPewuZEHqK7K+Q0xB3mOFu/U/oEm9X+FNZd9aDivQz24YfERO2WpU
 dmPA0KG4dC3gORBmmO6qOQsOQ50t3q6D0InTx2qYMtggwTwINR8EzlGy9h2F9x/CIlrBoP
 XZGcuEj4MXp8sNWK0BdRZC8Mf5bByNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788513652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkDEo7DRftlztbA7An106v1Ptc/r3I+z7Weoc4IrDTA=;
 b=DbZUp4rHlD8d8qBR4gujkj7EQoKR8klOXm0gqXcXnWKYYHK706bfIuk3LjWsVyezPbVm9D
 n+d8BARJXAHGo4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B969F13887;
 Fri,  4 Sep 2026 09:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7NQ/LWyNmmrMAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 04 Sep 2026 09:20:44 +0000
Date: Fri, 4 Sep 2026 11:20:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apqNcb103ZVuzpIf@yuki.lan>
References: <20260904-min_kernel-v1-1-47b556550780@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-min_kernel-v1-1-47b556550780@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Check minimal supported kernel version
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> LTP does not support kernels older than 4.4, but this requirement was
> only documented in static text without automated runtime validation.
> 
> Define the minimal supported kernel version in tst_kvercmp.h so that
> the documentation fetches it dynamically and the core library aborts
> unsupported kernels with TCONF during test setup.

Great idea, but I wouldn't tst_brk() on older kernels, I would just
print a message that there may be failures becuase older kernels are not
supported or tested.

LTP has been historically used for many different purposes, e.g. for
testing BSD compatibility layout for running Linux binaries and I fear
that hard stop on older kernel versions would break these usecases.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
