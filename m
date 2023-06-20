Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E991EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 20:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6F03CE104
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 22:31:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E05C73CA8D7
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 22:31:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEE631400348
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 22:31:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E583218E0;
 Tue, 20 Jun 2023 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687293089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGPQJvY5LQywGgsz4MkBYrN3IMgzeVBLSYZbn8BmPcM=;
 b=PPB0Pp3f8bl6UeEKM7X0PfO+S4sovYEaCG1kNoXoTWJ2swQoq2OVMLXaRgkDRIE0gUnHbp
 pmlNG31/pPwGrTBcu+w8VuzoHksbr7wig2SoLaN6CO5iuwDiPfAqjenbURwXxc0cDIefwW
 Qgk0VhW9A0ee2Vt1EIIlQZROwylZGgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687293089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGPQJvY5LQywGgsz4MkBYrN3IMgzeVBLSYZbn8BmPcM=;
 b=CTjPEL3jXxIdCfc8mtOkPEPvDes2xDfKArWRkpRfMwwABx8lheR8N8XpgV+mVXYXqm2rDe
 BcU8fFzeS0LTjKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 441E01346D;
 Tue, 20 Jun 2023 20:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6CxFDqEMkmTBdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 20:31:29 +0000
Date: Tue, 20 Jun 2023 22:31:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230620203122.GA328326@pevik>
References: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
 <CAEemH2cyEdy0QVZQTuH9hHhkPtgBfV+Aswp6QRCX0hBEUOZfQw@mail.gmail.com>
 <CAEemH2ejYND502tSx7fQ2XPNkRmWtOS4keGM2sQsG1vOLYOKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ejYND502tSx7fQ2XPNkRmWtOS4keGM2sQsG1vOLYOKoA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] testcases/kernel: Add CVE tag to some
 existing tests.
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

Hi Li, Souta,

...
> > ---
> >>  testcases/kernel/mem/ksm/ksm05.c                    | 4 ++++
> >>  testcases/kernel/syscalls/ipc/shmat/shmat03.c       | 1 +


> My 'Reviedwed-by' applies to all except this shmat03 change.

FYI I merged it with reverted shmat03.c change.
Thanks to both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
