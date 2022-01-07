Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62D3C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 15:34:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DF5B3C90E8
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 16:34:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351E83C0684
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 16:34:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7F7B61A01169
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 16:34:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D48C4210EA;
 Fri,  7 Jan 2022 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641569641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=21yiOGYjmPrM3l6b0e0PhXfPSxynAI13JBWFCanNSMP/pRHVDXxCcQyuKckJwNnyydVYUJ
 3BX9Puc84rXdIHLl/m8XeF2wxLtrxlnFepz7jHq2V+wPX8w0i8QG2SaMJxIDP0qnb5IXKp
 E73PogiXBF1sWGmV2HCtze2DDtmADNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641569641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=sb2Iq9PsQ//mNnlStJe5ldn7rBTNuBS+vvZsuJofwUYuEwZAkZoagJ0hyrS3C6lwj9RR3V
 /fEO25do5oAE/UAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6D3C13D0F;
 Fri,  7 Jan 2022 15:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6AawKmld2GGvFwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 15:34:01 +0000
Date: Fri, 7 Jan 2022 16:35:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Ydhdxhc+/tsHXH9M@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639380414-24390-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/6] syscalls/quotactl04: Add quotactl_fd test
 variant
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
