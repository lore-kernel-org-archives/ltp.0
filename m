Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77383C433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 12:04:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D45161131
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 12:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D45161131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE47A3C9705
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:04:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0313C22CB
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 14:04:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A37A200DEC
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 14:04:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E421A20138
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631102665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a9QDi12j26HmQzJC/IgpWkqBJ7VUWmiRe2LBRhn/63c=;
 b=hgIvg2q+oIS2DU/dLaepQ5oiAG6F3oM89LDSy2XDtv9y7WUM/VsfFoNgw47gyYwsWrTeZ+
 pdoIUVEL+LWmft7mXFD29VPVxl2pWpAs8HTh1IncncWuskejEJIbgT5nuVcmAqa/UVQBo1
 0O8EJxGdQ8hL+dMlkzoTJoAUQOLToTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631102665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=a9QDi12j26HmQzJC/IgpWkqBJ7VUWmiRe2LBRhn/63c=;
 b=XYbtCmt0qOQoc++uJxpxyItluil+j+U3vak2WYgeQS1gNUNpjjU5Tl21AcFzLuGPyq7bO3
 dywp/xe+i2qXTWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C16F313D0B
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 12:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mcquLsmmOGFoZQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 08 Sep 2021 12:04:25 +0000
Date: Wed, 8 Sep 2021 14:04:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YTim11sKKT8ioZBe@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP release planning
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908120439.Ef3QXalZDok7-dY1DmWRVibLYbWLYncIoHydCA9K1Ho@z>

Hi!
Since september has started already we should start preparing for next
LTP release. Lately we tend to release at the end of the month, which
still leaves us plenty of time for the preparations.

Looking at the calendar we should start the git freeze at the end of the
next week on Friday 17.09. That would give us a bit less than two weeks
for pre-release testing and then we can finalize the release at 29.09.
or 30.09. If this schedulle does not work for you, let me know.

If there are no complaints I will continue to review patches until the
end of the next week, especially the ones that have been hanging in the
queue for a while.

And lastly but not least if you have some patches that should be
included in the release please make me know ASAP so that we have a
chance of getting them in.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
