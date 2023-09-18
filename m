Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF8DCD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:49:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B38BE3CE4D9
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:49:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6FA63CA983
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:49:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB16C1A027B5
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:49:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CFB221B2A;
 Mon, 18 Sep 2023 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695037771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADI9Z0yIjA31BPbbDpRaivz1RYyBMb28wGEj+22WD68=;
 b=HAl0yjOpFxEE/IcXFiJbZSGkGgB38+SIrv78QvfwCf/RK5U4QRoDAyNTHojI9EedX/rhgr
 dfH2sEoq9iBRcuGlT8clCBjWEcZdc80PX5BdYMJZAIQwfrUX/AOOye6b7vdh5dzuSmgtiW
 I6Orf9vzpExgSr+W/Fcjdtm6NwuGCGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695037771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADI9Z0yIjA31BPbbDpRaivz1RYyBMb28wGEj+22WD68=;
 b=r/BNkyTh2Let/wgmIXqWVQwDSBG5XIidTyt1STP5SfstnLvpFrtNZXY69XpR7Bjs+oOTd7
 IIcAuw36dQwQrEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7636C13480;
 Mon, 18 Sep 2023 11:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UYyzG0s5CGVxYgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 18 Sep 2023 11:49:31 +0000
Message-ID: <d85fc0df-2e44-2cec-83d8-a7d6b7828e96@suse.cz>
Date: Mon, 18 Sep 2023 13:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Cyril Hrubis <chrubis@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>
References: <20230918112358.25858-1-rpalethorpe@suse.com>
 <ZQg4EN2EYZnjP5Sr@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZQg4EN2EYZnjP5Sr@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] kvm: Fix Nix build failure by specifying
 -fno-stack-protector again
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
Cc: mdoucha@suse.com, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 18. 09. 23 13:44, Cyril Hrubis wrote:
> Hi!
>> I found that adding the GUEST_LDFLAGS to the lib_*.o compilations
>> fixes the issue on Nix.
> 
> I suppose that, if nothing else, we should add just -fno-stack-protector
> to the GUEST_CFLAGS instead.

+1

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
