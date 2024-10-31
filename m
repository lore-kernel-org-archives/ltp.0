Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A0E6896A
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 09:49:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831CA3CBDE6
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 10:49:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28933CB779
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 10:49:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20BFF1012BD5
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 10:49:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6674221DF4;
 Thu, 31 Oct 2024 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730368173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBw5VbvhPECBC53PcESCet7Dta/PDXSaND5Dz5U8ZFQ=;
 b=ViUvtrUp265/aTUAgAqKbPEYjnhx8XsdnF1Nk98tR2JNAgYyvHs+J/zvEok/q6SN7NGf3h
 HzE54xelGvbiezZT2uz5CMVq9pCUTGHu1CEQBhfMhTssK8g45a0wn+LwJ0pe99ZrdyiWN3
 BNeyMfV3mNCRbav9X1M+3QISZYkfRvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730368173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBw5VbvhPECBC53PcESCet7Dta/PDXSaND5Dz5U8ZFQ=;
 b=TpdkB0m66jMPetwGE9Uu/7LUugvl2slv3oPzoe1M8bJmoV2Hd4zt42ejFkBW1NSSIlOgwz
 ZKa0u101IG8bWiDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ViUvtrUp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TpdkB0m6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730368173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBw5VbvhPECBC53PcESCet7Dta/PDXSaND5Dz5U8ZFQ=;
 b=ViUvtrUp265/aTUAgAqKbPEYjnhx8XsdnF1Nk98tR2JNAgYyvHs+J/zvEok/q6SN7NGf3h
 HzE54xelGvbiezZT2uz5CMVq9pCUTGHu1CEQBhfMhTssK8g45a0wn+LwJ0pe99ZrdyiWN3
 BNeyMfV3mNCRbav9X1M+3QISZYkfRvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730368173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBw5VbvhPECBC53PcESCet7Dta/PDXSaND5Dz5U8ZFQ=;
 b=TpdkB0m66jMPetwGE9Uu/7LUugvl2slv3oPzoe1M8bJmoV2Hd4zt42ejFkBW1NSSIlOgwz
 ZKa0u101IG8bWiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3737013A53;
 Thu, 31 Oct 2024 09:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lozcCq1SI2fMMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 09:49:33 +0000
Date: Thu, 31 Oct 2024 10:49:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241031094927.GB995052@pevik>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
X-Rspamd-Queue-Id: 6674221DF4
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
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

whole patchset LGTM, thank you!

I was comparing the old include/lapi/syscalls.h (21579 lines) and the new one
(20054). Having new file shorter is a bit surprising to me. I haven't found what
is missing, probably I'm missing something myself :).

> Rename regen.sh into a more meaningful generate_syscalls.sh name, rename
> order into a more meaningful supported-syscalls.txt name and rewrite
> part of the regen.sh script code in order to execute it from anywhere in
> the filesystem, without need to be in its own folder. The new code is
> also more clear and concise, using native sh features which are
> simplifying the code.

Purely out of curiosity (nothing to block this), which "native sh features"?

> +++ b/include/lapi/syscalls/generate_syscalls.sh
...
> +SCRIPT_DIR="$(realpath $(dirname "$0"))"
> +SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
> +
> +echo '
> +// SPDX-License-Identifier: GPL-2.0-or-later

very nit stylish: This produce new line. Why not just:

echo '// SPDX-License-Identifier: GPL-2.0-or-later
/************************************************

Feel free to ignore or amend before push.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
