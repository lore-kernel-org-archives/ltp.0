Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB875CA1002
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 10:07:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8573CD434
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 12:07:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64A3F3CD3E9
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:07:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9564F6007AE
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:07:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 357A0343CA;
 Thu,  4 Sep 2025 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756980455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtY3+5iC2yLf8AeJID5Pahd2H4DYU9oikKUZHw4/ADQ=;
 b=mWjFvDIRRJB/YyipWd0MhcemRMOD8GDKgY3bo+gXCLyyv/d+YpUr1YL21dGC5hrylX2xUi
 Rj/Eoxm37XF25+xaNnhzcyrpM+PK5ypT38HRMT7yVro06ufj46WbvfD5u4ATrR2oqiubrs
 r1oi9Uw+ILTUmbzL1ah7GdBH/JnvPe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756980455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtY3+5iC2yLf8AeJID5Pahd2H4DYU9oikKUZHw4/ADQ=;
 b=KXGVU/NuDTF+VMLYfL0H61EpLbjc/JMrX6ZT7xLW+3XVhbrlL1N8NnwY6jPT8vyCG7H5zH
 IA6ukf922qRVYICA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mWjFvDIR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KXGVU/Nu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756980455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtY3+5iC2yLf8AeJID5Pahd2H4DYU9oikKUZHw4/ADQ=;
 b=mWjFvDIRRJB/YyipWd0MhcemRMOD8GDKgY3bo+gXCLyyv/d+YpUr1YL21dGC5hrylX2xUi
 Rj/Eoxm37XF25+xaNnhzcyrpM+PK5ypT38HRMT7yVro06ufj46WbvfD5u4ATrR2oqiubrs
 r1oi9Uw+ILTUmbzL1ah7GdBH/JnvPe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756980455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtY3+5iC2yLf8AeJID5Pahd2H4DYU9oikKUZHw4/ADQ=;
 b=KXGVU/NuDTF+VMLYfL0H61EpLbjc/JMrX6ZT7xLW+3XVhbrlL1N8NnwY6jPT8vyCG7H5zH
 IA6ukf922qRVYICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FAED13AA0;
 Thu,  4 Sep 2025 10:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id esdABudkuWgoKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Sep 2025 10:07:35 +0000
Date: Thu, 4 Sep 2025 12:08:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aLllCF-dioIEJftH@yuki.lan>
References: <20250904064126.125661-1-liwang@redhat.com>
 <20250904094842.GA52619@pevik> <aLlhv1HDEXGENba1@yuki.lan>
 <CAEemH2ecch7oK5RMCGx-Dagw3=FUa3PDA69GJpjkw+zvEtxy_w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ecch7oK5RMCGx-Dagw3=FUa3PDA69GJpjkw+zvEtxy_w@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 357A0343CA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: synchronize with kickoff flag to
 reduce skew
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
> > No Cyril wasn't wrong. The realtime schedulling priorities in kernel are
> > completely different thing from realtime kernel patchset.
> >
> 
> Yes, we can set up processes with SCHED_FIFO or SCHED_RR policies
> on the stock kernel, but it's not the same thing as the PREEMPT_RT kernel.

Honestly it is, the difference with PREEMT_RT is that the scheduller is
more aggressive, which probably explains why things settle down into a
steady state faster after the barrier.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
