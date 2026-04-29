Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD07FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:51:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C3FD3E49C8
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:51:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 342603E2538
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:51:37 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA1C0600467
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:51:36 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c8c9c4cd8so566835c88.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777474295; x=1778079095; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cr2edGhxKiIIU6g/MD9jd7C3mVAmfvqTOhoyazIAumQ=;
 b=hKXHJnIN9xENjZiS2huUYmkAQKj2vlw44Yx//DKKu7LR1JXaXj4q9OE3i0xsh+gZcm
 ctOq4v34m4lY+WyJQajT3oy2b22xVEZxqeZHeunbzCeRvRCM8XrtK00F/mDTcFGhpdNu
 uBiEJvkcu0DRrVrVP53Xcf3dyvWHtysK/ja+TTxcXteIIbRhs/omVFHBlKME6YqkFSZm
 S68iIltPm2UBmz0kBRLWt8zP9MiV9uWDYe0RGxnOEZMSZT9Heub0J5zgOtQDTYibaGZu
 0kS4gbRk9ewqk0J8AC15dBt7I0eHcHFcjLiU3NTeZwAygvHZsURCudkHkMZsbGWKg1O+
 nWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474295; x=1778079095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cr2edGhxKiIIU6g/MD9jd7C3mVAmfvqTOhoyazIAumQ=;
 b=I3c7RhH12swg6r54ALto540xeErUyF06FtQLO3+t226kyieYtBycPCozcng/cXq+T7
 Vr/vTw12efJT1+89jYVLaLKn2BD/qafG/kVlFfuzs+TshM7hWJrrXKWN7jjCwwMoOn5l
 FjXO3SvBKH0Y6dquUdPRlsxma6qDl51h1mvi3YOMqR2eHcd/frqj1Uvv00ehTc1J3mjD
 6ohq0tza40lVOuyG3tPaUYPmtXXRurrp3QDmfqSVSQ75R5oKzAzLE+VbCr8fc/m9VbAc
 471aKUlkKEJs8qrT97fFEYlhLH3ZO0e7XJmg32hYP67SS3ivj/BLClwHhTYf09F+UD6I
 KfeA==
X-Gm-Message-State: AOJu0Yx2CBmahTwsqXZU+G8PNnmyTVVe2+4QHVC/6KlV1JIp5UcsNEb0
 i5LTdw3GnXEEpXw6rxuVAv1u9gtM/P3SmA+1mzgRqcjbKlfYaVtvq2Dm
X-Gm-Gg: AeBDieuMD3PJksQ+SiwfEovESXDw6c//FxTWpmprSOASiWPFwHOMzJi+/hFYV9nDmLm
 vDuiORMamFs5BJApHr1ws2UUrFbEUgfdb2caRVYEnw+EIJB7wEPxlRmxpRqHD+nv8oDzrdT9BFy
 xwargUexbdmIKqn/dTVvxj801nBGUkpFGLO9cYi9uLaWcLJHTQOj5E9SXTEj0MBT3T+nartZUlK
 S4NCBWwRNhVEJVUTavNB+v06ctr2rh2fT3Z3208sOps+skqA9N5Fc3VNzkP5PzmWdM7Xq0GwsTQ
 Gbul5VImsIr3TQcLa8m9qO/Z+fzsIqEBCrEOmWx9vNVi1o7mT8Sd9/h72o4VCEEfRFzYpDcXpLz
 lgL5b07XgxE2/NleNrK0QHxicmtxjHZAsXjot/NC84UJ7UHeMpU5iLgi3RgdOLcsKwNoa/Js4C/
 o/lgHSSt/xBDf40AlkBbwuQTrth34gVZqAgS7JAF8rFR4pENDkOLC3yMYNyUlyMVYuv2DWPn4y6
 cfMuXJvGzew8ekI+89qUhNOnM/i0JJCJv5jxY+HHFfoskkqninh
X-Received: by 2002:a05:7022:43:b0:119:e569:f873 with SMTP id
 a92af1059eb24-12de2e398e8mr1301579c88.16.1777474294754; 
 Wed, 29 Apr 2026 07:51:34 -0700 (PDT)
Received: from
 runnervmeorf1.uzm4dnevkx0exmdpusqguksr3c.dx.internal.cloudapp.net
 ([172.184.219.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de320f2a7sm3243669c88.1.2026.04.29.07.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:51:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 29 Apr 2026 14:51:32 +0000
Message-ID: <20260429145132.4008-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331111857.10995-1-wegao@suse.com>
References: <20260331111857.10995-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify22.c: handle multiple asynchronous error events
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

On 2026-03-31, Wei Gao <wegao@suse.com> wrote:
> fanotify22.c: handle multiple asynchronous error events

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
> Signed-off-by: Wei Gao <wegao@suse.com>

This fixes a known sporadic failure; please add a Fixes: tag referencing
the LTP commit that introduced fanotify22.

> +	for (metadata = (struct fanotify_event_metadata *)buf;
> +			FAN_EVENT_OK(metadata, len);
> +			metadata = FAN_EVENT_NEXT(metadata, len)) {
> +
> +		event_num++;
> +		struct fanotify_event_info_error *info = get_event_info_error(metadata);

Declaration after statement. Move `info` to the top of the for-loop block.
Same issue with `current_pos`, `ret`, and `m` inside the while loop in
do_test(). Kernel coding style requires declarations at the top of each block.

> +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> +			...
> +			continue;
> +		}
> +
> +		if (!first) {
> +			first = metadata;
> +			first_info = info;
> +		}

Logic bug: `first` is set to the first valid event in buffer order, which
may be the error2 (ESHUTDOWN) event with null_fid. check_event() then
validates that event's FID against ex->fid (bad_file_fid) and fails.
Set `first` only when `info->error == ex->error` so the event with the
expected FID is always selected.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
