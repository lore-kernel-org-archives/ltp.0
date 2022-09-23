Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3AAC6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 06:05:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3533CAD71
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 08:05:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 608E43CAAC7
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 08:05:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBCC0602589
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 08:05:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E75C91FA3C;
 Fri, 23 Sep 2022 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663913112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UoG/mg9vNw3rd4DPoo2XRy0FPbr7fDczWz+EJwOV4o0=;
 b=riw042cvsL2bqxmKcroq4dYi5WsFsrVF3ukBU1220U/LsaaBcVO52nSp1vRyF4h5Pa7vXq
 HM4lJ/Po+54t7IHSkclvJEMWtOIogoBxE9DhpPyx96EYTAt+Gw4tTNjFpcdNUjOPn8+jiB
 QLFj2nOaI3WTpQWhKFYQKon8dbHg5Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663913112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UoG/mg9vNw3rd4DPoo2XRy0FPbr7fDczWz+EJwOV4o0=;
 b=Xq1+RY/b4bQbOfNp+I1RlkJH0sBLWwgJNl2QwtYCeuE6BG990X8BbSLqPLELzgJbQoyE52
 c3ng47j7hZGjdgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B081813AA5;
 Fri, 23 Sep 2022 06:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DoNdKZhMLWMOTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 06:05:12 +0000
Date: Fri, 23 Sep 2022 08:05:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yy1MloHWZ7rSxd+v@pevik>
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-2-pvorel@suse.cz>
 <CAEemH2enjnO-=VLb8Lq3Gz3MT4_PoOTZBU76S3Z7ojBUdywaew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2enjnO-=VLb8Lq3Gz3MT4_PoOTZBU76S3Z7ojBUdywaew@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3 v2] tst_supported_fs: Unify messaging
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

> > I'm not sure about this myself. Shouldn't we rather use tst_brk() and
> > tst_res() instead? It's show tst_supported_fs as command.


> Not exactly, looking at testcase/lib/* tools, most of them are not written
> by LTP standard API, some even do not include tst_test.h.
FYI I meant tst_{brk,res} message starts with filename and line, which is kind of handy.

> I personally think if we want more flexibility for those small programs
> as auxiliary tool, we should not apply API as dogmatism for everything.
Sure

> Btw, there is patch confliction when performing git-am, if you can
> rebase accordingly for solving that, the whole patchset will be
> great for me.
I'm sorry, indeed git-am does not work. I remember rebasing it (and my remote
branch is rebased), I obviously must have run git format-patch before rebasing.

In case of anybody want to actually run it, it's in my fork:
https://github.com/pevik/ltp/commits/fix/TST_ALL_FILESYSTEMS.v2

> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
