Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B4FC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 11:41:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60D43CA331
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 12:41:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F933CA30C
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 12:41:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C9EB02000C7
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 12:41:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 002BD218D9;
 Thu,  3 Mar 2022 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646307662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnCnOn11MDHtaU2GR1IuOG/NDPfHA8dDWuEBsq+WaQU=;
 b=BFI/GFH1OB65b8vuXwhk5hTOoGXyTq+iORi3b02klYKY/gNLQQKzS03T12pB9O5tKGXX1V
 N5WvWoz+eSq+5BK0fJRKa1HZ/0ocQ/zUrNk1l9H0VWmcrF6gGPw6exjaVtKz+QHBmYYcJu
 0SLy03l3p/37zzJ12LG077REzoQOX8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646307662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnCnOn11MDHtaU2GR1IuOG/NDPfHA8dDWuEBsq+WaQU=;
 b=lJ0z74WiODbV+JtEkMNKtw82SLNvA7gGofTzX6TAkU+aGzo1CG58EOOqZHDUQLQyuM10GE
 R09n91//SrIeOsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4AD013AB4;
 Thu,  3 Mar 2022 11:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gnS4Mk2pIGIhJwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 03 Mar 2022 11:41:01 +0000
Message-ID: <34bbc640-80d9-ad59-bb8f-d525e923ce91@suse.cz>
Date: Thu, 3 Mar 2022 12:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>,
 "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz> <6216E3ED.1050700@fujitsu.com>
 <Yhz1+H3SAlwPaO8H@pevik> <621D72EF.50500@fujitsu.com>
 <Yh3SOwogWwWQdZ4O@pevik> <621DD533.50509@fujitsu.com>
 <Yh3y0b7WRfYfBWHF@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yh3y0b7WRfYfBWHF@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 01. 03. 22 11:17, Petr Vorel wrote:
> FYI: in our case it was JeOS broken due missing quota_v2 kernel driver
> (JeOS tries to be minimal, so it's always a fiddling between space and
> functionality). I'm still not sure if we want to add check for .needs_drivers
> quota_v2.

.needs_drivers would probably be the cleaner solution.

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
