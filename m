Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F7C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 15:31:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61DEF3CA5FD
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 17:31:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B23A3CA2C5
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:31:42 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A229C1400242
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:31:41 +0200 (CEST)
Received: by mail-qv1-xf2a.google.com with SMTP id e22so4227049qvf.9
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ExqBtu8j14lXF6aTiRu5Hoe0PAY+zhBw0urHIlMPDoo=;
 b=bu0hxd2z8td1gPLF2gFdVWToROjPG2evAgrvpz00Aet4663i/fc0fptsaScbSuLavz
 WAZyk0VaHzkmd0hGcWlPrv4RvOzAIn7+asWVLT6YqhRg6MA1Dof7FES9BjVyRqGfMS7P
 i+hGrUJlUF9koHziaJvNnlGO78rA9+F3wg6PROnOVaZVp1j1Rbz6Sijec2APhNu+HAhi
 re9/t+5bqqNwy9VRPMxAGtuHNtb+32JWhjhV/10iD96K7eaD6lmTr15Qj8mFnXcb9rVE
 l60BBE2fRFXCJvKy+vVMS//cAfJB15BcU43taHnzLD8GaiRG+IT+hiP5srPvNrTPPFSg
 BP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ExqBtu8j14lXF6aTiRu5Hoe0PAY+zhBw0urHIlMPDoo=;
 b=xThoNXzvUJxOn5NlzhxcF4yRPeLw14KEISvW1hYvcpK9YKxPqVHwMOv5TBptG2uec2
 BxcfuUBD9y4MnobV5UIC5rbB77lNkVm02RKGFoZQJvVb9w2NPpm93wiQoXFelEshhQeN
 sAmv6Kao7p2CfMmee/SZ1Sqj6s+3Ov3RgT1PlazzshNJVosJWJLUm8tGaG6njq3ZMWMA
 2R2M+VMZmDjQ3FZB8/akI8uDT26ajsMfNtpuP/g+7hBtCp2BuSagVqHJ0PMhg29kL0WG
 ZkWw03Vns5/GGi+7m6TUbPxyAKUsYYO6O301eFivIxBcilEb8QwlGkioYMj9lCRQUWVV
 53PA==
X-Gm-Message-State: AOAM533+qqkNL67B/IdzZ3JItkzqYKLw0wyN7qsLd1CIWycUK0MUA1j0
 ZwLn2qk/L7CsvL876VCZfopnosKdknwaj9OY0v67pDQeX5U=
X-Google-Smtp-Source: ABdhPJxn2X77ywOcdIzJHRVuztJwz5M172ipwtsYR+weo4BjEFSAC9yblaOm/QAk6dYQ3mg2L9hsDUt57vteU52SYEI=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr3886574qvd.0.1649950300291; Thu, 14 Apr
 2022 08:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220414145357.3184012-1-amir73il@gmail.com>
 <20220414145357.3184012-2-amir73il@gmail.com>
 <Ylg51UMuHsxbHRSA@pevik>
In-Reply-To: <Ylg51UMuHsxbHRSA@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Apr 2022 18:31:29 +0300
Message-ID: <CAOQ4uxgd4dGjr8HmUc4uO_jp6JoHHNjzCTddt8_BJ6OWGUEeRg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] syscalls/fcntl: New test for DN_RENAME
 (dnotify)
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 14, 2022 at 6:12 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> could you please fix fcntl39.c to be running for more iterations?
>
> ./fcntl39_64 -i2
> tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1459: TINFO: Timeout per run is 0h 05m 00s
> fcntl39.c:68: TINFO: Testing no DN_RENAME on rename from parent to subdir
> fcntl39.c:73: TPASS: No event on parent as expected
> fcntl39.c:77: TPASS: No event on subdir as expected
> fcntl39.c:79: TINFO: Testing DN_RENAME on rename of subdir itself
> fcntl39.c:82: TPASS: Got event on parent as expected
> fcntl39.c:88: TPASS: No event on subdir as expected
> fcntl39.c:62: TBROK: open(test_dir,0,20254540) failed: ENOENT (2)
>
> Kind regards,
> Petr

Sorry forgot to run it with -i

Here is the fix if you want to apply it yourself:

--- a/testcases/kernel/syscalls/fcntl/fcntl39.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl39.c
@@ -89,6 +89,12 @@ static void verify_dnotify(void)

        SAFE_CLOSE(parent_fd);
        SAFE_CLOSE(subdir_fd);
+
+       /* Cleanup before rerun */
+       SAFE_RENAME(TEST_DIR2 "/" TEST_FILE, TEST_FILE);
+       SAFE_RENAME(TEST_DIR2, TEST_DIR);
+       got_parent_event = 0;
+       got_subdir_event = 0;
 }

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
