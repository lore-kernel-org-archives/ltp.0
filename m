Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1EC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881CB3C96FB
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:26:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52FA03C96C2
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:26:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24FD460148E
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:26:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0269B1F3B3;
 Fri, 21 Jan 2022 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642771582;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/r0e9GX9iQRn9p8xHdsPBXasc/Jy6FhC4/s0HKWNLM=;
 b=vgpB5jxSNjHNN0+RUt/g9ObzM9etu4FcyzrQd/rfniY8sotTFFSxZranqVWJW734ohghal
 idzHFePgUy524wz4sstvBApeViWQoW7/4bzj2eAgF0TKAWgHLpxzbaCNuaZplwgafRxk3P
 LnQLqmU9HoIw1cYO0MI/zZTdboQ+geI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642771582;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/r0e9GX9iQRn9p8xHdsPBXasc/Jy6FhC4/s0HKWNLM=;
 b=3EuK3cK2/9mOnvzYIeyOW5LPZqR3qQeojoXJ/szZaxz4kfTbpy9HBCCzXOWj0NHHN/oMtW
 VYRWrRbwNCv5PcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2F7C13AF2;
 Fri, 21 Jan 2022 13:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d3JjKX206mFCSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 13:26:21 +0000
Date: Fri, 21 Jan 2022 14:26:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yeq0e5h7EfuLIXtp@pevik>
References: <20220121100604.1072-1-pvorel@suse.cz>
 <205bdbc1-6216-8364-697d-36f7c98b3cb2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <205bdbc1-6216-8364-697d-36f7c98b3cb2@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

Hi Martin,

> Hi,
> one tiny nit below, otherwise:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Thanks!

> On 21. 01. 22 11:06, Petr Vorel wrote:
> > tmpfs does not support it.

> What's "it"? ^
+1, I'll add O_DIRECT.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
