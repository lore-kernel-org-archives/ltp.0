Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A46C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F6D23C7B35
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:31:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A4943C296F
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:30:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1929E60D4E8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:30:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 768F6210F5;
 Fri, 17 Jan 2025 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737109853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QyKCVJtf6tyT2oXnTbG3JTAFK96QdE0l2xOQcrDYv0=;
 b=GP5dYyItldy5WAJYlLWsMCyCOqE/2wlyWdYDB3OKefyyTSWG1E2U/cuJ4yiqd6Skqmgr7c
 i5Yd17Jtilsa7H4yDk0/wr/RnbuhKkJQJZkBcF0uyJqieENT23q8MVT+YQT5zC6X19VJiV
 +t0pv5ynYDfr9mbnpnFQY+e1ZBJoKEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737109853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QyKCVJtf6tyT2oXnTbG3JTAFK96QdE0l2xOQcrDYv0=;
 b=5ozWewXGUC91D5MmFP4FWeymhcEDBJWLFvzhurSbVvNT0Ua5Ar3QVOnPEv9fIcUBamM5P5
 N4fdwWs1roqtdvCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GP5dYyIt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5ozWewXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737109853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QyKCVJtf6tyT2oXnTbG3JTAFK96QdE0l2xOQcrDYv0=;
 b=GP5dYyItldy5WAJYlLWsMCyCOqE/2wlyWdYDB3OKefyyTSWG1E2U/cuJ4yiqd6Skqmgr7c
 i5Yd17Jtilsa7H4yDk0/wr/RnbuhKkJQJZkBcF0uyJqieENT23q8MVT+YQT5zC6X19VJiV
 +t0pv5ynYDfr9mbnpnFQY+e1ZBJoKEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737109853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QyKCVJtf6tyT2oXnTbG3JTAFK96QdE0l2xOQcrDYv0=;
 b=5ozWewXGUC91D5MmFP4FWeymhcEDBJWLFvzhurSbVvNT0Ua5Ar3QVOnPEv9fIcUBamM5P5
 N4fdwWs1roqtdvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E16913A30;
 Fri, 17 Jan 2025 10:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBv1FV0ximdzXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 10:30:53 +0000
Date: Fri, 17 Jan 2025 11:30:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4oxVM7f9jppXtpZ@yuki.lan>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
 <20250117101804.GA750287@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117101804.GA750287@pevik>
X-Rspamd-Queue-Id: 768F6210F5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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
> via:
> tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);
> 
> I wonder if this should be wrapped with
> #ifndef TST_NO_DEFAULT_MAIN

I do not think so, it makes perfect sense that the timeout for retry is
multiplied on a debug kernel. The real question is if we need to retry
the clone in the case of tst_ns_exec. The commit that added the retry
loop was:

commit 7d882081a5613f44a12fc6b1c44267d4df0857a4
Author: Petr Vorel <pvorel@suse.cz>
Date:   Mon Mar 28 22:46:43 2022 +0200

    lib: Retry safe_clone() on ENOSPC

    In some tests we are creating the namespaces faster than they are being
    asynchronously cleaned up in the kernel:


I guess that this is not going to be the case for tst_ns_exec because we
are not adding new namespaces but rather cloning a processes into an
existing namespace.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
