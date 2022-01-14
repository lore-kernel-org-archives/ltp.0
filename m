Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C4AC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 09:49:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3D63C953A
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 10:49:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95873C8C61
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:49:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F2191001348
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:49:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6021F1F3D3;
 Fri, 14 Jan 2022 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642153784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RM7ulMmPqUNWVwx7DCocz3GAnA/DsdhxmivNjaDkMfQ=;
 b=Lp6OnfHTMKCg2SxXK17exwS53ucOo/2eWkm+WwoexH0/YvknIwJ2MpmPSSjetSYNUOF4hU
 QJTHicpdfi7EfiN+PMyNVeQ+RSXJmAf91FJmjLQ4+S5liZ9lFMIQgJTMMKDyyS6wioIbNj
 zMfoySIPSk8Chne3//v31IGdWDGEI44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642153784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RM7ulMmPqUNWVwx7DCocz3GAnA/DsdhxmivNjaDkMfQ=;
 b=J3srR6XcfAR4UJqllVWPTiSWfEMbIQzcCPvbhHE9mgdTPtC8nP/BMvOzScFxVQnoehxwKy
 AMcXJ9bWABurVBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 129CB13EC6;
 Fri, 14 Jan 2022 09:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DGjFAThH4WEnGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 09:49:44 +0000
Date: Fri, 14 Jan 2022 10:49:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YeFHNubjIKQYuLe+@pevik>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
 <61DD4215.2050104@fujitsu.com> <YeBKakIm5I4HQECr@yuki>
 <61E117E8.5080901@fujitsu.com> <61E14069.8030800@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61E14069.8030800@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr

> I find  ltp doesn't update wiki automatically. Or I miss something?

> This occurs the last patch doesn't update doc when we merged a patchset.
Hm, I need to look into it.
Thx for info.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
