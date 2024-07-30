Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C371CC3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 07:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26EB13D1D7F
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:37:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9A1C3D1C18
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:37:30 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5E6660563D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:37:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F17FF21A64;
 Tue, 30 Jul 2024 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722325048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKjk5n48N9+NfpePDB2nJQNv8g75c45YokAKl78i8GE=;
 b=x9UAVeI1/4W9S825IyzRIGaLTH3AODXXM21oku8ZmB4t/yH+mdeu1vrMrfSnEOXmSTQE7l
 3eo0aJkKTpuKPJcrQPWZrz1YIDzgHhEV0cHbqnOzPNOORFZHYmmVIJ7l5iTIm/8ADPh5VI
 Olic8LJZ6ccqvik8TA1vG+uhf7rCoWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722325048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKjk5n48N9+NfpePDB2nJQNv8g75c45YokAKl78i8GE=;
 b=K98hHCAU2oqnA7SFRcM79h6EdMOYnULcj+tpbzMKFu8owqr8HU9L+Ono8hnurx2rlrSBKO
 yYvrNeC8MHmt+NAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722325045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKjk5n48N9+NfpePDB2nJQNv8g75c45YokAKl78i8GE=;
 b=v0zJjQu+CLNKzsV4XNbdG4YLAqUJzLxDAGCi2ISC3aoeIlCCzdjfoXBADyOXzAHgus/0Xq
 2HL4VH8h44ICyjPMAugG+h12m/TLjQzF+6IZcWv9eeBJnTW1Z+sO5CWGlcdJ//0qfGhb3E
 2eJKkvirwJyixDRwqznv2cjN7diXaMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722325045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKjk5n48N9+NfpePDB2nJQNv8g75c45YokAKl78i8GE=;
 b=0ABvBwrGvSJbnqr9G02Fcnuhu42IyAlIWor7pDNJj+XxFeXAHv3ugpU8xKTWVitwpBzjgJ
 jb4qR1omU5OuNwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08E913983;
 Tue, 30 Jul 2024 07:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oO1vMzWYqGbUcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jul 2024 07:37:25 +0000
Date: Tue, 30 Jul 2024 09:36:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <ZqiYFfHsx4H1Dc8d@yuki>
References: <20240724130553.126252-1-fstornio@redhat.com>
 <ZqEaRwixo1dHiBEC@yuki>
 <CAHzY_-55nD2yUQRL0wUT9ddD5ESSnBJAqiYZ5PscJF=bU4+j=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHzY_-55nD2yUQRL0wUT9ddD5ESSnBJAqiYZ5PscJF=bU4+j=A@mail.gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mlock05: add log details about the success/failure
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
> Our test logs will be reviewed by people not familiar with the test purpose
> or its implementation. These will be people who may not have the background
> or time necessary to read and understand the source code.

You may be interested in the metadata extracted during the test build as
well. LTP produces a big a big html page with descriptions extracted
from the tests in docparse/metadata.html for mlock05 you get:

...

Description

Verify mlock() causes pre-faulting of PTEs and prevent memory to be swapped out.

Find the new mapping in /proc/$pid/smaps and check Rss and Locked fields
after mlock syscall: Rss and Locked size should be equal to the size of
the memory allocation

...

> However, improving the TST_EXP_EQ_LU() macro to print additional
> information looks great and I believe it would be the better approach, as
> it would also be useful for future contributions.
> Do you already have something in mind for a possible implementation?
> I was thinking of creating a new one that looks like this:
> TST_EXP_EQ_LU_MSG() so that the test writer can add a custom message where
> the test passes/fails.

Most of the TST_EXP_*() macros have optional printf-like format string
and parameters, it should be easy to add that functionality the
TST_EXP_EQ_*() macros as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
