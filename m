Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6CC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:25:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38630610C8
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38630610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA033C67EA
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:25:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42863C67DE
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:25:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F4B0201192
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:25:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80EB41F770;
 Tue, 26 Oct 2021 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635258310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWHEBnt3xgbHoq7Q/EddoP35/dT3r9PdCIBwHaR+/H0=;
 b=fBuX9HJDFQ4aDDOgpyXrW4VGsf4NOfKFwT76Q6+XELs9HCeytuWu+kG6cjMV4x1b25U221
 pw48nL3lz+1+s9DbEB5NYMayHiSlw2/WcJi2o0L+p7boL12ehQazMu753564WcvcM94JDZ
 3XG5b8XnfwP7AjA5u5SE1D8SYZtQiZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635258310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWHEBnt3xgbHoq7Q/EddoP35/dT3r9PdCIBwHaR+/H0=;
 b=3ZyoMQIPq9FoqgwfS4EyWr0h4nPpM+LSX37Q/b1aCufv4q6LKunrHnelZj2uOPmpU37fT9
 1XNiwLHi851TwCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 582B313AE2;
 Tue, 26 Oct 2021 14:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6W2zEMYPeGGzFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:25:10 +0000
Date: Tue, 26 Oct 2021 16:26:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgP+JZv5V3xxpjG@yuki>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562888-5987-5-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562888-5987-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 10/11] syscalls/quotactl04: Add quotactl_fd
 test variant
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
And here as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
