Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC43C67871
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 09:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381553CA8B5
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 11:19:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE23C3C2297
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:19:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 572EA1400FA5
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:19:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9F1501FDD4;
 Thu, 27 Oct 2022 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666862388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzoPE4eqyjgs4d1zhWGbQNykdwqVWse6sBn+H9MYk+0=;
 b=m2C3aAe5JwAfZcyXmKHBwK2g/OgWDl3nFPg92tvMwi7NIBXZdPsBzevkGKophMzhpAEegG
 fINKXE5hXn07474GT6fvf7rWEK0CG5GcaKbPanCsLf7KaJblzolBc2H7xgn7QrjBv2yk0D
 2TY6cwPP8I2qS5GRH4H8gLPTUipxY0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666862388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzoPE4eqyjgs4d1zhWGbQNykdwqVWse6sBn+H9MYk+0=;
 b=1CfswvcVBdzVUR+pDbFBnXPzWDgXOxPqOyZSn2dnQVMXBTFLa5IOErVN0/5WRZInEk5P7I
 FCdRzseLIxVBy/AQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C61922C143;
 Thu, 27 Oct 2022 09:19:47 +0000 (UTC)
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-4-tsahu@linux.ibm.com> <8735bcxicr.fsf@suse.de>
 <7951cad5022973849caf54884732000e7e9cb2e3.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: tsahu@linux.ibm.com
Date: Thu, 27 Oct 2022 10:18:21 +0100
In-reply-to: <7951cad5022973849caf54884732000e7e9cb2e3.camel@linux.ibm.com>
Message-ID: <87bkpxsjwt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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

> On Tue, 2022-10-25 at 12:04 +0100, Richard Palethorpe wrote:
>> Hello,
>> 
>> Tarun Sahu <tsahu@linux.ibm.com> writes:
>> 
>> > Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test
>> > 
>> > Test Description: Test sanity of cow optimization on page cache. If
>> > a page
>> > in page cache has only 1 ref count, it is mapped for a private
>> > mapping
>> > directly and is overwritten freely, so next time we access the
>> > page, we
>> > can see corrupt data.
>> 
>> Seems like this and 2/3 follow the same pattern. The setups are
>> reasonably similar and could be encapsulated in tst_hugepage.
> Do you mean by a encapsulating in a function. and call it from setup.
> becuase it will anyway require explicit cleanup.
>
> Or by defining a new field in struct tst_hugepage, if that is true,
> that setup will automatically be done in do_setup in tst_test file.
> which means it will require change in tst_test.c too. also change in 
> do_cleanup in tst_test.c will also be required.

Yes, it's a very common pattern, so will probably save a lot of
boilerplate.

>
>> 
>> > +
>> > +static struct tst_test test = {
>> > +	.needs_root = 1,
>> > +	.needs_tmpdir = 1,
>> > +	.options = (struct tst_option[]) {
>> > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
>> > /var/hugetlbfs"},
>> > +		{"s:", &nr_opt, "Set the number of the been allocated
>> > hugepages"},
>> 
>> nr_opt also seems suspicious. The test only ever allocates one page
>> at a
>> time regardless of what this is set to. Changing it will just change
>> how
>> much free memory we check for unless I am mistaken.
> yes, Will update it and also will check for other test cases if not
> required. 
>
>> 
>> > +		{}
>> > +	},
>> > +	.setup = setup,
>> > +	.cleanup = cleanup,
>> > +	.test_all = run_test,
>> > +	.hugepages = {2, TST_NEEDS},
>> > +};
>> > -- 
>> > 2.31.1
>> 
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
