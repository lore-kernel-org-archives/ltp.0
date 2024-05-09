Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A8DC10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 08:07:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ECFA3CE0E1
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:07:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A73E03C8658
 for <ltp@lists.linux.it>; Thu,  9 May 2024 10:06:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D50351400E65
 for <ltp@lists.linux.it>; Thu,  9 May 2024 10:06:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A7EC38057;
 Thu,  9 May 2024 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715242010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjDobLnv1yMrFqgtWGBwEo1gZRyHgbLm9axBZeZnzCs=;
 b=cUGUyIeRiOA/gbtCdQIsgUNmddFpX4tFfwQtO2kRJC0ZTRt0EPdRdbW4wSCSb/n2TQSVVb
 PAe4a9FBx4tNEh9N/0BZp/x8s+oUXMJKLHobRkWVXvjU3LgHMn2j3DrgPz4JSaLYlMhtOB
 HfVihg0zkHoMUx4QDgZOLh1aZvTdey4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715242010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjDobLnv1yMrFqgtWGBwEo1gZRyHgbLm9axBZeZnzCs=;
 b=/oMMIdLX1lP5wtNWJqL2NgqQgRBSxJekUiogBWJxnfPaMdadOlmi9T6Gn5MjPCYyzDL35Q
 5TGd9R4FOAameDCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715242010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjDobLnv1yMrFqgtWGBwEo1gZRyHgbLm9axBZeZnzCs=;
 b=cUGUyIeRiOA/gbtCdQIsgUNmddFpX4tFfwQtO2kRJC0ZTRt0EPdRdbW4wSCSb/n2TQSVVb
 PAe4a9FBx4tNEh9N/0BZp/x8s+oUXMJKLHobRkWVXvjU3LgHMn2j3DrgPz4JSaLYlMhtOB
 HfVihg0zkHoMUx4QDgZOLh1aZvTdey4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715242010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjDobLnv1yMrFqgtWGBwEo1gZRyHgbLm9axBZeZnzCs=;
 b=/oMMIdLX1lP5wtNWJqL2NgqQgRBSxJekUiogBWJxnfPaMdadOlmi9T6Gn5MjPCYyzDL35Q
 5TGd9R4FOAameDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 700D013941;
 Thu,  9 May 2024 08:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M34VGhqEPGYfGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 08:06:50 +0000
Date: Thu, 9 May 2024 10:06:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hui Min Mina Chou <minachou@andestech.com>
Message-ID: <20240509080649.GB234264@pevik>
References: <20240509052541.18707-1-minachou@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509052541.18707-1-minachou@andestech.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,andestech.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap15: Support RISC-V to do __cache_flush.
 (#79)
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
Cc: tim609@andestech.com, cynthia@andestech.com, az70021@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hui,

> AndesCore CPU test fails due to an illegal instruction at the first
> jumpfunc(), caused by executing incorrect instructions after
> self-modifying code.

> On RISC-V CPUs, a FENCE.i synchronizes instruction and data streams,
> ensuring that subsequent instruction fetch on a RISC-V hart will see
> any previous data stores already visible to the same RISC-V hart.

> Thus, cacheflush() in the test should also use __clear_cache for RISC-V.
> In SMP systems, it invokes the kernel syscall riscv_flush_icache to inform
> each hart to flush their local i-caches.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW what "#79" in the git message subject means?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
