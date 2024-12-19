Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C8AE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:19:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7CB3C02D1
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:19:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C544E3C02D1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:19:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CD5A200C88
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:19:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68D6321153;
 Thu, 19 Dec 2024 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imnz34zdEpMsO2TdeU03aJNjQ0sP/rX72aY0qJ4heUA=;
 b=gyHnfinq6KIQP/OhXdmXxTQvHGYwByxYosRa2LJ+ad54y/pLpFLssMLih9HyCGd3Et+M5n
 Jwyd3qG3yTFouz4hca8kHdrHoBs6iixGQTMw2aBaDXnPb1Qo9vqycvysTdZbOIYuk2go4E
 RxIagG6f03PHEVVNZfUD+R8EqaKJKzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imnz34zdEpMsO2TdeU03aJNjQ0sP/rX72aY0qJ4heUA=;
 b=t5IBYa06hp3cn+qgU7mbMEC+wqmDWiQtbZw+mqI77IPt826W7NL6VXzHj3s/zvSCsSUk9J
 tv8qXJ2JpuqCPxCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gyHnfinq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t5IBYa06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imnz34zdEpMsO2TdeU03aJNjQ0sP/rX72aY0qJ4heUA=;
 b=gyHnfinq6KIQP/OhXdmXxTQvHGYwByxYosRa2LJ+ad54y/pLpFLssMLih9HyCGd3Et+M5n
 Jwyd3qG3yTFouz4hca8kHdrHoBs6iixGQTMw2aBaDXnPb1Qo9vqycvysTdZbOIYuk2go4E
 RxIagG6f03PHEVVNZfUD+R8EqaKJKzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imnz34zdEpMsO2TdeU03aJNjQ0sP/rX72aY0qJ4heUA=;
 b=t5IBYa06hp3cn+qgU7mbMEC+wqmDWiQtbZw+mqI77IPt826W7NL6VXzHj3s/zvSCsSUk9J
 tv8qXJ2JpuqCPxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5475613A32;
 Thu, 19 Dec 2024 13:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MPWQE14dZGe3FAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Dec 2024 13:19:26 +0000
Date: Thu, 19 Dec 2024 14:19:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z2QdUCGAhfPZHDtp@yuki.lan>
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <Z2QbRxeekZyxhoCc@yuki.lan>
 <CAEemH2d6_O-JYe1MsDZ4hO5QL+OrDeCESi=GSAYxWVF+1f6J7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d6_O-JYe1MsDZ4hO5QL+OrDeCESi=GSAYxWVF+1f6J7w@mail.gmail.com>
X-Rspamd-Queue-Id: 68D6321153
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
> > Sounds like we need to have two different runtime values in the tests,
> > max_runtime which is the timeout for the test and just runtime which is
> > for how long will the test loop.
> >
> 
> Agree, if we define the looping runtime in a separate value, that would be
> helpful.

There was a problem with having the two different values in a single
variable before as well. We do have the LTP_RUNTIME_MUL which multiplied
both the timeout and runtime. These should be separate multipliers as
well which multiplied both the timeout and runtime. These should be
separate multipliers as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
