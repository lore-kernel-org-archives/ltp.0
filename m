Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD69EB64DC
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:32:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C3193CDDBF
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:31:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F81E3C9CFA
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:31:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29E116008E3
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:31:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C65A21C90;
 Wed, 21 Jun 2023 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687350702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKAbWZw4slQz+cFKDZcOuBOXQYhvVHXTXU/lhLVApsI=;
 b=pxg4Y0vGbFJ8E+R/MLgwZuJJD3xC3Q+OWaUebt5ns23lXp/gkdKc9ucqLimSRbd/8rYK1g
 u4Hq1CSoBcnuTh2UqK963AS+biMenJcXzwypNycKS79YQ87BNIWeDSgYAvk9pWuPvowDrA
 m+lITnluJiFlOFFyQHrJwIQpXm/hnj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687350702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKAbWZw4slQz+cFKDZcOuBOXQYhvVHXTXU/lhLVApsI=;
 b=pHPEZ9rKMRiR1mIH3Z+d5qzWlbh5X3Wkn8duVSV3ki4TmXO4m5G8La4APtTE2Fu6FlH7TT
 XwkZK8tzZ2G/okDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AC70133E6;
 Wed, 21 Jun 2023 12:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EwfkEK7tkmT9SwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 12:31:42 +0000
Date: Wed, 21 Jun 2023 14:31:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230621123140.GA407092@pevik>
References: <20230621115443.12676-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230621115443.12676-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove KVM tests from CVE runfile
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

> KVM tests are currently limited to baremetal testing of x86 machines only.
> They have their own special runfile. The CVE runfile is used for testing
> any architecture and machine type including virtual ones. Adding KVM
> tests to it will cause non-x86 platforms to complain that the tests do
> not exist.

Good point, I'm sorry I forget on this during review.
Merged.

BTW I wonder if we should put some note to the file to remember this in the
future.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
