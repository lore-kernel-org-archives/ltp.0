Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62291125823
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 13:52:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A213E2BAF
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 14:52:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFF43CCB72
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 14:51:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F2876001EA
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 14:51:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A5D85BD57;
 Wed, 11 Mar 2026 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773237101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMFD3bfGOkPNQjVPYfp1lPdWuWspnZN2l2Qan+AUdbk=;
 b=hy4mrtbhm+6lNIdrqtzB9B3eWZqL2L01ns9lYRgtQDHGEbqzHB6Rb3AhuDfwNk+mAgnZX/
 iABqMQb1dqNcxV1iMuCZfXJ46pjASiJQ+awFokEz6hPeZMXT4N1Ibu4rNbDaDBgBQQ7/ds
 54zJmr2CmauwyUZENQ25Gw4KrLrFW1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773237101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMFD3bfGOkPNQjVPYfp1lPdWuWspnZN2l2Qan+AUdbk=;
 b=NVGiglarIN6FeFPl1LM9t4B9rnOZNqTk7x78AlnSYA3LgbLAMIliBUcS8QMpOXwWfKH7Sg
 iAYjpsOyBPCQYpCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773237101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMFD3bfGOkPNQjVPYfp1lPdWuWspnZN2l2Qan+AUdbk=;
 b=hy4mrtbhm+6lNIdrqtzB9B3eWZqL2L01ns9lYRgtQDHGEbqzHB6Rb3AhuDfwNk+mAgnZX/
 iABqMQb1dqNcxV1iMuCZfXJ46pjASiJQ+awFokEz6hPeZMXT4N1Ibu4rNbDaDBgBQQ7/ds
 54zJmr2CmauwyUZENQ25Gw4KrLrFW1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773237101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMFD3bfGOkPNQjVPYfp1lPdWuWspnZN2l2Qan+AUdbk=;
 b=NVGiglarIN6FeFPl1LM9t4B9rnOZNqTk7x78AlnSYA3LgbLAMIliBUcS8QMpOXwWfKH7Sg
 iAYjpsOyBPCQYpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF39C3FA4E;
 Wed, 11 Mar 2026 13:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PObMGxzsWkCcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Mar 2026 13:51:40 +0000
Date: Wed, 11 Mar 2026 14:51:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260311135139.GA103831@pevik>
References: <69b16303.050a0220.27d4f3.6151@mx.google.com>
 <69b16378.050a0220.e24c3.cee0@mx.google.com>
 <abFrW5DJSJAeG8EE@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abFrW5DJSJAeG8EE@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
Cc: Cyril Hrubis <notifications@github.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Can we go for Monday the 16th at 9:00 UTC?

> ACK.

OK for me as well.

@Andrea could yo please create calendar event for us (suse.com address for me
please).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
