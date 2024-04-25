Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF2CC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 21:38:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A35F3CFE80
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 23:38:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55D2A3CE2B0
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:37:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B41001A0043E
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:37:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B14F91FB8D;
 Thu, 25 Apr 2024 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714081075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZhxZMQBxl39r5bHyknvhF/afyh9tHh6XwEn+8jnyKw=;
 b=BBFnZ4psjTlvfFdytNYUWaIPoaaJAKVyRj0MhurPA9gQpZNFc8hZC1W5k+qX8Owp1gHc45
 pEWUbMNMYFzaqftA6xGUDkxLKAkSAVDVpAEgVsRLKsm2z72pgSQ7zSA82iwVLUaBPmhcLZ
 FOzatw+nEDEpioegU8EPgAdIY49be/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714081075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZhxZMQBxl39r5bHyknvhF/afyh9tHh6XwEn+8jnyKw=;
 b=ttXHNeRxvnD2AoAJOrs8VsTMVLVkqoFvR8NqksOsuyuA9gQPaUeGTeMJAElRTXo37AQ15o
 Jd4fntlSG0GwynAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714081075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZhxZMQBxl39r5bHyknvhF/afyh9tHh6XwEn+8jnyKw=;
 b=BBFnZ4psjTlvfFdytNYUWaIPoaaJAKVyRj0MhurPA9gQpZNFc8hZC1W5k+qX8Owp1gHc45
 pEWUbMNMYFzaqftA6xGUDkxLKAkSAVDVpAEgVsRLKsm2z72pgSQ7zSA82iwVLUaBPmhcLZ
 FOzatw+nEDEpioegU8EPgAdIY49be/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714081075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZhxZMQBxl39r5bHyknvhF/afyh9tHh6XwEn+8jnyKw=;
 b=ttXHNeRxvnD2AoAJOrs8VsTMVLVkqoFvR8NqksOsuyuA9gQPaUeGTeMJAElRTXo37AQ15o
 Jd4fntlSG0GwynAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A68A1393C;
 Thu, 25 Apr 2024 21:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJVzFDPNKmZebwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 21:37:55 +0000
Date: Thu, 25 Apr 2024 23:37:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240425213749.GA304030@pevik>
References: <20240423082119.16117-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423082119.16117-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: update syscalls statistics
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

> This patch black-list a few syscalls which are not implemented in the
> kernel, untestable or either really old (=< 2.6 kernel version), as well
> as defining already tested syscalls.
> Also fixed an index issue with table generation.

Thanks a lot, obvious fix, therefore merged.

I would still consider:

1) Listing also mq_getsetattr().
2) Trying to links syscalls names to the syscalls directory
(e.g. read => read directory in LTP tree[1]) that should not be that hard.
3) Write explanation, that these syscalls are to "some extend tested".
Ideally, I would wish we would transform metadata output generation [2]
to the docs here and enable also LTP latest stable version docs.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/read
[2] https://github.com/linux-test-project/ltp/releases/download/20230516/metadata.20230516.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
