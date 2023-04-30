Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C89C77B73
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 13:44:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CF843CB9DD
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 15:44:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7573CB921
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 15:44:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C616A200224
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 15:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682862263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mb7xZh10Mf6G4iyKCpaDPovpg4aRYbm5q4hnAbMUags=;
 b=gjymzPbqdIOl1YoCnAYJOcQWTS9+bIkttZQUhiS5IcT8Ci/n8veikIH1gCjRz3ArEBpSFu
 r/+OJMEdxoVrLFBgYetLX8W3kJX2Wfgsuvcwll5MMiSINjBxg/PAD1muSiBmb+Tjion+aA
 d/zAhIrLMWjDU4nK9I7AqDN6PWLkcFk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Ps3SUhk5Oyioz4V1Vb7XIg-1; Sun, 30 Apr 2023 09:44:21 -0400
X-MC-Unique: Ps3SUhk5Oyioz4V1Vb7XIg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso928606e87.3
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682862260; x=1685454260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mb7xZh10Mf6G4iyKCpaDPovpg4aRYbm5q4hnAbMUags=;
 b=DGn6An+3AKAXWku3kJHjRNvK0QICCyKkk87qyWkkRPixhpUNmKXBQ6XuxYvjlllP8E
 45sDJ2uy1CrD7dQbAA6XL9fWh9xRb9sJv3Evz7qGCpuvW3aA56z+O/HJvwMFD6u7cNpc
 ji8QfLr7T20S199amPv71hvZBO7Rfe7SuHyGlXw15IwU1CgcJ7mZPNluRmMqOofjSORw
 YqAoJypo1UDYzlRc6lP1zanHB/2uBvhDOpYO8wqsrAx5FgVi/6o3Kmp1LZKy26JhyFsp
 A5KDXKUpnCeZWK1A2jbNENvQTKZPRo3mbv++r29B/TMsg+7Ql1PSFqqE+TlgZovuLs/w
 JFYg==
X-Gm-Message-State: AC+VfDxpTWg/2HUEAbVFcVPiK0TdEryCBjqQxk3B3je+rhxYFGITEBml
 lt2KACWmo7mvdYeg+cms2vDgAUFY9to2L2twI37Sq+BdomQvbozFm4c9kivd70Oyz9Vs5UeWpYh
 IxeJH7Gv57SsV5Zq598Q17VkN3iM=
X-Received: by 2002:ac2:46c7:0:b0:4d8:5238:ae97 with SMTP id
 p7-20020ac246c7000000b004d85238ae97mr3009757lfo.36.1682862260530; 
 Sun, 30 Apr 2023 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4I/Era3i9SqjWq1dKVAuAvVU6VyWJN2IisMO0OUUFpoqwxWIIe9jx00BBS6N5LUFBIhDAxRD/jidU688+h2nA=
X-Received: by 2002:ac2:46c7:0:b0:4d8:5238:ae97 with SMTP id
 p7-20020ac246c7000000b004d85238ae97mr3009750lfo.36.1682862260212; Sun, 30 Apr
 2023 06:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230428101038.7253-1-wegao@suse.com>
 <20230430074811.29555-1-wegao@suse.com>
 <20230430074811.29555-2-wegao@suse.com>
In-Reply-To: <20230430074811.29555-2-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 30 Apr 2023 21:44:08 +0800
Message-ID: <CAEemH2cK60iL2cxeJQVfAwcqmhtmdA5=L25M5QEreMmp74-gCA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v12 1/2] tst_cgroup.c: Add a cgroup base controller
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

Hi Wei,

Seems we have to skip the cgroup.subtree_control cleanup
process inside tst_cg_cleanup(), otherwise, test complains that
there is error operation in line#1020 if the unified cgroup-V2
was mounted by LTP.

(no need to resend another patch, someone who merge this can help fix.)

--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1012,7 +1012,8 @@ void tst_cg_cleanup(void)
        }

        for_each_ctrl(ctrl) {
-               if (!cgroup_ctrl_on_v2(ctrl) ||
!ctrl->ctrl_root->we_mounted_it)
+               if (!cgroup_ctrl_on_v2(ctrl) ||
!ctrl->ctrl_root->we_mounted_it
+                               || !strcmp(ctrl->ctrl_name, "base"))
                        continue;

                SAFE_FILE_PRINTFAT(ctrl->ctrl_root->mnt_dir.dir_fd,

With above fix:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
