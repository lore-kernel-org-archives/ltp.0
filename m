Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B35CE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 09:52:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0892F3C7A21
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 10:52:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE63A3C76C8
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:52:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A582C1000D53
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:52:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E11201F38F;
 Tue, 14 Jan 2025 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736848347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNMwJXe3qUlNx6XO+tEgInNskn8niWLajO9d37Bq7gE=;
 b=0EToccT0EVJwBE2I90arEx+q6isDuVWQ8nFYdn9kJa2UM95xOelRIqZ6lxHJpFB6KpCahL
 4d1WnxeNmQXssyFu96WjHWgyiHDFFYE8S11aqgwLVz1jEVXA2CN2xMnQBdmyhBknr2Jt0F
 uCJc3s1vNkWzPjVS7w95j6s7QXGqRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736848347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNMwJXe3qUlNx6XO+tEgInNskn8niWLajO9d37Bq7gE=;
 b=bJez6Pc6tIq9i0/kMUfiVlDL79Ae+Hl9EzHIeDmZHoaxyRjbBqe8MTw/DJk6vdVoHJNErw
 vxK8OuFwAMX0OsDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YdwXPmLI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="82REE7W/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736848346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNMwJXe3qUlNx6XO+tEgInNskn8niWLajO9d37Bq7gE=;
 b=YdwXPmLIiUGzINRjIk0pWiKIkUFI0gQaFnnqXJmv6LjGnFYWYA21kXIbrrwKrmWhFJSaai
 pv0Od8jHH5JgHZ8y9OpvUhwK1GDzqy369FKfVrylbtcv4KKyE6HLelNk9GTEzvKOl998hp
 HoKbzQnZGvsGdJQx8Xv/tZRTmXYPzWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736848346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNMwJXe3qUlNx6XO+tEgInNskn8niWLajO9d37Bq7gE=;
 b=82REE7W/wBhlWlXZOhjDKIZpD5hVbul/jsp0v72sWmTdKBP11zHJVpn5Htdw2dyUTdrvue
 aSFTzGiACEaZvNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC24139CB;
 Tue, 14 Jan 2025 09:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zesFItozhmdgAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 09:52:26 +0000
Date: Tue, 14 Jan 2025 10:52:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <20250114095224.GA594486@pevik>
References: <20250113-tst_kconfig_stddef-v1-1-66c75790d127@suse.com>
 <20250114025507.GA564529@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250114025507.GA564529@pevik>
X-Rspamd-Queue-Id: E11201F38F
X-Spamd-Result: default: False [-3.70 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; SINGLE_SHORT_PART(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_kconfig: Include stddef.h
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
