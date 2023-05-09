Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9432C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:28:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F5303CD731
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:28:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E211C3CB513
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:28:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E5E7600736
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:28:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1ECE521B97;
 Tue,  9 May 2023 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683624493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icYcET1ZxYXeByBVVneo/z3rT/228pHqYCVJJBb3SsM=;
 b=T4TpfCq1q8bE9QNY8Ut47OxE8KNJHmAWDFCgjBAB/LWzva/F7iP7GKnjA3uTd2iwQowDgl
 16C0PHEZ9YA6jGCNMPpP2GFewDzp/TZ9KOp+lD9mr2KLkLr0/FfUB4zEyD96PkjSQDhYci
 n0ZbY69yCWNzv0Mv5mftgblFTPsTkGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683624493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icYcET1ZxYXeByBVVneo/z3rT/228pHqYCVJJBb3SsM=;
 b=Lmy6iWAzFgk3ovcYhaom0TPvtY200lC6dqOscTGCgboIQgfwfOyDzXb7NiCzt0hyHhXlWm
 U6tWLR8FVR8I+cCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFBA7139B3;
 Tue,  9 May 2023 09:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M2eYNywSWmT0ZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 09 May 2023 09:28:12 +0000
Date: Tue, 9 May 2023 11:29:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZFoSZkkjVXQhdEpe@yuki>
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
 <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> > More widely LTP pre-release test will be deployed base on RHEL products
> > as well.
> >
> 
> I have completed the LTP pre-release test against RHEL 8 and 9,
> all looks good except one test warning as below, but I suppose
> it's a tiny problem caused by the ppc64le configuration.
> 
> This only observed on ppc64le arch:
> 
> 3 cmdline="hugemmap32"
> 
>      4	contacts=""
>      5	analysis=exit
>      6	<<<test_output>>>
>      7	tst_test.c:1558: TINFO: Timeout per run is 0h 01m 00s
>      8	hugemmap32.c:34: TWARN: Failed to close FILE
> '/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages'
>      9	hugemmap32.c:35: TCONF: Can't update the gigantic hugepages.
> 
> 10 hugemmap32.c:69: TWARN: Failed to close FILE
> '/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages': EINVAL (22)

Looking at the file_printf() the test uses it does produce a warning
when we fail to write to the file.

Also we seems to be using FILE_PRINTF() exactly in these tests:

testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
testcases/kernel/syscalls/fcntl/fcntl33.c
testcases/kernel/syscalls/readahead/readahead02.c

In three cases we use the FILE_PRINTF() in the test cleanup, which does
not matter, since we do not break test on TBROK when we run in the test
cleanup.

That leaves us just hugemmap32 and readahead02 in both cases I think
that generating TWARN in just plain wrong.

So what about:

* changing FILE_PRINTF() to SAFE_FILE_PRINTF() in test cleanup
* changing TWARN to TINFO in FILE_PRINTF()

I guess that we should have been using TINFO in the file_fprintf() from
the start.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
