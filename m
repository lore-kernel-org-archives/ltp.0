Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08713EE49AB
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 06:51:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52983CC634
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 08:51:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385CF3C8AC4
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 08:51:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26BDE6000F8
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 08:51:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57E6A1F38A;
 Wed, 23 Aug 2023 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692773466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf01u7LXEDoxL4Tuv6IGzJAPTuEyk87XGyQimCNAMNY=;
 b=s+WLPzVHD556WlL5Hu4ssqPFHLYMyGj/chq5CimwatlgKRNHx3Epx2dOY7K+HavYxaAdxX
 NNZNoL6+JtjqoJDwmUiLv+D/cgp4YVKMC1522yurv7X/D8KjDpVybMedbo8VRnE4xkv7jB
 tW11peW0Roo24i5YwSGD/4drx2q1fg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692773466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf01u7LXEDoxL4Tuv6IGzJAPTuEyk87XGyQimCNAMNY=;
 b=NTMhMSO1wmd9L0l1xBw7LxoUXzIQN5N1rIKDmKnZFrg/uDiTdkmFm9PMtuZhb8hFy2W5NO
 26dzWrKojn8HDMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46BC813458;
 Wed, 23 Aug 2023 06:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mr4kEFqs5WR8LwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Aug 2023 06:51:06 +0000
Date: Wed, 23 Aug 2023 08:51:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <ZOWseuRX3rJKObL0@yuki>
References: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692700900-13521-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZOTNSlPaoSaxU493@yuki>
 <c9ec804c-d100-f678-a0bf-9634f2d17b67@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9ec804c-d100-f678-a0bf-9634f2d17b67@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/faccessat202: Add new testcase
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> =

> Thank you for your suggestion, but i think " SAFE_SETEUID(ltpuser->pw_uid=
)"
> =

> should be changed to "SAFE_SETEUID(0)" to change EUID back.

Right, that was copy&paste typo.

> >> +			TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename,
> >> +				     tc->mode, tc->flags), tc->exp_errno);
> >> +		}
> >> +
> >> +		tst_reap_children();
> >> +	} else {
> >> +		TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename,
> >> +			     tc->mode, tc->flags), tc->exp_errno);
> > Can we get a better message here? As it is it prints
> > "faccessat2(*tc->fd, *tc->filename, tc->mode, tc->flags) ..."
> >
> > Which is a bit ugly.
> =

> Because i used tst_get_bad_addr to test a bad pathname point ,
> =

> so if i output relevant information, the test will be killed by SIGSEGV.
> =

> In the v3 version, I will change it to this:
> =

> "TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, tc->mode, tc->flags),
> =

>  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tc->exp_errn=
o, "faccessat2()")"
> =

> How about this?

Either that or we can add short description to the test structure and
pass TST_EXP_FAIL(..., "faccessat2() %s", tc->desc)

At least some cases would be better with description, for instance for
the euid test the description should be something as
"with AT_EACCESS and unpriviledged EUID"

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
