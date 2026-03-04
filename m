Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998E2EB7EB5
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:31:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F6393DAE56
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 11:31:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C4F3D0722
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:30:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29AE9600B1A
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:30:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FF665BE04;
 Wed,  4 Mar 2026 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772620243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOR+4ZIou24PMiqr9tRYmc0OSkxiPLUKAVQ31i+uaWU=;
 b=KngNHi/h/H5TTtqHKi9EPmYNR8MCVaUHQI2YcxwFrdOPnMSxhyJEJdRSofr8A46CSF/D/n
 iSFkv/MbpZSOCvq5vcOE2N3zPGpJcrB2YgEIp0tYyg/qP8uXUF+8MHegX+Xv/tkIj6bFTl
 K9AXV3lNkJtqxl2uiDG7dYQYJ7u5A6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772620243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOR+4ZIou24PMiqr9tRYmc0OSkxiPLUKAVQ31i+uaWU=;
 b=dUUgGynxwfHFpFSYkAUP5vp0xbU7rRH6NuTs3ZRzbihUHJZpu9HgWjbmsfygsGG2EOvLii
 86wmECZ9Rqo3p/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772620243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOR+4ZIou24PMiqr9tRYmc0OSkxiPLUKAVQ31i+uaWU=;
 b=KngNHi/h/H5TTtqHKi9EPmYNR8MCVaUHQI2YcxwFrdOPnMSxhyJEJdRSofr8A46CSF/D/n
 iSFkv/MbpZSOCvq5vcOE2N3zPGpJcrB2YgEIp0tYyg/qP8uXUF+8MHegX+Xv/tkIj6bFTl
 K9AXV3lNkJtqxl2uiDG7dYQYJ7u5A6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772620243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOR+4ZIou24PMiqr9tRYmc0OSkxiPLUKAVQ31i+uaWU=;
 b=dUUgGynxwfHFpFSYkAUP5vp0xbU7rRH6NuTs3ZRzbihUHJZpu9HgWjbmsfygsGG2EOvLii
 86wmECZ9Rqo3p/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90E253EA6C;
 Wed,  4 Mar 2026 10:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtlXI9MJqGnBDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Mar 2026 10:30:43 +0000
Date: Wed, 4 Mar 2026 11:30:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aagJ3VU0Y80-c2Ll@yuki.lan>
References: <aagEIyMmF04crhk0@yuki.lan>
 <69a80553.050a0220.18a0c1.f1ed@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69a80553.050a0220.18a0c1.f1ed@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Add safe macros for stream testing suite
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
> > Just do not add the cleanup_fn parameter to the new functions 1added
> > there. That's all I ask for here.
> > 
> 
> But their implementations inside safe_stdio.c requires the old test.h
> header. Should I move them somewhere else?

Just pass NULL to the tst_resm() and tst_brkm().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
