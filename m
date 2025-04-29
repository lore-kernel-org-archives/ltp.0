Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC0C3ABAB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1E023CBC31
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 17:05:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714C73CA670
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:05:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E1DB600447
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:05:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 29C4421205;
 Tue, 29 Apr 2025 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745939139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnGIaQ/gC7+oN0tiurItTUu2Wy+JHCDyf8eBlWvF6Ig=;
 b=vjwPyCRxaEZrTdxX/nPRzwuPmgWp+nDlLS/l4hKmkq/emqLsd3bRc5yveLB01T3Decre2I
 p0n4rMMHMPqXPNhWy4ZJ9XbwqOYD2oGxsM3rJiY7LOhwqD2Z9ofCFQcjgT4pEF4ZxDimup
 rbNse9isceUvxn+EFyQrg4dmBujO9QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745939139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnGIaQ/gC7+oN0tiurItTUu2Wy+JHCDyf8eBlWvF6Ig=;
 b=aU2BvdgxVB6+jTtdYaWbqrV5Y6i+uobH8igzkifVpsWvVrVrhjPF3RDzrXOMyUD5Foozkj
 n78An2AVFDuDxPCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vjwPyCRx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aU2Bvdgx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745939139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnGIaQ/gC7+oN0tiurItTUu2Wy+JHCDyf8eBlWvF6Ig=;
 b=vjwPyCRxaEZrTdxX/nPRzwuPmgWp+nDlLS/l4hKmkq/emqLsd3bRc5yveLB01T3Decre2I
 p0n4rMMHMPqXPNhWy4ZJ9XbwqOYD2oGxsM3rJiY7LOhwqD2Z9ofCFQcjgT4pEF4ZxDimup
 rbNse9isceUvxn+EFyQrg4dmBujO9QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745939139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnGIaQ/gC7+oN0tiurItTUu2Wy+JHCDyf8eBlWvF6Ig=;
 b=aU2BvdgxVB6+jTtdYaWbqrV5Y6i+uobH8igzkifVpsWvVrVrhjPF3RDzrXOMyUD5Foozkj
 n78An2AVFDuDxPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 144AF1340C;
 Tue, 29 Apr 2025 15:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WWDvA8PqEGiRCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Apr 2025 15:05:39 +0000
Date: Tue, 29 Apr 2025 17:06:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aBDq6PobtIDF2_nV@yuki.lan>
References: <20250429135542.19680-1-chrubis@suse.cz>
 <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com>
X-Rspamd-Queue-Id: 29C4421205
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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
> I guess the reason is that we want to skip code which is not compiling 
> for our architecture, right?
> But do we already have TST_TEST_CONF, so I'm a bit puzzled on the use case.

The problem here is that with TST_TEST_TCONF() the supported architecture
is not exported into the metadata.

There are two cases where TST_TEST_TCONF() is used in LTP:

- usupported architecture for the test
- missing headers during compilation

The first case should ideally be converted so that we have the supported
architectures in the test metadata.

Another option is just to add metadata to the tst_test structure and
keep TST_TEST_TCONF(), but I do not like that solution, because the
ifdefs and .supported_archs can go out of sync easily because tst_test
structure is not used when TST_TEST_TCONF() is used.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
