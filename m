Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971FC77B72
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 09:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6423CBFA1
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 11:14:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A326A3CB337
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 11:14:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C679260013C
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 11:14:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76E381FDB9;
 Thu, 20 Apr 2023 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681982055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/yQPRIX3XrlwWyhrHmwzRf9DVcKspcA7QyJNUDYb0Y=;
 b=IMiuNvAf7bpIBhSF5dsWKyYpLhNLuJ+2FgK8Mio36cUQEiSwbjIrvoNbE6cxmONRiqASIA
 n1I5MCExwyWNjJ5cm5/QXfNqOoNrYbbE3jxMiBlXR2V3D9d/KgPITxXmgJQn2GporMCBRe
 Qh7so9TeDzz+oQkmZ+go+21tTegN+38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681982055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/yQPRIX3XrlwWyhrHmwzRf9DVcKspcA7QyJNUDYb0Y=;
 b=CLe6jIhzLGnITEEjuWU/DRXLvH3q96tgKiHOH2Uh+hF6G2wtSkeWaHro6/QGwfw9n14RmC
 /xG3lJPNMHbdZRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59C8D13584;
 Thu, 20 Apr 2023 09:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sffxFGcCQWQKCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 20 Apr 2023 09:14:15 +0000
Date: Thu, 20 Apr 2023 11:15:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <ZEECphsAzkd3MRrZ@yuki>
References: <20230419114144.1219505-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230419114144.1219505-1-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Test to detect bug with freeing
 gigantic hugetlb pages
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
Cc: piyushs@linux.ibm.com, aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com,
 geetika@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've added a .gitignore and runtest entry for the test and pushed,
(please do not forget about that next time)
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
