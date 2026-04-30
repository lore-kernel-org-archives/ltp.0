Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B984FF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 18:41:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460D53E6C9A
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 20:41:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25413E1BEC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 20:40:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22786140127D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 20:40:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C64E15BD7B
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777574441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCe+2gs+5hWPlCtQ3DZHj/dvqzndqf6Pui4OQ3Abelc=;
 b=rKjO1NXCwxa3XZXfrbzZgWtgsQ6c92BKCW0uCz/6wZOA/iPQEacC6MyW5vDhmesYIgFhGY
 hoM4hFz0Y66e9tgCdsBQGHM6XsAJtVXgA/wd86g9L2MMh/aTR07Z2qw+WRaQ7vOIbuBh46
 IXUaZtzpH3SfiXXE4E29RosBRJ2nIfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777574441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCe+2gs+5hWPlCtQ3DZHj/dvqzndqf6Pui4OQ3Abelc=;
 b=aEn7+V2/VOxiEUiNvvgdJ7+6kqcDIZQ7mKKG1ormx/c520vGEW5qQ/MI5zzmrid5j9IYFN
 daMsiKNZ20l0jqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777574441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCe+2gs+5hWPlCtQ3DZHj/dvqzndqf6Pui4OQ3Abelc=;
 b=rKjO1NXCwxa3XZXfrbzZgWtgsQ6c92BKCW0uCz/6wZOA/iPQEacC6MyW5vDhmesYIgFhGY
 hoM4hFz0Y66e9tgCdsBQGHM6XsAJtVXgA/wd86g9L2MMh/aTR07Z2qw+WRaQ7vOIbuBh46
 IXUaZtzpH3SfiXXE4E29RosBRJ2nIfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777574441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCe+2gs+5hWPlCtQ3DZHj/dvqzndqf6Pui4OQ3Abelc=;
 b=aEn7+V2/VOxiEUiNvvgdJ7+6kqcDIZQ7mKKG1ormx/c520vGEW5qQ/MI5zzmrid5j9IYFN
 daMsiKNZ20l0jqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B198F593B0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 18:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X4+hKSmi82ncaAAAD6G6ig
 (envelope-from <rbranco@suse.de>)
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 18:40:41 +0000
Message-ID: <7181353a-14cb-4ded-9120-557f55f3d0f1@suse.de>
Date: Thu, 30 Apr 2026 20:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <afNbfCcv83zeMsgZ@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <afNbfCcv83zeMsgZ@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 4/30/26 3:39 PM, Cyril Hrubis wrote:
> Hi!
> Given that we have a SUSE Labs konference in the week starting 18. May I
> would like to start LTP May release preparations a bit sooner.
>
> I would like to do the usual patch review that decides what goes into
> the release during the first two weeks of May. Followed by the
> pre-release freeze starting at the 18. May and final release at the end
> of the Month.
>
> If there are any patches that should be considered to be included before
> the release, please reply to this email.
- [LTP] [PATCH] userfaultfd: Use two-step handshake to probe features
- [LTP] [PATCH v3] userfaultfd: Minor fixes

Maybe also:
- [LTP] [PATCH] userfaultfd: Add test using UFFDIO_CONTINUE

Best,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
