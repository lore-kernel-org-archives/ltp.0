Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C196C433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 15:11:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A7661050
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 15:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3A7661050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334A53C8F48
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 17:11:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 084923C8304
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 17:11:33 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FFA51000643
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 17:11:32 +0200 (CEST)
Received: by mail-qk1-x736.google.com with SMTP id d207so28705071qkg.0
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1J8dC6kcxzeXlmZTaCw0TCJN0xTEKLeJS7/k0wvHRgg=;
 b=e3VM/UXz5b8Mg1tq9nEoOZ8VhJn/mqs26KCLqdatrC+dcHZSAZ2IAKKX0ISTohr7IP
 8axj0JDdFmWmISWwC0UOAdmaPO28pNkCIsjFrd/lsPEweTqs8sR0Vwg9a7hFfOvM9xIq
 x8J9AiPyNpMndSowxiBcQY82QzFEtPiZg4GTv7j0OQvnfaiFWv+jlmFTMkv912IYC0/r
 Cy98RlJ0CYHNnKbr4eLLLsKGhCRBvOAR8n2b5kS4/Lsw+Z/8oxLHiGr4L+XqsH1BzSkZ
 NuQlV1BlqqsrHdWd6b49pyOQAkCgZRmF0AETI9r4/BeTvv9Uza65Dfstau8z8HRi7WsM
 hvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1J8dC6kcxzeXlmZTaCw0TCJN0xTEKLeJS7/k0wvHRgg=;
 b=NsvrUMpj+HvsTJT6dMxmHOK9n4k2Pa81Ogf++RpGxGUn10fGbBYX6u8mL3UH5toWC7
 9q/mmFTIZV67SI3y8VcrprwEo8e6JJo0jUgWwbUjNBUI5Go6z4o1vmn8o1WfQbC3GUlJ
 MG8ULc9ZnZxHOcYOui1126V8FuV0BNPTU1F1w9O5PeAmGwz77g7FyjK7oYzZA3vYVWzN
 dsjx9L4nF8WuvPUWuRr2ZG0NWtQGv7QFgkDCOKZS0ePcoEXZ026BEkJ4mPWCpOUrCsVl
 WODG796mlOTFI9p8OZ83xGvEG4Vb+BKSbEu58VsgkZoUtyZ0hkPILyEdIr4+b6A9qfC9
 NS9w==
X-Gm-Message-State: AOAM530xYcpEdt/zsxH05kEM+rB+9px8oepEj7ABkq37m9KtViW7vW14
 NrfLaR1GRxLPWgbtXzYih6Jlhg==
X-Google-Smtp-Source: ABdhPJyX2mWp1KaS3l12JuU628ycirHTbZtkO9Wj5782SLBw0YC+pggDl435zouu/OrQJ4kObJfAZQ==
X-Received: by 2002:a37:58e:: with SMTP id 136mr11251508qkf.324.1632496291365; 
 Fri, 24 Sep 2021 08:11:31 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id w11sm6599309qkp.49.2021.09.24.08.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Sep 2021 08:11:30 -0700 (PDT)
Date: Fri, 24 Sep 2021 11:11:30 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210924151130.GA4029248@maple.netwinder.org>
References: <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Sep 24, 2021 at 12:18:45PM +0800, Li Wang wrote:
>
>That's weird.
>
>What about the testing result with unlimit the tmpfs size?

With the .dev_min_size field set to zero, it still causes OOM. Looking 
at the test output, it seems to use 256MB in this case:

tst_test.c:1421: TINFO: Testing on tmpfs
tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
tcf-agent invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[...]
Mem-Info:
active_anon:229 inactive_anon:44809 isolated_anon:0
  active_file:7 inactive_file:4 isolated_file:0
  unevictable:0 dirty:0 writeback:0
  slab_reclaimable:1205 slab_unreclaimable:3757
  mapped:334 shmem:42064 pagetables:226 bounce:0
  free:1004 free_pcp:0 free_cma:0
Node 0 active_anon:916kB inactive_anon:179236kB active_file:28kB inactive_file:88kB unevictable:0kB isolated(anon):0kB isolated(file) :0kB mapped:1336kB dirty:0kB writeback:0kB shmem:168256kB writeback_tmp:0kB kernel_stack:1016kB all_unreclaimable? no
Normal free:3776kB min:1872kB low:2340kB high:2808kB 
reserved_highatomic:0KB active_anon:916kB inactive_anon:179236kB active_file:28k B inactive_file:16kB unevictable:0kB writepending:0kB present:262144kB managed:220688kB mlocked:0kB pagetables:904kB bounce:0kB free_pcp:224kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
Normal: 1*4kB (M) 1*8kB (M) 22*16kB (U) 35*32kB (UE) 16*64kB (UE) 9*128kB (UE) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0* 16384kB = 3660kB
42138 total pagecache pages

>> tst_test.c:903: TINFO: Limiting tmpfs size to 64MB
>
>Hmm, set to 16MB, 32MB? test result?

It does not reach the tmpfs test, because btrfs is unhappy:

tst_test.c:922: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
ERROR: '/dev/loop0' is too small to make a usable filesystem
ERROR: minimum size for each btrfs device is 47185920
tst_test.c:922: TBROK: mkfs.btrfs failed with exit code 1

With a size of 48MB, machine still crashes with OOM.

>Can you post the /proc/meminfo here? I'm curious how
>small memory it is can not tolerate 64M consuming.

Here is what I get right after booting up, before starting ltp.sh tests. 
I've already disabled numerous services (nginx, redis, etc) to try and 
free up more memory.

MemTotal:         220688 kB
MemFree:          121064 kB
MemAvailable:     157484 kB
Buffers:            9376 kB
Cached:            38052 kB
SwapCached:            0 kB
Active:            16320 kB
Inactive:          45176 kB
Active(anon):        844 kB
Inactive(anon):    22492 kB
Active(file):      15476 kB
Inactive(file):    22684 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:         220688 kB
LowFree:          121064 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                60 kB
Writeback:             0 kB
AnonPages:         14140 kB
Mapped:            19244 kB
Shmem:              9268 kB
KReclaimable:       6260 kB
Slab:              20816 kB
SReclaimable:       6260 kB
SUnreclaim:        14556 kB
KernelStack:        1008 kB
PageTables:         1160 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      110344 kB
Committed_AS:      93916 kB
VmallocTotal:    1818624 kB
VmallocUsed:        2308 kB
VmallocChunk:          0 kB
Percpu:              496 kB

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
