Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21690C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6EA3CBE6D
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:33:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CC2D3CA4DD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:33:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57D3D60078F
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:33:47 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AF8F51FE91;
 Mon, 12 Dec 2022 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670855626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EYYgXvAQeV7iDHbexmQvOPoLXM9M/1gQLn5SOIn6RM=;
 b=m7jez0RHItNENXhFsXe1mxIQOjitj0sT5hMzB3UrgnHhwYDKaQmlUen79sRf1aDhHaJ8sa
 Fpb6vI0c/3BjToeI55M/xuD6oXjbMe1fnchfe/PbgJXKx/TjlP1/0SM1Epk8Qo3EKJjgZL
 NQ21uyZNCrZwGrjDcaa9BuSbwLa9k4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670855626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EYYgXvAQeV7iDHbexmQvOPoLXM9M/1gQLn5SOIn6RM=;
 b=bds+MYSOz3yAjKgeRT6jUYa+x7BtSAScvEoHo45aTZFv/SR3AsqxK+o5w6cwB5erdBpdU9
 C0DA+KOC8LGE3qBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 61AF92C141;
 Mon, 12 Dec 2022 14:33:46 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-9-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 12 Dec 2022 14:33:08 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-9-tsahu@linux.ibm.com>
Message-ID: <87r0x4u1x2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/8] Hugetlb: Migrating libhugetlbfs
 misaligned_offset
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

> Migrating the libhugetlbfs/testcases/misaligned_offset.c test
>
> Test Name: Misaligned offset
>
> Test Description: At one stage, a misconversion of hugetlb_vmtruncate_list
> to a prio_tree meant that on 32-bit machines, truncates at or above 4GB
> could truncate lower pages, resulting in BUG_ON()s.
>
> WARNING: The offsets and addresses used within are specifically
> calculated to trigger the bug as it existed.  Don't mess with them
> unless you *really* know what you're doing.
>
> The kernel bug in question was fixed with
> 'commit 856fc2950555 ("[PATCH] hugetlb: fix prio_tree unit")'.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
