Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F028C433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 18:25:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5BE61241
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 18:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD5BE61241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2653C8F24
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 20:25:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8DC3C8F24
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 20:25:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A78C14002D1
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 20:25:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B4C020323;
 Fri, 24 Sep 2021 18:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632507928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvw95z/y0HHhHMgrd3jSDzF2ZFTfTNWGeQqhf83Q+lA=;
 b=Yh9TJf6YsqesXrQTCpnzpPSKQJqWHDh3oN6sqwchtp11oFCyDS5+lYVDLS+/bkE0O6sWuh
 pdfehDg0JqyP17gCFNbCb5YDAeu6YegiNkAwLomKbFOet6NVrJMCu5e4x+wD5YuMVt7gp7
 Sh5i11boB2zMDclk7ZOrUslP++c7zuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632507928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvw95z/y0HHhHMgrd3jSDzF2ZFTfTNWGeQqhf83Q+lA=;
 b=c/lqM94msqELFCci3TMHQVqcXYT03xXQkz6fBd6PpuE+ZbimcqkIJyn7Y/z3eq8CU6Xzvz
 gsEqmE9z2kA3BLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BEEC13BA9;
 Fri, 24 Sep 2021 18:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7b0CEhgYTmGBLwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 24 Sep 2021 18:25:28 +0000
Date: Fri, 24 Sep 2021 20:26:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Message-ID: <YU4YOI4yPufWP9uC@yuki>
References: <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924151130.GA4029248@maple.netwinder.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >That's weird.
> >
> >What about the testing result with unlimit the tmpfs size?
> 
> With the .dev_min_size field set to zero, it still causes OOM. Looking 
> at the test output, it seems to use 256MB in this case:
> 
> tst_test.c:1421: TINFO: Testing on tmpfs
> tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
> tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
> tcf-agent invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
> [...]
> Mem-Info:
> active_anon:229 inactive_anon:44809 isolated_anon:0
>   active_file:7 inactive_file:4 isolated_file:0
>   unevictable:0 dirty:0 writeback:0
>   slab_reclaimable:1205 slab_unreclaimable:3757
>   mapped:334 shmem:42064 pagetables:226 bounce:0
>   free:1004 free_pcp:0 free_cma:0
> Node 0 active_anon:916kB inactive_anon:179236kB active_file:28kB inactive_file:88kB unevictable:0kB isolated(anon):0kB isolated(file) :0kB mapped:1336kB dirty:0kB writeback:0kB shmem:168256kB writeback_tmp:0kB kernel_stack:1016kB all_unreclaimable? no
> Normal free:3776kB min:1872kB low:2340kB high:2808kB 
> reserved_highatomic:0KB active_anon:916kB inactive_anon:179236kB active_file:28k B inactive_file:16kB unevictable:0kB writepending:0kB present:262144kB managed:220688kB mlocked:0kB pagetables:904kB bounce:0kB free_pcp:224kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> Normal: 1*4kB (M) 1*8kB (M) 22*16kB (U) 35*32kB (UE) 16*64kB (UE) 9*128kB (UE) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0* 16384kB = 3660kB
> 42138 total pagecache pages

That is strange, for me the tmpfs starts to return ENOSPC when the
system is getting low on memory.

> >> tst_test.c:903: TINFO: Limiting tmpfs size to 64MB
> >
> >Hmm, set to 16MB, 32MB? test result?
> 
> It does not reach the tmpfs test, because btrfs is unhappy:
> 
> tst_test.c:922: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> ERROR: '/dev/loop0' is too small to make a usable filesystem
> ERROR: minimum size for each btrfs device is 47185920
> tst_test.c:922: TBROK: mkfs.btrfs failed with exit code 1
> 
> With a size of 48MB, machine still crashes with OOM.

Uff that really sounds like something is wrong with tmpfs implementation
in your kernel.

Meanwhile Li posted another patchset that adds limits for tmpfs
filesystem only and limits it to 32MB. Can you please test that one?
Also if that one fails as well it's likely that something is wrong at
your side.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
