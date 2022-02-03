Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F7DC433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 17:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7CA3C9ACC
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 18:05:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5263A3C9871
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:05:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7A251A010C8
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:05:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB1D11F3AF;
 Thu,  3 Feb 2022 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643907928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d7gVBUhdV9vSi1hHDARmL1+gAtLmoGKp5TL9ff04ul8=;
 b=Ph0m1m/dOfaZVkt8oDE4i9bOiaqVkgohqIldS9xOvy5nJuh92eAFA4a9uz8nKrHAht7slX
 xRmaBP3QZRRlEQcCDHqxAwxY5bwv6iJ8xEcOqjo1TE3PEbQRhIHjEvABhk5b+twL07ObcK
 Y1HB6NpeZeKFMjKer5iEBaxo3IZEdMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643907928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d7gVBUhdV9vSi1hHDARmL1+gAtLmoGKp5TL9ff04ul8=;
 b=SKONZNtAUUl16djZYzFtp8/9AR10qXevV+HaMNQALlRJdcdAQA2eu1IRZVZTO7MP4T2TFR
 IiN+Qrp1hK/gYwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98CE013A07;
 Thu,  3 Feb 2022 17:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xN7yIlgL/GEJOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:05:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 18:05:20 +0100
Message-Id: <20220203170522.22051-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix SCTP tests on systems with disabled IPv6
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich <vyasevich@gmail.com>,
 linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this is needed for systems which boot with ipv6.disable=1.
Although we have some discussion what should be the primary repository [1],
I'd like to get this fixed in LTP sooner than later.

I could not stop myself to fix little bit of broken formatting (first
commit), but I can drop it, if that's easier for backporting to the
other repository.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-sctp/Yfu4ucYOvXbOqXYt@yuki/T/#md06d317a4200592ed5c3a47ff30884a224c503c9

Petr Vorel (2):
  sctputil.h: Fix some formatting
  sctputil.h: TCONF on EAFNOSUPPORT

 utils/sctp/testlib/sctputil.h | 105 ++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 31 deletions(-)

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
