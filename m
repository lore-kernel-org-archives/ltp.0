Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B291BC982D6
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 15:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 488BD3E7607
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 17:41:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6543E2FB7
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 17:41:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9629A1400E4B
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 17:41:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 499DB21D15
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789659679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFsihZLfmd3OIV9XS5BvnX5OhFpzE4oOZFXGq93Uvz8=;
 b=ZiPueTbzyCMUWlFRNBUDkAhFaWg7LRfApjg7GwAjkPDMC4CB2jKdVbtlLtnT0NRsYd9DAo
 gp6ITDt8J6AGb/BdapCa3b9XkBr+P+RcXMMHHNwpr1vb08j3dxqXgUDOe3JtgLcjleeqXd
 l7+FOq4mGtbXdl6xGupNCbPa1UFRI/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789659679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFsihZLfmd3OIV9XS5BvnX5OhFpzE4oOZFXGq93Uvz8=;
 b=P4mWYinWelhFRrNmLBUp6QXZ7ifGirhkCzKr3uk6QvXL1GoYYMIGsjlS3wvaLOEBoW7z7u
 rFBcmYBmnJPkkkCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789659675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFsihZLfmd3OIV9XS5BvnX5OhFpzE4oOZFXGq93Uvz8=;
 b=cX47bO7ni6Xj7u/kfMfFLuEXRNhu86iJBqDeYZdSqsAFFygzx2UdLtaO+JIsudO94pQDXk
 y8FLc9iZNKi3W9AwDb4qC60OmFhljtGCTZgQMPs8jwtHRUxGSsCKYYHOSYO9CgXvqn4xPa
 7oFnRLZMQH9W7KNDWpZO+LkeeeXk81g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789659675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFsihZLfmd3OIV9XS5BvnX5OhFpzE4oOZFXGq93Uvz8=;
 b=ieQW4COU3bAo9MPUOqy3gsjpwnp9zNIUdPpoMp8CsZ08ZDvCVwZVfp/pJ13mwx31r8SqRo
 Fez601iL380PT6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 062ED134B3
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 15:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NHEBNBoKrGr1VQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 15:41:15 +0000
Date: Thu, 17 Sep 2026 17:41:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Linux Test Project <ltp@lists.linux.it>
Message-ID: <aqwKIiTAtTvsmQD5@yuki.lan>
References: <ap6fQ11ieRK5FCjk@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ap6fQ11ieRK5FCjk@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Hi!
As we are nearing the release my plan is to finish review of the
keyctl() patchset tomorrow, it looks in good enough shape to be merged
before the release with a few minor fixes.

After that I would like to freeze the git, then we will start the
pre-release testing and continue working on the few fixes that are in
the queue.

The release should happen as usuall on the 30th of September.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
