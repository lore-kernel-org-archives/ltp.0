Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E73C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:09:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5690C3CBC79
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:09:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEFBF3CAAF4
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:08:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC4A660070D
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:08:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8B71F7E4;
 Wed, 30 Apr 2025 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746018533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giFjRJU4e6eVe4Ol1ITwQKAOHRtfSmOkgyH/Xou7hKs=;
 b=cg4Ywz3T8LGniLAGt7Uv7w5cekqcanYHp3quGGucmSEfJxoAVNlNKdi3LmupRJpxHbEyK5
 eFuljjPJsC+YPeP9WaqwHF8WQ217Z8OYI/sIvBRAsKlgHgiEzS0dBrWMA0YPm7P+M3Shvy
 RiwOM7Xiw5baag4R14RzFONiiZk7WyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746018533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giFjRJU4e6eVe4Ol1ITwQKAOHRtfSmOkgyH/Xou7hKs=;
 b=U4npL/r+2fThKKEpr5CxFxJ+4OlGz118HxmzB5ibbLp7H3/Lz3HqxdFMtAQwXzylx1XeXY
 hQ4MeEH+KX4NKfDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cg4Ywz3T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="U4npL/r+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746018533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giFjRJU4e6eVe4Ol1ITwQKAOHRtfSmOkgyH/Xou7hKs=;
 b=cg4Ywz3T8LGniLAGt7Uv7w5cekqcanYHp3quGGucmSEfJxoAVNlNKdi3LmupRJpxHbEyK5
 eFuljjPJsC+YPeP9WaqwHF8WQ217Z8OYI/sIvBRAsKlgHgiEzS0dBrWMA0YPm7P+M3Shvy
 RiwOM7Xiw5baag4R14RzFONiiZk7WyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746018533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giFjRJU4e6eVe4Ol1ITwQKAOHRtfSmOkgyH/Xou7hKs=;
 b=U4npL/r+2fThKKEpr5CxFxJ+4OlGz118HxmzB5ibbLp7H3/Lz3HqxdFMtAQwXzylx1XeXY
 hQ4MeEH+KX4NKfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1658813A25;
 Wed, 30 Apr 2025 13:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zO4EBeUgEmhdbQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 30 Apr 2025 13:08:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Apr 2025 15:08:52 +0200
Message-ID: <2225787.irdbgypaU6@thinkpad>
In-Reply-To: <4650874.LvFx2qVVIh@thinkpad>
References: <20250408161745.9757-1-chrubis@suse.cz>
 <4650874.LvFx2qVVIh@thinkpad>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2F8B71F7E4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tlibio: Get rid of support for old UNIXes
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

On Wednesday, April 30, 2025 2:42:06 PM CEST Avinesh Kumar wrote:
> Hi,
> 
> This is causing a regression in growfiles tests 
> (all variants of gf01, gf13, gf15 and gf18 in
> fs/doio/growfiles.c and fs/fs_readonly/test_robind.sh)
> 
> ./growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 -f glseek20 -S 2 -d /var/tmp/
> DEBUG tlibio.c/1187: No I/O method chosen
> growfiles(gf01): 140867 growfiles.c/2602: 1 CW 
> growfiles(gf01): 140867 growfiles.c/1765: 1 Hit max errors value of 1
> gf01        1  TFAIL  :  growfiles.c:134: Test failed
> 

./growfiles -W gf01 -b -e 10 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 -f glseek20 -S 2 -d /var/tmp/
...
...
growfiles(gf01): 141102 growfiles.c/2050: 30 
DEBUG tlibio.c/1187: No I/O method chosen
growfiles(gf01): 141102 growfiles.c/2602: 31 CW 
growfiles(gf01): 141102 growfiles.c/1765: 31 Hit max errors value of 10
gf01        1  TFAIL  :  growfiles.c:134: Test failed



We hit the issue even on increasing max error value to any number.

> 
> 
> Thanks,
> Avinesh
> 
> 
> 
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
