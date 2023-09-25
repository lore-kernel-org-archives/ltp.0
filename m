Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49307CE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EFB53CE21B
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:10:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5593CACBD
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:10:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F54A1001161
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:10:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B60F41F74A
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695647412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKrUT8ABukRTt/JHVSNQJNRpd/4J+kcVFlHWDYwiGAU=;
 b=0DkDlUWZl7bjOOPR0eqoUJeXZIYGIn55mt00gpE8y19P3hyWQs9nZEbNkD4TCT/TtvEE87
 a/G2jb8FFECBRjt7iQoo8Kd5amiUFCVgmwsLU4UmOUhfzCsE4GJm74BCUBA00W/QC0Owpi
 KDNhyCEozYvNaAW0nCZToWgq6Lt5T88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695647412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKrUT8ABukRTt/JHVSNQJNRpd/4J+kcVFlHWDYwiGAU=;
 b=ZsEDzfHuwZ6aNIg5fr8ctt2zZOgRDiWtrgLilrSs4X+593BPivqV/kjLlqVyzPJUP1Me3Y
 mcewayUhC6ITByCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7AC713580
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zpuaJ7SGEWXSBQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:10:12 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 15:10:12 +0200
Message-ID: <4513172.LvFx2qVVIh@linux-9lzf>
In-Reply-To: <ZQ2GltNFaQIrszXl@wegao>
References: <20230921090658.11224-1-mkittler@suse.de>
 <5973304.lOV4Wx5bFT@linux-9lzf> <ZQ2GltNFaQIrszXl@wegao>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port getxattr03.c to new test API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Freitag, 22. September 2023, 14:20:38 CEST schrieb Wei Gao:
> On Fri, Sep 22, 2023 at 11:23:47AM +0200, Marius Kittler wrote:
> > Am Freitag, 22. September 2023, 02:00:32 CEST schrieb Wei Gao:
> > > > #ifdef HAVE_SYS_XATTR_H
> > > 
> > > Normally i saw this kind of ifdef in include/lapi/xattr.h
> > > I suppose we need create include/lapi/xattr.h?
> > 
> > No, we don't need that header here. This macro is actually defined in
> > `config.h` which also makes sense as it is generated at configuration
> > time. Note that also all builds (including musl) are passing with this
> > change, see
> > https://github.com/Martchus/ltp/actions/runs/6259530698.
> 
> Maybe some misunderstanding, i mean put ifdef logic into
> include/lapi/xattr.h instead of define HAVE_SYS_XATTR_H, since i saw ifdef
> logic for judge exist of xxx.h normally handled in include/lapi/xxx.h.

Ah, so I'd add `include/lapi/xattr.h` and to the `#ifdef HAVE_SYS_XATTR_H` 
there. But is that really the way to go in that situation? I've just checked a 
few header files in the `include/lapi` directory and there's no precedence for 
the case when a header is not supported at all and the corresponding test 
should thus be disabled. These headers seem more for abstracting differences 
between different (versions) of C libraries but not for handling the case when 
a test should be skipped completely.

Note that the way I wrote this test was suggested to me in "Re: [LTP] [PATCH 
v1] Port `getxattr01.c` to new test API".



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
