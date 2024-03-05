Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B4C54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 13:31:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4EE23D022E
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6F423CD840
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 14:31:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66F2C208D21
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 14:31:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDECB6B22B;
 Tue,  5 Mar 2024 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709645485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixy77FOuEN6ciXd0lLmYTNYWqUYIaWaoXQ03+wadsS4=;
 b=K2Q/5MOOu2pzMOYQcNKES4LxX1Wh3cOXH3j8UQjxqDFQl+brSFgv0EU8lF4e9QmrQxnPkU
 o6LZa+BUyLz6MLRDszVRurdjyUX11Z7gQQhINrsLcrwVYTkhRJzh15ca5tK5yjmipFS/Kb
 WmReP8Dy96KMXBzS5359Jj/eSAXEKHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709645485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixy77FOuEN6ciXd0lLmYTNYWqUYIaWaoXQ03+wadsS4=;
 b=i991ZZjaV8mQP7wcmsx+1euCxPhIMpcJlrcqQ/2ChSZyAKv65oTS4PUYmltM58oXGOcTtF
 KHtdIa51jsD6dvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709645484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixy77FOuEN6ciXd0lLmYTNYWqUYIaWaoXQ03+wadsS4=;
 b=NjKsLmwCm5vfeH3Kqy7Qoytp2vLuwNZeU7bX87JQoHs+8/AodjZ95GtVfxeeLfq+oz7jjP
 cz8ictUjPgoGdpGcUUyQcrOQ5Y3Y5+YpSw9I6t4v/mbYaIiHYOyFEvqUnqyW0bn3ov3X5e
 5dexTX1ofDqyVVbw6Dgv0N53QRun5NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709645484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixy77FOuEN6ciXd0lLmYTNYWqUYIaWaoXQ03+wadsS4=;
 b=UR18Mm6Ciy1wkK0kpnTGYU2e1PCNpDRoLiezI8zMrho2VLuNENtu1GPoPcHaPoEcxiRuyq
 Z2f5pTjSIP3iLoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C42CE13A5B;
 Tue,  5 Mar 2024 13:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I1TbL6we52UhTQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Mar 2024 13:31:24 +0000
Date: Tue, 5 Mar 2024 14:30:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dennis Brendel <dbrendel@redhat.com>
Message-ID: <ZecebvbXRWiWyWl_@yuki>
References: <c63c49c3-30e8-494d-9ceb-64fc55060e1f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c63c49c3-30e8-494d-9ceb-64fc55060e1f@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.89 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.09)[64.40%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] munlockall: add test case that verifies memory
 has been unlocked
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
Generally this is much better test than the munlockall01.c so it would
make more sense to replace munlockall01.c instead of adding a new test.

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* 
> + * Copyright Red Hat
> + * Author: Dennis Brendel <dbrendel@redhat.com>
> + */
> +
> +/*

This should be docparse comment, i.e. start with /*\ so that it's picked
up with the documentation parser.

> + * [Description]
> + *
> + * Verify that munlockall(2) unlocks all previously locked memory
> + */
> +
> +#include <sys/mman.h>
> +
> +#include "tst_test.h"
> +
> +static void verify_munlockall(void)
> +{
> +    unsigned long int size = 0;
> +
> +    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +    if (size != 0UL) {
> +        tst_res(TFAIL, "Locked memory after init should be 0 "
> +                       "but is %ld", size);
> +    }
> +
> +    if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
> +        tst_res(TFAIL, "Could not lock memory using mlockall()");
> +    }
> +
> +    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +    if (size == 0UL) {
> +        tst_res(TFAIL, "Locked memory after mlockall() should be greater "
> +                       "than 0, but is %ld", size);
> +    }
> +
> +    if (munlockall() != 0) {
> +        tst_res(TFAIL, "Could not unlock memory using munlockall()");
> +    }
> +
> +    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +    if (size != 0UL) {
> +        tst_res(TFAIL, "Locked memory after munlockall() should be 0 "
> +                       "but is %ld", size);
> +    } else {
> +        tst_res(TPASS, "Test passed");
> +    }

This obviously does not work, you have to either return from the
function after each tst_res(TFAIL, ""); or set a flag and print TPASS
only if the flag wasn't set.

> +}
> +
> +static struct tst_test test = {
> +    .test_all = verify_munlockall,
> +};

Also have you checked the test with 'make check' before sending the
patch?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
