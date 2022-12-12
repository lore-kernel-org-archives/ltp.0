Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D99C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:53:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2DED3CBE56
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:53:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BA9A3CBE4B
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:53:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A882364842F
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:52:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A585D336D7;
 Mon, 12 Dec 2022 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670856778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Otjw9vchmL4iVVgkBHRtZXqXfJEFvAKMPZMJGbZDo3E=;
 b=SqfvGKXQffCHrAZS6vpmCA6rwftKILyB0w35P+FXzmwAy9WjFwpYW5vfw0jd9cS0RuYYcN
 axWjtvruSfAO5NR355dZ0OWWeXp0vFsAo/eJplqcqBipYviAqdTqtg/dVZxlWwQnYTnO2U
 n/J74dOtzo078PiejcwdeoU3EP6HWQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670856778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Otjw9vchmL4iVVgkBHRtZXqXfJEFvAKMPZMJGbZDo3E=;
 b=YEdn4TF1PeDH+G/Sezw8RviB6Ic3b35eWs8OvhUTdUY9CbIWvX6jvRHBzPKGn2xiyiXkKd
 deNtcM65H1HFLUAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5933C2C141;
 Mon, 12 Dec 2022 14:52:58 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 12 Dec 2022 14:50:01 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-1-tsahu@linux.ibm.com>
Message-ID: <87edt4u112.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/8][PART 3] Hugetlb:Migrating the libhugetlbfs
 tests
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

Hello,

Setting the rest of this patch serious to "changes requested" in
patchwork. EVen though I have added reviewed tags to most of the tests,
I don't want to merge them out of sequence.

Also please assume that any comments that were made about previous tests
may also apply to those left. I did not check these very carefully.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
