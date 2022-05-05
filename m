Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA01C433EF
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:01:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06C013CA8B7
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:01:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693943C9F5F
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:01:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65472200A1B
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:01:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB1C01F45E;
 Thu,  5 May 2022 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651737694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfv7dy4HyvO5BLqdgcCBrwR81HCpKT+uwWIl+/RZWTQ=;
 b=qfT/Ei0UtR+Wi2aQL3gB6A9Za7xDtUkOD7oyu8jxkbe7ommzQwZTmcQ2PsEK+ffaIxls2c
 bFjPoQDigk0epd6XhDf7MZYY+4zUhWIoQSHiTxbJPptcdOxF7U/QNJDHuPsCvtlhDv540e
 hF6Pi4s44tTS4BLlu1IE1AnLKcvq3dI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651737694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfv7dy4HyvO5BLqdgcCBrwR81HCpKT+uwWIl+/RZWTQ=;
 b=/eSgxlgMoaMrHUgDRnIwCx/Cm+2/Ovp1/MyMnsZRdr+SpRhoCTzE7MuMzn/3wpnUX2JRjW
 B2/gqfhEHX6HWbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A53413A65;
 Thu,  5 May 2022 08:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 477FG16Ec2JkfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 05 May 2022 08:01:34 +0000
Date: Thu, 5 May 2022 10:01:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YnOEXB/xDIZBHFZ5@pevik>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <ce6c0683b6f053161fbb8b1469ad73e670e2d22f.1651176646.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ce6c0683b6f053161fbb8b1469ad73e670e2d22f.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/19] testcases/lib: Add tst_flag2mask function
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

Hi Luke,

> This function exists in the older test.sh and should be added here so
> that easy access can be made to map the flag to return values by
> programs and vice versa.

FYI we deliberately didn't add tst_flag2mask into new shell API.
I'll post more comments on next patch where it is used.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
