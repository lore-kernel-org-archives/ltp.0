Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2477C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40D563CB090
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:10:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4FDD3C2CAE
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:40 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D72FE2009C5
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666095038; x=1697631038;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6ONzkbiT5K5fMvoId0NyK0htpmz+8um1anF5xy772EE=;
 b=GfWzRCBijJSuGZqjwVYuQNDESLSDP5sQ1AOmRr5Recou9RsRcc3vxyS3
 vDvyhQWv964D43htOKC6NWaug2IVYof4UsTgiRphg0P+RzCpRZdaZg+Bw
 wtpWwj6fXi/PeWO+oQcgQgjCsO0ymcOuP/of9b61TIu5F0/YQUUDQJ8Nc
 lZWpjNcJ+FRbg75obujW+gCw9FrfZjCXb1B56KgF111dMnjt4opLpC+7C
 5S01XFizUqVQVa75Lca0q15OcOJ/ZpXVFJ3Iu7OCXpOLP5pI8QMuiC+NP
 U4GoSl/kUcwWiHDJ12sdCU5NqMdZ7EwFE51n0+zUWPlRnU77tN+OCC5ik w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368113351"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="368113351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 05:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="771172069"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="771172069"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 05:10:33 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Tue, 18 Oct 2022 20:10:45 +0800
Message-Id: <cover.1666094709.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Fix ptrace07 hardcoded xstate size issue
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
Cc: chang.seok.bae@intel.com, eric.devolder@oracle.com,
 Heng Su <heng.su@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Should not use a hardcoded xstate size(512 * 8 = 4096 bytes), and use maximum
XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX instead.
If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
it will cause the ptrace07 case to break as below:
"
./ptrace07
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
tst_test.c:1571: TINFO: Killed the leftover descendant processes

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
"

And there is no proper cpuid() function in LTP, so provides the cpuid()
function first in previous commit.

=========
v2 -> v3:
 - Thanks Richard Palethorpe's report, should not use old API cpuid function
   in LTP, and provide the __cpuid_count() function instead
 - Thanks Richard Palethorpe's suggestion, put __cpuid_count() in
   include/lapi/cpuid.h
 - Add the aligned_alloc() successfully check in ptrace07.c
 - Add the cpuid output check prints as Richard Palethorpe's suggestion


Pengfei Xu (2):
  cpuid.h: Provide the macro definition __cpuid_count()
  ptrace07: fix the broken case caused by hardcoded xstate size

 include/lapi/cpuid.h                        | 24 +++++++++++++++++
 testcases/kernel/syscalls/ptrace/ptrace07.c | 29 ++++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/cpuid.h

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
