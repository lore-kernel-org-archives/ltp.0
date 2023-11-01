Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58C8C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 11:17:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BB673CE9AE
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 12:17:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C96633CC8EB
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 12:17:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E4D02002B2
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 12:17:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA60D216DA;
 Wed,  1 Nov 2023 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698837443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlJ/S/Mx0tH+ycbtFoIljdPOmbOhhmuiCMt1pwKM5Gs=;
 b=vJN4OXkbXdG/B02xsgoi6YRi4DPZsWb2KDMLR6mB7EAPvog+oi2nfUnhES78RrPu+tKZhV
 47i0rxw+YnvnU1a5eRBSKyEEox4PVGM5E/zNZDtvNscD1SR8wZJ4jOFwXnVs6/3hPmqvrQ
 reU3+GFB8ojLXcbNvpJPq02JRPipnHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698837443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlJ/S/Mx0tH+ycbtFoIljdPOmbOhhmuiCMt1pwKM5Gs=;
 b=vh6zHrW/FNI74u+D28kwYre3lPxbdYTpbtlcSXmsyOyYufjn9ue6ieY6JQu+txoovbQBHs
 HWdad1NssFQi+EBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E3CF13460;
 Wed,  1 Nov 2023 11:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bBZCG8MzQmWyNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Nov 2023 11:17:23 +0000
Date: Wed, 1 Nov 2023 12:17:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
Message-ID: <20231101111722.GB896131@pevik>
References: <20231025140109.340441-1-pvorel@suse.cz>
 <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Note for myself: typo in subject s/ReAplace/Replace/

> > we recently had yet another regression on old CentOS 7 (kernel 3.10,
> > glibc 2.17, gcc 4.8.5 [1]. That brought me to the question if we still
> > want to support it.

> > Although we test in SUSE also very old SLES releases, these are tested
> > with older LTP releases. I suppose Red Hat does the same with RHEL
> > (Li, Jan, please correct me if not, or feel free to introduce another
> > CentOS version, as there will none with this patchset), thus why
> > pretend current LTP is useful on these old releases.

> Looking at internal LTP test wrapper, it's using older LTP release for RHEL7,
> so your assumption appears to be correct.


> > I wonder who is actually interested in keeping LTP compilable for CentOS 7.
> > According to distrowatch it EOL in 2024-06 [2], but does anybody even run new
> > LTP on it. If yes, please speak up, but I'd expect that person to
> > actually maintain CI failures.

> There's planned ELS until 2026, but I'd expect that continues using
> older LTP for tests.

@Li, Jan Could you please add your ABT or RBT?
Also, feel free to add quay.io/centos/centos:stream9 or rockylinux:9 or
rockylinux:8 or whatever makes sense to you. These are tested in
https://github.com/iputils/iputils/blob/master/.github/workflows/ci.yml
(it would have to be checked if ci/centos.sh needs be modified to support).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
