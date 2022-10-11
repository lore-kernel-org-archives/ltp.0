Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2FC4332F
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143AD3CAEB4
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 16:27:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E615D3C07B4
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:27:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B40E2005D0
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:27:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44DF91F8D2;
 Tue, 11 Oct 2022 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665498463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woWLOHkUwYan8fnqg/Bnnty8m6pm865uzU8r7bSVhkU=;
 b=HjVv1dvalkR8FMP8d39WElcwWgtrDVbA/4cw3xZKTF5GWaDMbtMxsiuKoRAu+D3TT5utRd
 BGIl1yeIAMxtVCNsnj1Xh5YfVlR4WTpfIk8R4NRhLwOhTq4zYz8a8Shm77yYL1L8slDrN4
 0LIrcL6StP/X9gvq9qXd6ftazy/Q9ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665498463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woWLOHkUwYan8fnqg/Bnnty8m6pm865uzU8r7bSVhkU=;
 b=2CO5GnKLJ1J44+uS3nm7j20dJ87I8s8zGSfIxiT9yJ/poY/8mnEbQ3uN4GuMk9zkEGMEDM
 TH6Gs4t9wIZFlUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21B44139ED;
 Tue, 11 Oct 2022 14:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r60SCF99RWOLKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 11 Oct 2022 14:27:43 +0000
Date: Tue, 11 Oct 2022 16:29:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y0V9yZfYbu97qEbZ@yuki>
References: <20221011121607.55575-1-zhaogongyi@huawei.com>
 <20221011121607.55575-3-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221011121607.55575-3-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
The MADV_DONTNEED has been implemented for hugepages since:

commit 90e7e7f5ef3f712da992d505aee2d921797c3f96
Author: Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu Mar 24 18:13:18 2022 -0700

    mm: enable MADV_DONTNEED for hugetlb mappings

So for newer kernels this actually works fine. I guess that we should
change the test to expect the call to pass for v5.18 and newer.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
