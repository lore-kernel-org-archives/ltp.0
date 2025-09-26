Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF97ECAC5BB
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 20:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98EC73CE155
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 22:31:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCCCD3CA61F
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 22:31:42 +0200 (CEST)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89E18600B38
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 22:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758918699; x=1759177899;
 bh=/JJtfZsl1uOmD3Ux3p08BJrPtjUDI0yxFpvWX7xgyJM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AZqMYzrl1VVRCjmqRquMy/Ak6zgN39lEkgwN6y8LPX6U3OxGM7x0HHIAAQhvRICdR
 dU6PLm/Z5amRsqqiAvItFATjCMcwXszvuob19MD8CE9kSQfahEb6Muuc4ziC/KLB42
 e3egDbw+abWLVGToiMJTRQA7SQzuyddhMK3ZsDJn8YESQ6GrNqYouCjzxnfK+FfCCT
 3LLc9j13wslsuvpwHkS1XgzeBG3RkkyGUn7bzqy5PwVWz2vKMSkiMYTK89RTZyEg5W
 kC2yLJYjDiMz3/mxxumQnJwTVWMo2Rag3x7kYcvE9PS/S35uVLdnckpUWOZbmLmF5Q
 S1V6pWXd9ESXg==
Date: Fri, 26 Sep 2025 20:31:31 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <55d4c295-fb95-4536-9381-6fd79ffa3d4a@naotchy.com>
In-Reply-To: <f69056a2-1280-4490-9b49-cfcbc0999c6c@suse.com>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <20250926040707.671282-2-jmorgan@naotchy.com>
 <4d514eb9-cf7e-430e-a0ad-dfffdf947fcc@suse.com>
 <f69056a2-1280-4490-9b49-cfcbc0999c6c@suse.com>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: 0cb9ed5ef89b8666c1cd694c589b5da05f455ea4
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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

On 9/26/25 01:22, Andrea Cervesato wrote:
> On 9/26/25 9:32 AM, Andrea Cervesato wrote:
>> +#ifdef HAVE_STRUCT_STATMOUNT_MNT_NS_ID
>> +
> According to the follow-up discussion, this is more correct:
> 
> #if!defined(HAVE_STRUCT_STATMOUNT) ||
> defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)

Thank you for the feedback. I'll update my patch with this change and 
send v3 shortly.

For the change to configure.ac, I've sent a separate patch for this[1].

Finally, the suggestion is to then drop patch for statmount.h as checks 
will be in statmount09.c test case, correct?

Is there anything else I'm missing?


[1] 
https://lore.kernel.org/ltp/20250926025318.612308-1-jmorgan@naotchy.com/T/#u


Regards,
Jack Morgan


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
