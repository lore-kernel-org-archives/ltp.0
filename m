Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F3C3ABBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:15:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8161F3CBFBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:15:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F78E3CB281
 for <ltp@lists.linux.it>; Tue,  6 May 2025 03:06:36 +0200 (CEST)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 0A0E3200962
 for <ltp@lists.linux.it>; Tue,  6 May 2025 03:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:From:
 Subject; bh=azvumEZbRxbojbfqVdXtkwbtCCX6DcOFm6CInx8Kq2A=; b=ZBHh
 +pFiWQLCsBHSXPuA/NUwfl2UgC8ZTP5ZVM6H1Oz8vVjK8OJ8r0IdI4BtUPDyOZIK
 gvKdeYcCXouJ7DhR4VPUfd9micNqnoJirN0MHXg7LMVz+PPxBwS9NQPPB9eUwDVh
 mRJvQIQdt/2NjP+LnOFPPEs3qwxgIrY5GrN4Sio=
Received: from [192.168.109.86] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgD3l3SXYBlok3NUDg--.48878S2;
 Tue, 06 May 2025 09:06:31 +0800 (CST)
Message-ID: <6d607471-4bae-47d5-ade9-e45d9778689f@126.com>
Date: Tue, 6 May 2025 09:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhao Mengmeng <zhaomzhao@126.com>
To: andrea.cervesato@suse.com, Petr Vorel <pvorel@suse.cz>
References: <20241218015032.735590-1-zhaomzhao@126.com>
In-Reply-To: <20241218015032.735590-1-zhaomzhao@126.com>
X-CM-TRANSID: PikvCgD3l3SXYBlok3NUDg--.48878S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry8JF4UKrW3Cr4fuw1DGFg_yoWkGFg_uw
 18JrnrArn8CryIgF93Ar4Dtr1ayr98CrW0k3Z7K347Ga4UZr1fCFyUGr90ywn8GF4vgFWI
 vana9Fs8tw4UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNv387UUUUU==
X-Originating-IP: [1.193.37.141]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiJxlFd2gZV8-OcgAAsZ
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 07 May 2025 17:14:16 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] controllers/cpuset: Join string to dump full
 fail log
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi, Andrea, this is the mail I mentioned about the V2 patch.

At 2024-12-18 09:50:32, "Zhao Mengmeng" <zhaomzhao@126.com> wrote:
>From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
>While debugging LTP cpuset_load_balance_test, when rmdir a path failed,
>it only dumps part of the log, missing the $subdir. Join string to fix
>it.
>
>Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>---
> testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>index 567178e3fd52..f43518c71668 100755
>--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>@@ -195,8 +195,7 @@ cleanup()
> 		done < "$subdir/tasks"
> 		rmdir "$subdir"
> 		if [ $? -ne 0 ]; then
>-			tst_brkm TFAIL "Couldn't remove subdir - "
>-						"$subdir in the cpuset"
>+			tst_brkm TFAIL "Couldn't remove subdir - $subdir in the cpuset"
> 		fi
> 	done
> 
>-- 
>2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
