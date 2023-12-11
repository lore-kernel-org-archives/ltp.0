Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B682C4332F
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 21:02:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60F5B3CF82E
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 22:02:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15A0F3CB7D9
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 22:02:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26C601400BE5
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 22:02:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4B12242F;
 Mon, 11 Dec 2023 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702328564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXkR5J+foOmTz+A5fdxnRlxoAReC92K6Pj4M6IrkSd0=;
 b=1oWzQd6JBmadmCIHmYsf99yJ4WdbqERESV8M1fZe4PrFJW+Df85AAHCDx6jFu5BFtvGrQy
 OMynAclKZafkYzAYj2BxhqNSy7Eh3JPsXWV20FskpXKn8jNiAEgdfnH94dnQj7wc/gnkg5
 /QOm1NdcHn9QytmVzkt+WsHN02xpoqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702328564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXkR5J+foOmTz+A5fdxnRlxoAReC92K6Pj4M6IrkSd0=;
 b=h7hG+rki6yE5WiKMK2v324ev4yMSOj2a5EFAnBDXcvY2hSwcpNGJU7OH6wV+HdGXsi01qb
 18DhhDRGVVoqOCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702328564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXkR5J+foOmTz+A5fdxnRlxoAReC92K6Pj4M6IrkSd0=;
 b=1oWzQd6JBmadmCIHmYsf99yJ4WdbqERESV8M1fZe4PrFJW+Df85AAHCDx6jFu5BFtvGrQy
 OMynAclKZafkYzAYj2BxhqNSy7Eh3JPsXWV20FskpXKn8jNiAEgdfnH94dnQj7wc/gnkg5
 /QOm1NdcHn9QytmVzkt+WsHN02xpoqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702328564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXkR5J+foOmTz+A5fdxnRlxoAReC92K6Pj4M6IrkSd0=;
 b=h7hG+rki6yE5WiKMK2v324ev4yMSOj2a5EFAnBDXcvY2hSwcpNGJU7OH6wV+HdGXsi01qb
 18DhhDRGVVoqOCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0926E133DE;
 Mon, 11 Dec 2023 21:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FTIRAfR4d2WdIwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 11 Dec 2023 21:02:44 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Dec 2023 22:02:43 +0100
Message-ID: <2718045.mvXUDI8C0e@localhost>
Organization: SUSE
In-Reply-To: <20231031132756.12799-1-chrubis@suse.cz>
References: <20231031132756.12799-1-chrubis@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1oWzQd6J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h7hG+rki;
 dmarc=pass (policy=none) header.from=suse.de;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of akumar@suse.de)
 smtp.mailfrom=akumar@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-8.10 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 DMARC_POLICY_ALLOW(0.00)[suse.de,none]; MX_GOOD(-0.01)[];
 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[];
 BAYES_HAM(-0.09)[64.93%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 WHITELIST_DMARC(-7.00)[suse.de:D:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 1C4B12242F
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_rr_get_interval: Convert to
 docparse
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

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>


--
Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
