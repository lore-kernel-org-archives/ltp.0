Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1485DC3ABA5
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 13:59:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08F523CBC0E
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:59:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F41B3CA0E0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 15:59:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4B3EF100048F
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 15:59:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1B611F391;
 Tue, 29 Apr 2025 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745935161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENkguroCutcR+m+MkwvsgNZBK7+Stmmj8JqsVoX8iG4=;
 b=hMh7NZBsl70ndecev2iek/MA8sRxYMelK7JdnzQBcj5LlVa/SMeOn3A5YXsl4ePKnOQ95I
 TX9lSEQSy+M6S5tzX1dQCT695beIYI+DJr6zX2lZG4NDifAGDofqN6xlyVy0MTRF9NKnN5
 NuCa4mLcEG+HsZAqEs2bIgk6ZORwIfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745935161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENkguroCutcR+m+MkwvsgNZBK7+Stmmj8JqsVoX8iG4=;
 b=9PztgKmO3tbTlnZcweQIXi4XVz9ZVlr/e1tRnEq+D0+BiHg2NNygj4bGlee3FFMTyWx9vd
 zNwQ8at59hr2KmBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745935161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENkguroCutcR+m+MkwvsgNZBK7+Stmmj8JqsVoX8iG4=;
 b=hMh7NZBsl70ndecev2iek/MA8sRxYMelK7JdnzQBcj5LlVa/SMeOn3A5YXsl4ePKnOQ95I
 TX9lSEQSy+M6S5tzX1dQCT695beIYI+DJr6zX2lZG4NDifAGDofqN6xlyVy0MTRF9NKnN5
 NuCa4mLcEG+HsZAqEs2bIgk6ZORwIfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745935161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENkguroCutcR+m+MkwvsgNZBK7+Stmmj8JqsVoX8iG4=;
 b=9PztgKmO3tbTlnZcweQIXi4XVz9ZVlr/e1tRnEq+D0+BiHg2NNygj4bGlee3FFMTyWx9vd
 zNwQ8at59hr2KmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B042013931;
 Tue, 29 Apr 2025 13:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QpVfKjnbEGizcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Apr 2025 13:59:21 +0000
Date: Tue, 29 Apr 2025 15:59:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aBDbX26nPXWU3G-r@yuki.lan>
References: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
 <20250408-conversions-modify_ldt-v8-2-7bdba108f64a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408-conversions-modify_ldt-v8-2-7bdba108f64a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/3] syscalls/modify_ldt02: Refactor into new
 API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
The patch looks good, however for the sake of metadata I would like to
get my patch to the test library merged:

http://patchwork.ozlabs.org/project/ltp/patch/20250429135542.19680-1-chrubis@suse.cz/

And then use the pattern described in the patch example to disable the
test on non x86 hardware.

And the same applies to the second patch.

Also no need to resend, I will fix that before applying these patches
if my patch gets in.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
