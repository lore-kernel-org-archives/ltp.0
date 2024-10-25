Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9F0D0C5F9
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 10:20:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923F23C72CF
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 12:20:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A9D3C562B
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 12:20:41 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DFDA11E49D7
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 12:20:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C49E1FDE9;
 Fri, 25 Oct 2024 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729851639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZTb8NZqTIFknIfYp6FCrfdDhqc6hf+sMVxeQCV1thE=;
 b=kuvGCJqj0VReTHXHDPGkuEfWGoYrGYYPDD/yV4UwYVBjmP7zfVLk8GgWOtrDV485OLu7N0
 KiXVRiyjkcqaeY8JrQkDmPmPF30e3OMl4Si8nvhk4i2VOKxeDOMgLMzE/Eo2ochiIqKOWN
 IjAgWUdVjlbecwBVUNdqjQEuUCcNRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729851639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZTb8NZqTIFknIfYp6FCrfdDhqc6hf+sMVxeQCV1thE=;
 b=QsBWFicAX/aw+0kEy6E2EK+a0zpYQnoQslxznImWMkMcHrPQc8oVl4C8ms9frJlkcgNvha
 b8Oa/l9P+fgvrdCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729851639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZTb8NZqTIFknIfYp6FCrfdDhqc6hf+sMVxeQCV1thE=;
 b=kuvGCJqj0VReTHXHDPGkuEfWGoYrGYYPDD/yV4UwYVBjmP7zfVLk8GgWOtrDV485OLu7N0
 KiXVRiyjkcqaeY8JrQkDmPmPF30e3OMl4Si8nvhk4i2VOKxeDOMgLMzE/Eo2ochiIqKOWN
 IjAgWUdVjlbecwBVUNdqjQEuUCcNRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729851639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZTb8NZqTIFknIfYp6FCrfdDhqc6hf+sMVxeQCV1thE=;
 b=QsBWFicAX/aw+0kEy6E2EK+a0zpYQnoQslxznImWMkMcHrPQc8oVl4C8ms9frJlkcgNvha
 b8Oa/l9P+fgvrdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65952132D3;
 Fri, 25 Oct 2024 10:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /IH/FvdwG2eQCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Oct 2024 10:20:39 +0000
Date: Fri, 25 Oct 2024 12:20:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241025102037.GB681652@pevik>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-2-5328a785bbad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241009-generate_syscalls-v4-2-5328a785bbad@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] Add script to generate arch(s) dependant
 syscalls
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

Hi Andrea,

> Add generate_arch.sh script which can be used to generate arch(s)
> dependant syscalls file. The way it works is pretty simple: for each
> architecture defined into supported-arch.txt, compile kernel headers,
> extract the list of syscalls and generate a .in file containing all of
> them, associated with their own syscall's number.

Nice improvement, thanks!

> The way syscalls files are generated, passes through a C application
> which is automatically checking the availability of the syscalls in
> the user space environment.

This C application is in the Linux kernel and we only consume the result right?

If the C app was needed to be run for LTP, that would broke LTP cross compilation.
(There are people compiling LTP with cross compilation, e.g. arm folks in yocto
and Buildroot, riscv64 on openSUSE Tumbleweed).

> diff --git a/include/lapi/syscalls/generate_arch.sh b/include/lapi/syscalls/generate_arch.sh
> new file mode 100755
> index 000000000..abdb52256
> --- /dev/null
> +++ b/include/lapi/syscalls/generate_arch.sh
> @@ -0,0 +1,205 @@
> +#!/bin/sh
> +#
> +# This is an adaptation of the update-tables.sh script, included in the
> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
> +# under the MIT license.

> +#
> +# Author: Andrea Cervesato <andrea.cervesato@suse.com>

nit: I would still use some SPDX + copyright here.

> +
> +KERNELSRC=$1
Generally all shell variables should be quoted to avoid problems with space.
Feel free to do that before merge.

KERNELSRC="$1"

> +
> +# to keep sorting in order
> +export LC_ALL=C
> +
> +if [ -z $KERNELSRC ]; then
Also here and on other places.

if [ -z "$KERNELSRC" ]; then

Try run script with:
KERNELSRC="foo bar"

[: aa: unexpected operator

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
