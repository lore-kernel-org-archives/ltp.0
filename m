Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0596CEDD87
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:56:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E7983C2CF2
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 13:56:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59613C2750
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 13:54:38 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F397B201744
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 13:54:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DD6321E5D;
 Wed,  9 Oct 2024 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728474876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUvGL+sPmRmjMQqWkjor2e4sPlA8EZDWqN+kZ9oteLo=;
 b=mLYPyaitTcegU8E6eMKZAutBgCCB+zCZWUJZ7wim12jFiEspOZvA3V6NiE3bIBNbtPPT7+
 TCVlQIgLf7hGe/KAv5n0f6LTjrquvho33fWCAxCo59ER7P6E5y1jzEo6FWEjR5WuDRjl0O
 r+TOz/770C5FysmZNwI8N9X5kNYWdnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728474876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUvGL+sPmRmjMQqWkjor2e4sPlA8EZDWqN+kZ9oteLo=;
 b=WrkZoEASi/jBZ/ULqsAMhbXUKb2xpyb5lgf8fp+HhmzKwvVriwuOzDnucnHbnnVB64ppsn
 oGEuo4Z4/rLUizDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mLYPyait;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WrkZoEAS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728474876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUvGL+sPmRmjMQqWkjor2e4sPlA8EZDWqN+kZ9oteLo=;
 b=mLYPyaitTcegU8E6eMKZAutBgCCB+zCZWUJZ7wim12jFiEspOZvA3V6NiE3bIBNbtPPT7+
 TCVlQIgLf7hGe/KAv5n0f6LTjrquvho33fWCAxCo59ER7P6E5y1jzEo6FWEjR5WuDRjl0O
 r+TOz/770C5FysmZNwI8N9X5kNYWdnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728474876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUvGL+sPmRmjMQqWkjor2e4sPlA8EZDWqN+kZ9oteLo=;
 b=WrkZoEASi/jBZ/ULqsAMhbXUKb2xpyb5lgf8fp+HhmzKwvVriwuOzDnucnHbnnVB64ppsn
 oGEuo4Z4/rLUizDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36E8A13A58;
 Wed,  9 Oct 2024 11:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TRdICvxuBmdoEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 09 Oct 2024 11:54:36 +0000
Date: Wed, 9 Oct 2024 13:53:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <ZwZuuz2jTW5evZ6v@yuki.lan>
References: <20241008115648.280954295@linuxfoundation.org>
 <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
 <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4DD6321E5D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.98 / 50.00]; BAYES_HAM(-2.97)[99.87%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[25]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,linuxfoundation.org,suse.cz,kernel.org,mit.edu,gmail.com,gmx.de,denx.de,lists.linux.it,lists.linux.dev,vger.kernel.org,lists.linaro.org,sladewatkins.net,kernelci.org,linux-foundation.org,nvidia.com,roeck-us.net];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim, linux.it:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 09 Oct 2024 13:56:37 +0200
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
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
Cc: Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org, allen.lkml@gmail.com,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 jonathanh@nvidia.com, patches@kernelci.org, linux@roeck-us.net,
 srw@sladewatkins.net, broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 rwarsow@gmx.de, pavel@denx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, conor@kernel.org, patches@lists.linux.dev,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Work in progress, see:
https://lists.linux.it/pipermail/ltp/2024-October/040433.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
