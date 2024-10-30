Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192ED5CCB4
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 14:49:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B4BF3CB143
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 15:49:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932293C2EFA
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 15:49:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 006F567E892
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 15:49:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD37021C86;
 Wed, 30 Oct 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730299765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUx0lgQcKi6Grhz5wkAasjRTbIYeHrI3uy/7gXwqnxg=;
 b=ZmCin5r8c3APyRfsQLc64pUguVB0kMdmiGy38/oK8GubSGXBWtqyBgRMVJZkMQr0Cn/q12
 eZfIQsVqY6R2Y5Df938QQUkU0jU7tgNEi2RCGRNGCo4A4+5z2/llc0WDlevf15bZkGbt17
 0wwyYaPn1qcV1GlpEdmGJS1nOZtg4us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730299765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUx0lgQcKi6Grhz5wkAasjRTbIYeHrI3uy/7gXwqnxg=;
 b=KeG6+jdXMIv+p1+pclPZnOfCKlYXIagM9/uU7s0tTA1Rm1S9S0aOuf2a+pC0NGhbhmlKlN
 cIxgdRQ9RaD0qFBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vm9wvb9L;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ihcj2ovZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730299764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUx0lgQcKi6Grhz5wkAasjRTbIYeHrI3uy/7gXwqnxg=;
 b=vm9wvb9L48DIv5Bq7jKcxrFwoXZdFD5owdVLjXLpuS2JPYuPUGPanHYoz221SR1V6yy+Xc
 cOQuNK+fndzhyKmJ6i6J8BKVrdgM6wXg4yMBdH7FBjxhM6zXNWQ4qKrLKaXau152ZPWKZ7
 M/DqLPCJeOVbPhHhgRRjoR3lbFIgKEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730299764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUx0lgQcKi6Grhz5wkAasjRTbIYeHrI3uy/7gXwqnxg=;
 b=Ihcj2ovZ0qZ8g2z3a8KCJ8xWFJRBbj7yMdfEh5AKX3cs6cw7kX3dLMPo+QR3f+6i2k3sBa
 XPh8JQhrRfNn2RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4692136A5;
 Wed, 30 Oct 2024 14:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kk8nKnRHImcoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Oct 2024 14:49:24 +0000
Date: Wed, 30 Oct 2024 15:49:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241030144908.GA915191@pevik>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
X-Rspamd-Queue-Id: DD37021C86
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
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

> +++ b/include/lapi/syscalls/generate_syscalls.sh
> @@ -0,0 +1,115 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Generate the syscalls.h file, merging all architectures syscalls input file
> +# which are in the current folder and defined inside supported-arch.txt file.
> +
> +SYSCALLS_FILE="$1"
> +
> +if [ -z "${SYSCALLS_FILE}" ]; then
nit: I would still replace ${...} with $... (e.g. ${SYSCALLS_FILE} =>
$SYSCALLS_FILE) as I noted in v4 - readability. IMHO there is no need to use
${...} in whole script.

The same applies to include/lapi/syscalls/generate_arch.sh in the second commit.

> +	echo "Please provide the syscalls.h directory:"
> +	echo ""
> +	echo "$0 path/of/syscalls.h"
> +	echo ""
> +	exit 1
> +fi
> +
> +SCRIPT_DIR="$(realpath $(dirname "$0"))"
> +SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
> +
> +echo '
> +/************************************************
> +* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
> +*  change your arch specific .in file instead  *
> +************************************************/
> +
> +/*
> +* Here we stick all the ugly *fallback* logic for linux
> +* system call numbers (those __NR_ thingies).
> +*
> +* Licensed under the GPLv2 or later, see the COPYING file.
> +*/


nit: fixing space in /* */ comments (correct in the original regen.sh)
+ replacing old note about COPYING with SPDX in generated header:

+++ include/lapi/syscalls/generate_syscalls.sh
@@ -17,18 +17,16 @@ fi
 SCRIPT_DIR="$(realpath $(dirname "$0"))"
 SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
 
-echo '
+echo '// SPDX-License-Identifier: GPL-2.0-or-later
 /************************************************
-* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
-*  change your arch specific .in file instead  *
-************************************************/
+ * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
+ *  change your arch specific .in file instead  *
+ ************************************************/
 
 /*
-* Here we stick all the ugly *fallback* logic for linux
-* system call numbers (those __NR_ thingies).
-*
-* Licensed under the GPLv2 or later, see the COPYING file.
-*/
+ * Here we stick all the ugly *fallback* logic for linux
+ * system call numbers (those __NR_ thingies).
+ */
 
 #ifndef LAPI_SYSCALLS_H__
 #define LAPI_SYSCALLS_H__
---

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
