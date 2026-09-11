Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0A7C88E42
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 06:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C14E3E2E81
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:44:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF8613C99FC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:44:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BCFA1000600
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:44:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70C1721CB0;
 Fri, 11 Sep 2026 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789109049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQ+WDQmoYis0/wnhiEwYLHm/paq8mll5e3DqdK6lyVc=;
 b=YytnAyoSJFksRnB5fjdeBkD6rW8pJITqX3f1qBYnhMh7355UWUPV2tgh2NCPwHk6eVwkMO
 sV2SovMIlvJnaAOkKGK0foD+wCcMvS+oG/+Pbizs0LFHmeempA5ocNf1FpVdEbUbuLuHb/
 R43WybumlqsJa2KZZJoX7bIURHvRdJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789109049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQ+WDQmoYis0/wnhiEwYLHm/paq8mll5e3DqdK6lyVc=;
 b=hKSyJ/vepgxWtg7WPhhZ/iv+AiA25BY/BWzapDAAwBFQlFMksRjKpc4FZhqtH1A+SiL1aN
 yq1gz8qFOrBnD+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789109045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQ+WDQmoYis0/wnhiEwYLHm/paq8mll5e3DqdK6lyVc=;
 b=LTGhiTrK5/AkE9U/FnTVwDFrC8/I3nyKvTyEFJM9OpeWXLa8dsRPSjoZ1Oa7e70WJ4wC5g
 VqivWAJLKXeEufLuIiOwIQVmwAY1puerIgBmo+BJ1Au9ad7O7EAWwT+duYH3xaDwaVkUBx
 xX7diHJjV1Rc0ZNcIvZ79U5cALn58TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789109045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQ+WDQmoYis0/wnhiEwYLHm/paq8mll5e3DqdK6lyVc=;
 b=EQQ/0xYvyPiCI6lHclhu95Jhsb98oCEneN1Ny8E78RMxy5pD3/yFN9QSnUW3iLJ3ZJoWIa
 WJTW+oTP1PQuDQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3178313715;
 Fri, 11 Sep 2026 06:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yeYKDDWjo2oJHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 06:44:05 +0000
Date: Fri, 11 Sep 2026 08:44:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqOjPy8_kB0VlHIg@yuki.lan>
References: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
 <6aa3a2b4.be490abf.30a09d.d9f7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aa3a2b4.be490abf.30a09d.d9f7@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +
> > +	if (tst_kvercmp(v1, v2, v3) < 0)
> > +		tst_brk(TWARN, "Kernel is older than minimal supported %s", TST_MIN_KVER);
> > +}
> 
> @Cyril @Petr I'm wondering if this should be tst_res(TWARN, ..) instead.

Sorry missed that, yes, that was the point I was trying to make, that
this shouldn't exit the test. Only produce a message.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
