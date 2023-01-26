Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E0C54EAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 23:01:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BDE03CD36D
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 00:01:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 401C73CB5BD
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 00:00:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C08471000C13
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 00:00:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 814901F8A8;
 Thu, 26 Jan 2023 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674774046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7EXtEgYOQI23G3BOCqpnOex0tLhMePgQZIqp60h6X8=;
 b=ZlCF3l7otx9axGPf0ecHD+A+GJzWWxDIJktbDBqnxuRvYfMh6KerjmBrjhgJvIsdixb29F
 ku4SatW6CusFk5TeBih0dIo7G+w+iMhy2cXg9VcNVeFBQcVc3I6yvrjFE1pYcb5RfOcgip
 z4CkXso1ovoc60PZLjuWU2x5j+ZGGxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674774046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7EXtEgYOQI23G3BOCqpnOex0tLhMePgQZIqp60h6X8=;
 b=Akjei4kyz7byoemvOP7F5KagVBoUdVOVRoKieiniAGqF++GuCqYdSq3GN+4CkSHPPSuixC
 kw6DKwC08545RMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 459B813A09;
 Thu, 26 Jan 2023 23:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id puXvDR4G02MIAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 23:00:46 +0000
Date: Fri, 27 Jan 2023 00:00:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y9MGHKXel5kjwoTT@pevik>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-2-pvorel@suse.cz>
 <87edrh0zy2.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87edrh0zy2.fsf@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tarun,

> Hi Petr, Cyril, all

> Though It already got merged, please note this,
FYI this has not been merged (only the second patch "hugemmap15: Use
TST_TEST_TCONF() for unsupported archs", which was needed to fix compilations).

> IIRC, I specifically turned off optimization for hugemmap15
> because of clang compiler issue, it behaves weirdly with clang
> without -O0 and test fails on the system.

Isn't -O the same as -O0 ?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
