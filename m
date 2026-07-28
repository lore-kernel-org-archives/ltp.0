Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E99C54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:16:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A375D3E1C4E
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:16:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E96C3E0CDC
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:16:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B4C71400BCF
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:16:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B4317C3AD;
 Tue, 28 Jul 2026 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785244567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAaQXxz/bKtjBiKfq/Lhro3SSp7h8e74jHxwnu2mwcs=;
 b=nxI1RGvEVyXcUmQNI9n2AhCcPRCl7E5c8sCsqnccBmjvdz8OXuRYB3epstUQcOXnm81dE0
 //5mr69mt/reeskiQddY6BRatdUV58WQ7HkLdHSbu+y7cJQ6leOcgp+E9YB5SpQczjA+gT
 5vdbPdMIH47YzBEfKtRlOZCSS7xeIUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785244567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAaQXxz/bKtjBiKfq/Lhro3SSp7h8e74jHxwnu2mwcs=;
 b=fM9EchlHK6Juldhrd2pwF+qs/hA7enZrOFi0wRne6ffC4aEn+g9XwRWbVk56xphxbloinU
 ka3nvxi/znsy2HCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nVc4v5bH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CmqHLzzf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785244563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAaQXxz/bKtjBiKfq/Lhro3SSp7h8e74jHxwnu2mwcs=;
 b=nVc4v5bHE3RnJgtmCM2rsU7131aHZ7KJgALUEjHNsg/djaRIaK3N3x07/T2bckizUnSC6p
 ZOqWhIptTlYArcEYg7YTbTymXsRxy4/9kMHYNGtx+kRAXKUsrllZFi/zJQYZgCot2sKcy/
 DzFWTS87Y2x8lT5zlO8Wuf0kaPR3CLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785244563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LAaQXxz/bKtjBiKfq/Lhro3SSp7h8e74jHxwnu2mwcs=;
 b=CmqHLzzfrMKwbKv63RK0uoP2Swr6fyPC00dhuT/mZlK3f8SWhBSYjd3B0WiGLFdx0Oyky0
 XImeoRoLpfusb5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29481779B3;
 Tue, 28 Jul 2026 13:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2XQ2CZOraGrITQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 13:16:03 +0000
Date: Tue, 28 Jul 2026 15:16:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Brian Grech <bgrech@redhat.com>
Message-ID: <20260728131601.GA1065673@pevik>
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com>
 <20260727082240.GA1010349@pevik>
 <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,suse.cz:replyto,suse.cz:dkim,sourceware.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,list.org:url];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 4B4317C3AD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Brian,

> Hi Petr,

> Happy to contribute!
We are happy to get new contributors :).

> Thank you for letting me know, that is strange. On my system it's
> configured correctly. Digging a little deeper, I think it might be a
> corporate smtp issue.

FYI it's mangled "From:" mail header [1]: "From: Brian Grech via ltp
<ltp@lists.linux.it>". It's probably DMARC + Mailman related.

BTW I thought it should not be on redhat.com side, because Jan Stancek does not
have that problem, but actually he does have that problem as well [3] "From: Jan
Stancek via ltp <ltp@lists.linux.it>". It's just he probably does merge these
patches directly without first downloading them from the mailing list.

Anyway, very minor problem, but it'd be nice to get it fixed. Our list has
setup: from_is_list = no. I suppose this is correct (looking at the docs [4] and
also check other projects setup [5]).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260722212646.2340340-1-bgrech@redhat.com/raw
[2] https://wiki.list.org/DEV/DMARC
[3] https://lore.kernel.org/ltp/08c85cf64d703dfaba31398ab9d9b480488fe338.1747227481.git.jstancek@redhat.com/raw
[4] https://list.org/mailman-admin.txt
[5] https://sourceware.org/pipermail/binutils/2023-October/129852.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
