Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205BC67871
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 10:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ABC83CA863
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 12:03:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50DB93C2A5C
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 12:02:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8CF9200C20
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 12:02:50 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 020AB2265C;
 Thu, 27 Oct 2022 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666864970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gz4kmIo/JKozMyVjTon6miDgcgWgtUKF6ZezEhArRvU=;
 b=0yPL88vXj3n999fc2ueQ5Nxg9u8RlRXxOVYLG/7C7H/ggVqvb+XSoMPz1AQtTUGI/Y3qhb
 Z/bup4uRtcpzt34WSFVaFIkoHmTINAIk5s8fk8EtApkkHqhliJ86B6mj76bXfSZoS/nJSr
 pvFmeNi1HhIMddwFUzzkEncPNCvhAZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666864970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gz4kmIo/JKozMyVjTon6miDgcgWgtUKF6ZezEhArRvU=;
 b=6C0nsLH+5y4rnoUamFNKAj7V9EhlXWdKSINIQ3oevBaVyGjdIn0NsvMxm14ufNZx1mX81Z
 GxLrKdT0tbPU2tAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 05C2A2C141;
 Thu, 27 Oct 2022 10:02:48 +0000 (UTC)
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
 <20221019184846.89318-2-tsahu@linux.ibm.com> <877d0oxj0v.fsf@suse.de>
 <0dd4161726a3cc1cea80d30ec87c92d9089efe41.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: tsahu@linux.ibm.com
Date: Thu, 27 Oct 2022 10:21:12 +0100
In-reply-to: <0dd4161726a3cc1cea80d30ec87c92d9089efe41.camel@linux.ibm.com>
Message-ID: <877d0lshx4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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

>
>> 
>> > +	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt,
>> > getpid());
>> > +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
>> > +
>> > +	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
>> > +	SAFE_UNLINK(hfile);
>> 
>> I'm guessing opening this file and using it with mmap is a very
>> common
>> pattern. If so, it should be encapsulated in tst_hugepage.c.
>> 
> Yeah I agree. But the change in tst_hugepage.c will require change in
> prexisting hugetlb tests.

You don't need to update existing LTP tests if you add a new flag to
.tst_test I guess.

>
>> > +}
>> > +
>> > +static void cleanup(void)
>> > +{
>> > +	if (fd >= 0)
>> > +		SAFE_CLOSE(fd);
>> > +	SAFE_UMOUNT(Hopt);
>> > +}
>> > +
>> > +static struct tst_test test = {
>> > +	.needs_root = 1,
>> > +	.needs_tmpdir = 1,
>> > +	.options = (struct tst_option[]) {
>> > +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
>> > /var/hugetlbfs"},
>> 
>> This is a source of confusion. This description suggests we pass in
>> an
>> existing hugetlb mount. However it's actually where it will be
>> mounted.
>> 
>> Perhaps instead we could use set/getmntent to find an existing
>> hugetlb
>> mount?  Then if it is not there, try mounting it. This is what we do
>> for
>> CGroups.
>> 
>> I'm not sure what difference it makes where the FS is mounted
>> anyway. Why is it even an option?
>
> Not sure, If user is ok for using premounted fs without their
> permission. So instead of searching, it will mount where user will
> explicitly asked for. Or otherwise if not provided, it will mount at
> temp location under /tmp.

Does it actually create a new FS or is it just remounting the existing
hugetlb interface in a new place?

Also it requires privileges to mount an FS. It seems unlikely that some
database wanting to use hugepages would mount it themselves.

From the kernel docs:

"If the user applications are going to request huge pages using mmap system
call, then it is required that system administrator mount a file system of
type hugetlbfs"

>
> I had taken this option from hugemmap01 test. Thinking, it might be
> to provide user the flexibility incase user doesnt want test to mount
> fs at random location by default.
>
> I will change the description to "Provide the location to mount the
> hugetlbfs or default '/tmp/xxxxxxx'"
>
>> 
>> > +		{"s:", &nr_opt, "Set the number of the been allocated
>> > hugepages"},
>> > +		{}
>> > +	},
>> > +	.setup = setup,
>> > +	.cleanup = cleanup,
>> > +	.test_all = run_test,
>> > +	.hugepages = {1, TST_NEEDS},
>> 
>> When we set this tst_hugepages.c could fill Hopt (which should be
>> something like tst_hugepages_mount) with the location of the mount
>> point. It could also open the hfile fd and store it in a static
>> variable like tst_hugepage_fd.
> Yeah, It will move the repeated actions to single location.
>
> This will
> require change in lib/tst_hugepage.c and which will require
> change in already existing test under hugetlb/ . Which will be like a
> new separate change patch series.

If it results in too many complicated changes, then converting all the
existing tests could be defered to a later time by creating new
variables.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
