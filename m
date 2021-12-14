Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F88DC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A2BC3C8DDA
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 17:41:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BDB73C8A8C
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:40:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D5C1200DDE
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:40:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78F3E21100;
 Tue, 14 Dec 2021 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639500051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oda2/E+j9eLywiJfwQHn2AzlEqSZK0s0jpsIjbF8ttY=;
 b=IzrNLRaoQcMmI/eElQRCyqGk6N7zih0hi9agjiZXGfpA08OpqUKNFpWccdho1IYBj3G29/
 F9wsEhV61ntFN7jfmwruwO8SUcO4lMKeV3BIVQouQU1n92ML0J3TuAq8Q60X1s+4uw1HuY
 uMqD2aExYdnqwPDkCfnr6yRyotug/9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639500051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oda2/E+j9eLywiJfwQHn2AzlEqSZK0s0jpsIjbF8ttY=;
 b=FU1CBvRLoBW/rir6VR24KHh5eeWrRDEuVVVwB2kCW663ShIrDl5EvAQEEPDrj97WieOs2q
 QuAl3dg2aS7cckBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5996613A1D;
 Tue, 14 Dec 2021 16:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M+VOFBPJuGF8CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 16:40:51 +0000
Date: Tue, 14 Dec 2021 17:40:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YbjJEVJq3vQchSBO@pevik>
References: <20211213121417.21825-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213121417.21825-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add io_read_eof in common.h utilities
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

Hi,

...
> +static inline void io_read_eof(const char *filename, volatile int *run_child)
> +{
> +	char buff[4096];
> +	int fd;
> +	int r;
> +
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
Just for a record [1] this open should be checked for errno == EINVAL
in case of /tmp/ being tmpfs.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YbjIqypOcAYAnLbl@pevik/T/#t
> +		usleep(100);
> +

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
