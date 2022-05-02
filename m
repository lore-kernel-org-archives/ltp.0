Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1ADC433FE
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 14:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 282D43CA83F
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 16:01:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B22323CA7EC
 for <ltp@lists.linux.it>; Mon,  2 May 2022 16:01:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 196951A00700
 for <ltp@lists.linux.it>; Mon,  2 May 2022 16:00:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2208F210DE;
 Mon,  2 May 2022 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651500059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PU71b2xfHjQZqYdz7b6OBEGZgubY4Ygd+YZgqn5+3vM=;
 b=XGfFpQNyv8e8OEwmQ4HASYE7b1S4obHBAeqbQYhGgJ178P2FyI5T5a0gYXlkunzwx+p0tR
 TRnVmjoKAqzO7dwi2lg99AeduFR4HTQ7h2YtHQeengzEc/WuzYWGd7qZk7pJqIElbxWoMX
 xPr1/isJGeALd69QLzQqKM6AJ4BXQd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651500059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PU71b2xfHjQZqYdz7b6OBEGZgubY4Ygd+YZgqn5+3vM=;
 b=XhIQ2DpsE625lYrsxAkwFx3cLwCFIioYWsLOnpVKMgv6VFSIs+MfF55lMwxcyCqu1WLpQd
 uITZC7WY6p2HJICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01D013491;
 Mon,  2 May 2022 14:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TkjOOBrkb2IrJwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 02 May 2022 14:00:58 +0000
Message-ID: <829f83dd-0aa8-ad08-6852-2ab27da55b14@suse.cz>
Date: Mon, 2 May 2022 16:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220428065657.32046-1-pvorel@suse.cz>
 <539e2eb7-05d5-470c-3287-b1e9b7220532@suse.cz> <Ymwp2cilZtjn+g3y@pevik>
 <cfabdc28-fef8-576f-7845-630a443833d1@suse.cz> <Ym/hi05AYBqtifLO@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Ym/hi05AYBqtifLO@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] busy_poll: Move TST_{SETUP,
 CLEANUP} to the tests
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

On 02. 05. 22 15:50, Petr Vorel wrote:
> Makes sense. But I'd probably prefer to postpone this commit,
> because TST_NEEDS_CMDS will be in more shell libraries.
> Because even this cleanup so far wasn't my intention, I'd prefer to get it
> merged soon so that I can post rebased fixes for tst_net.sh with disabled IPv6
> (to get them merged before release).

Sure, if you plan to fix that in multiple shell libraries, then a
separate patchset is a good idea.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
