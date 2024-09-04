Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96130CA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 14:00:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8350E3C223A
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 16:00:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D0B3C1CC8
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 16:00:04 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95BC91414C54
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 16:00:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A47311F7C1;
 Wed,  4 Sep 2024 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725458401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gsJG5Y8oMViGmgutGvBHadCN+gTYbIn89wClOellPs=;
 b=wJcqTsgL81GYzl3N0h+crSIB5rxkDAZMJ3YU86YCJpyg+gyJk+c7FbtOioQgOnDHZiH8R0
 Kp2rXsWfwHItIUPmNYrqQmcKIGccbz3l0msSOXtcD8CjSplqVrMKpIz2n3OcWIXu21Tq53
 9dDLHeU7hXMw5ITPEKkSrQnvxkyPrX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725458401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gsJG5Y8oMViGmgutGvBHadCN+gTYbIn89wClOellPs=;
 b=lDu18xvmviafxiQ6VAonLh4oGdVsqd5xWCEtCLaAKp0WWMWOtSlxTTGh1+xQQhd7G2/n4f
 WDWLWWpLqCRAXpBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725458401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gsJG5Y8oMViGmgutGvBHadCN+gTYbIn89wClOellPs=;
 b=wJcqTsgL81GYzl3N0h+crSIB5rxkDAZMJ3YU86YCJpyg+gyJk+c7FbtOioQgOnDHZiH8R0
 Kp2rXsWfwHItIUPmNYrqQmcKIGccbz3l0msSOXtcD8CjSplqVrMKpIz2n3OcWIXu21Tq53
 9dDLHeU7hXMw5ITPEKkSrQnvxkyPrX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725458401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gsJG5Y8oMViGmgutGvBHadCN+gTYbIn89wClOellPs=;
 b=lDu18xvmviafxiQ6VAonLh4oGdVsqd5xWCEtCLaAKp0WWMWOtSlxTTGh1+xQQhd7G2/n4f
 WDWLWWpLqCRAXpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87C9E139D2;
 Wed,  4 Sep 2024 14:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1DaLH+Fn2GbPbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Sep 2024 14:00:01 +0000
Date: Wed, 4 Sep 2024 15:58:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZthnmE5TB3Ji44lN@yuki.lan>
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan> <20240904053157.GA836933@pevik>
 <Ztgfu4bTVyw7hvdP@yuki.lan>
 <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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
> I'm wondering which distribution (and kernel version) did you use on raspi-0?

The default raspbian. The difference I guess is that RPi Zero is a
single ARMv6 if I'm looking right it's the same CPU as on the original
RPi. That's way slower than quad Cortex-A72 on RPi 4.

> My raspi4(ubuntu-24, 6.8.0-1010, Cortex-A72) takes a little faster.
> 
> ext2: 12s
> ext3: 12s
> ext4: 0.4s
> ntfs: 46s
> exfat: skip

I suppose that this is stil slow on RPi 4 because the rootfs is on a SD
card, since the CPU on RPi 4 is way faster than RPi Zero.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
