Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174BDEE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:18:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5E293CCDC2
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:18:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D24EB3CB62A
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:18:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 30EE6600D77
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:18:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7D1121866;
 Thu,  7 Sep 2023 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694081923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNb2LhbN7WnccDW0aG7z5la+3bg3m4XpPgLbJ1S8JQ0=;
 b=SsXk6FNKK3ovvcbN7OrxKgFBPnnetI7G/Zfv5T/3RHt7OwQaIjoqi42UpdMtUDInmRYfTA
 Pa8cj/U7f89u+iWHoR9LBS0HxIdA7vok5WTm0oTYEPjLgAiKLuHXZ4UzIhfxePBfDIstZm
 HOibQARO/U18NVeER3I3QvtEpKuO+6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694081923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNb2LhbN7WnccDW0aG7z5la+3bg3m4XpPgLbJ1S8JQ0=;
 b=zvK+qu+TkqPfHWHsa0bcp1N+NoALYuJBHCbnrxuSiFmmAC7afR+xjFv8fyAtPlxVTcjSO6
 nnE4RPfZSxskW9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C01F7138FA;
 Thu,  7 Sep 2023 10:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oV3MLYOj+WRGVAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 07 Sep 2023 10:18:43 +0000
Message-ID: <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
Date: Thu, 7 Sep 2023 12:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Ian Wienand <iwienand@redhat.com>, Richard Palethorpe <rpalethorpe@suse.de>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com> <87il8xhr05.fsf@suse.de>
 <ZPlxtKUwOta4GYh2@fedora19.localdomain>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZPlxtKUwOta4GYh2@fedora19.localdomain>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 07. 09. 23 8:46, Ian Wienand wrote:
> I don't think adding another test really helps.
> 
> I think the best course here is to fix zram01.sh to write enough
> random data to stress the compression paths and further sync to make
> it reliable.  This is what the patch proposes.
> 
> If there's some agreement that the investigation above is valid, we
> could probably remove zram03.c.  It's not really doing anything
> zram01.sh doesn't do and it is not really stressing anything either.

Please do not completely rewrite test scenarios to hide one failure due 
to filesystem specifics. If this is not a kernel bug, the correct way to 
deal with this is to disable testing on vfat in initialize_vars():

for fs in $(tst_supported_fs -s tmpfs,vfat); do
...

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
