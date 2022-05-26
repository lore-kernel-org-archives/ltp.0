Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6195CC433EF
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 13:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 781FD3C0FB0
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 15:21:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5B73C0574
 for <ltp@lists.linux.it>; Thu, 26 May 2022 15:21:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29FFF601145
 for <ltp@lists.linux.it>; Thu, 26 May 2022 15:21:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D5BF1F8E0;
 Thu, 26 May 2022 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653571267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhU2UKraUD6UCKoy9laIyy1/Ei8T/mfaEgtqbwXbZ0c=;
 b=Li/18SNjHz6VP4mPK2u1U9/wJjuReyibjnjHi2/y6CZ7SYUHwxEA0/Ru6HRkspO8CW/BRB
 mWv1uJUD1Svv+J7fsOElUizHynr2yRkuqDb/eQMJ8sBm8fMWjHfEVkzBmKQlio9brZv7EK
 ocNS07QR7vUmD2LAX7xBqwNUU86Twrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653571267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhU2UKraUD6UCKoy9laIyy1/Ei8T/mfaEgtqbwXbZ0c=;
 b=cmp93at4feieeCZ4L0N9ZTgDkY3vZ/7b/6amcWjzFhehaGkg8eBVBKhe7UqTelE7ZyTDJF
 UbMipwBh/0VEZYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36ECA13AE3;
 Thu, 26 May 2022 13:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EzbXCsN+j2IAYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 May 2022 13:21:07 +0000
Date: Thu, 26 May 2022 15:21:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yo9+wTjKm3H9lgpd@pevik>
References: <20220525113113.9811-1-chrubis@suse.cz>
 <CAEemH2dsasry++GmBxgbTRRAryrBs3FPtYgXMNEmDcOK--r4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dsasry++GmBxgbTRRAryrBs3FPtYgXMNEmDcOK--r4XQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/timer_settime03: Scale interval with
 clock precision
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Li,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Could we merge this before release?
Do we need more testing? (some testing already done on by reported on
https://github.com/linux-test-project/ltp/issues/925)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
