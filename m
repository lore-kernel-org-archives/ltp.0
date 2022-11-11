Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB24C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 20:57:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24FFA3CD73A
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 21:57:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02CD3CA956
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 21:57:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B77381A00484
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 21:57:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D287201E2;
 Fri, 11 Nov 2022 20:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668200262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrn1stqlZ5YXKip7HfEjGCb54NRm9/ted5RGJN7vm0c=;
 b=SCk7fDx3B/v/ZDsbGjLoQYZLZXL/nzpLCL34qznEoGRQ0NVVF5xqJv53UBKEu67k8asats
 LO+7+0arGDOJEEt35TV/asy3xDoUN/Tq9rLTJ6flNjJYS8QLDXmqimW8NfvjSIJyt4a59c
 Epp58HFU0+NFOgdeeI31XvaNXzbGcS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668200262;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrn1stqlZ5YXKip7HfEjGCb54NRm9/ted5RGJN7vm0c=;
 b=oFVHj1looe+UAC7TMRX/dtUlifjj9Izeun6tSXHlnRtXSnFfdm7mNDCWr67Fhz3K2/2A/j
 omfmL3kgT7BMjECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CB6A13273;
 Fri, 11 Nov 2022 20:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pyVfBUa3bmMPWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 20:57:42 +0000
Date: Fri, 11 Nov 2022 21:57:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y263P4XBMpFiDaL8@pevik>
References: <20221110102758.26328-1-andrea.cervesato@suse.com>
 <CAEemH2fc--utPwQmhB=fE_i+6PEGyK5a+B6j4NgVLxogc+kbgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fc--utPwQmhB=fE_i+6PEGyK5a+B6j4NgVLxogc+kbgw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Correctly check setitimer params in setitimer01
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

...
> > +       tst_res(TINFO, "clock resolution: %luns, "


> I would use "low-resolution" for this output, but
> someone merge patch can help modify it.
I fixed that + slightly reword docs and commit message before merge
(using imperative mood).

Thanks a lot to all!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
