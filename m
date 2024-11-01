Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5004E674BD
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 09:18:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03DFB3CCF35
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:18:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC8E3C21FF
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:18:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 97B8E1BD10B3
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:18:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF58F21C9D;
 Fri,  1 Nov 2024 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730452684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqPYXDipeRxrNOaVTM63kloFXxe7tiumDDemqZQ0ifU=;
 b=x53jbemfHLBXTn8U0MY5yFu3u6T3Jew31uTMaLsIGYV+luEIyEb8d+htyGcV7u/grUl8J6
 b2zM2r9H3Z/amImnfCqrgmfNhOYmrhTE8pX4E0oI40PlttTFmz4Ralk2axX6r8wAvyolcb
 3EjyTCFgXJ6ApGBaIqKbQyve/prX08E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730452684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqPYXDipeRxrNOaVTM63kloFXxe7tiumDDemqZQ0ifU=;
 b=TkI+IZTHzo40v7USh6j14o0py1x4Krnyhh7Sf6NcoirMdKNOhHCaPZG6B30TvA9dngEe+0
 kHIh7YiTIqNdAPCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730452684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqPYXDipeRxrNOaVTM63kloFXxe7tiumDDemqZQ0ifU=;
 b=x53jbemfHLBXTn8U0MY5yFu3u6T3Jew31uTMaLsIGYV+luEIyEb8d+htyGcV7u/grUl8J6
 b2zM2r9H3Z/amImnfCqrgmfNhOYmrhTE8pX4E0oI40PlttTFmz4Ralk2axX6r8wAvyolcb
 3EjyTCFgXJ6ApGBaIqKbQyve/prX08E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730452684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqPYXDipeRxrNOaVTM63kloFXxe7tiumDDemqZQ0ifU=;
 b=TkI+IZTHzo40v7USh6j14o0py1x4Krnyhh7Sf6NcoirMdKNOhHCaPZG6B30TvA9dngEe+0
 kHIh7YiTIqNdAPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 579A7136D9;
 Fri,  1 Nov 2024 09:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8q73EsycJGeBOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 09:18:04 +0000
Date: Fri, 1 Nov 2024 10:18:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241101091802.GA1180540@pevik>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
 <20241031-generate_syscalls-v8-2-8e35a9d6783b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031-generate_syscalls-v8-2-8e35a9d6783b@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Add script to generate arch(s) dependant
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

the script works for me, great!

Few more comments, I promis the last one, feel free to just ignore them.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> --- /dev/null
> +++ b/include/lapi/syscalls/generate_arch.sh
> @@ -0,0 +1,206 @@
> +#!/bin/sh -eu
> +# SPDX-License-Identifier: GPL-2.0-or-later
I would put here your/SUSE/LTP copyright (2024) and the original author
copyright:
# Copyright (c) Marcin Juszkiewicz, 2023-2024

The author does not have it in the script, but it has in LICENSE:
Copyright (c) Marcin Juszkiewicz

But I'm not a lawyer, maybe I'm wrong.

> +#
> +# This is an adaptation of the update-tables.sh script, included in the
> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
> +# under the MIT license.
> +#
> +# Author: Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +if [ "$#" -eq "0" ]; then
> +	echo "Please provide kernel sources:"
> +	echo ""
> +	echo "$0 path/to/Linux/kernel/sources"
> +	echo ""
> +	exit 1
> +fi

nit: use common syntax ($# is always defined, thus not need to be quoted, 0 as
well, "" is empty string, thus can be omitted):
if [ $# -eq 0 ]; then
	echo "Please provide kernel sources:"
	echo
	echo "$0 path/to/Linux/kernel/sources"
	echo
	exit 1
fi

...
> +generate_list_syscalls_c() {
> +	(
very nit: this first echo is probably not needed.
> +		echo
> +		echo "
> +		#include <stdio.h>
> +		#include <asm/unistd.h>
> +
> +		int main(void)
> +		{
> +		"
> +		for syscall in $(cat ${TEMP}/syscall-names.txt); do
> +			echo "
> +		#ifdef __NR_$syscall
> +			printf(\"$syscall %d\\\n\", __NR_$syscall);
> +		#endif
> +		"
> +		done
> +		echo " return 0;
> +		}"
> +	) >${TEMP}/list-syscalls.c
> +}
...
> +
> +do_all_tables() {
> +	for archdir in ${KERNELSRC}/arch/*; do
> +		arch=$(basename $archdir)
...
> +			arch=x86_64 extraflags=-D__LP64__ generate_table
> +			bits=32
> +			arch=i386 generate_table
> +			arch=x32 extraflags=-D__ILP32__ generate_table
> +			;;
> +		arc | csky | hexagon | m68k | microblaze | nios2 | openrisc | sh | xtensa)
I've never seen spaces between '|' separator in shell case command. It should
not cause anything, but it's just unusual (original code in
https://github.com/hrw/syscalls-table/blob/master/scripts/update-tables.sh
from which we diverged quite a lot now also does not have it).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
