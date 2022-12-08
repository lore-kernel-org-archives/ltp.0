Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8423DC63705
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 08:55:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15B73CC058
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 09:55:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55513CC037
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 09:55:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D26721400073
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 09:55:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E3289207C0;
 Thu,  8 Dec 2022 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670489718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilHE6FSN/7XaNkqEZL84kwRJfzDsUEJ9hMBdQRTl1+o=;
 b=gYUXxyOcJRaK5LXvag3acbZXanhpMyU06B+5Plw1+WrjIgTr6rt9rMajkltsiA8sEHyokq
 IcTjo6J+vfvlHWk+evSwUCu3z7v2l9Ojzk+RlpWv/G05L3cLH1gP1N+/3E0xUx6Hmz1ks1
 KcsKQwC0ZSCGKry8OOeWvlFGSrje8Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670489718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilHE6FSN/7XaNkqEZL84kwRJfzDsUEJ9hMBdQRTl1+o=;
 b=xe0d1cP466Y9Nwk5kWT8nPhofPKElhx3QLIMKGaTIHBiGOTMOvxvmtJ9gG8a2lCXBVex9t
 yulAPaDb9vxciiBg==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 978B52C372;
 Thu,  8 Dec 2022 08:55:18 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-2-tsahu@linux.ibm.com> <87r0xet3pt.fsf@suse.de>
 <20221207124758.e75o72ozwltbchyb@tarunpc>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Thu, 08 Dec 2022 08:54:19 +0000
Organization: Linux Private Site
In-reply-to: <20221207124758.e75o72ozwltbchyb@tarunpc>
Message-ID: <87sfhqqnpo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] Hugetlb: Migrating libhugetlbfs fork-cow
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
Cc: aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 ltp@lists.linux.it, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Hi,
> Thanks for reviewing it.
> On Dec 05 2022, Richard Palethorpe wrote:
>> Hello,
>> 
>> Tarun Sahu <tsahu@linux.ibm.com> writes:
>> 
>> > +
>> > +#include <sys/wait.h>
>> > +#include <sys/mman.h>
>> > +#include <stdlib.h>
>> > +#include <unistd.h>
>> > +#include <sys/types.h>
>> > +
>> > +#include "hugetlb.h"
>> > +
>> > +#define RANDOM_CONSTANT		0x1234ABCD
>> > +#define OTHER_CONSTANT		0xfeef5678
>> 
>> It seems their are actually 3 constants as "random" is inverted. I'd
>> prefer it if they had names like C1, C2, C3 with no connotations.
>> 
> Yeah, Will be more cleaner, Will update it.
>
> --skip
>> > +
>> > +	SAFE_WAITPID(pid, &status, 0);
>> > +	if (WEXITSTATUS(status) != 0) {
>> > +		tst_res(TFAIL, "Child failed: %d", WEXITSTATUS(status));
>> > +		goto cleanup;
>> > +	}
>> 
>> This can be replaced with tst_reap_children();
> Ok. I will update it in v2.
>> 
>> > +
>> > +	tst_res(TINFO, "child_readback = 0x%x, parent_readback = 0x%x",
>> > +			*child_readback, parent_readback);
>> > +
>> > +	if (*child_readback != RANDOM_CONSTANT) {
>> > +		tst_res(TFAIL, "Child read back 0x%x instead of 0x%x",
>> > +		     *child_readback, RANDOM_CONSTANT);
>> 
>> I think this could be checked at the end of the child and the extra mmap
>> for child_readback removed. The LTP lib already creats some shared
>> memory with children to propagate results.
>> 
>> Assuming that mmap is not needed for the original bug reproducer.
>>
> Looking at the fix: 86df86424939d316 ("Correct hash flushing from huge_ptep_set_wrprotect()")
> seems it can be done. I will look at it and will update it in v2.

Thanks and as you have the git commit hash, please add this to the tst_test.tags.

>> > +		goto cleanup;
>> 
>> I don't think this is necessary.
>> 
>> > +	}
>> > +	if (parent_readback != ~RANDOM_CONSTANT) {
>> 
>> These comparisons could be replaced with TST_EXP_EQ_LU or TST_EXP_EXPR.
>> 
> Ok. Will update it.
>> -- 
>> Thank you,
>> Richard.
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
