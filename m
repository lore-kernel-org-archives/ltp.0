Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C65C021B3
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 11:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15A833C678D
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 12:17:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE283C280D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:17:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 32B4914004EE
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:17:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AABA41F38D;
 Thu, 20 Feb 2025 11:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740050248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRcKELZ/ue9QG1MgZLLVDRq16ysdlTejs4dxKgAKD1g=;
 b=pPn4pkKZfMKiWBUcnh8DJ/UVOp0hSd3ZSOEeVQTOvaiD/1ismi2joZyztQjGkGnU7VuDqQ
 /BZ8pmmE+6weFUCEFvPwD5qh6vW6qTKbqDJe2j3kR95WQ9exDTXIlh4KiAvcVOX6fBuh2l
 WMBGMoJ6tjfaYkHM1KAkPNSw99JQBs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740050248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRcKELZ/ue9QG1MgZLLVDRq16ysdlTejs4dxKgAKD1g=;
 b=a09HYPoMIHeWASflIdpZkojQo+qTRNmaTRDntRGHTD5v/MHP/cOVX382kXJshUHqzGukvH
 xmDbQXi9KRrF6rAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pPn4pkKZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a09HYPoM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740050248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRcKELZ/ue9QG1MgZLLVDRq16ysdlTejs4dxKgAKD1g=;
 b=pPn4pkKZfMKiWBUcnh8DJ/UVOp0hSd3ZSOEeVQTOvaiD/1ismi2joZyztQjGkGnU7VuDqQ
 /BZ8pmmE+6weFUCEFvPwD5qh6vW6qTKbqDJe2j3kR95WQ9exDTXIlh4KiAvcVOX6fBuh2l
 WMBGMoJ6tjfaYkHM1KAkPNSw99JQBs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740050248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRcKELZ/ue9QG1MgZLLVDRq16ysdlTejs4dxKgAKD1g=;
 b=a09HYPoMIHeWASflIdpZkojQo+qTRNmaTRDntRGHTD5v/MHP/cOVX382kXJshUHqzGukvH
 xmDbQXi9KRrF6rAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C3D613A42;
 Thu, 20 Feb 2025 11:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QKfJIEgPt2cOGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Feb 2025 11:17:28 +0000
Date: Thu, 20 Feb 2025 12:17:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z7cPUCOZeJZipmo0@yuki.lan>
References: <b379b9603036d9d4877f562f750e2d1515dfd962.1740042744.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b379b9603036d9d4877f562f750e2d1515dfd962.1740042744.git.jstancek@redhat.com>
X-Rspamd-Queue-Id: AABA41F38D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/utime03: relax the check for 1 second
 difference
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The test is using tst_get_fs_timestamp() which is using REALTIME_COARSE
> clock, which is slightly less accurate. Back in 2022 we added extra log
> message to print also min and max time. In those rare instances where
> it fails this extra log shows it failed by one second difference.
> 
> Relax the check a little. Tested on aarch64 VMs, where it's usually
> reproducible after couple hundred iterations.

Aren't we just masking a kernel bug here? Back then we discussed this
with kernel devs and they told us that filesystems use REALTIME_COARSE
internally, so this shouldn't really fail.

What filesystem is this? Does it, by chance, use more granual
timestamps?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
