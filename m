Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EEED6ACF0
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 11:48:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB953D04B9
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:48:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A37A3CAA5A
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:47:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D20671400B6C
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:47:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4F35BD9A;
 Thu, 18 Dec 2025 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766058464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
 b=tDhRxNAMutZeRSaqtmrfIRLfKLvsXAai3lDXV2pboCNxYfJF5UNnihH5SpfeHk1TidtZ4c
 JJjct2EKf8TGG0h4/cWCK+ChXh/YkneWIqT+mAmBN7d8QHJsbZ3zi1QAYT1tmACOelX6Ed
 Q6LwQ9PgDWi+7batTY6i6aDTDX8olKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766058464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
 b=SOyn5zC0UuFFKiiC6IRTtxO85VIC8nlYYHjHjr38yOFH75PL3HD+X7cNzaIi7MGTlLW5AK
 vy0KkTdleIqDbDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766058463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
 b=jzgUfpO7N+LXL3v8jNUv4Hovqogb6PNjQeCtsDvWBBajt2lbkDYuRjPOeAeSKPsgahNAa5
 fgLeDGKeD1VPHl8zcBvkDBc9JZ9066nstKl02T/t/o9aVNHE6Gat2TNg2kAndglUyWNTCX
 eXebNAh4U9c18QUgMfFXlK+E0kD6SUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766058463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
 b=n88zK61jWF2tjVLUCU64eYUivR/bX8Jw1Sp1txM5DD7Kg9gXndamlMWaHvtLs0gusmm/+Y
 7cpGJdmH1PgqHpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8DD3EA63;
 Thu, 18 Dec 2025 11:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BB84MN7pQ2k8agAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Dec 2025 11:47:42 +0000
Date: Thu, 18 Dec 2025 12:47:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251218114733.GA98183@pevik>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-3-pvorel@suse.cz> <aULQlhbHltLTbdG4@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aULQlhbHltLTbdG4@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] tst_test.sh: Add TST_USR_{G, U}ID variables
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Add TST_USR_{G,U}ID variables with the default values from tst_runas.c.

> > These can be used as a default values for tests which use tst_runas and
> > need to know UID/GID for other commands.

> > It will be used in LTP IMA tests.

...
> > +# see testcases/lib/tst_runas.c
> > +export TST_USR_UID="${LTP_USR_UID:-65534}"
> > +export TST_USR_GID="${LTP_USR_GID:-65534}"

> Do we need this? We already have the default values in the C code...

I've merged the patch without notice this, therefore just to clarify.
I hoped I was clear in the commit message, obviously not.
Yes, just for a record you find the answer in the next patch:
https://lore.kernel.org/ltp/aULUsVxLIXFM19IV@yuki.lan/

So I hope everything is OK.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
