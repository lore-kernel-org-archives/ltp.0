Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906B9C982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:09:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBD063E6C15
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 13:09:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3672A3E309F
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:08:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D7A62005FD
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:08:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBFE91FF1D;
 Wed, 23 Sep 2026 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790161733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15etnfge3RH4WzrrdTOqRW6SLO7dCu+fPTpgpuTOoNo=;
 b=YyAf4IbcoQWeKyfWsTFlKlvzzBMz2xIMa7YuzmdY4jP/UDZ9Gdb2zxg6nFvT86ZOg5uOD9
 un7xkW4XFU3q+wUAyTnosF52IH9vW4EdIRFEY5AAsyI6RNx2mYjNitsI50gbjoFAts0H+a
 +9GADG8IjuqBIVt01WgQQka3Kv7V+X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790161733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15etnfge3RH4WzrrdTOqRW6SLO7dCu+fPTpgpuTOoNo=;
 b=oOn8Ukzr6vK2SJwUWHwFDTHar+sAARqhuxAAIOzZ2QAj3KUBFhWsbBAqeGfFDGBlW79wMa
 E7MawQnG7wWQ+0Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790161733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15etnfge3RH4WzrrdTOqRW6SLO7dCu+fPTpgpuTOoNo=;
 b=YyAf4IbcoQWeKyfWsTFlKlvzzBMz2xIMa7YuzmdY4jP/UDZ9Gdb2zxg6nFvT86ZOg5uOD9
 un7xkW4XFU3q+wUAyTnosF52IH9vW4EdIRFEY5AAsyI6RNx2mYjNitsI50gbjoFAts0H+a
 +9GADG8IjuqBIVt01WgQQka3Kv7V+X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790161733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15etnfge3RH4WzrrdTOqRW6SLO7dCu+fPTpgpuTOoNo=;
 b=oOn8Ukzr6vK2SJwUWHwFDTHar+sAARqhuxAAIOzZ2QAj3KUBFhWsbBAqeGfFDGBlW79wMa
 E7MawQnG7wWQ+0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE2813432;
 Wed, 23 Sep 2026 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zt82HkWzs2qACAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Sep 2026 11:08:53 +0000
Date: Wed, 23 Sep 2026 13:09:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Message-ID: <arOzUt2RLqUSAIpJ@yuki.lan>
References: <20260923054114.105891-1-pvorel@suse.cz>
 <arOVpNvSwS6E_oQl@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arOVpNvSwS6E_oQl@linux.dev>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Stop using libkeyutils
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This patch looks good, but it doesn't apply cleanly with git-am on the
> latest branch. I think you need to rebase it.

It probably depends on the keyctl fixes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
