Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ADFC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 10:00:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 774CD3C9ADB
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 11:00:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341C73C9871
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 11:00:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 734786006EF
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 11:00:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 037E7210FD;
 Fri,  4 Feb 2022 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643968798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSoPYePboxor4Y3sFnHGsIOJ6PTY/OTdzABZ+tXLqdM=;
 b=iv4YVd/kN3Tew39vJGHctlp9t3kObg9eEhw6xx9BCQKqzxRYE/LGb1sa1fbhHCAnwgNGXf
 fw50m9jmhFsnCjofV1/n5Tt4SWvskZgV0+N8rYWXwJpUCVAcb08mkPflWuEO6esn1VuFGB
 jziC1mAfGSV5RRlbelrKdjBUcXXOd14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643968798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSoPYePboxor4Y3sFnHGsIOJ6PTY/OTdzABZ+tXLqdM=;
 b=gTauqOch7bZdcAgyttIEp83jVfR+OnGAcBGZA9IUlR3JHBvK1Q+owUaZMX6qI3eoc0eyO1
 tALPjEIBZrpH4jDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E12E413A49;
 Fri,  4 Feb 2022 09:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oG8zNR35/GEtDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Feb 2022 09:59:57 +0000
Date: Fri, 4 Feb 2022 11:01:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yfz5lF4SR0s7bv/N@yuki>
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-6-rpalethorpe@suse.com>
 <CAEemH2f6PYXGEDrARM7JKCr08K-GEfRa9xJKPLChSG6bnvVpoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f6PYXGEDrARM7JKCr08K-GEfRa9xJKPLChSG6bnvVpoA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] API/cgroup: Make tst_cgroup_group_mk
 sprintf like
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Seems this is too strict for some compiling.  e.g.
> 
> cfs_bandwidth01.c: In function ???mk_cpu_cgroup???:
> cfs_bandwidth01.c:64:9: error: format not a string literal and no format
> arguments [-Werror=format-security]
>    64 |         *cg = tst_cgroup_group_mk(cg_parent, cg_child_name);
>       |         ^
> cc1: some warnings being treated as errors
> make: *** [../../../../include/mk/rules.mk:37: cfs_bandwidth01] Error 1
> 
> gcc version 11.2.1 20211203 (Red Hat 11.2.1-7) (GCC)

Ah, right, that's the __attribute__ format printf. I guess that we would
have to live with changing all the calls to
tst_cgroup_group_mk(foo, "%s", child_name)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
