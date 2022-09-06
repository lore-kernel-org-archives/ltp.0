Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEAC38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 10:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 319D23CA911
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 12:13:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61F283C010E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 12:13:34 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5ECC200D59
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 12:13:33 +0200 (CEST)
Received: by mail-vs1-xe2c.google.com with SMTP id k2so11133832vsk.8
 for <ltp@lists.linux.it>; Tue, 06 Sep 2022 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=XCUmrQBvbQACP412V62xMBlL0hLTcPSP+iHjqSgVtrw=;
 b=BwmPryx1JvbWQ0brPtzgIwRdAJEa8nB1Q1lT4pk42WSGa/emhelpxZNwyDEH6XkjV9
 w1SER3pMRBUjbB9VYsTR2Nv4acmcXN+uuxblqKUQmFq6s8rq9aMZsR0FNWe2Tut6jrRL
 5lXv5qi9i40CoDgW9Y4uuzfjaOzo0bVzSq1zdHDDw/tIsGs6RZV69h91K/Lr+Ppx4VTn
 z+PPG0qyG1252HbNLjlCQi1tieklPzj3oFfYPBja0V05ZunKiDYWF0Oyck+Drbm6XpF8
 +RbgKZe504j8FO65wDCPcegDVBSbqEY5WMXZr45xUDGnDcAD8n25emqEtf6OGcxESrE2
 2yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=XCUmrQBvbQACP412V62xMBlL0hLTcPSP+iHjqSgVtrw=;
 b=AXmgwNZtsB6j46PoyboYhq8kpSMAH9E2xrnKX3hS+7nuQZzSac2Wf6whHMCnzy6Wde
 PMomuK/BGonI0OsnXydDZTZTmasf/K8vZsn12P1Z6N1ZUY+pZoRB4rtJj8GWpN0jpILi
 zfIL9crTRCxeX7K5xq2n9TuHTKOiVCOcEySyb1c0k7RDPxUQxoytxLXY5q2MpjbvJHPe
 zy+RvTMdqxyyfS/ZjnFl22J5XDa+5zHCCyD9pgfRrCozt9N5oGWM7I/u0njOkD/7WiDB
 QRaunw4ztT3ouK7rGdFxByyZlQet3hPUlmOGxnNBNYxGH39Y+LULQJ3GFdQgn4zNccIY
 5lxw==
X-Gm-Message-State: ACgBeo0I84MAWC0NgTcam/uHWd5OONHfipTL8jICrjIipUbaFsMgpmUJ
 9SX3QDBP5hRi7dSGQSg0D25QU0N6edXXER6tCArvcPrWALU=
X-Google-Smtp-Source: AA6agR4A7l9k6YEMWSFWp/+NUNTOLrcclgYLYDTGMj3E8alzvqgccg7aO95u73pvm492srvy63TZ757POUZ9w0jAL4o=
X-Received: by 2002:a67:d00f:0:b0:397:f237:98f3 with SMTP id
 r15-20020a67d00f000000b00397f23798f3mr423827vsi.71.1662459212607; Tue, 06 Sep
 2022 03:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-4-pvorel@suse.cz>
In-Reply-To: <20220906092615.15116-4-pvorel@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Sep 2022 13:13:21 +0300
Message-ID: <CAOQ4uxitPLeqeaydDbG6=4eDU8=6wfFaSiih0bFXj0_DRdeMnA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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

On Tue, Sep 6, 2022 at 12:26 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> That greatly simplifies the code.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Nice cleanup.
You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I don't think that this patch conflicts with the patch in my FAN_MARK_IGNORE
series - if there are conflicts they should be trivial, so feel free to
merge these cleanups either before or after merging my series.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
