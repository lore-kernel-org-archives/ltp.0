Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725D5C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:42:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 357C33CCD78
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 08:42:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2883CB708
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:42:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BA72200279
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:42:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D49B522A3F;
 Fri, 10 Mar 2023 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678434140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxMSEwHaC8jghs9dGGEcuJUpRWP7x674gGGMHPlBVJE=;
 b=EgbbxM811hzoZuZp6niksfFp7mnCRnf8QDcZ6CFEAI9dgal5LsKpNeBKhk8CiOarTXSKXi
 zqNyZTEa1CZDxc+YmeYIy7Wh2SloWfgSt/LrDTrlsxJ4BN3NlScmWchWUoarBl3k+lN31j
 PdvwnwMpb/9VxiW7c70ArS2aHULBdJ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3935513A77;
 Fri, 10 Mar 2023 07:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l+0ABFzfCmQyBgAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 10 Mar 2023 07:42:20 +0000
Date: Fri, 10 Mar 2023 02:42:17 -0500
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
Message-ID: <20230310074217.GA8843@localhost>
References: <20230215144820.17876-1-wegao@suse.com>
 <20230221020853.7650-1-wegao@suse.com>
 <ba91dc79-cbbe-52d0-8bcb-d0fda74dad34@miraclelinux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba91dc79-cbbe-52d0-8bcb-d0fda74dad34@miraclelinux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mq_notify03.c: New test CVE-2021-38604
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

On Fri, Mar 10, 2023 at 03:58:39PM +0900, Souta Kawahara wrote:
> Hi!
> 
> I tried this test on several environments and got the expected results. and
> no problems were encountered.
> env1) Test PASSED on glibc2.23-21.fc34 after vulnerability fix.
> env2) Test PASSED on glibc2.23-5.fc34 before the regression.
> env3) Test FAILED as expected on glibc2.23-16.fc34 after the regression,
> before vulnerability fix.
> 
> It looks good from my site.
> If there is anything else I should check, please let me know.
> 
> Thank you!
Thanks a lot for your verfication :)
> 
> --
> Souta Kawahara <souta.kawahara@miraclelinux.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
