Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A57DC433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 09:07:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B6A23CA8EB
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:07:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BDD3CA55B
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:07:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7E341A01727
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:07:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA36E21882;
 Fri, 30 Sep 2022 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664528818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+TJVPucdbWzfkpefeSUetjyN61t9JlBWyVCHsrPWQQ=;
 b=gBm/3TGxyKQg0QCOqnjHZyNTi6tzvM1LtELvT10uTbEIhifymiDCq4fRZOOvT6dtEmm1y7
 Wt3D4Lv4+vss6lk9m0hpfl3TU2GUYibHJSFe0qkOUeW4wXUjUig2nBv0Ryqh6WwFpqh7b5
 vBfjbVW4BsaoHR3XaANDyNaLmctJHL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664528818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+TJVPucdbWzfkpefeSUetjyN61t9JlBWyVCHsrPWQQ=;
 b=d4uz1HjnsShUwI6SRVw73lLVf5MbaJ6Q0C176g15ecje65g1IMYMPc2G00pXdHqfKupDiW
 oTugA37duHfz3HBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9444513776;
 Fri, 30 Sep 2022 09:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w+IJIrKxNmO8VAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 09:06:58 +0000
Date: Fri, 30 Sep 2022 11:06:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YzaxsM95JXaJPn6p@pevik>
References: <20220929192047.22125-1-pvorel@suse.cz>
 <YzaxFda/gGg1TIBR@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzaxFda/gGg1TIBR@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Fix minimal size for XFS on kernel
 5.19
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

> Hi!
> > mkfs.xfs for kernel 5.19 bumps minimum filesystems 300 MB. Due this we
> > already updated minimal filesystem size for all_filesystems /
> > $TST_ALL_FILESYSTEMS in 66e05c841. But zram01.sh does not use the API,
> > thus update it now.

> > Check for RAM size was added for f18c8fd3a for Btrfs on ppc64le due to
> > larger page size. Hopefully this is not needed.

> Looks to me like that check is there to make sure we have enough RAM to
> run the system and create the filesystem at the same time.

> It does check if we have more than 1G of memory, which seems sensible
> if we are going to allocate ~300MB for a RAM based filesystem.

> I would say that we should really do the same for xfs, i.e. rename the
> check_space_for_brtfs to check_space_for_fs and pass the fs in the first
> argument so that it can appear in the tst_res message.
BTW I even had originally this version prepared, thus this v1 is wrong due this
left over:

-                       check_space_for_btrfs || continue
+                       check_space_for_btrfs "$fs" || continue

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
