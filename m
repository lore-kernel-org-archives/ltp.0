Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C706BD4899E
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768569947; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Bq79zIum1unytmofP+0Rs9/0vK5u/EN4aN6pdF8gVaA=;
 b=Oo2FMnzMjqVEHDziLa3FJJ2+yNb9aBK8uNR/1GiMQ8qhwxWg2WdGrG9S7eaH9m0vI0kWG
 Oys8Ay01a9LpX4X2MpL0tbIOS1Ylzj/p2Co8cfoY+61RabgnuMybfbR2UTrup6/lHWIcZ+C
 qOe5n+grrszLR8MERFVpyNjwMK8rVGM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE9D3CAA26
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 14:25:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA5003C1428
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 14:25:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DBBA3200935
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 14:25:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768569922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF+t1qgZbw6YA343IAjbno+Um/mYhvqHlEcCQrXEbQA=;
 b=SPtOjKb7E+ZSxKTwejPI+1pXjzvu3b+dLT+vVxUtl9ByspWPyiFtfljJ9274YBNHmFbCME
 Ioq338ff/Cs+sLR/dJM5i7ttdAd8cGCpVY5WuiHELu3/vbjN0xl4Ux+LvwWHdkKNU4W7L8
 jyP6i6evtDnKxRQmqp2K3u4VD3UIAes=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-fMKt-pvIPfO3CwdnfEGPIg-1; Fri, 16 Jan 2026 08:25:20 -0500
X-MC-Unique: fMKt-pvIPfO3CwdnfEGPIg-1
X-Mimecast-MFC-AGG-ID: fMKt-pvIPfO3CwdnfEGPIg_1768569919
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ae26a77b76so3678695eec.0
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 05:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569919; x=1769174719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF+t1qgZbw6YA343IAjbno+Um/mYhvqHlEcCQrXEbQA=;
 b=Hk2lbyyFtV33G5nrFBmT66qgqdGbamKBvjVoORtaQWGr1m/PqOKi2A8mQ5oUySvKOI
 uN1Reobzzhs16yupGK9xFTNOaEK/ScUgL8+5qenPveF+xPx0KdSKIdXUI4iZZhadV8DQ
 s5IJpTqrTtBJRi+OWC7Ja5GWlQfmEARK123EndhwZ75NPrerWSQrZyanEm0IBLbRFRk8
 nbNr/qt7KsBSF1Ob8KJ7h0hK+7L1O2cCmDznfFljVyTEn7NIOYNJ/jUUJ/sUXBtwH3Rh
 UpQJbfLHczudfdw1rpubc06oA5KiJ5fphlPmv9o9QPRUyk0q5bmTUEXOPr62GLei1c/+
 o/7A==
X-Gm-Message-State: AOJu0Yzm7HqABl70XPfyc7OYf8rXcH8TikoOpVngPs37F/SVm9Pu39NM
 2PoXHPXk7HeIiWWwWjvwQWoGmIfCZqmchoH1CjArVhZb1ZL7MAg6EIdTjKX9TFeSq/1iojO5xeb
 N4xGJNeea37iTzlkk0olJYBuX2wcG4TSA9mm3JfFsMnJ0mJ/FpiX/glSPZU4QjG8qIfipYRQMzF
 d5GL96YMYzKdQvrXtvAcS3YThAr+MgDlDkqJouCg==
X-Gm-Gg: AY/fxX5I/6dsRMSEgm8f+T3pG+4THnqAlc6CmPwQMACB5V77a2TVLxGFs84yUO4vcxF
 jJyJHEwWqBXXCJIkfMefcfaARry6e58iMIa91lzmGF8O7lSuvLMnJbhHk2okXxTAe1W8fvrCqgO
 4dcJjSoIM/2B8SV7ZTHFJAgYHxuYP9sEHpNAA46Vgwep+lJ/0KK1z0PG6jD29GrTskk7c=
X-Received: by 2002:a05:7300:d0d:b0:2a4:3593:c7ca with SMTP id
 5a478bee46e88-2b6b4708303mr1707042eec.10.1768569918403; 
 Fri, 16 Jan 2026 05:25:18 -0800 (PST)
X-Received: by 2002:a05:7300:d0d:b0:2a4:3593:c7ca with SMTP id
 5a478bee46e88-2b6b4708303mr1706997eec.10.1768569917230; Fri, 16 Jan 2026
 05:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-4-wegao@suse.com>
In-Reply-To: <20260109061716.20258-4-wegao@suse.com>
Date: Fri, 16 Jan 2026 21:25:05 +0800
X-Gm-Features: AZwV_Qj8NgSCBoN7fwXVsIHFpnI2o3Es0XufA_MNxbbxE7jH6zJkzbKytz9AmYw
Message-ID: <CAEemH2eS1guKHV+MSSuCb5KPWRe7km_u0rYr99gEUybXdeJFpA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sKMkoEzPFekhEp4QGqyl1NVDaYkutzJYTI-7ghw6bjM_1768569919
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>         TST_ASSERT_INT(partscan_path, 0);
>         TST_ASSERT_INT(autoclear_path, 0);
>         TST_ASSERT_STR(backing_path, backing_file_path);
> @@ -114,10 +97,23 @@ static void verify_ioctl_loop(void)
>
>  static void setup(void)
>  {
> +       parted_sup = tst_cmd_present("parted");


In the logic of tst_test.c, there already did check and store the
value in tst_test->needs_cmds.present, so why here do the check
seperately again?

+               struct tst_cmd *pcmd = tst_test->needs_cmds;
+               while (pcmd->cmd) {
+                       pcmd->present = tst_check_cmd(pcmd->cmd,
!pcmd->optional) ? 1 : 0;
+                       pcmd++;
+               }


> +       const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> +                                         "primary", "ext4", "1M", "10M", NULL};
> +
>         dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>         if (dev_num < 0)
>                 tst_brk(TBROK, "Failed to find free loop device");
>
> +       tst_fill_file("test.img", 0, 1024 * 1024, 10);
> +
> +       tst_attach_device(dev_path, "test.img");
> +       attach_flag = 1;
> +
> +       if (parted_sup)

Can we just reuse the 'tst_test->needs_cmds.present' result?

> +               SAFE_CMD(cmd_parted, NULL, NULL);


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
