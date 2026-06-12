Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297DCD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781282310; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9CTRUserGFeAMdKdGZMtBTEIsU39pxFSC78lJTeje94=;
 b=E09tEGdkJntt7k+eDvvXJNL7w56VH/sbae3B9xS+w+KvqymbLYzr0hJ7O4gZco1Eaum1Q
 CEnP6T8ouE0yC/L1qiYNAmWUwvGZDeBjC+e69tUTjitL8OqP5Y5F0W7myKXrnQUkVxBEp8Z
 +cOb9pmJyTMPsJxSqYqI6jqPmxrrbJI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547493E6A5D
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 18:38:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137F93E5E62
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:38:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 637751000A61
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:38:10 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so912744f8f.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781282290; x=1781887090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=07SZeuE4qEZsKNh7aJyHvuGykm3pLevjPUvqODhBuiU=;
 b=R8YeQq/5xiRGa8ld7peN02NYomVLV9CZ8ipHVvSySPIt1XzKaY/FcLOCi69M9grLUH
 orFEHOx+QLj4xpnlUNt/t9uGSS4wtpteVdex/BZykvUh5EHkAxLRrjNPzGUqADeLxAri
 k2WJyCu2CpAR39AZZxvoxrRVeGgXAmLk6LXIwdtYjcoIWU3NPK6uW4+5e9INK5fYY2G4
 uDAQmwdcJUc5W1OIrmEIv+Uknf+V/9djH8S147z5BHNNPt0lN2trF+dJVCQMcif0odyj
 kkp0E19YLUZSdsZPfyw5dRMN4Sv4BSsAofaTNOV2Qkwz5vcQPOXv9auZqzoDgXHNXQaK
 OXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282290; x=1781887090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07SZeuE4qEZsKNh7aJyHvuGykm3pLevjPUvqODhBuiU=;
 b=Ke9QPNfbrgS6e6AVZLQakSTT5MkN0mYMdTk4gF52wMvjxNseFeowQ2MffNp/QtXbvZ
 aeylLjrYGDuud/fCs/epP0//iVxnrG+USRmdVbqZD1FXbAEImJ/xu7fP1AaOgRVgCzrW
 Lj1k4yL6F0O5AMpXA7BWx9vALT5pyM2/c8OoiqEF4jHkUfhrMA2X9ATjS9tM5eznuJGV
 cjZT2+Yzu20VF1QwR/qdnpd2/Q9LnRVo+gSQu0ky3FTVKiIPLw4gkeeWNZFbivxLw9NK
 5G7t2wTR29lxmW0SM/0+4HqY9Ycamj69EsMh6twH4/bT2dg4KTkbvMC1y5oWOfgqtwn0
 MmkA==
X-Gm-Message-State: AOJu0YwXqLT7Wij0ng1akM7/fhTjg7p3GCHRQWs6Lta1y0x577emzP/I
 Dsg6pcYMTwFPa15sWm5QXn8m2AoByWq0BD+bUOatxfOSUMKPRTK5R/6IldJ4X6/kC21fKi3P+T+
 vGM9rtoI=
X-Gm-Gg: Acq92OF1sP+34nmkcXypjXiyhCt1RdoJDUOMnXjS4gFtBmkqd0XgtYXP1PSYfMcwkMA
 0+ZnyBf6x8ej+npGKyXAAE9CWX4aomScCyDUhyACsZUG79sQqNKh7UfOb7N6YKdetEXYKhESLPr
 d2uzuK22DC1APWL0m5/Mh+D3AzD2PTOnaOevmELiaWYBllwfS/htV1xH4twegibp8hyI31hIvvi
 3vuigkl6SOuWtv0LPcwNqmqf1Yxzxyn6yfxG3Jj+NGZVqW0/UO+0AnyPMsVCqG5oKVelhgc3wvV
 Xs6swege2s8BU2EovDbw5ERQZu22lgNsVyuBmgytBpDTSOvM2ko2JK2x5LhrXsazNLPUk5jroMJ
 i0WtPtPOdTnHOR/XECWquKWRRgzn0nuuUqisZ7RlQIVYvXeBgp3P23YA+MeR0QfO7W83Ti2RYRO
 RWLa6X4dpEJQ==
X-Received: by 2002:adf:ec46:0:b0:45e:dabf:a00e with SMTP id
 ffacd0b85a97d-4606dba68c8mr4100707f8f.31.1781282289679; 
 Fri, 12 Jun 2026 09:38:09 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm7511009f8f.14.2026.06.12.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:38:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 18:38:04 +0200
Message-ID: <20260612163808.293181-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream kernel commit
644132a48f4e ("selinux: prune /sys/fs/selinux/checkreqprot") [0]
removed the selinux_ima_measure_state() call from the checkreqprot
write handler.
This broke tst_update_selinux_state() which relied on writing to
checkreqprot to trigger IMA measurements of SELinux state.

Switch to toggling the enforce value instead, which still triggers
selinux_ima_measure_state() on all kernel versions >= 5.12.

[0] https://github.com/torvalds/linux/commit/644132a48f4e28a1d949d162160869286f3e75de
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/lib/tst_security.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 820736c72..e9f7147e3 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -146,6 +146,9 @@ tst_update_selinux_state()
 	local dir=$(tst_get_selinux_dir)
 	[ -n "$dir" ] || return 1
 
-	val=$(cat $dir/checkreqprot)
-	echo $val > $dir/checkreqprot
+	# Toggle enforce to trigger SELinux state measurement
+	orig_val=$(cat $dir/enforce)
+	val=$((1 - orig_val))
+	echo $val > $dir/enforce
+	echo $orig_val > $dir/enforce
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
