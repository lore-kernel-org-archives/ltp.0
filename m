Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62BB10F92E9
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 18:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2626F3E5BE2
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 20:28:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0D63CEDD3
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 20:28:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5F421400DD6
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 20:28:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 439205BD35;
 Tue, 31 Mar 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774981682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mruHA0poIBL22QQoqrG+LCF00WHgIenIERQPLirmhc=;
 b=BKqzMq0M9CqdMq3tIXnN0vi2rv87dWQUuN8YrE/hVD3kyQgiqy2RZBDMRb3oSPkSCvLluL
 LHVGrF2Au2w7VfYwQthKzFVierWMgQ+ZugZm3oLpq3XQ6oMzwQJ1DBQb5dGz8xDyaC2Fa0
 76YppdawGybEvzLJXuTNcXEPzgHs85Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774981682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mruHA0poIBL22QQoqrG+LCF00WHgIenIERQPLirmhc=;
 b=CDiDDdcgdGeYvki6wNxs5bRpGwiHqu4TgSVNgs9QntRK0uID2AahhtwCBljp+7eFq88Xlo
 sV9OanACpG+skADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774981682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mruHA0poIBL22QQoqrG+LCF00WHgIenIERQPLirmhc=;
 b=BKqzMq0M9CqdMq3tIXnN0vi2rv87dWQUuN8YrE/hVD3kyQgiqy2RZBDMRb3oSPkSCvLluL
 LHVGrF2Au2w7VfYwQthKzFVierWMgQ+ZugZm3oLpq3XQ6oMzwQJ1DBQb5dGz8xDyaC2Fa0
 76YppdawGybEvzLJXuTNcXEPzgHs85Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774981682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mruHA0poIBL22QQoqrG+LCF00WHgIenIERQPLirmhc=;
 b=CDiDDdcgdGeYvki6wNxs5bRpGwiHqu4TgSVNgs9QntRK0uID2AahhtwCBljp+7eFq88Xlo
 sV9OanACpG+skADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB754A0A2;
 Tue, 31 Mar 2026 18:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xf3PBTISzGnpEgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 31 Mar 2026 18:28:02 +0000
Date: Tue, 31 Mar 2026 20:28:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acwSNTzXaBQZmQmT@yuki.lan>
References: <20260330071554.49304-1-lufei@uniontech.com>
 <20260331015538.53326-1-lufei@uniontech.com>
 <20260331075610.GC5254@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331075610.GC5254@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite ftrace_regression tests with new C API
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
Cc: lufei <lufei@uniontech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	for (i = 0; i < LOOP; i++)
> > +		tst_cmd((const char *[]){"ls", "-l", "/proc", NULL},
> > +			"/dev/null", "/dev/null", 0);
> It should probably be SAFE_CMD().
> 
> @Cyril are we ok with 'ls' as external dependency, or do we want to have test
> to have simple binary helper run as child to not depend on userspace?

Hmm, I guess that even tooling such as rapido[1] have ls in the initrd
so I guess that ls is just going to be there.

[1] https://github.com/rapido-linux/rapido

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
