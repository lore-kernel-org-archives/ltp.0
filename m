Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FAC6FA82
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:27:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551F43CA493
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 10:27:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EF383C02C2
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 11:00:22 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 27674601151
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 11:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662541221; x=1694077221;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s6bddafwr0HDTF7381THv/L3QigOSTqVRVkiAB9do7w=;
 b=XeA/eAVTyyIkhQvZtLdIpQGoK6nUll8uHUYmUj4AKavTO0zl1Ezd0avA
 Po74Sd5XQqrY0knytXYr3/a6GhipfIBcvbIfM/KFh0JM+5+aAxWVaOusg
 dw3aWhAzzXwh/n9xTslU/mu1eyKI7oysMnafHb8gLDPZ6LVh4rx0PH44k
 B9dcaum83vmTpzSXUpS9eGfw4kTCnMIEeXy4G0wMJ4HQh8k/bByIDT/Dc
 rwZGtdg9fqDHvHWB8BkzL/00RzJ1LZWgmYmWio2WwpJud/PPpdrXAzNBk
 /YYCBEgCEqynIg3rHo645t5nbXbogilfpKLSVKW3J075YFRtYKajK8fhQ Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="323004561"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; d="scan'208";a="323004561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2022 02:00:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; d="scan'208";a="676090073"
Received: from jiebi-mobl1.ccr.corp.intel.com (HELO
 jiezho4x-mobl1.ccr.corp.intel.com) ([10.255.30.104])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2022 02:00:16 -0700
From: Jie2x Zhou <jie2x.zhou@intel.com>
To: jie2x.zhou@intel.com
Date: Wed,  7 Sep 2022 16:58:41 +0800
Message-Id: <20220907085841.59171-1-jie2x.zhou@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 19 Sep 2022 10:27:25 +0200
Subject: [LTP] run "./runltp -f ltp-aiodio.part3" failed
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
Cc: Philip Li <philip.li@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi,

The test error is caused by "No such file or directory".
The test command is "./runltp -f ltp-aiodio.part3"
The call sequence is following:
runltp -> ltp-pan -> ltp-aiodio.part3
And I find in no place create "$TMPDIR/aiodio.$$" directory.

output:
<<<test_start>>>
tag=FSX034 stime=1662538554
cmdline="fsx-linux -l 500000 -r 4096 -N 10000 $TMPDIR/aiodio.$$/junkfile"
contacts=""
analysis=exit
<<<test_output>>>
/tmp/ltp-qFoktcygy7/aiodio.435919/junkfile: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=91 corefile=no
cutime=0 cstime=1
<<<test_end>>>

After I change junkfile to exist directory, the test is OK.
diff ltp-aiodio.part3_org ltp-aiodio.part3
4,5c4,5
< FSX032 fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000 $TMPDIR/aiodio.$$/junkfile
< FSX033 fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -N 10000 $TMPDIR/aiodio.$$/junkfile
---
> FSX032 fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000 $TMPDIR/junkfile.$$
> FSX033 fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -N 10000 $TMPDIR/junkfile.$$

test output:
tag=FSX032 stime=1662538553
cmdline="fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000 $TMPDIR/junkfile.$$"
contacts=""
analysis=exit
<<<test_output>>>
skipping zero size read
truncating to largest ever: 0x2c000
truncating to largest ever: 0x55000
truncating to largest ever: 0x5e000
truncating to largest ever: 0x74000
truncating to largest ever: 0x75000
truncating to largest ever: 0x79000
skipping zero size read
skipping zero size read
skipping zero size read
skipping zero size read
skipping zero size read
truncating to largest ever: 0x7a000
skipping zero size read
skipping zero size read
skipping zero size read
skipping zero size read
All operations completed A-OK!
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=17 cstime=10
<<<test_end>>>

best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
