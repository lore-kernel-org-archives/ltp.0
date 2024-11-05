Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61118D2C122
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 15:14:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E043D2764
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 16:14:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A152B3D0FB7
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 16:13:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 45D08100185E
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 16:13:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA5AB21D1D;
 Tue,  5 Nov 2024 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730819625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9bWgLlJlxRwdley8JsGMuTrxF/Lj+VnxHInrn3fiqE=;
 b=CYaMtWRiLlUNUwxbQh0VF8TXLfVtZ3pg0ubFL2r1defKaFzmkiJVbbYIovFYTgSqWamuZf
 0eDomgU1iQS/Qb93jSpU2SsFjJdvuNUpS5RFKf7zHbmaCbZKa3V+Bc6iakVyM61ltF3DsP
 v/WOo8epxxVwpA6Pvy5Brn0+ehHkJC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730819625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9bWgLlJlxRwdley8JsGMuTrxF/Lj+VnxHInrn3fiqE=;
 b=XCO+z1k3p5qrfavTsVS68Dpo1xNRqP2yY0X3hSQnUIxemebgKCoG1M9oOvsIe/ZpJkMNhD
 E9HraE1Hx2j6XpDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730819624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9bWgLlJlxRwdley8JsGMuTrxF/Lj+VnxHInrn3fiqE=;
 b=AaEjRJgQmQXCgItkWIYFjO43BBnFhDhwwH/szNE70m8O6MOJDcJsdD5oR7UaPBBsYXVKKY
 Km76oqxS9LcA5Er3MWiBwJ86wFn9j1K4J3UPbqnwBRlCTSjAlHOb6KIy20wddgYwFqsm3L
 8YM0KKLBEoDbVz05eOVRfLL0TXijobo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730819624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9bWgLlJlxRwdley8JsGMuTrxF/Lj+VnxHInrn3fiqE=;
 b=Kh/xmIYRvlKC1yJf7CYefSed7DHzoH/QZ7qxXSnwl484o2wTOtNWrucuN0cYAW++2icRnJ
 05bUKApCsR80O0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C98561394A;
 Tue,  5 Nov 2024 15:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5IUAMCg2KmckMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Nov 2024 15:13:44 +0000
Date: Tue, 5 Nov 2024 16:13:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zyo2JHlICIu1jEok@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
 <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
 <a5e05496-76c0-432c-8779-84ab573a8b7d@suse.com>
 <Zyoah1Av6lmabsw0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zyoah1Av6lmabsw0@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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
> And backward compatibility also means that we have to properly handle
> the case when we need newer ABI than currently supported, so the
> verify_landlock_enabled() needs a size parameter so that we can check
> that the ABI is >= than the minimal ABI the test needs...

Looking at verify_landlock_enabled() it does return the ABI already, so
this is covered as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
