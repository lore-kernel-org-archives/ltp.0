Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862EFECAAD2
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 07:06:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77F173CA777
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 09:06:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 105C53C0C9F
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 09:06:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 93BE01A000A3
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 09:06:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAC79220B2;
 Thu,  1 Sep 2022 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662015967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/u7rqWJN2HPb97lHryK9EaZeU/WHPm4mDBrJosya2g=;
 b=HCOdLFSmhRvUO1CFPcYX2tnMoPuUjTywkT5FpxuCva2c7KBJhFCxCr2KKWIj30X3EfENHa
 ZgWc7DsegssGa8rSRDnzNF3D+zY2IMH10ANAjQ7CLrecDIKfVM+v3iET8nKmV72WmJIrw+
 TvRvqdoY+wBMN4rsxpaNJBNZ0c5M+WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662015967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/u7rqWJN2HPb97lHryK9EaZeU/WHPm4mDBrJosya2g=;
 b=+oMKrNIqNg6F/s/kbbm8guW1Njbna27uOnmv8bu53OqCK5wkVdt5x1CFrUcgD7K6l15HBZ
 qkiSkV69Xr32dUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95284139C4;
 Thu,  1 Sep 2022 07:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o+XuId9ZEGOCLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 07:06:07 +0000
Date: Thu, 1 Sep 2022 09:06:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxBZ3Q3dmjKXVMfJ@pevik>
References: <20220714160514.21062-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220714160514.21062-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] write04.c: use TST_EXP_FAIL() macro
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

Hi Avinesh,

merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
