Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328C8CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:42:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868333CD279
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 12:42:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 639AC3CD279
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 12:41:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F5286008EF
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 12:41:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE3661F461;
 Fri,  7 Nov 2025 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762515716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZGPajadwRIdP4ezTU4ZNWqn81L76X+Fy0KQWlWfFkk=;
 b=F+53sHwstxEQFTnyyBw6zC+id7H1Tz+oKdkraQnHzPE0wgTbd6renfCkJlm3s2Ffl26C3Z
 ObnQo5/XTiiR0LwTlJlGW0Fp78w4YzQ6LWTguvaRjlQKXNHV088CppEpMRiJCjdKpH+EIT
 VvkaEj8fqPBm4pMVnAx+8MxEc7wv0mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762515716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZGPajadwRIdP4ezTU4ZNWqn81L76X+Fy0KQWlWfFkk=;
 b=iAmlxdgDQOME6mF6erejiOgIOT8IEKisu4/bC/sTsrIYl8J4CeOwW5vMxh1AZwDq6Vt4Lt
 TzE07hZh/98wv6CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762515716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZGPajadwRIdP4ezTU4ZNWqn81L76X+Fy0KQWlWfFkk=;
 b=F+53sHwstxEQFTnyyBw6zC+id7H1Tz+oKdkraQnHzPE0wgTbd6renfCkJlm3s2Ffl26C3Z
 ObnQo5/XTiiR0LwTlJlGW0Fp78w4YzQ6LWTguvaRjlQKXNHV088CppEpMRiJCjdKpH+EIT
 VvkaEj8fqPBm4pMVnAx+8MxEc7wv0mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762515716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZGPajadwRIdP4ezTU4ZNWqn81L76X+Fy0KQWlWfFkk=;
 b=iAmlxdgDQOME6mF6erejiOgIOT8IEKisu4/bC/sTsrIYl8J4CeOwW5vMxh1AZwDq6Vt4Lt
 TzE07hZh/98wv6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFBB31395F;
 Fri,  7 Nov 2025 11:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yU57KQTbDWmjCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 11:41:56 +0000
Date: Fri, 7 Nov 2025 12:41:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251107114151.GB1116063@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
 <20251107003041.28929-5-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107003041.28929-5-wegao@suse.com>
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.19)[-0.931]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] shell_loader_cmd.sh: New test case check
 needs_cmds
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

Hi Wei,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_cmd.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2025 Wei Gao <wegao@suse.cz>
> +#
> +# ---
> +# env
> +# {
> +#  "needs_cmds": [
> +#   {
> +#    "cmd": "ls",
> +#    "optional": 1
> +#   }

Ideally we would also some test with an expression with version on "cmd",
e.g. "mkfs.ext4 >= 1.0.0" to make sure it's correctly handled. I know it's just
passing to the C library, but just for sure.

Kind regards,
Petr
> +#  ]
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_test()
> +{
> +	tst_res TPASS "We are running with needs_cmds"
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
