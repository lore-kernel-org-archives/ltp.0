Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B6C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:44:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A9F33E9A1D
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 18:44:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F493E22C2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:43:54 +0200 (CEST)
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 652DB6001A2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:43:53 +0200 (CEST)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c96739a46acso2091420a12.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783961032; x=1784565832; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sTyQMTyQpZ+MH5fjNmrjGKWMF5KUazky3WSf2NPfbck=;
 b=llopW94XjQQ4uT6Y2LAQ2Bhgxitzdc4LdQyv5DB20+NZ1yI8cVU1Ua3gQFYT+LtmoY
 mmrhikV/Q8UJgYfpyXCusv7FmPhVpmYBppqOlQvv49hCEqhI9Ij1njIhaInE7a5xcfj2
 7pPW/pJWme8+OV26Xo+38iA+tcDrROMPQIpvUNzt5ShTQ0gKkoV1A0zNs1N+l3QLlILw
 ntRGgv8/zIGHR8TzHGzie7pWEpE6S+mqG7SBoiZ5o3UEqe42xOBAA04Qt4uRDquvU17d
 TJJ3/AslODrE2dTihXLbDGiRbJtHdQxwEvmsanzGetdcMjQkWGfk+kL4CKOhCVQlt3Zj
 cbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961032; x=1784565832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sTyQMTyQpZ+MH5fjNmrjGKWMF5KUazky3WSf2NPfbck=;
 b=WZD28iI8QH1fk9VJfjH3KXIhfvkFSFrni40FN+WGcQzh8x96gWjbMa9+D3uSKA1fuS
 xQItOjLfhrtInZq+6MSF6S1U0AHcEf6hxyvv8TyuwAQuNmO8gHeLcKtW9rSjqF89YrHk
 C4TOfNKdd3ll2t3rmxBSa4fVGgUDyFd9ddPb4QFIRqiP8BsR/WhWTOhd2Q/xCUcpxMFE
 JbiYsEIOBO0Mt6BgrZneuxN24Unzd3Zp+6WmH0MG5rFkSCKIktRxr0q8bH9ndj5/uBD9
 qMbiyMxGzzL9OspD+yaSuetMYfcI9wbF2KcyDeA4qjUXi+KEzHEzc/G6Ir15CUJLRSg8
 k3MQ==
X-Gm-Message-State: AOJu0YytJMJasNwxiFRvNibSgZgQzMm0OIsMrz8KxHST1naDxPel3miH
 VeyZITXMyviJq5oM1F1EtNWhyWr6+88BaLLpM8/loTkv0Ok4CQMCY0dYfSbg3GPx
X-Gm-Gg: AfdE7cmFeFZgSuwkjRPCiIa17HPR4mHdZOcOh6opFqZ1Kht+I3PIfQEbb6dVf+P0gbD
 A7svlDNBNRnWo3UpV9Kz2rY8xnJWxDm7EdlKylg5x2zL+o1ZhwCfbAHoQkV52ejZqnEsOqwqiWI
 UK1bte4Z+f25VwmScQnjBMLq0qqMNPvimHYfa+FKr9utwcbGaEyYXDcmewowmxxrz91bczFeDo5
 EYnSmpk05GtakEfO3mB4wX/wWJ9GZwW4nomLTbnfzmm5gTWOF+VeBsKjolt9pmvm0DTgQGTT/zD
 pXm140A1Cq1sRkRTyW+2Rr0u7POLgyJ1DgqR9M+GF8g7cO8rA3MaDaeswweLFGRjBX2KT/usyif
 B/W9V3lv7i9sX4jh85Y7LngyFHEwsArBqtK85xLq5z1QyWjO1cfOwqGt56HrdLEVIHV+0K3L49d
 5MY84nFlU5pyu5DRDUZvCMA44RtD0OX2M1vdVRLbZL/bbXx4052GhLhDmnyqdZcbiNw2hdHlzql
 PzY569TMoUFbGkriVIly+66nsr2I0+Az4KTwra1
X-Received: by 2002:a05:6a21:e097:b0:3b4:b276:a789 with SMTP id
 adf61e73a8af0-3c110b43701mr9646403637.36.1783961031608; 
 Mon, 13 Jul 2026 09:43:51 -0700 (PDT)
Received: from
 runnervm5mmn9.bz51w4jame5urfvxkbexpjqmjf.phxx.internal.cloudapp.net
 ([134.33.71.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3119c2a7bb5sm46659629eec.25.2026.07.13.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:43:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Jul 2026 16:43:50 +0000
Message-ID: <20260713164350.3931-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713155739.48823-1-mdoucha@suse.cz>
References: <20260713155739.48823-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify25: Add CVE reference and include it in CVE
 runfile
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

Hi Martin,

On Mon, Jul 13 2026, Martin Doucha wrote:
> fanotify25: Add CVE reference and include it in CVE runfile

> + * CVE-2023-52879
> + *
> + * Verify that :manpage:`fanotify(7)` monitoring can be applied to the tracing
> + * filesystem and write events will be correctly delivered. NULL pointer
> + * dereference fixed in:
> + *
> + * commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4
> + * Author: Steven Rostedt (Google) <rostedt@goodmis.org>
> + * Date:   Tue Oct 31 12:24:53 2023 -0400
> + *
> + * tracing: Have trace_event_file have ref counters

The Author: and Date: lines are commit metadata that do not help
describe what the test does or why it matters. The linux-git tag
already records the commit reference.

Other tests in the tree use a compact inline format, e.g. fanotify24.c:

  commit 28bba2c2935e2 ("fsnotify: Pass correct offset to
  fsnotify_mmap_perm()")

Would it be possible to drop the Author:/Date: lines and fold the
reference into the description as a single line, e.g.:

  NULL pointer dereference fixed in commit bb32500fb9b7
  ("tracing: Have trace_event_file have ref counters").

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
