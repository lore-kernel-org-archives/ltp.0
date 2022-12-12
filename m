Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA51C4167B
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B32E33CBE54
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:33:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A490A3CA4DD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:33:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0BBC8140044A
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:33:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E2F6F1FE03;
 Mon, 12 Dec 2022 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670855583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fy4Z5XWTKK7uQykqY9xjuWAV2ks1bEzxKuEUBtyglno=;
 b=a+MlTjpcAHs/sIWbQuoOjLBxEiYAojaXT4J+r7FFhvIptWY1O9zbtMvfjQLvfI2RE+nefU
 VIl2qJNXlpnhv7HDdjIPcZ62axxNn/XaZDYBfpGuDBI42u3NuXAbmTlpJBv+EHjhu/Z/lC
 8q73k25/Ai4N+zpt2ZrbxApEf2lJ3RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670855583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fy4Z5XWTKK7uQykqY9xjuWAV2ks1bEzxKuEUBtyglno=;
 b=luKZoURdcqNsQxP51nRcHYvv38yi1s4OdWkMKie5jCEvZ8tH3rKMLr9agDTjGdVmu/V2yC
 Cf6OIBcBrBrfCgCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 911AF2C141;
 Mon, 12 Dec 2022 14:33:03 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-8-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 12 Dec 2022 14:32:09 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-8-tsahu@linux.ibm.com>
Message-ID: <87v8mgu1y8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/8] Hugetlb: Migrating libhugetlbfs misalign
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
Reply-To: rpalethorpe@suse.de
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/misalign.c test
>
> Test Description: Just as normal mmap()s can't have an address, length or
> offset which is not page aligned, so hugepage mmap()s can't have an
> address, length or offset with is not hugepage aligned.
>
> However, from time to time when the various mmap() /
> get_unmapped_area() paths are updated, somebody misses one of the
> necessary checks for the hugepage paths.  This testcase ensures
> that attempted hugepage mappings with parameters which are not
> correctly hugepage aligned are rejected.
>
> However starting with 3.10-rc1, length passed in mmap() doesn't need
> to be aligned because 'commit af73e4d9506d
> ("hugetlbfs: fix mmap failure in unaligned size request")' added ALIGN()
> to kernel side, in mmap_pgoff(), when mapping huge page files.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
