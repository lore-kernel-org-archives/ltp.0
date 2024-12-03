Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68064E64A80
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 11:34:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB2423DDEC3
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 12:34:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 794533DDD40
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:34:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 22C431A027C4
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 12:34:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A707D210F7;
 Tue,  3 Dec 2024 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733225662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERYALJtP2cOLlw6k36BBXyM8P8kZ35KmyGrPuFUhTgk=;
 b=WNgW+aX7x8SSRkyNwvmHFapZtGkwL73jYiLVsj9U/YjXz+EfpPlATOkshi0amsNfBGyjfq
 GqEAjbFwu4uJKz1p4NDf9URHp0BhSgrQBmbAXO1RyY1sPzmqbEDwrJp3vzL1i1pk/izIFP
 7vyYwHcMd5LWM3NybhV5DZ0AiQiinQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733225662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERYALJtP2cOLlw6k36BBXyM8P8kZ35KmyGrPuFUhTgk=;
 b=oxg5/8AvGIseUE+HfXuGY/ND5RCv8UvPGUFoCQz7GDTP1yVBm1tEwkZALBgch/lZXKMX2M
 USoLh3kHubiFVCCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WNgW+aX7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="oxg5/8Av"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733225662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERYALJtP2cOLlw6k36BBXyM8P8kZ35KmyGrPuFUhTgk=;
 b=WNgW+aX7x8SSRkyNwvmHFapZtGkwL73jYiLVsj9U/YjXz+EfpPlATOkshi0amsNfBGyjfq
 GqEAjbFwu4uJKz1p4NDf9URHp0BhSgrQBmbAXO1RyY1sPzmqbEDwrJp3vzL1i1pk/izIFP
 7vyYwHcMd5LWM3NybhV5DZ0AiQiinQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733225662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERYALJtP2cOLlw6k36BBXyM8P8kZ35KmyGrPuFUhTgk=;
 b=oxg5/8AvGIseUE+HfXuGY/ND5RCv8UvPGUFoCQz7GDTP1yVBm1tEwkZALBgch/lZXKMX2M
 USoLh3kHubiFVCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95D9F13A15;
 Tue,  3 Dec 2024 11:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CKqhIr7sTmcNeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Dec 2024 11:34:22 +0000
Date: Tue, 3 Dec 2024 12:34:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z07szYg2_To9zNEk@yuki.lan>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
 <20241202-input_refactoring-v2-6-369609492896@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241202-input_refactoring-v2-6-369609492896@suse.com>
X-Rspamd-Queue-Id: A707D210F7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/7] Refactor input06 test
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
> - /*
> -  *  Create a virtual device, activate auto-repeat and
> -  *  and check that auto repeat is working
> -  */
> +/*\
> + * [Description]
> + *
> + * Verify that auto-repeat is working on a virtual device, that in our case
> + * it's a mouse.

This is wrong, the device is a keyboard with a single key, at least that
is what is being constructed in the test setup. The original description
was at least correct...


The rest of the conversion looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
