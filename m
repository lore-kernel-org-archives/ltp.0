Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01C3F327B0
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776759684; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=J6CRzOCJqTAbP0Oqi4YHpu19loU7GqIkfIHGbSsmhHs=;
 b=DCoZzk+OztPzvx/ovFsqIEHvHspZ9z9cprIigQJdZ/rT2EbpiMc7T8jfM0mILP1x6OPaf
 M76DXm3Nxrf0f4GUejuzh7vDYp0eZtWREfZWbWEnJJM1DTM8+Y15rhxMK4mK5JhU0JMgMcM
 EogT7kKd8GKCU4zg7nnUxUg7MAlLgHw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D9C53E293D
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 10:21:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0473E10D0
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 10:21:00 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61D161400B6B
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 10:21:00 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso2614595f8f.3
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776759660; x=1777364460; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wD615jqOCE0iG6VdVsrkLTZV06B6auGBhRE5+PruOFs=;
 b=YaqbOV4bPdueWcR86MV2ez78x8o7etzqAbHSefd9HMJQ19FLkzqgvp6Vi43kpVWyg1
 EdVxCa9FcU38ZrjEQhKQCIBlFjRAPZOI9oqjy7Qa+jcO6HQLrPeYN7Tqe57SYPrH6DUW
 QjfQvQ1J+E1ij/KDn63HuFzeZuWD7Q2BUPizh3KoKim3aaqJvfGmZ4XtUi2h9BOFV9gG
 qUSGDkC87t7A07OXWd1NjLpoFftH9UNiH6KPQOtKNyTTsTr/HboRpip1FXxOOsbRj90Y
 /eHa86y/FORWX+FTR/JdW+2bcGRtTZu/ktpCnmypf59M3ZYEC5RwpDnPlyM7d5OJU62c
 WNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776759660; x=1777364460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wD615jqOCE0iG6VdVsrkLTZV06B6auGBhRE5+PruOFs=;
 b=FAz/0Lp3VOb6OIQzA0BqXhmlBsbY635P4IjBwB8BUFmfOgWB9k///dKYvF4057Tbx7
 oV+8wUSfnK3whWfJeGPRx+LvJKZmEqb+MqvS0cpK5Lp5E7mab76BjIy/IQ17wKeJ232D
 QrJ4rDxKUy+XozT9wsgCYKVs7Zdb5pyawPuqdzJciKmlA2u5ofHYephqL9uU7tmw6jNx
 uqf75L8VPd5zahCLo4hvIg7mci81tg6eVooD2Y1tQETvdYVaLHqBfVcjtCL38LS5Bn9s
 X+UBepIRt9ranUwz25uqp53W/8AoPwepr03c1DfoBY7BtV/x/VmulVIr/qcbpqZkuPi9
 B2NQ==
X-Gm-Message-State: AOJu0YzCXClmFajhP1PQXirjo4gNEwkisz7Zt6kynH92Y0c7amtshJzD
 KaNiFAjDLw7SIkTspLBcAkFGE23gIIJCEH/VhOg96PvtOrZJu4sr+aBA5l379JpETfcreg3+tGB
 6VH0=
X-Gm-Gg: AeBDieuMljWrBoyGu2ykPtsAHDAFnzppZfgkkXks999IIU/zTEKFpQpdjXHi6i4Q9YP
 SfKe1SzWmzWp5B0FUzmE+TtxlmZW/7lB8NV7iBpsQw4qgT0vSVPLlfMlLVobRN8H7qFHJ+mR3yg
 wNlt6GMzC6dGvfiqZXglWSG1V8XxyZo2DNvxn3s9VHjWvltQI/hnt8wjNAOUYYhN8N+8MKNv9XQ
 Laj3lCjYXiT6rGJMEMuUQnEsZjEJ77nYL0RKX+YUPEamIsH1KHm8E+SDydC0N/g0hNVNGjeo2kX
 3FV3E3gKLtVvQJvhF91nSZRaRXoy1NGe/8qXPEc8hMV+T1K/SDDbEInKfbg54RiQdSmTdrwZ8u9
 OU8/ZWsO3w/MjxbJHoI9VZPBaVZYeY+pbWlxl9jZH2+0SSrhFpf3Mxaze30z4ttsekBnTxLI+Tm
 jpQc28ZB9eiABbatNv0qA+ZJnSODKW1qVgbu2Sjd6veSy1ELUXB3I=
X-Received: by 2002:a05:6000:2888:b0:43d:7b90:fa21 with SMTP id
 ffacd0b85a97d-43fe3dcaefamr26739955f8f.12.1776759659694; 
 Tue, 21 Apr 2026 01:20:59 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm34179425f8f.31.2026.04.21.01.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 01:20:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:20:57 +0000
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <aeczaSCt8Qnt0Uuc@autotest-wegao.qe.prg2.suse.org>
References: <20260417065332.23663-1-wegao@suse.com>
 <20260417122804.23890-1-wegao@suse.com>
 <CANgNiRxgPHo1yQGbT=QGK0NKQEAWO0_9qk6+xiXiC1S6vWvmfw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRxgPHo1yQGbT=QGK0NKQEAWO0_9qk6+xiXiC1S6vWvmfw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] mremap07.c: New test for mremap() with
 MREMAP_DONTUNMAP
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Apr 20, 2026 at 06:12:19PM +0800, Li Wang wrote:
> Hi Wei,
> 
> This is an excellent test design, but still few places need
> refactoring in my opinion.
> 
> Wei Gao via ltp <ltp@lists.linux.it> wrote:
> 
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
> >  AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
> >  AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
> >  AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
> > +AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])
> 
> I didn't go through all the previous discussion, but can we define
> MREMAP_DONTUNMAP in the lapi/mmap.h then remove the .min_kver
> and TST_TEST_TCONF?

To handle older kernels without using .min_kver and TST_TEST_TCONF, 
we'd need to implement extra logic. Would it look something like the following?

-	if (new_remap_addr == MAP_FAILED)
+	if (new_remap_addr == MAP_FAILED) {
+		if (errno == EINVAL)
+			tst_brk(TCONF | TERRNO, "mremap() with MREMAP_DONTUNMAP not supported");
+
 		tst_brk(TBROK | TERRNO, "mremap failed");
+	}

Test on old kernel if not using .min_kver/TST_TEST_TCONF?.

susetest:~/ltp/testcases/kernel/syscalls/mremap # uname -r
4.12.14-122.231-default
susetest:~/ltp/testcases/kernel/syscalls/mremap # ./mremap07 
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_tmpdir.c:309: TINFO: Using /tmp/LTP_mreVVHzVk as tmpdir (btrfs filesystem)
tst_test.c:2059: TINFO: LTP version: 20260130-147-g19c9b694c
tst_test.c:2062: TINFO: Tested kernel: 4.12.14-122.231-default #1 SMP Wed Oct 2 17:30:21 UTC 2024 (5f0ddca) x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:714: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1889: TINFO: Overall timeout per run is 0h 02m 00s
mremap07.c:88: TINFO: Original mapping created at 0x7f19f2edb000
mremap07.c:121: TBROK: mremap failed: EINVAL (22)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
