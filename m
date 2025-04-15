Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5C3C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 13:54:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC19B3CB8F9
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:54:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2B23C2EFD
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:53:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 021DF600C46
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:53:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E7852111F;
 Tue, 15 Apr 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oWE5UWJIkCxqMeNr1myTVLJXefOVnPn4yMcw8mbkOY=;
 b=g3VwQ7lNXSxyPo2FL5ZQe4JWBTTYS3mAzmhxbzY0vkg6+spIshpCnnF6/9E+ZjCEhRH5hV
 P1iMDSwKYe7VLcq5fmA0oLd2whRO+Paduc4jSvA2+ESMUxTEj65HtXFaa5LKCQMbXNynuo
 9y6JQfKGzbdHzch3qd5xepjCNreYp64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oWE5UWJIkCxqMeNr1myTVLJXefOVnPn4yMcw8mbkOY=;
 b=z3a4gEkzyhf4bpwRdcFJmQ6sj0UqadRDNLicQ0h6KCTr2hgTACL+b9nNftPZpWsrotCgyO
 b/1PfvC6S5f1CECw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g3VwQ7lN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z3a4gEkz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oWE5UWJIkCxqMeNr1myTVLJXefOVnPn4yMcw8mbkOY=;
 b=g3VwQ7lNXSxyPo2FL5ZQe4JWBTTYS3mAzmhxbzY0vkg6+spIshpCnnF6/9E+ZjCEhRH5hV
 P1iMDSwKYe7VLcq5fmA0oLd2whRO+Paduc4jSvA2+ESMUxTEj65HtXFaa5LKCQMbXNynuo
 9y6JQfKGzbdHzch3qd5xepjCNreYp64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oWE5UWJIkCxqMeNr1myTVLJXefOVnPn4yMcw8mbkOY=;
 b=z3a4gEkzyhf4bpwRdcFJmQ6sj0UqadRDNLicQ0h6KCTr2hgTACL+b9nNftPZpWsrotCgyO
 b/1PfvC6S5f1CECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58DA213A9F;
 Tue, 15 Apr 2025 13:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9xGNFfJk/mdyLwAAD6G6ig
 (envelope-from <pvorel@suse.de>); Tue, 15 Apr 2025 13:53:54 +0000
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 15:53:54 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
In-Reply-To: <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <9abec7f0f1c75c312a54e6ea5da3f285@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Queue-Id: 5E7852111F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:email, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/4] ci: add ci-patchwork-trigger workflow
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

3rd patch finally got to the mailing list, great :).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

On 2025-04-15 12:00, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Add ci-patchwork-trigger workflow that is meant to run every 30 
> minutes,
> checking for new untested LTP patches in the Mailing List and running
> the ci-docker-build workflow on them.

I guess that's the original message for some previous version. Now it 
runs every 15 min (4x hour) during working days (Mon-Fri) and at 0 and 
45 every hour (2x hour) on weekends.

Thanks for testing github.repository.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
