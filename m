Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E03DC02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 09:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006203C91F8
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:39:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ACDB3C7AFA
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 10:39:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4BC7204A41
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 10:39:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A80A11F458;
 Wed,  5 Feb 2025 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738748360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FQ7xxv83lw8P59vVv3CfuvAGhyghM58t8THFWgZzok=;
 b=FU+lVjUIWqfIWvgrkniU7+RcENbbGujfHhAcvKMk0vdAXQ0U3FCQ9bdFAzKyNZIg6loqMy
 enbAffC09TId50FOChKnqpY2YjztC64DIh6Hi9Ks5m8TT8Bg3JDsYOTLgnO7ndZXRUEmdS
 6EurVGMRlKLRRlgGBvspSCya5qy00gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738748360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FQ7xxv83lw8P59vVv3CfuvAGhyghM58t8THFWgZzok=;
 b=YqcQmn4UGMkyHfZUHCVS9N+9CjD3AEKReNHNuXnmzYdXg5vZ2f9X5Ikvb6zBCbvzlN8u1k
 bJg/hdGPBe1ThnDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FU+lVjUI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YqcQmn4U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738748360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FQ7xxv83lw8P59vVv3CfuvAGhyghM58t8THFWgZzok=;
 b=FU+lVjUIWqfIWvgrkniU7+RcENbbGujfHhAcvKMk0vdAXQ0U3FCQ9bdFAzKyNZIg6loqMy
 enbAffC09TId50FOChKnqpY2YjztC64DIh6Hi9Ks5m8TT8Bg3JDsYOTLgnO7ndZXRUEmdS
 6EurVGMRlKLRRlgGBvspSCya5qy00gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738748360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FQ7xxv83lw8P59vVv3CfuvAGhyghM58t8THFWgZzok=;
 b=YqcQmn4UGMkyHfZUHCVS9N+9CjD3AEKReNHNuXnmzYdXg5vZ2f9X5Ikvb6zBCbvzlN8u1k
 bJg/hdGPBe1ThnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79067139D8;
 Wed,  5 Feb 2025 09:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mn/ZGsgxo2f+MgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 09:39:20 +0000
Date: Wed, 5 Feb 2025 10:39:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250205093918.GB1473026@pevik>
References: <20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com>
 <99e715d2-d30c-4bee-bd0a-30ab6929e58d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99e715d2-d30c-4bee-bd0a-30ab6929e58d@suse.com>
X-Rspamd-Queue-Id: A80A11F458
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: add tests catalog page
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

first, thanks for doing the migration.
I haven't checked whether all necessary keys are shown (will do).

It would be nice, if the keys (e.g. mount_device) were references, then user can
click to the documentation.

I'm also thinking that splitting tests by alphabet would help to have shorter
page + not that long list of the tests on the left side. But for searching it's
better to have all tests on a single page. WDYT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
