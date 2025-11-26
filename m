Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7DD10390
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 09:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 702233CF1A1
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 10:02:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A893CEF6E
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 10:02:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEE00600A47
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 10:02:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D655B5BDF7;
 Wed, 26 Nov 2025 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764147758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
 b=PwzhDNQmxqBMD2AE93VTwTPSaGbmhSYvjBu5KXizIac+obx7HuOuJgdGUHpNJJhRw48kzX
 34uTHnL7UITcljCRYRsEulqGicRfQgPVhS0yZTV5jNuEUC17uzpfOhpFbluPCCgXE72tWK
 oKaZI+Wjg+sUHwHDe/BZ13N1jv9V3gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764147758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
 b=JyhBzehpq7fLNghYkyTuHSU0gE0hiYG17yoneUuv9vTVEeoenZxiANDU+mRhCoUXCQ/9Ik
 2K+mCwxirbQMcGDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dEptsKoL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JhkS8lWa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764147757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
 b=dEptsKoLJjaWA6VymHOdZWDb0Tsp8y3C4m4StoAfQNckIkOTKBNcUVcNgctyyJO+R3/W8y
 Q5aYJOPngHsJ2NfZRibhcJKgXZQFHUQhQ2WW1eFtEMbDVd8sBLgH98Q5JSkKMK9O6WCU5O
 UwFepEdUf5py4rkh7wYsFf9Knb3ASGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764147757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
 b=JhkS8lWa3mOU3avKJ6CBhI6Qi0RrOvCQ0cSArILuVmgAY8V0kyA1nYGwa6qfWLQHNBAa16
 bro4TGOB5gMP6hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C628B3EA63;
 Wed, 26 Nov 2025 09:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hbF2Ly3CJmlmeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Nov 2025 09:02:37 +0000
Date: Wed, 26 Nov 2025 10:03:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Oliver Sang <oliver.sang@intel.com>
Message-ID: <aSbCY9flDrZGC5NC@yuki.lan>
References: <202511251654.9c415e9b-lkp@intel.com> <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
X-Rspamd-Queue-Id: D655B5BDF7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [sysctl] 50b496351d: ltp.proc01.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>, oe-lkp@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I attached one results.json FYI.

Looks like the test is getting unexpected EINVAL when reading from files
from /proc/sys/net/ipv4/neigh/default/ and
/proc/sys/net/ipv6/neigh/default/ directories.

> it need some code change to upload it to download directory, we will consider
> to implement it in the future. thanks

Please do so, without the logs it's much harder to debug the problems.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
