Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF9CC433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 13:09:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9DD611C9
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 13:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B9DD611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD5E73C72EA
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 14:09:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE4D3C5AEF
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 14:09:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AFC281A0122B
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 14:09:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC361218B5;
 Thu,  4 Nov 2021 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636031383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FuftfFGVdXB96vB2nrWzJWSAQMu398CkPaouPngEtJI=;
 b=2ynr4xJ/Wm5z1AyptIkm2GVLtUj4qOXwx3q+8yZVySpsiP5IpIDbljoTDIegDkgJLuWBis
 l2tXu0mHCcLzwrCrZpccxrNAo9sKLbD6laV8RPTOz9gj0lGp6E5yEezeV0sWcGrEplhry5
 Mw/HY/qmyKwtrsS4Wz762teM2zgEyaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636031383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FuftfFGVdXB96vB2nrWzJWSAQMu398CkPaouPngEtJI=;
 b=nh8LrE60ioI0f+OPMavlh9rl15ZTjkn/Re+E0i4aDstpiqUeWA6FFUW/3J21/Kr35bh/s1
 htQawJPUGkgyoUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D4213C68;
 Thu,  4 Nov 2021 13:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A2cJI5fbg2HLIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 04 Nov 2021 13:09:43 +0000
Date: Thu, 4 Nov 2021 14:10:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YYPb0HgsJ0YEZ9PB@yuki>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-8-chrubis@suse.cz> <YYKI9I05hEjiKNiE@pevik>
 <YYKLnxZL44ftguOx@yuki> <YYKMIuHDheI1PK8x@yuki>
 <YYKe0sdsN/qGRO8E@pevik> <YYKmqo3NCZi35DKB@pevik>
 <YYKsVYjYm0lk8cpD@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYKsVYjYm0lk8cpD@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] docparse: Split into metadata and docparse
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
And I did a CI run with the correct version at:

https://github.com/metan-ucw/ltp/actions/runs/1421302973

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
