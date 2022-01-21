Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4A7C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6E303C96FB
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:33:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327F03C96D6
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:33:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6903A60164F
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:33:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6B21F3AF;
 Fri, 21 Jan 2022 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642772011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dlsoZSK9LtjvEo1IVBWOtI2rmZ1vWdiekpUq91GPJY=;
 b=gwn8CvdVjfv5z0nJyOOLB8Iz9F6VzJq/84DPEiIy/QLILt44kYfyFtcU+TCrhya1NU51zZ
 R0OwEimWxpFSiPZH0frSdB+CWoBXt5A9IIaizDVjCM3nJtfKK51JFJjzqZ2CCSeBY53ou+
 HPNCNTVgp3JksIERODiYp84iEfIurOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642772011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dlsoZSK9LtjvEo1IVBWOtI2rmZ1vWdiekpUq91GPJY=;
 b=jk7TQG4r9ZsCm8kNscDcDJziaRuQIkzkenHJNFPZvz+dinRp6QSvO789BkZRSLTBWdW+jc
 FpAQwyAOkADtS2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54B5113671;
 Fri, 21 Jan 2022 13:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Aq+YEiu26mHTTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 13:33:31 +0000
Date: Fri, 21 Jan 2022 14:33:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yeq2KeBX5/04d01m@pevik>
References: <20220121103011.6266-1-pvorel@suse.cz>
 <4508acbd-3ca2-b1b4-ff38-6ffa573aa6fd@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4508acbd-3ca2-b1b4-ff38-6ffa573aa6fd@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] aiodio: Set timeout 30 min
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

> Hi,
> only dio_sparse really needs higher timeout because we use it for a slow
> stress test in a runfile. dio_read should get a lower default number of
> child processes instead (8 or 16 to keep the default memory requirements
> under 512MB).
Thanks!

I also noticed dio_read, but as you pointed out it's already fixed by
f3caabe44c ("Reduce memory footprint of the dio_read test")

> The other programs finish in less than 30 seconds so if anybody wants to
> use them for a custom stress test, it's their responsibility to set
> LTP_TIMEOUT_MUL accordingly.
+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
