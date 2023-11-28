Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA726C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 03:03:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1C683CDBB5
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 04:03:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39E543C88DB
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 04:03:02 +0100 (CET)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE43B1000937
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 04:03:00 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="129546544"
X-IronPort-AV: E=Sophos;i="6.04,232,1695654000"; d="scan'208";a="129546544"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 12:02:58 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5398CD502B
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:02:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B3A9D3F15
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:02:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 179F920079118
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:02:55 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AE6D91A0070;
 Tue, 28 Nov 2023 11:02:54 +0800 (CST)
Message-ID: <ab0157cc-f7c5-29e0-f79d-14220d402370@fujitsu.com>
Date: Tue, 28 Nov 2023 11:02:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.004
X-TMASE-Result: 10--12.369600-10.000000
X-TMASE-MatchedRID: P7d3tDo+wQqPvrMjLFD6eK5i3jK3KDOot3aeg7g/usAgUEQTkIWiYtPQ
 +kcNsyKztjrLscdqa/XmD0/n9mv+d4T1xJNOHZm0uLt50vtxBA52ZYwNBqM6Ipyka59saICoPXc
 ag8UDUcUi+t+0AiFaYvL3NxFKQpq1xOHHA5l3Dp03xmlyRdP8c30tCKdnhB58vqq8s2MNhPAir3
 kOMJmHTLmHxFy+2CIWC24oEZ6SpSkj80Za3RRg8DMIkcpOLFW7su9MXLUro4QfP+3VGxandGVDS
 CEMRpP9oYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vma05.sh: Fix check for core file presence
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang

On 2023/11/10 11:56, Yang Xu wrote:
>   	rm -rf core*
>   	{ vma05_vdso; } > /dev/null 2>&1
> -	[ -f core ] || tst_brk TBROK "missing core file"
> +	[ -f core* ] || tst_brk TBROK "missing core file"

The root cause seems that the name of core file contains the pid number 
by default. I think the better solution is set 
/proc/sys/kernel/core_uses_pid to 0 before running vma05_vdso. Like this:

diff --git a/testcases/kernel/mem/vma/vma05.sh 
b/testcases/kernel/mem/vma/vma05.sh
index a09951462..e1ef1014e 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -25,11 +25,13 @@ TST_NEEDS_CMDS="gdb"

  CORE_LIMIT=$(ulimit -c)
  CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
+CORE_USES_PID=$(cat /proc/sys/kernel/core_uses_pid)

  setup()
  {
         ulimit -c unlimited
         echo "core" > /proc/sys/kernel/core_pattern
+       echo 0 > /proc/sys/kernel/core_uses_pid
         unset DEBUGINFOD_URLS
  }

@@ -37,6 +39,7 @@ cleanup()
  {
         ulimit -c "$CORE_LIMIT"
         echo "$CORE_PATTERN" > /proc/sys/kernel/core_pattern
+       echo $CORE_USES_PID > /proc/sys/kernel/core_uses_pid
  }

Best Regards,
Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
