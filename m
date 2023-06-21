Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19701EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:52:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441623CC473
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:52:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D3AA3C9DB1
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:51:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E967600481
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:51:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64A301FE2D;
 Wed, 21 Jun 2023 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687351911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lITIsPt6jF12qMbj0gShYHlAaHkbGSB3T9QIGRtHRWs=;
 b=C2SC3q2jeJN2/EVo8gtCEOWyPHw0TJzECOlCq4ZSDDYscx1C8Nr7Qg+6izDGRmjF20rEB0
 nCYRHAfgcooOFcv3gGzHRt5lDhJtTua+3pTsJFCcydvzuKcpEl41tIsvwSVZ80cJB1XM6L
 raEgWo+65nmnoq4c0JcQM4ZDzJTsUGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687351911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lITIsPt6jF12qMbj0gShYHlAaHkbGSB3T9QIGRtHRWs=;
 b=PFo+VDjcetIMyEIcPjGYSCLqVO9fJ1rFfgdhUri2PJ6d4nzYaPwtz1ju4umbe2BLStcIhJ
 u3hcjkeTVg48eXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49478133E6;
 Wed, 21 Jun 2023 12:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /9bkDmfykmSJVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 21 Jun 2023 12:51:51 +0000
Date: Wed, 21 Jun 2023 14:52:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZJLypX9iZ8n-SJJy@yuki>
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
 <1cca2a5f-64e0-2932-2971-8d7d91e01605@suse.cz>
 <CAEemH2dYgefTdWd2VgK5aur9qo8Z89C9CuK=pAT1O_dccOdw9w@mail.gmail.com>
 <e6dc2fff-99cc-33ff-548e-1828143d9d74@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e6dc2fff-99cc-33ff-548e-1828143d9d74@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Thanks for the info. I look a while why can't build them
> > as fake programs and only exit with TCONF on non-x86,
> > but seems it has some platform-dependent assembly language
> > and the linker rule=A0unsupport that.
> =

> The KVM Makefile is complicated because we build a raw machine code =

> binary which will be executed in the VM and then link it inside the test =

> program as a data blob. Adding extra conditions to skip the blob =

> compilation and safely TCONF in the test programs would make everything =

> even more complicated so it's not worth the effort at this point because =

> the KVM test coverage is still quite small.

I guess that proper solution could be implemented in the new generation
LTP executor. For instance if these tests have arch tag in tst_test set
to x86_64 the executor can read the metadata and wouldn't even attempt
to run these tests.

The whole point of the metadata parsing is to make the test execution
more flexible, since the runtest file based approach does not scale and
was outdated even ten years ago...

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
