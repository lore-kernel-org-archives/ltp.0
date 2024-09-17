Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E6C36011
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 11:18:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578503C2DF6
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 13:18:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59143C130D
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:17:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33442208D2A
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:17:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B80792001F;
 Tue, 17 Sep 2024 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726571868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjBZ80zzM4bfY3X7EHG8HwUUc3v/rCzL8vyia1R31oE=;
 b=P4IZYuaEbv4RsY0lSDGgv1LL/cFt4JX5QLQFldkoCrLvnsvafbYNBjJsr8Z0iPVgeFfv2n
 kj851hBLwBsFkmoZjCFcdP+O5GOG+3//y7miXXjCfIHMxUmeHDcfpK/c+C1aoTjAgDjwhM
 62KED4o9Nmfbevj0ZlzCRa8poIANYE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726571868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjBZ80zzM4bfY3X7EHG8HwUUc3v/rCzL8vyia1R31oE=;
 b=REqis6a2HOMX3voNMVLk0C4c6Dyb/DbgUBKDUAEVch/lcad5z/NzyXUojC5I80hJn2N0dB
 7BXzFA6dJvGOXtCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="i2/w+0Mw";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NQlVKbb5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726571867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjBZ80zzM4bfY3X7EHG8HwUUc3v/rCzL8vyia1R31oE=;
 b=i2/w+0Mwtcgb1y9XmYqK85AcJavOwap4X9hP6WfwjBodSVAvtXTxsG82E/D8HLqNwhRjdT
 2xrHUFytAN0v3rXjbZvMio/Y92UjMhetEbAxG43eyeJIUjycIXg+YXDaFcIHvaJlhX25jt
 BKcbkjJAbyrrDdyTX/QZesXOVT4nUZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726571867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjBZ80zzM4bfY3X7EHG8HwUUc3v/rCzL8vyia1R31oE=;
 b=NQlVKbb5AtQ7ucxj1/esuYSfJikzhm03MBGTlHtlXKOSRKURqThmJcfpiqwgOJtykKilYa
 pxjNrDc5rjOJqRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3BDC139CE;
 Tue, 17 Sep 2024 11:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cceyJ1tl6WaYBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 11:17:47 +0000
Date: Tue, 17 Sep 2024 13:16:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZullFLOc6fLJyCts@yuki.lan>
References: <20240805063616.12572-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240805063616.12572-1-liwang@redhat.com>
X-Rspamd-Queue-Id: B80792001F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: Forcing context switches to update
 resource usage
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
Cc: Scott Weaver <scweaver@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Our CI sporadically complains that this test grandchild's MAXRSS did not reach
> the expected 300MB size.
> 
>     12 getrusage03.c:86: TFAIL: child.children = 258048, expected 307200
> 
> As the ru_maxrss value is generally updated at certain intervals or under
> specific conditions, such as page faults or context switches. There may be
> delay between the completion of memset() and the update of ru_maxrss.
> 
> To address this issue, we create a function to force context switches by
> calling sched_yield() multiple times. This approach helps to ensure that
> the system has the opportunity to update the ru_maxrss value more promptly.
> 
> Reproted-by: Scott Weaver <scweaver@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>

This looks forgotten but should probably go in before the release...

Anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
