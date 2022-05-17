Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B3C433EF
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 11:42:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250463CAA7C
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 13:42:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73FB53CAA50
 for <ltp@lists.linux.it>; Tue, 17 May 2022 13:42:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 069C01A0065A
 for <ltp@lists.linux.it>; Tue, 17 May 2022 13:42:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC301F8F7;
 Tue, 17 May 2022 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652787733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQkTu4JO77SNhGFlzfRA/5M19yPOI7OrGFj/PAHpz00=;
 b=H9arHIRZvFG6dEtgCyGPGKff7QDyj/jbNtwT3mq2YbjG8yRFxYqt7lfjyaSrwn5pUUsREl
 s58hcuNrA8IcTMQQPGcZ2XD8VET5on3Tz/bOvwWgNFEtbZxRaz9Kl33xddd41HVZmn4/Xa
 JIZy+AED/ARez5fDumZS/0UAqrZQIpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652787733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQkTu4JO77SNhGFlzfRA/5M19yPOI7OrGFj/PAHpz00=;
 b=jkWeDnnWhcgP6rQTNfu3loIlYkSucMj9vNeoi9BO0FC/+5EToyUoTgxTnG5DSu7ewETvqj
 l/7mO+kk1kwY/ECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1135F13AA2;
 Tue, 17 May 2022 11:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZWW0AhWKg2JMegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 17 May 2022 11:42:13 +0000
Date: Tue, 17 May 2022 13:42:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YoOKE71nG6tG8T4S@pevik>
References: <20220310104457.764-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310104457.764-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] smoketest: Add macsec02.sh
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

Hi all,

> macsec02.sh is a network tests which uses macsec_lib.sh, which uses
> ipsec_lib.sh and virt_lib.sh which use tst_net.sh.

> Adding this test to smoketest to cover functionality of nested
> libraries. Use macsec02.sh as it requires more setup (unlike macsec01.sh).

I merged this one, replacing ping01.sh, to keep number of the tests the same.
NOTE: Although it's a performance test unlike other tests in net.features
macsec02.sh is very stable (looked for results for 4 architectures). In case
anybody complains about the stability we can always revert
be1888a9e ("smoketest: Add macsec02.sh, remove ping01.sh")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
