Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472CAC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 12:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A0ED3E5DBF
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:16:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EAFF3DFABE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:16:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA04E200B26
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:16:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C1401FEE0;
 Fri, 28 Aug 2026 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787919355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kMpzSUfAD/TUheciOc/0CNx8EJes1yTLmnw2Uf4JAw=;
 b=gn2cqqNN4kRPTgCjrmQyLdkWvyNkvp8m5wzUUcAwwTdhvLhiKTvzZORrt+G7Jdh9HTvK+V
 U0CjCktHXEPgn+og+48YFsz+XzwkndZtw48Ek4cjv9PT0SvMZqaKsYKYLudorfACeegzOE
 kyF2s9i0ru5ufYp7X6vTtVNXPnZ0OQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787919355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kMpzSUfAD/TUheciOc/0CNx8EJes1yTLmnw2Uf4JAw=;
 b=X8z0eoWoeKpnkrpx7oHGNrYZ0pVLym2OMDkdYeaN48PqOymPcUmj9IMrsxYXAMIr0VMPwv
 vp2doGVcpaY3GtCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sFZWBKhR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Jij+fC/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787919351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kMpzSUfAD/TUheciOc/0CNx8EJes1yTLmnw2Uf4JAw=;
 b=sFZWBKhROmAHSmYDNtKTrEksA7fwvjUDWGjC4sX64wbwPwbUevheGf4CG+x8wtAdGjkm6S
 LKc6WfUd60tO3V4jeEIOye/pehwHKn6+4etcXI5j8zEJsUzNHOB1ESnKAozZf1CMk++QUS
 jTJS3TduJomBItkv5t5NQpPGXo+Q0ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787919351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kMpzSUfAD/TUheciOc/0CNx8EJes1yTLmnw2Uf4JAw=;
 b=Jij+fC/ccbUu4Wka8ZPml2uFOPuc4ZwsdMucmEu5FzId7AyR3uBPcffp+INMZdlA63uPNy
 9v7yp2o1819itrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D3EA13515;
 Fri, 28 Aug 2026 12:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N1CoGvd7kWrkJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Aug 2026 12:15:51 +0000
Date: Fri, 28 Aug 2026 14:15:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <apF7_VcBfoEMHqrz@yuki.lan>
References: <6a7af65a.24f60c78.2beb43.4fda@mx.google.com>
 <20260812074413.3159992-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260812074413.3159992-1-wakel@google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9C1401FEE0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] controllers/cpuacct: Dynamically adjust
 cpuacct_task execution time
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
> The test helper cpuacct_task currently runs for 10ms (virtual time)
> before exiting. On some systems (e.g. fast virtual machines or under
> heavy load), this short duration can lead to 0 usage being recorded in
> cpuacct.usage cgroup file due to timing resolution or scheduling delay,
> especially when running small configurations like cpuacct_1_1.

I was starting at the test for a while and I do not see how this could
happen.

The test uses ITMER_VIRTUAL which is counts user CPU time, so the kernel
guarantees that the loop would consume CPU for 10ms, regardless of the
CPU speed.

At the same time the cpuacct.sh script waits for all the processes
before it checks the usage counters. So under heavy load the test should
run longer but shouldn't fail.

All in all it should be guaranteed that the usage should be >= 10ms.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
