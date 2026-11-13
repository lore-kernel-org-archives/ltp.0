Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC34606A33E
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMxZJEk3
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B0913EA0D1
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 19:18:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F4BA3EA06D
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 19:18:33 +0100 (CET)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B101F600AB2
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 19:18:32 +0100 (CET)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-377f12217c7so1316752eec.1
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794593911; x=1795198711; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XjAuIFNkwzTh5NR1Ek0/Tu/TQr4BEoye1lIa89GNco4=;
 b=aMxZJEk3wf1fOGrVXScagt79oPJ6yaBzS6XxF7curf5QS9FEUEcztEhzeurfX5AI01
 0TuFY/PXkcoY0c14Ptfyk2++Bx1utr/gX81ocv2318yewPVgLmZnCQMRwUUdyxh9fP32
 noszNwfVSLN/RZ7hjzWH7t4TfnH71xtemat5hRj741HdacbjM6LyeZzUDzfr3n8tGT/V
 QFDpnx2GYEnJUcNBjcb8xXgMDxhv06VNS00TGj5CQBcsSG72YfQTSPg0VyR3MnYJqHq4
 CRFeFgQJosEw7FZbZAfiZYJN3GfV80RJKWqIDJ+uifyhpF+bUbLO42yvMdplKWR5dSGl
 wEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794593911; x=1795198711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XjAuIFNkwzTh5NR1Ek0/Tu/TQr4BEoye1lIa89GNco4=;
 b=G1kPaYdofRxRek2+U5Lc8W6iAbSzLTcSM2pb/B43J2ZUviYCiype6c5JTu10jR3LfR
 bUX/7FVvHzpw9mhgbEAA5fS0237WE1CWbMnWq33zUkBx5W/mioKs93acn0V3Y0B+JuD0
 dVL4tWcSY8TDY1mHK+o8g3oyDdEU8uX4lEIb3oipTSi5nB5XO+lz3XocC1kEI2Vg6XLt
 aVdHaeIhRwUjMIFBneiKyX2X4/sXyq29E1uvrBCdqzyElBNdWMmHKWhSHmPwa5GP7587
 x45nP9AV5krApx/tGyCWM3+sKIU91+6pQNsDTvUM7jVre4Ugd5yINGu7Wt/Ff97ZIejG
 e1QA==
X-Gm-Message-State: APuU4Z8PKcZZS2qfiWjcdRyaHgO0BQwOpW5BntDhZnRDjpYm3k3FVd88
 QyNGIMUcOyir5JM7gjFGgQt+fEb1iPJi4lmc9gmj4Z5a2aMfWkbTgYFr
X-Gm-Gg: AYBFou1wP1z7jv/W8dUaPttbe9ggRjbf+qKk89JXgG24RZVJFcOwVi+4kfYFN6qHhYj
 oOWA3E3oNvCNizdEl3dDx2syOGbD1ET7lmw5rOJmcm05/lnnYN38Cjaw8Kcj9Tp8KUy+PIwJLbA
 m5O5cSgWn4aQHImJlxfN6ELkKAPrPwPuvIzS5l/Ww32r7dj0D53PuTF6UWG96EynNl3SF/dXJ/7
 gyEWvdPUTRv7bJGAtSRZwedRLXoGsSYLS6OgQgGisp9U5+dZQWyNSr+kHKAuQdFdA4m2l7g7Uy6
 WLuS4HzCsJgofNEZxDxDeKHhN+qO6nV4mrVybYQ4mxJfQauqnDtSCNqaK9I9m5zQIY5YYw0JQAe
 rWWMjTarMBNQAiDyU9Y5Y/gxeBww/5iucvlNJYgqR1nfi28ww+BIxdiA2J3FSga+f5O/rKAPGd3
 hCcpQ1urw4XCb1KkWZvy5UY1cvwcC9aD3OcXNgVSLGmuSgu6hTdF6eCpIhV2gloRbcgLqNZ1h5H
 BwH0cX1DEuaLS5JpJQEY4yt0wfyqD3IgnqMB+FuIVn0M/DqZspTDheXWx/4XNMLfHG94h3M1Y4J
 obv/aLIR/ooegofYZK8QuZjqU2mXlin8UDEvIJ1TThmb0zxz3yt994L0hCSC3AMhA3UaZEYoZU9
 rdnF53yyOIjJKSKpGxYUazhZGO4LaufauBlCR4cpZMbI=
X-Received: by 2002:a05:7300:d107:b0:36d:b933:675c with SMTP id
 5a478bee46e88-37966b5274cmr2899361eec.17.1794593909716; 
 Fri, 13 Nov 2026 10:18:29 -0800 (PST)
Received: from
 runnervmccnms.4lm5vi020hgurhq2pzbrlr22sb.phxx.internal.cloudapp.net
 ([20.169.98.153]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d73dsm9359017eec.2.2026.11.13.10.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:18:29 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Nov 2026 18:18:28 +0000
Message-ID: <20261113181828.5184-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113175119.455908-1-amir73il@gmail.com>
References: <20261113175119.455908-1-amir73il@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify27: Test FAN_DELETE_SELF on unlinked hardlinked
 open file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

On Fri Nov 13 18:51:18 2026 +0100, Amir Goldstein <amir73il@gmail.com> wrote:
> fanotify27: Test FAN_DELETE_SELF on unlinked hardlinked open file

> + * Before the fix, the unlink of the last link reported FAN_DELETE_SELF and
> + * removed all the inode marks of the still open inode, so the write to the
> + * open file did not report FAN_MODIFY.  Closing the file then reported a
> + * second FAN_DELETE_SELF event.
> + */

Document why .needs_root = 1 is required in the /*\ ... */ comment block
(mounting the test filesystem and using FAN_MARK_FILESYSTEM).

> +	while ((len = read(fanotify_fd, buf, sizeof(buf))) > 0) {
> +		for (metadata = (struct fanotify_event_metadata *)buf;
> +		     FAN_EVENT_OK(metadata, len);
> +		     metadata = FAN_EVENT_NEXT(metadata, len)) {
> +			if (!event_matches_victim(metadata))
> +				continue;
> +			if (metadata->mask & FAN_DELETE_SELF)
> +				(*delete_self)++;
> +			if (metadata->mask & FAN_MODIFY)
> +				(*modify)++;
> +		}
> +	}
> +
> +	if (len < 0 && errno != EAGAIN)
> +		tst_brk(TBROK | TERRNO, "read(fanotify_fd) failed");

Use SAFE_READ(SAFE_READ_ANY_EAGAIN, fanotify_fd, buf, sizeof(buf)) in the
while condition and drop the manual errno != EAGAIN check.

> +static void cleanup(void)
> +{
> +	if (file_fd >= 0)
> +		SAFE_CLOSE(file_fd);
> +	if (fanotify_fd >= 0)
> +		SAFE_CLOSE(fanotify_fd);
> +}

Use file_fd != -1 and fanotify_fd != -1 to check file descriptor validity.

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
