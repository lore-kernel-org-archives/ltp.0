Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF6E98FB6
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 06:14:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D833E2989
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:14:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C06C3E2970
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 08:13:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 694911000524
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 08:13:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2845BCE6;
 Thu,  9 Apr 2026 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775715233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GcTBX0Yad+SCC7SHDfvHzq5VEYInnZ2aQIFV8mcoOw=;
 b=AJmCCxpetBu2Fj8j//GpTYbK+GZ6VFPHAawrLx9NtCcx+nhA2t3DTnoXNWuubsVBL6eoom
 NBfShkNL65RMZ/+oqp2Z4w39ItVem3N8v6lnj9J+OJI6UQjRoCLYph0LgCE8hkKKiafj1N
 kbKLbjJhWpEOZEuc0UK1Zg5jP4fclHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775715233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GcTBX0Yad+SCC7SHDfvHzq5VEYInnZ2aQIFV8mcoOw=;
 b=P5/59UQGZV1mwD8wNgk5dy0Bn1yBwu3ibxaKeBy78ARUKJCyT+7xhxVs7fTykeIxo0mYUk
 2Sym/35X6PG1bmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775715233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GcTBX0Yad+SCC7SHDfvHzq5VEYInnZ2aQIFV8mcoOw=;
 b=AJmCCxpetBu2Fj8j//GpTYbK+GZ6VFPHAawrLx9NtCcx+nhA2t3DTnoXNWuubsVBL6eoom
 NBfShkNL65RMZ/+oqp2Z4w39ItVem3N8v6lnj9J+OJI6UQjRoCLYph0LgCE8hkKKiafj1N
 kbKLbjJhWpEOZEuc0UK1Zg5jP4fclHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775715233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GcTBX0Yad+SCC7SHDfvHzq5VEYInnZ2aQIFV8mcoOw=;
 b=P5/59UQGZV1mwD8wNgk5dy0Bn1yBwu3ibxaKeBy78ARUKJCyT+7xhxVs7fTykeIxo0mYUk
 2Sym/35X6PG1bmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 556B64A0B3;
 Thu,  9 Apr 2026 06:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id phZ0E6FD12n5BgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Apr 2026 06:13:53 +0000
Date: Thu, 9 Apr 2026 08:13:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260409061347.GA64002@pevik>
References: <20260402200431.157875-1-pvorel@suse.cz>
 <ac8f0MPErGdZzDNe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac8f0MPErGdZzDNe@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[vmcp_m.sh:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Remove s390x test
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
Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Elif Aslan <elas@linux.vnet.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> On Thu, Apr 02, 2026 at 10:04:31PM +0200, Petr Vorel wrote:
> > vmcp_m.sh is a pure user space test (out of LTP scope). While test
> > claims testing vmcp tool and module IMHO it's mainly testing vmcp basic
> > usage (-h, -v), exit codes on error. The only real use is 'vmcp q dasd'.

> > s390-tools maintainers confirmed they have internal CI and are working
> > on to be part of s390-tools on GitHub [1]. Another reason to remove.

> > Remove also runtest/s390x_tests, which contained only this test.

> Agreed.
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks for your ack, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
