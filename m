Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECB4C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:18:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E04C53CAE83
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 14:18:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BED5F3C93D0
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 14:18:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD2DD2000D9
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 14:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A88371F894;
 Fri,  4 Nov 2022 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667567900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfsDY/Sbxbyh7tW7K7GMaJg83cA/beLw1/JvlH9Ij54=;
 b=1N2+8J3kBrg/Z3XX09WAgnXcq9v1qEZC1VdAGAbzGh88nn3Xfe/EfCWroGRiezHWbmRyll
 Ney1pkcZJbI+t4TmaA7hq6jglep9HBK+st0ktxvS8AOd3o/7EEX4/zNStQQ9X3OEDvcXkh
 vAJt3apnOQ3MXbcp/Q0JOMTCdPIOh4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667567900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfsDY/Sbxbyh7tW7K7GMaJg83cA/beLw1/JvlH9Ij54=;
 b=2ZZKA9swepkxBuQ/7dEeyXVc0LRC9OjIwrfZlQrkBu2CSr/zlM49LbVPCcqyI+tz8v9IqB
 izB6WP4TAtCG6lDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DA1013216;
 Fri,  4 Nov 2022 13:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hZN1IRwRZWMBBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Nov 2022 13:18:20 +0000
Date: Fri, 4 Nov 2022 14:19:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2UReVDcsxQctNYu@yuki>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
 <20221104062716.615021-4-tsahu@linux.ibm.com>
 <Y2TdNaxOzpaaCaPL@rei> <20221104131615.dac6oo3tt2f56xi3@tarunpc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104131615.dac6oo3tt2f56xi3@tarunpc>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > #define HUGEFILE MNTPOINT "hugefile"
> > 
> > ...
> > 	huge_fd = tst_creat_unlinked(HUGEFILE);
> > ...
> > 
> This function creat a file with random name, so that one test
> can call this function multiple times to creat multple files
> whenever required. So it will just take the path inside which it will creat
> all these files. To keep hugetlb test file with ditinguisable name, the path
> is sufficient, no need to take hugefile as argument. 
> 
> So file is: hugetlbfs/ltp_xxxxxx_<tid>

Sorry, I got somehow confused in the morning, of course the code is
correct.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
