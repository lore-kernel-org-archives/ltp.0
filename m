Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455EC433FE
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 17:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EE1C3C9AB8
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 18:48:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44473C6912
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:48:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEB24600C77
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:48:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E68CB21123;
 Thu,  3 Feb 2022 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643910517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4evBO+POjQzamNc4DHb8Bx/EMzfDWMdsaLbNmOWVCa0=;
 b=sS5h+fqayr9QJBnAV9sYn/AtXlxnjyEy2lVAShVgNmoPDPeLECJa9QcDjd2aKnsW7hGX1O
 8VokbGeSjNX8FeitrahWGjzplq6rB8emKl9pMpxD+5OfBVsdDbDn5N+vBjH9pqkUt5+n+X
 FJ6inRnHaALIP9dxoCndYZ/GwaDU3SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643910517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4evBO+POjQzamNc4DHb8Bx/EMzfDWMdsaLbNmOWVCa0=;
 b=DJHNapkDoLtoeSVafMudNSqU3g8JEDtx4aacYoHeQgNDswhxFxqi0gN9xI5ugY2b3EoBP8
 bVP3Syxe73c4AiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0568513671;
 Thu,  3 Feb 2022 17:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nSj0OnQV/GEbTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:48:36 +0000
Date: Thu, 3 Feb 2022 18:48:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: automated-testing@lists.yoctoproject.org
Message-ID: <YfwVcwpZU/lusVlC@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] SCTP testing
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich <vyasevich@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Philip Li <philip.li@intel.com>,
 linux-sctp@vger.kernel.org, Joerg Vehlow <joerg.vehlow@aox-tech.de>,
 ltp@lists.linux.it, Erico Nunes <nunes.erico@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

we've been just discussing, which repository should be hosting SCTP tests [1].

Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
SCTP kernel developers repository [3] ? If you use integrated to some testing
framework, would it be a problem if repository changes?

Also, do you use LTP network tests at all?

Kind regards,
Petr

[1] https://lore.kernel.org/linux-sctp/YfpnVfrto4Elshy5@pevik/
[2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
[3] https://github.com/sctp/lksctp-tools

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
