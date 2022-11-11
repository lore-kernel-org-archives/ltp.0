Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F48C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:18:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74B553CD544
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 10:18:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2BE3C816F
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:18:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89300200D58
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:18:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1330720167;
 Fri, 11 Nov 2022 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668158285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sg0XL9IMMLHu41b3KMPw143SB4/bUxyeRYmvJVGYUhk=;
 b=iUiCtmLjvTRIAwo7RL0RPt0jNtLzE2wqZAEJgByrgFPpJflpTDDHxtkrKRvjRL/hgJ3Z46
 l1B4kQUDwE6XJQ6rTrrH1WfP8LmQYB2/zW9rIPRxTQ2X8l+RXXFVKB5goaFOL1HL7Vitj4
 fy1uLqgF3VOV4JeEXfJvkG74jMErTUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668158285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sg0XL9IMMLHu41b3KMPw143SB4/bUxyeRYmvJVGYUhk=;
 b=y+iq6ZFC1pB8zHh2yELDaOlN/q/OMvlpwdcFA+Mq//7dZ4bZpSe5yPJunv6ahmwVUp+68y
 Q/iE3yrnO5lJ2HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7334413273;
 Fri, 11 Nov 2022 09:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2YCyGUwTbmPiWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 09:18:04 +0000
Date: Fri, 11 Nov 2022 10:18:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y24TSnsYYCQxAJwW@pevik>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
 Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

thanks a lot for providing more complete description!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
