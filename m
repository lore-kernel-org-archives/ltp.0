Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD048C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 10:42:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51C713CDAFF
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 11:42:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10AB83CD923
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:42:02 +0100 (CET)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id EDEED1000246
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:41:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=st/7M1KgZe6eEomjsBKO4yjN2z/jXzk/Xaj/xYmofVM=; b=I
 vHOLPf2HxrBiBLtVYUyALxPEYAJ1bds/Bvmd+pPF9x1B35oW7LkwIstWvaKBG0EA
 csdGkwlpeDDkuLgG87cSdI7ZEwRlWGEM6OBhf/kACa1ae9DslRgU/h8yHvRDBln+
 4TmTKt6R6hGSfAIokfqJpFjTvH6xvLurrThZpPCfFs=
Received: from xuyang_jy_0410$163.com (
 [2409:8924:220d:8760:106a:d0ff:fe72:76d8] ) by ajax-webmail-wzpm-k8s
 (Coremail) ; Fri, 1 Dec 2023 18:41:49 +0800 (GMT+08:00)
X-Originating-IP: [2409:8924:220d:8760:106a:d0ff:fe72:76d8]
Date: Fri, 1 Dec 2023 18:41:49 +0800 (GMT+08:00)
From: xuyang <xuyang_jy_0410@163.com>
To: mdoucha <mdoucha@suse.cz>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT build
 20230828(bca80109) MailAndroid/7.17.4_(13) Copyright (c) 2002-2023
 www.mailtech.cn 163com
In-Reply-To: <20231201100907.7308-1-mdoucha@suse.cz>
References: <20231201100907.7308-1-mdoucha@suse.cz>
X-NTES-SC: AL_Qu2bA/iZuEsr7ymbbOkZnEoVguY8Wce4uf4l2IJVOZ00niLT1x0cdl1/B3jPwN+eNByqkjq8aTNC5ONgVLJxQ6MsxgzXybdQfNU5UQUdW63r
MIME-Version: 1.0
Message-ID: <b535b89.17d1c.18c24f86d7d.Coremail.xuyang_jy_0410@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3X2tvuGlleUk4AA--.10016W
X-CM-SenderInfo: p0x1t05jbm5saquriqqrwthudrp/1tbiXAw5hFXl8Knv6QADsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: Check for unsupported
 LOOP_SET_BLOCK_SIZE ioctl
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin

LGTM

Best Regards
Yang Xu



---- Replied Message ----
| From | Martin Doucha<mdoucha@suse.cz> |
| Date | 12/01/2023 18:09 |
| To | ltp@lists.linux.it |
| Cc | |
| Subject | [LTP] [PATCH v2] ioctl_loop06: Check for unsupported LOOP_SET_BLOCK_SIZE ioctl |
Loop device ioctl() returns EINVAL error if the command is not
supported. However, in compat mode, it'll return ENOTTY error
instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Moved check from verify_ioctl_loop() to setup()

Tested on kernels 4.12 (ioctl not supported) and 5.3 (ioctl supported).

testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 6d009af6a..64800b4ee 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -109,8 +109,9 @@ static void setup(void)
     unalign_value = pg_size - 1;

     dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+     ret = ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 512);

-     if (ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 512) && errno == EINVAL)
+     if (ret && (errno == EINVAL || errno == ENOTTY))
          tst_brk(TCONF, "LOOP_SET_BLOCK_SIZE is not supported");

     file_fd = SAFE_OPEN("test.img", O_RDWR);
--
2.42.1


--
Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
