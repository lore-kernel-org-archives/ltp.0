Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA93EB64DA
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62CC73CC03E
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:25:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1826A3C99A4
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:25:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A466600125
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:25:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB5722665;
 Tue,  4 Jul 2023 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEsgIO3025jMD7zsxgPaamaBbO1RwaJuzQwBi69y2Gk=;
 b=fx6M17OTi0CYokzqoUeo80+lQWDriChhkVpRV8xjhIceOft8q/5/dSMgQsh/DsA3dtV8mY
 c13mOpEbN4yyUnp8JBUxrWh0pq2GGruDPVB348fC+qwlWb0Op7O5zfFeY8Ijr0M2Ioe44J
 NTVodmV6Gl1dTpr5lumBp9H/3j7hmiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEsgIO3025jMD7zsxgPaamaBbO1RwaJuzQwBi69y2Gk=;
 b=S4UV88t7xZWSIpMcOZdGErJlemPBT7h+Q+/u6jxHDTnmjf8JiMKwhvAKYaxXHr4Qdy7Op3
 a1mpeUv8OkX2/GBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E9C3133F7;
 Tue,  4 Jul 2023 09:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSbVHZHlo2SSTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:25:37 +0000
Date: Tue, 4 Jul 2023 11:25:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230704092536.GA497945@pevik>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230704091933.496989-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

obviously this is wrong, because $(top_srcdir)/Version (ltp-version.h
dependency) is not specified in the top level Makefile (only Version is
there). But I'm not sure if it should be changed to
$(top_srcdir)/Version.

I suppose ltp-version.h should be in include/, but here I'm completely
lost with dependencies under lib/. My goal is to type make in lib/ and
make sure the header is generated (dependencies correctly resolved).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
