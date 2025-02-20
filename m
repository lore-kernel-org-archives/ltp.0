Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F25C021B0
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740036298; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=zLscPm0ADNG6Egqe3O1lN3RH4g3LI/h/6QZGpmPHXm4=;
 b=Uj0+vEH8n6LbZApMMV6svj2wr7+/Llefdq83swGv9dqvbVOM3rSpVj0yqRcOBkCr54W12
 5x8WZE/e505rz7tDR7FvLDzHY+/yVT3j695jy+MkaKzbht0PoAR0y930H6htsJwKl61NOHi
 1OhkMuvlOhRNngszGr+F0glcctakmDs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A2C73C663A
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:24:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 899283C0134
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:24:36 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B54F654C34
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:24:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740036275; x=1771572275;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DavEHgKmu1dGqD+lvI01HUZz/vsAS+fK9YGd+n49zbQ=;
 b=cYFkcUSrgVEznCDGd+0m+2gtCMil4U4ECTx+Xouid0yGtAwjtqqh70MU
 Rx7S30OEMnJblLy9I02vOTZBcQ+J/TtnwHP8plnwtCejN3i4GkyycwxDa
 +QY04el4DM1Ad5oZjDkuti6ARaWv6RsrwkpcxWEhSsg6enPbLa8K0o14i
 8wUaH5qQaW7l9vU9ukvRSf24GpXPskqxt48/lZkS1HanK3vSMppN1MWXh
 32uxxY7Zsgj94HFLDCjmjn23eZa1GA87GFcsulHvtDgxT+2jR05SE3Usa
 lE0U2lUksytvaPzUhQoSKUE5zign/Tqk5NzOdxeAv9SnTYs043Edfijte A==;
X-CSE-ConnectionGUID: ctU/Y7w4Ta+1cseM7Qh11w==
X-CSE-MsgGUID: VsjTIOeTSyu0qsAzKKaCwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="190672111"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="190672111"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:24:33 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E190EE60B9
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:24:30 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A65A8D5618
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:24:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1349E1A0003;
 Thu, 20 Feb 2025 15:24:29 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:24:33 +0800
Message-ID: <20250220072433.1121399-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open08: Fix comment indentation to fit RST format
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/open/open08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index ad868b0ec..a4906815b 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -9,7 +9,7 @@
  *
  * - EEXIST when pathname already exists and O_CREAT and O_EXCL were used
  * - EISDIR when pathname refers to a directory and the access requested
- * involved writing
+ *   involved writing
  * - ENOTDIR when O_DIRECTORY was specified and pathname was not a directory
  * - ENAMETOOLONG when pathname was too long
  * - EACCES when requested access to the file is not allowed
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
