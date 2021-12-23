Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09218C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 07:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E6283C92A0
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 08:57:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D613C074D
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 08:57:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 804E3600157
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 08:57:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 963D221110;
 Thu, 23 Dec 2021 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640246223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OX8ardKhV6iwQFcO2cRyHFZ9LCrGIfXPoRp3g4c4eZ4=;
 b=oJa81bGj+OSoZAXsZbwXtAantw6LD9ojM1uLQQTZX+INaNgPAemWENXO5RXbIGpN1SvnS/
 BZx51ScBaPK6OW3/tC/QKOsxNEgVZZ44tUrIF7DaNzGBF0K+pxisRwATRjvQW2UyBM674n
 NTkCZk5ixCNeZFV8Flb58O5bD6NvFn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640246223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OX8ardKhV6iwQFcO2cRyHFZ9LCrGIfXPoRp3g4c4eZ4=;
 b=DgWXq+zJ29zGW8rcb71Tvx6otvo7zmYm4k6IghEdoqYnpwIkRG0+WLaXS6pqtajVHO639n
 DowD5r+H9uUI9hAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6423A13E3A;
 Thu, 23 Dec 2021 07:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A8XGFs8rxGFpVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Dec 2021 07:57:03 +0000
Date: Thu, 23 Dec 2021 08:57:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcQrzbWJyWPpyjeZ@pevik>
References: <CAEemH2di0818vNoByrpUeEfZi-T58fNMg131=HZFeF2W6Be0Ng@mail.gmail.com>
 <20211223024841.801160-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211223024841.801160-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Do not fail a test if oom score cannot be
 adjusted.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Notes:
>     v2 --> v3
>     	* drop the useless CAP_SYS_ADMIN
>     	* add some new commments
Yes, CAP_SYS_ADMIN was redundant, thus I merged it.
Thanks a lot all.

>     CI job: https://github.com/wangli5665/ltp/actions/runs/1613852940

Yes, ubuntu cannot reach repos:

    Ign:1 http://security.ubuntu.com/ubuntu groovy-security InRelease
    Ign:2 http://archive.ubuntu.com/ubuntu groovy InRelease
    Err:3 http://security.ubuntu.com/ubuntu groovy-security Release
      404  Not Found [IP: 91.189.91.39 80]
    Ign:4 http://archive.ubuntu.com/ubuntu groovy-updates InRelease
    Ign:5 http://archive.ubuntu.com/ubuntu groovy-backports InRelease
    Err:6 http://archive.ubuntu.com/ubuntu groovy Release
      404  Not Found [IP: 91.189.88.142 80]
    Err:7 http://archive.ubuntu.com/ubuntu groovy-updates Release
      404  Not Found [IP: 91.189.88.142 80]
    Err:8 http://archive.ubuntu.com/ubuntu groovy-backports Release
      404  Not Found [IP: 91.189.88.142 80]
    Reading package lists...
    E: The repository 'http://security.ubuntu.com/ubuntu groovy-security Release' does not have a Release file.
    E: The repository 'http://archive.ubuntu.com/ubuntu groovy Release' does not have a Release file.
    E: The repository 'http://archive.ubuntu.com/ubuntu groovy-updates Release' does not have a Release file.
    E: The repository 'http://archive.ubuntu.com/ubuntu groovy-backports Release' does not have a Release file.

I'm testing upgrade to impish:

https://github.com/pevik/ltp/actions/runs/1614667613

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
