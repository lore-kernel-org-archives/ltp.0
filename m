Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29D3C04AA7
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 15:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DD403CA59A
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 17:39:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF3943CA59A
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:39:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 432861A01983
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 17:39:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 599F02023F;
 Wed, 20 Sep 2023 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695224369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drGXkrDiEYO8OtYCDSXtlkry50W+NrzM0b/nDhvXde4=;
 b=GwYrqX9oNNiX4Gk9bm1bNgadYsAOwEB6evkYHivi3mxnyxylutOrO2hYerULFu70Z4EESW
 E5r0jsQPDwdNx9m1wnFLNsIHAeEE1KZsEGSk0x4ibeLhA0qVVw6FxiPhLut6x488D7C+20
 M7dfBGeVXo+nJJ7/4V3X0TMGD4WOZgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695224369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drGXkrDiEYO8OtYCDSXtlkry50W+NrzM0b/nDhvXde4=;
 b=ArmG3G2vtoan7We38eVwc3x2/IS9HUXMZC5DxEy9YGCWuFlMB3zZ+6LQnFy3b56t1bVC13
 7knmZnLOdMYC6bAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4499132C7;
 Wed, 20 Sep 2023 15:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XPezMDASC2UyTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 15:39:28 +0000
Date: Wed, 20 Sep 2023 17:39:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230920153927.GC375961@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920095318.340582-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Few formatting fixes would be needed, e.g.:

-1. Release eve work
+1 Release eve work
 -------------------
 
-a. Collecting the (must have) patch list for new release
-b. Reviewing and merging the patch list of (a.)
-c. Widely testing, explicitly post results
-d. Tiny fix according to release testing
-e. Writing release note
+[start=a]
+.. Collecting the (must have) patch list for new release
+.. Reviewing and merging the patch list of (a.)
+.. Widely testing, explicitly post results
+.. Tiny fix according to release testing
+.. Writing release notes

But the text is what matters, thus not sending fixes before getting feedback.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
