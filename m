Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2FC6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 11:42:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BDCB3CD22A
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 12:42:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32D993CA503
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 12:41:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43F761000DC7
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 12:41:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30B9F21A00;
 Fri, 24 Mar 2023 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679658117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPSFvJZp9MHkytGBR0WkBlkwgkqffzB76WrRQ19lCIo=;
 b=2skwn1X/H3QETiKHa9tv1K3tn0FI88VnE5ioyUZ8vRjpLdKj9C08L0QpBh+2ekP5/7c2d0
 maWZqAPMcDK+UK+d3a/VS+IntprQ2N4H7m/MqNRZhmoneGNDGJqt+tSNHvJ0Fa2KE1eOm5
 NjI40/8U/iDZqXOqoJz8I1FUrfyKKsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679658117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPSFvJZp9MHkytGBR0WkBlkwgkqffzB76WrRQ19lCIo=;
 b=RCztzyHK/S2KOTHJYcTZkvIc91SaMk6xfz+6PUJqt7o4QXejo5UEeXIM0Cf/lPfzvoCo5X
 1108BkxgH+K9GMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEBDE133E5;
 Fri, 24 Mar 2023 11:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PXk4OISMHWTOawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 11:41:56 +0000
Date: Fri, 24 Mar 2023 13:09:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, ltp@lists.linux.it
Message-ID: <20230324120954.GA6872@pevik>
References: <20230323-override-unpriv-userns-sysctl-v1-1-0b62c71acd43@kernel.org>
 <20230323162459.GA476022@pevik> <20230323162904.GB476022@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323162904.GB476022@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers: override
 kernel.unprivileged_userns_clone sysctl where needed
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

Hi Seth,

thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
