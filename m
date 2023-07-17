Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD4EB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 14:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92183CDDDB
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 16:35:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557FC3C99AE
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:35:02 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 899681000231
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 16:35:01 +0200 (CEST)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666e6541c98so4668495b3a.2
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689604500; x=1692196500;
 h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4BYLcNQI8huu9QFMy9I1uV9Z2M9k8SXeF4zF9gh3CZU=;
 b=jPSv5Sk5pxmVc8p5jjDApn+MZrG0aK3Tzn7t9YcSUHTKnNZ1ADUAoGJXASUubASmEn
 WIQZelQhm2559jwQKDsREioZrkpoQRPaJZTIsiwPhnOAai2fgyPccFV7xlAIRT1XGHWd
 9xUVxB/XdBj1+BOnFX4vWbjn6uhNRMR+FOrmt/sEz1Za8Xez5r9L+xzGGrluP33eLJG6
 UqX43s+AvqaiaYuIG8eV9E8aeSpqf0rRIOdsh5MhPbopjsxBbmAnYQUkpDLYhBzyj5Du
 oJe8KI1E0YafvghyjQitXy9cya8WlgGbGSDoma0wTrwweyYP353kU6wOINFVHJj/cx3Y
 Rl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689604500; x=1692196500;
 h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BYLcNQI8huu9QFMy9I1uV9Z2M9k8SXeF4zF9gh3CZU=;
 b=QLdEeZ6+PHpANGqT6PbhM6ajwf9yrTlETocQ5v7GnOjHBQnijYbbUiGl+QcPT7QdUx
 6aIZu+W9A2+t/OlACe6Q8spsyZ3NENZJYQV9ay1AdYl4Hw+/G4r1fsuyVOP1HgNqkonc
 nkCN42sGg6BWRcePh0xknZfzZ13X0+tw65RW0PTxJ/5CMv/u0p4m3u2TpxaZXuKin50m
 iwD78Till+GuMGmycbHyHfZcjU09PbR0VCQfk7JtVhz94N3F33svYKE+OlCeVzkQf+IE
 DtzUid7D048OlJ/Q+gULIL7h4b5a/7dz1LxPFvqtgGg9XBg5dagFxF+kgDgKuDHuvo5h
 lUDQ==
X-Gm-Message-State: ABy/qLYml+grf4xokHLwkFXIWSrZRa3OMUfaBVL6q/Pz6uHcZMKVwsJc
 5UzkAORwJdPVYe+E7mt7Zcg=
X-Google-Smtp-Source: APBJJlHAPdcJ6KFA2sv9z3Ia/B+Z9Y4x09UnZq7fBkGBsVJ2BJn5QQ5Fk3EK5lO+9+2Glx7Z2FZW0Q==
X-Received: by 2002:a05:6a00:2e05:b0:681:415d:ba2c with SMTP id
 fc5-20020a056a002e0500b00681415dba2cmr16138558pfb.31.1689604499783; 
 Mon, 17 Jul 2023 07:34:59 -0700 (PDT)
Received: from dw-tp ([49.207.232.207]) by smtp.gmail.com with ESMTPSA id
 x18-20020aa784d2000000b0068288aaf23esm11992747pfn.100.2023.07.17.07.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 07:34:59 -0700 (PDT)
Date: Mon, 17 Jul 2023 20:04:54 +0530
Message-Id: <87jzuyobch.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
In-Reply-To: <87o7kbnle9.fsf@doe.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>
>> Following kernel BUG noticed while testing LTP fs testing on x86_64
>> arch x86_64 on the Linux next-20230716 built with clang toolchain.
>>
>> I see a similar crash log on arm64 Juno-r2. The logs are shared below.
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> x86 log:
>> -------
>> tst_test.c:1634: TINFO: === Testing on ext2 ===
>> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
>> mke2fs 1.46.5 (30-Dec-2021)
>> [ 1393.346989] EXT4-fs (loop0): mounting ext2 file system using the
>> ext4 subsystem
>
> ext4 driver is used for ext2 filesystem here. It will be using indirect
> block mapping path.
>
>> [ 1393.396754] EXT4-fs (loop0): mounted filesystem
>> 7ca8e239-bc8f-488c-af12-5e0ef12d17a5 r/w without journal. Quota mode:
>> none.
>> fs_fill.c:115: TINFO: Running 6 writer threads
>> tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread6/AOF\", iov,
>> 512): ENOSPC
>> tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread5/AOF\", iov,
>> 512): ENOSPC
>> ...
>> tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread6/AOF\", iov,
>> 512): ENOSPC
>> tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread3/AOF\", iov,
>> 512): ENOSPC
>> tst_fill_fs.c:109: TINF[ 1393.817197] ------------[ cut here ]------------
>> [ 1393.823305] kernel BUG at fs/ext4/mballoc.c:4369!
>
> It's hard to trigger the race I guess. But here are some debugging
> information.
>
> [  955.508751] EXT4-fs (loop1): mounting ext2 file system using the ext4 subsystem
> [  955.515527] EXT4-fs (loop1): mounted filesystem 57096378-d173-4bc5-ac06-9cd53c1dfa1c r/w without journal. Quota mode: none.
> [  959.289672] EXT4-fs (loop1): unmounting filesystem 57096378-d173-4bc5-ac06-9cd53c1dfa1c.
> [  959.490548] EXT4-fs (loop1): mounting ext3 file system using the ext4 subsystem
> [  959.503719] EXT4-fs (loop1): mounted filesystem 841c90bd-4d83-4bc5-be10-39452034e84b r/w with ordered data mode. Quota mode: none.
> [  960.553669] ext4_mb_pa_adjust_overlap: ==== This should not happend ==== left_pa=ffff8881471c7f50 deleted=0 lstart=6144 len=656 right_pa=0000000000000000
> [  960.557437] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7540, deleted=1 lstart=5872 len=272 pstart=34560
> [  960.560659] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7f50, deleted=0 lstart=6144 len=656 pstart=26848
> [  960.563855] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7ee0, deleted=1 lstart=6623 len=2 pstart=45503
>
> (This is the rbtree printed ^^^ )
>
> (gdb) p ac->ac_o_ex
> $8 = {
>   fe_logical = 6625,
>   fe_start = 27328,
>   fe_group = 0,
>   fe_len = 1
> }
> (gdb) p new_start
> $9 = 6144
> (gdb) p new_end
> $10 = 8192
> (gdb) p left_pa_end
> $11 = 6800
>
>
> The bug one happens here -
>
> 	if (left_pa) {
> 		left_pa_end =
> 			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
> 		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
> 	}
>
> i.e. left_pa_end(6144 + 656 = 6800) > ac->ac_o_ex.fe_logical(6625)
>
> Thought of sharing this info which can save time for others.
>

Ok, so looks like we have some idea of what could be going wrong here. 
ext4_mb_pa_adjust_overlap() account and adjust for PAs that are marked
deleted as well. However ext4_mb_use_preallocated() doesn't. It will
simply skip the PAs which are marked deleted and move forward with
searching in the rbtree. This could create problems while searching
when we had PAs marked as deleted which were fixed in ext4_mb_adjust_overlap().

For e.g. when we have below tree...

[ 5473.519335] ext4_mb_pa_adjust_overlap: pa = ffff88814a2ed1c0, deleted=1 lstart=1040 len=16 
[ 5473.515741] ext4_mb_pa_adjust_overlap: pa = ffff88814a2ed4d0, deleted=0 lstart=1024 len=46 
(Note the entries have overlapping ranges).

(gdb) p ac->ac_o_ex
$26 = {
  fe_logical = 1042,
  fe_start = 21967,
  fe_group = 0,
  fe_len = 1
}

... and we are allocating for ac_o_ex (1042) and root is pa =
0xffff88814a2ed1c0 (lstart=1040). The root pa covers the requested range
but since it is marked as deleted, we ignore and search further.
Since 1042 > 1040, we go to right. But we won't find any PA in the right
subtree of pa (1040).
This could cause PAs to be skipped for e.g. pa with lstart = 1024 will
not be considered which ideally should have been used. 

This then causes a bug_on in ext4_mb_adjust_overlap() function
(normalization path) when it finds an already allocated overlapping PA.

@Ojaswin mentioned the same problem was solved in
ext4_mb_pa_adjust_overlap(), however the logic was never added to
ext4_mb_use_preallocated().

These can basically trigger in extremely low memory space and only when
such ranges exist in the PA rbtree. Hence, I guess it is a little hard
to tigger race.

-ritesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
