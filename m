Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBE5C43217
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D32B3CB0DD
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 16:02:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE35E3CAEAA
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 16:02:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 325821400DB1
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 16:02:07 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 295A033E7E;
 Tue, 18 Oct 2022 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666101727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rKxi8yJD+7ndnfE7+rWVwrLI9fYh5JNbf/vR8e+tls=;
 b=NsoPyDeSTc67MHM0G+V6NLDZYRJjjIGU28/xNsckpvWzMttXw2I8sTF86ymIjbNECmLi3F
 dJxyEQAdgSYM0C8Ob9/iPY3Rf2UFaY9Y792VZvKCJ4kctWHhTH7vJZ5bV9B3BFRE++90AK
 8mG6IgUJuPLZ1i2bkKkq+208DpCYgDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666101727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rKxi8yJD+7ndnfE7+rWVwrLI9fYh5JNbf/vR8e+tls=;
 b=RoLq/pjhg3LWZp+QqyAJ6HeOizYlglIvuExUkjvxkJWKj772N6gCr2tTP66TFQQ79c8OMj
 agFHb9fuC4LF8jBQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 423982C141;
 Tue, 18 Oct 2022 14:02:06 +0000 (UTC)
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue, 18 Oct 2022 14:51:51 +0100
In-reply-to: <20221016125731.249078-1-tsahu@linux.ibm.com>
Message-ID: <87wn8xi61v.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/29] Hugetlb: Migrating libhugetlbfs tests
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Hi,
> Libhugetlbfs is not being maintained actively, and some distro is dropping
> support for it. There are some tests that are good for testing hugetlb
> functionality in kernel.
>
> As per previous dicussion in RFC[1], Here, this patch series consists
> of hugetlb tests taken from libhugetlbfs modified to work in ltp
> environment. This series do not include all the tests, I
> will post another series for the remaining tests soon.

Perhaps Cyril already said this, but I suggest just getting one or two
of the tests merged first then working through the rest.

This reduces the iteration time and batch size.

At least in terms of what you submit to the mailing list. Perhaps if it
gets to the point where most tests pass review first time, you can
submit everything remaining.

Also note that submitting this many new tests, once they are merged we
will probably get failure reports (including compilation failures). It
will make life easier to stagger that.

I'm going to mark this patch-set as changes requested in patchwork.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
