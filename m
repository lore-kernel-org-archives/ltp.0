Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138C7E6B24D
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 12:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC003CD439
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 13:11:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65813CD3F0
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 13:11:30 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 611531BC7989
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 13:11:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC1A31FBAB;
 Fri,  1 Nov 2024 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730463087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABYUvh2dRkUp9rLUTTbjUKCWWOcYEw0Klf0KJo/ABLQ=;
 b=VXtlWyqRwt6kmudFFeDTRJVIkwIY10IA1YbKhLP9Kh+k0MySZKXTE4M4hBbuioLv9GnnJp
 ds/Zc5H1WOxd0NpYKQG6XhNhDDCCuhDS4F/+fdY11wx1j12WRYxMz/F273NVRAMUgg9eB2
 CFz8QuojBU3S2saaZF1TJKib5QrNfq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730463087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABYUvh2dRkUp9rLUTTbjUKCWWOcYEw0Klf0KJo/ABLQ=;
 b=4aB4Qe840w0AbjIfIFjy9jMfeIc+UBwnpxDVg7la0m+g2ta2xqttyLgT+tMHbIO/58bRHG
 Bae3lXMmAdyLT+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730463087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABYUvh2dRkUp9rLUTTbjUKCWWOcYEw0Klf0KJo/ABLQ=;
 b=VXtlWyqRwt6kmudFFeDTRJVIkwIY10IA1YbKhLP9Kh+k0MySZKXTE4M4hBbuioLv9GnnJp
 ds/Zc5H1WOxd0NpYKQG6XhNhDDCCuhDS4F/+fdY11wx1j12WRYxMz/F273NVRAMUgg9eB2
 CFz8QuojBU3S2saaZF1TJKib5QrNfq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730463087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABYUvh2dRkUp9rLUTTbjUKCWWOcYEw0Klf0KJo/ABLQ=;
 b=4aB4Qe840w0AbjIfIFjy9jMfeIc+UBwnpxDVg7la0m+g2ta2xqttyLgT+tMHbIO/58bRHG
 Bae3lXMmAdyLT+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8CF513722;
 Fri,  1 Nov 2024 12:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pk/NLG/FJGctZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 01 Nov 2024 12:11:27 +0000
Date: Fri, 1 Nov 2024 13:11:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyTFZaAlrtNLkUow@yuki.lan>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik> <Zw-15cE2R0_5FOmJ@yuki.lan>
 <66c4cb2a-14de-4967-9c86-843759087dc5@suse.cz>
 <20241016211513.GA104519@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241016211513.GA104519@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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
> Back to ftp01.sh (file modified in this patch). It tests downloading and
> uploading with FTP protocol. It looks to me more as FTP client/server test than
> anything else (it's not a stress test). IMHO not relevant for LTP.

Fair enough, ftp01.sh really looks like a ftp server unit test, that is
something that is out of scope for LTP. So I do agree with ftp01.sh
removal.

And the ftp stress tests these should be replaced with a generic TCP
stress test later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
