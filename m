Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84109C10F1A
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 13:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07B093CFFA8
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 15:52:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1963CFB67
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:52:29 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 00267204716
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:52:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9A0F5FFDE;
 Tue, 23 Apr 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713880348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
 b=rYatyu05UZ5WqfVfLxuNOAWMy4W+PCssPHr/5n3oIhVfFL64DgPd0Ay5HoUsqmLklmASk0
 8OoIuI8PnoWMfndsKm+RSUwVdQepQ49bCZ8MsoVBChreIEihIkL+k7BkuVrC0WLyJcDv/2
 PYh1rQcPsG4G/8bH57kDhgo00wpDexw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713880348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
 b=kf/COY7lXjOGh1SP1uOSoH0J1Gjot3A704KY9ffiUAs2Q9LT1OtQP/LLG8z1DQ/KUbcggf
 k+kB89sdmk6QyhBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3J4H+zWP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mIJh+WXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713880346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
 b=3J4H+zWPsS0SxnmdTAdUwVpRt8QPEJyJ3CMqNJgNI9RTJl+zewqgIwzP0gHnvwZ/Ber77Q
 DjASXm6+Bth5b2VEPuO60a++OL/FD0xz5gMhozkpx3TvLat9EZZ8GZUzaei6kCoXPaeQbc
 LeWLXi8D2X69TJy6tz6Rwhn3J4zHpsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713880346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
 b=mIJh+WXZjqUkXb04mduTycZiYg5xS5Z83Im/3aErIrKZzpAtF4UHO+ifGdWuor8OvXfQGn
 sDHMfHO6sAdNH/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BF7013929;
 Tue, 23 Apr 2024 13:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1BinHRq9J2aecAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 13:52:26 +0000
Date: Tue, 23 Apr 2024 15:52:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20240423135225.GA195737@pevik>
References: <202403151507.5540b773-oliver.sang@intel.com>
 <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
 <ZfRf36u7CH7bIEZ7@yuki>
 <20240318-fegen-bezaubern-57b0a9c6f78b@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240318-fegen-bezaubern-57b0a9c6f78b@brauner>
X-Spamd-Result: default: False [-3.68 / 50.00]; BAYES_HAM(-2.97)[99.85%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B9A0F5FFDE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
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
Cc: lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> On Fri, Mar 15, 2024 at 03:49:03PM +0100, Cyril Hrubis wrote:
> > Hi!
> > > So I'd just remove that test. It's meaningless for pseudo fses.

> > Wouldn't it make more sense to actually return EINVAL instead of
> > ignoring the request if readahead() is not implemented?

> It would change the return value for a whole bunch of stuff. I'm not
> sure that wouldn't cause regressions but is in any case a question for
> the readahead maintainers. For now I'd just remove that test for pidfds
> imho.

@Matthew, any input on Cyril's question please?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
