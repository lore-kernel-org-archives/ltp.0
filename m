Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C1606A323
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B2bGdcOa;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LE2h0Dw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B2bGdcOa;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LE2h0Dw
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26AFC3EAC93
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 16:36:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE6453E1253
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:36:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 528326008F1
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 16:36:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33EF821EB0;
 Tue, 10 Nov 2026 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794324980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWP5bXDXwPNWH/zX1jgZKKO3pQ4QvUS1WateF0GjRcA=;
 b=B2bGdcOaxdgi6WlGGvrzzgn26hchCAl3xg4ASgZ7NI0i5LW7gndp66xzqpfyh68G8yz3xd
 GGrukXrVqYyRn1w84YWlGHDCrAeRjrIbr0uqTMNUmWCV4OLwlDQwcgu5rGbjPRUen7LiRl
 uTGT3Zrm9LqfT6rWDQgHv+2C++prrH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794324980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWP5bXDXwPNWH/zX1jgZKKO3pQ4QvUS1WateF0GjRcA=;
 b=0LE2h0DwuFsdlP5+15dENQ42VWz+qZAW6Ua5ps+9xZt5e1PUVpHipAjdEIOGZGuGnUgGwM
 InknUUaZeK+9u1Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794324980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWP5bXDXwPNWH/zX1jgZKKO3pQ4QvUS1WateF0GjRcA=;
 b=B2bGdcOaxdgi6WlGGvrzzgn26hchCAl3xg4ASgZ7NI0i5LW7gndp66xzqpfyh68G8yz3xd
 GGrukXrVqYyRn1w84YWlGHDCrAeRjrIbr0uqTMNUmWCV4OLwlDQwcgu5rGbjPRUen7LiRl
 uTGT3Zrm9LqfT6rWDQgHv+2C++prrH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794324980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWP5bXDXwPNWH/zX1jgZKKO3pQ4QvUS1WateF0GjRcA=;
 b=0LE2h0DwuFsdlP5+15dENQ42VWz+qZAW6Ua5ps+9xZt5e1PUVpHipAjdEIOGZGuGnUgGwM
 InknUUaZeK+9u1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 053FA13479;
 Tue, 10 Nov 2026 15:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pFCENfM582oSagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Nov 2026 15:36:20 +0000
Date: Tue, 10 Nov 2026 16:36:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20261110153618.GA707028@pevik>
References: <20261110152531.382231-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261110152531.382231-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve/ghostlock.c: Print return value and attempt
 in TBROK message
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> The check after FUTEX_CMP_REQUEUE_PI breaks if the call did not fail
> with EDEADLK, but the message only said "did not return -EDEADLK" and
> TTERRNO appended errno, which is 0 when the call succeeds. The resulting
> "SUCCESS (0)" reads like a return value of 0 and hides what the call
> actually returned.

> ghostlock.c:243: TBROK: FUTEX_CMP_REQUEUE_PI did not return -EDEADLK: SUCCESS (0)

> Print TST_RET and the attempt number, so a TBROK here shows right away
> whether the call succeeded (and how many waiters it moved) or failed
> with another errno, and on which attempt it happened.

Make sense, merged.
Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
