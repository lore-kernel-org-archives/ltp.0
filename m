Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2887C4450A
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44E6D3E76D6
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 15:00:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 383623E1D74
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:59:59 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7AD6600330
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:59:58 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 af79cd13be357-92e9c41fe9aso26847785a.1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784120397; x=1784725197; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yIiGFFMY72P7ZAA5J86Z90gJy8skxiTV1Lyau/QGMm0=;
 b=gUOUvTO/QfcEs2aPuoTne0qYVaGy5aVls7+o8411BvbD4eLGCczSQ4W9gXiVUY5KBz
 JNzzc9HPR8UHGD2Cp3nBEXS9lcOeBqNpCKPnxgF34Am7QwDos7C6xiENq/7l8lqzFz6s
 7H069R5QSZcwO8ufsowCp5Lf7ITO3+z0iKcc3fNVSN1KCjdnlt9/qiGggq5qKjZAN31e
 7L5WmfEmRJloYa4qfgNOMuKEOZnyHcEMsHMKCMt6CigYBNqcpkbVG6Te4KV5qUKmYNlp
 X+OSqJLYtHHjtKyAVwysfqrtX6vV5yumn+a8SP11pc2lT/8CMcFeaRsVEmC9YeRoEnWC
 pDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784120397; x=1784725197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yIiGFFMY72P7ZAA5J86Z90gJy8skxiTV1Lyau/QGMm0=;
 b=hcFaORNxiJjRJlp5LIT2dENYNLCwzNngIbBGd/HxBKg0Jp5iLwpCPoHI0E4Xm7KgzJ
 N4zbML9tn+sderADgTaRkLzJKviEg7cR4+Dbj9P79GyAmQ+sqAfFJXXCWvKX4oJS65XH
 j9YhBI1GtDvqVdMbOgPHx3tQRPiG7vqDaRdINwaePEkz01c4ey34PqsBzbavBD70kKtv
 USK6bDZV13bca/Q8J0QAzy7RRBwas3u8DDc7APvL5imVx8FTsb17izLXKfu3eIVR+EPt
 CatqHPeF45Uk752D9qemM2kjXt1QhdzIebQw9SesI1zhfzuP6pm0C7OYLGEEQ1FN2xPM
 bB1w==
X-Gm-Message-State: AOJu0Yzjd7LNzpOpd3gedvXpvljEzFBOQ1b9dwbiLLeMyHq9/0bfTyBS
 ilbvsbdtxrH0RKd2mjp2d2yIU89c6XmrtBcO2ZEAHmvAPT4yTq01oLcVJVGFTR2v
X-Gm-Gg: AfdE7clTimNdibxEG8ksvOhwwHRa/tMmE1rlvXRmriX0LzOmspufxsB5lAXTX+2RmXW
 Dom+oFdcogj6kcPeZBS8IRYHu4hhtKoEoQx+2d13xvkPplFXDDIkltsDsu7OgdizrQeWvU4tjWT
 jlrYSjVWGQiFATTa0Jei73eebHF7xnlL3kv4l46wtaZYKZKVTdwgxLn0erBOJU5yETCnrfePhvJ
 FBWxBnuGSEe253zraWecxbWdi6LxblRN4e3Moqew7nOqmsQKM7EA5LI4OWzED/9K+DJNN+JsiFK
 sy0r8lkm4O8hxnlBAbUdaJdYsQWi4snfaCdAJ85kCg95EZVT2ev8uJHtUtnt3jxUV7Opfwv+ywm
 WR1B29XEiZnBn0alxzTIDkVEgk4j7xaT47YVKOoum7FLDuC5cg6VNpmWd5r3yNOoecWrCv8UniG
 qzjap23isdTNBYydlpr6jiw96fX1oSDZ39VhIhlmnk90dbU1s2fvHZiExVh/cRvGHaow2FGQIA/
 YF7FOoj1yF5GzTYAt7EuoiSK3PBfQ==
X-Received: by 2002:a05:622a:ce:b0:517:5ed7:d28f with SMTP id
 d75a77b69052e-51cbf8df5c7mr172308801cf.25.1784120396991; 
 Wed, 15 Jul 2026 05:59:56 -0700 (PDT)
Received: from
 runnervm3jd5f.xyzs513huevuljhxakirjdzfba.cx.internal.cloudapp.net
 ([172.172.86.231]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caae24d04sm131179601cf.18.2026.07.15.05.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:59:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2026 12:59:55 +0000
Message-ID: <20260715125955.4118-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715123612.1684984-2-chrubis@suse.cz>
References: <20260715123612.1684984-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_ctl07
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

Hi Cyril,

On Wed, Jul 15, 2026, Cyril Hrubis wrote:
> syscalls: Add epoll_ctl07

--- [PATCH 1/5] ---

> The epoll_ctl05 exercies the loop detector with a longer chain this
> test does the same but only with two epoll fds.

Typo: "exercies" should be "exercises". Also the sentence runs on --
a period or semicolon is needed after "longer chain".

--- [PATCH 2/5] ---

> That checks that subsequent calls to epoll() return all events if there
> were more events than the size of the events array passed to epoll.

The syscall under test is epoll_wait(2), not epoll(). Should read
"subsequent calls to epoll_wait()".

> +static void close_fds(int fds[][2], int n)
> +{
> +	int i;
> +
> +	for (i = 0; i < n; i++) {
> +		if (fds[i][0] > 0) {

The check `> 0` uses 0 as the "not opened" sentinel, but fd 0 is a
valid file descriptor. If SAFE_PIPE() returns fd 0 for fds[i][0]
(which happens when stdin has been closed), both pipe ends would leak.

The convention in this file is already `!= -1` (see epfd). Initialise
the arrays to {-1, -1} and guard with `!= -1`.

--- [PATCH 3/5] ---

> +	for (i = 0; i < NREADY; i++) {
> +		if (ready_fds[i][0] > 0) {

Same `> 0` sentinel issue as in epoll_wait13. The static array is
zero-initialised, but fd 0 is a valid descriptor. Use {-1, -1}
initialisation and guard with `!= -1`.

--- [PATCH 5/5] ---

> +		nwoken = tst_atomic_load(woken);
> +		if (nwoken != round+1) {
> +			tst_res(TFAIL,
> +				"event %d woke %d waiters in total, expected %d",
> +				round+1, nwoken, round);

The condition tests `nwoken != round+1`, so the expected count is
`round+1`, but the third format argument is `round`. When round=0 and
nwoken=2 the message reads "expected 0" instead of "expected 1".
The last argument should be `round+1`.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
