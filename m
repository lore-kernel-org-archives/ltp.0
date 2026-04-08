Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA51073C8E
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 10:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9493E29B5
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 12:33:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 134473CA219
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:33:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91F5A1400B9D
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 12:33:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA2BD4E95E;
 Wed,  8 Apr 2026 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775644409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXsrxtxE9U4gh4ERV9Z/Bx5X2RmuBxkFsJAy5NHKEv8=;
 b=CZSMiEfnMwiO+vUN7cyaugWSSyIqsrY36UuC8VXdXZSna4y0hBiSgIbF+QPBnDT+CWXn5E
 EK52XCHEXAnyQMyNLQBQdflOuj8yhGOVhjDOki/XnTdhfwaDW4tZ8mzgf/GMjwuQxnARAB
 DGj2qabvE8z/7nNjAmRyXW/sSeoCHVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775644409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXsrxtxE9U4gh4ERV9Z/Bx5X2RmuBxkFsJAy5NHKEv8=;
 b=nKmdyw/mfnEuHkvZcybwOYISENRmwrJeMNAH3tJY/3XYD3laJcSvTI3gd0I94rpP7FDOUU
 BxKAtqIWc8sPELAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wh60UsFn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="mtt7/Ul4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775644408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXsrxtxE9U4gh4ERV9Z/Bx5X2RmuBxkFsJAy5NHKEv8=;
 b=Wh60UsFnBmswCs3pPja/+48AStC+O5hBDuem+dncFJqiRfQOgnk8B19TpmL3BzJ6WWthUe
 57+RRC+A1lpbtm2+1JtQlRT+S9Tffn+7PKivlIOL85LHpenasCZNmGd3ovRkr+msoDWu8r
 DeIOSCXq9qIpLO82R1rK2kTpsKMYSCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775644408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXsrxtxE9U4gh4ERV9Z/Bx5X2RmuBxkFsJAy5NHKEv8=;
 b=mtt7/Ul4LHudmu5HovoM/Hdy4JHNYFWJjw0o5wWjZhj58CQLZUUsGxh53vFd+oHF0MSpUx
 3AHka/CkZgl1FSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC0AF4A0B3;
 Wed,  8 Apr 2026 10:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 95nWMPgu1mlncwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Apr 2026 10:33:28 +0000
Date: Wed, 8 Apr 2026 12:33:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ming Wang <wangming01@loongson.cn>
Message-ID: <adYu_0Vea_Byk1EH@yuki.lan>
References: <20260404014047.993528-1-wangming01@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260404014047.993528-1-wangming01@loongson.cn>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[yuki.lan:mid]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: DA2BD4E95E
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] proc01: whitelist biba attr files returning EINVAL
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
Cc: gaojuxin@loongson.cn, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> proc01 already treats several attr files under /proc/self/attr and
> /proc/self/task/*/attr as known exceptions that may return EINVAL
> on read.
> 
> On systems exposing biba attr files, reads from
> /proc/self/attr/biba/* and /proc/self/task/*/attr/biba/* also
> return EINVAL, which makes proc01 report false failures.

What is biba? There does not seem to be any mention of string 'biba' in
upstream kernel. As a rule we do not add any fixes for out-of-tree
patches to LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
