Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D379C433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 09:11:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A12403CA6E6
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 11:11:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C453CA6AC
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 11:11:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 77AA71A0088E
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 11:11:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6430F21115;
 Thu, 21 Apr 2022 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650532301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJ7M8osFbD6EH/8xzu3fq1zbAIyfrZ91jd363QSLhDc=;
 b=nLneRxMZjACSPa5rc8Qtmz/f/Dc+1soFSyMaWDryxfsJoDUZiPhEOwwUwXXv+id+uZj+85
 HyQP9yMLlKD5u4b2emr4MPsfDxFQVS1tBlCRJc4iPestzW10zHaTgUBoT2BFrSoVhq2/25
 GB468zBrYL3SKqmz7H/AbXclvZnb2cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650532301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJ7M8osFbD6EH/8xzu3fq1zbAIyfrZ91jd363QSLhDc=;
 b=X+BvsHcawJNGr6frV9r5y35uXrdWc3UGBKnyJY1VcSWoURp8u6KM9iyuf1AUwgN6iKa0Au
 HBgopmHk4QxARFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 451B513446;
 Thu, 21 Apr 2022 09:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +kzLD80fYWKJPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 21 Apr 2022 09:11:41 +0000
Date: Thu, 21 Apr 2022 11:13:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YmEgVS3DBARBkYOx@yuki>
References: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
 <YmBwWqS0GEuwnb/d@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmBwWqS0GEuwnb/d@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mount_setattr01: Add basic functional
 test
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
Cc: ltp@lists.linux.it, Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +struct mount_attr {
> > +	uint64_t attr_set;
> > +	uint64_t attr_clr;
> > +	uint64_t propagation;
> > +	uint64_t userns_fd;
> > +};
> Interesting enough: in kernel tools/testing/selftests/mount_setattr/mount_setattr_test.c
> defines it as __u64 (IMHO should be really uint64_t as that test is userspace as
> Cyril pointed out) but real kernel code in fs/namespace.c happily uses "unsigned
> int" :).

You are just confused by the fact that there are two different
structures there is mount_attr and mount_kattr, the mount_setattr()
syscall gets the mount_attr from userspace and then fills in mount_kattr
based on that. See the function build_mount_kattr() in fs/namespace.c

I guess that this is simply done so that there is enough space for flags
to be added in the future without a need to change the structure.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
