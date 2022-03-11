Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A4C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 14:34:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6651E3C8CBE
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 15:34:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2428E3C1ADE
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:34:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 919BA601039
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:34:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBF97210FB;
 Fri, 11 Mar 2022 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647009249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NKHq5P+uMAsjlvksN9baCj5d+TUHCXFkFdkhI6Ly9D4=;
 b=uZfiHgMyXeHRzzSWYnjyhhNXFheIl+bZuwopoPTMNt1GfSYY0XltAvYn+wuuAUXCpvh631
 FFqYCpUZIVH2IJ0vmsxoRAeuHXbXhLLwDdpsf4Uj2q/2cUW8fiDOIHt9t4LmJAP6jGCxDT
 tUssccchByPLLahL3kTKnLqFZxVT+uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647009249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NKHq5P+uMAsjlvksN9baCj5d+TUHCXFkFdkhI6Ly9D4=;
 b=x5tvfqZ3JfC24uyBfz6Qg9bPP77jTn2ZJRnEk5bYdIvI11ZqiQ3OVB4ntKaIDYJiVOZWm4
 mPP5EOGZcbEv3uBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A850813A89;
 Fri, 11 Mar 2022 14:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OAWzJ+FdK2KidQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 14:34:09 +0000
Date: Fri, 11 Mar 2022 15:36:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YiteaypbzivKl4gb@yuki>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-6-pvorel@suse.cz>
 <6205F185.5080603@fujitsu.com> <YgYF6AHb6XLMX3+2@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgYF6AHb6XLMX3+2@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/6] shell: Add test for TST_FORMAT_DEVICE=1
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +TST_FORMAT_DEVICE=1
> > > +TST_TESTFUNC=test
> > > +TST_CNT=2
> > > +TST_DEV_FS_OPTS="-b 1024 -O quota"
> > > +TST_DEV_EXTRA_OPTS="5m"
> > > +TST_NEEDS_CMDS="df lsblk"
> This is left over from previous versions => should be deleted.
> > > +. tst_test.sh
> > > +
> > > +test1()
> > > +{
> > > +	tst_res TPASS "device formatted"
> > > +}
> > > +
> > > +test2()
> > > +{
> > > +	tst_check_cmds df || return
> > We have checked df command in TST_NEEDS_CMDS, why still check it again
> > in here?
> Correct, TST_NEEDS_CMDS should be removed so that at least creating the device
> (test1) is supported even SUT is missing df.

And what do we need the lsblk command for?

Other than the TST_NEEDS_CMD= variable:

Reviwed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
