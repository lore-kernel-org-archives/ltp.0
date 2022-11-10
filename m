Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A723C4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 07:32:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E34643CD648
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 08:32:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C926F3C00D1
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 08:32:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E620D10000C7
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 08:32:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E43133898;
 Thu, 10 Nov 2022 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668065555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICGwuclGRFDgFip+Tvo3KCirwPNblEOcJC5ol9esgJI=;
 b=mDuTAR+krn7eNqbWpcRAkWswvFwqEq2r5XITgOpnSUju9Qc0hbhkN4PTl0dTmlBfmYAf57
 3rhGwtB5BC7aCf3Pg04dtyKJdeLt0GPn56grG2XeT9DVU9AwZjV3XobcnPas+Ktb2/BMPG
 L49MuMcJ5RVwgBL5mhVmSr3B4EWCdrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668065555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICGwuclGRFDgFip+Tvo3KCirwPNblEOcJC5ol9esgJI=;
 b=5ciNfTCSa3yYpJHHU3sEJev2Jizc4w+0xyCc15WArIXypZ/P46Fk6TnDy4CR9bz2iX3DV5
 qdjSk/GwYhFcrZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A1BC1346E;
 Thu, 10 Nov 2022 07:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z6KFAROpbGOnIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Nov 2022 07:32:35 +0000
Date: Thu, 10 Nov 2022 08:34:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2ypbQSB60tMm4Ir@yuki>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-4-tsahu@linux.ibm.com>
 <Y2vS0slepYtvWQBx@yuki> <20221109184020.y4wyeli6cegffgby@tarunpc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221109184020.y4wyeli6cegffgby@tarunpc>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] Hugetlb: Migrating libhugetlbfs
 fadvise_reserve
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
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes. I am thinking of adding it to tst_safe_macros (SAFE_POSIX_FADVISE).
> But there are other tests, that uses it raw
> (https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/mincore/mincore04.c).
> Was there any reason to not create a SAFE_MACROS for it?

I do not think so, we started adding safe macros for the most common
calls and slowly moved to the less common. There are still plenty of
calls that should have been added and tests converted to use them.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
