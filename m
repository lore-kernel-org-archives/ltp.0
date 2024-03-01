Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC5CC48BF6
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 02:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709259161; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2I7RsXqmd11uTVXFVlDkNL+7e6k1eUkMrO6BQ0TfOHo=;
 b=A4fdlpsBEKfg0tG/L5ksgiCC0GbXh5f7pz0Qv5TJP3CSRP7QCsUaD2l9gKEMeTEyMuQDi
 9BzEiaia6/He4wRpS83MDreVL/eEd0WlBdHN74xHG+2x0FEfijKKTKP1dlIinevUPwftnt4
 4d+W4xz8v8LCODUkhYOsnrOTB4RNkiw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 200523CF029
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 03:12:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D533CF029
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 03:12:19 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=baidu.com (client-ip=111.202.115.85; helo=baidu.com;
 envelope-from=xuwenjie04@baidu.com; receiver=lists.linux.it)
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF6DC1400B82
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 03:12:15 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH] pipe/pipe15.c: Adjust fd check for pipe creation
Thread-Index: AQHaa33er6r1n4eoeUWq8GmNAuj2LA==
Date: Fri, 1 Mar 2024 02:12:10 +0000
Message-ID: <EF89BFA1-4088-4497-B0C3-788743AAED3C@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.70.31]
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.13
X-FE-Last-Public-Client-IP: 100.100.100.51
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] pipe/pipe15.c: Adjust fd check for pipe creation
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
From: xuwenjie04 via ltp <ltp@lists.linux.it>
Reply-To: xuwenjie04 <xuwenjie04@baidu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A pipe occupies 2 fds, and considering 3 standard fds,
we should compare rlim_max with such *2+3 calculated value
to verify whether the maximum file descriptor configuration
of the current machine is sufficient.

Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
---
testcases/kernel/syscalls/pipe/pipe15.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
index c85ad1820..9e02fe2eb 100644
--- a/testcases/kernel/syscalls/pipe/pipe15.c
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -59,7 +59,7 @@ static void setup(void)
      tst_res(TINFO, "Creating %i pipes", pipe_count);

      SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
-     if (nfd.rlim_max < (unsigned long)pipe_count)
+    if (nfd.rlim_max < (unsigned long)pipe_count * 2 + 3)
             tst_brk(TCONF, "NOFILE limit max too low: %lu < %i", nfd.rlim_max, pipe_count);
      if (nfd.rlim_cur < nfd.rlim_max) {
             nfd.rlim_cur = nfd.rlim_max;
--
2.41.0

--
Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
