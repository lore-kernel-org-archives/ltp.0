Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEFAC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 11:37:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 771D63CC0AC
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 12:37:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 088EF3C0204
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:37:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F34B60073C
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:37:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B35265C8C7;
 Thu,  9 Feb 2023 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675942627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fS8jYP59qcw5rJW7/vyAr9vppFC6aGsQdLneSsj2zn8=;
 b=nf2gl2gEcOQRcPI/KoAgANBVZHPQsrrkkaHWKA9JMcAVjC/Vp5396e3Q2X+BykKxwWYaSb
 t1yibaPBP4aH52XOzirXwKf7VK9bQIbM1S2gQ6iuPulA7I1TEdIx7ymBnNN5Jt+vzPZs60
 u3o1e2s5srvEQEyWC+U19Vj4K760iX8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F178D138E4;
 Thu,  9 Feb 2023 11:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EYpOL+La5GNOQgAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 09 Feb 2023 11:37:06 +0000
Date: Thu, 9 Feb 2023 06:37:04 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230209113704.GA25132@localhost>
References: <20230129115021.25778-1-wegao@suse.com> <Y9pf5075zsuAhznN@pevik>
 <Y+DYmkBnv/NQK8gZ@aa> <Y+Eoqd5+bWPxlpXD@pevik>
 <20230208090148.GA8108@localhost> <20230208154823.GD1918@pevik>
 <20230209022522.GA10910@localhost> <Y+TGpsrGdPy13FSK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+TGpsrGdPy13FSK@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 09, 2023 at 11:10:46AM +0100, Cyril Hrubis wrote:
> Hi!
> > Let me explain more detail for this:
> > 
> > CVE-2022-0185 security bug popped up since 5.1-rc1 and fixed by 722d94847de29 in v5.17-rc1~50, so normally we should check build from v5.17.
> > Most important thing is this security issue ONLY happen if fsconfig go through legacy_parse_param function(security issue happen and fixed within this function).
> >
> > But:
> > For xfs filesystem, from v5.5-rc1 already start use xfs_fs_parse_param instead of  legacy_parse_param, so make no sense check this secruity issue
> > For ext2&ext3&ext4, after patch cebe85d570cf8 in v5.17-rc1~131^2~36, use ext4_parse_param instead of legacy_parse_param, so also make no sense check 
> > 
> > In summary, we can reject this test case since from v5.17, ext2/ext4/xfs not go through legacy_parse_param and means we can not verify security fix 
> > 722d94847de29(this fix happen in legacy_parse_param.)
> 
> Quite contrary it make sense to add regression tests for kernel and keep them
> running on all filesystems and never releases since you never know when
> similar mistake will make it into the kernel code again. It does not
> make much sense to invest time into tests only to keep them disabled
> later on.
> 
> More generally it makes sense to try to throw all kind of garbage
> strings into fsconfig() and expect to get EINVAL or other sane behavior,
> writing such tests is the only way to avoid or at least catch most CVEs
> before they happen.
> 

Thanks for review this, i will update the case later.

> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
