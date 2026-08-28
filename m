Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF3C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 21:09:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 735A43E9A7F
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 23:09:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B71E3E9A5A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:08:44 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9CA796005DC
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:08:43 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2ccc2e84048so5755955ad.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787951322; x=1788556122; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Id3NZo7D5dtYdMhLqShfnJv4J4uHlDirRUdKABrIU1s=;
 b=KC8J+5kGJng2MiPKs33gTqXDDtkqy0luIMqTSK2iTTMI/pj562V/1AesT1FDxt6DIj
 b+DooLW1C9nb75QAhA8gZwuMEeViJealuA5OdpbgzcdwdpiqjBdcZzr83NheA5EtWfAL
 spEIp221qFJ7E8v4zUdYyf2NX94Wwu5vOBpLw9V20JqFvTyXo2BJbX1Ekb2cBZ1YHauW
 TOIhxnVpbBaqznhOKS7HYuqz7NtvwpeCT6iP0bgy/gkLxpb+AWKKTEw7FOcyHyyfmfyR
 9AtFJPlaoDcRtTa8OZCpJnqA4ZvoFVPqvq5SSZP2+uqExBKKgZeIdzW7iILbFcxysfof
 7XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787951322; x=1788556122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Id3NZo7D5dtYdMhLqShfnJv4J4uHlDirRUdKABrIU1s=;
 b=ks9uq6gL2xGF6Y2fmMw8pn65VnZI8k/uQbPTnyTWGNF9LrsUEMTJWwzYUaT2yA9wDY
 ou4OdOz/VErciLVPOVomgzNCyo8QxnQuUPTUq3QYWPjpfGFYQMA4LnxmLhajFqZGwM7f
 ClMvQV/nGN+w7VcgTuRabJCbqhlkXcOXsus4lzfu7tL5QZDv8K0WXVT+dLAPy+wzzdSV
 qP8AZYBPXtG8YliAKh74eWy37OFiqdgkOpNS6d0DfTrb2C0Bfd2X37pY4nvXqB6Q7TiJ
 bCx8ttWNKrNNYYXo8Or7Q2EdpYLJH9Ki2JB54lqOdbE17wWs2dRi0mSDuLOfCEoan1Bx
 2JUA==
X-Gm-Message-State: AFuF++kgKOP92o4+hVcVuOPdufplTIVrA8BYBwyyVY8+tNOI9PnZk+xv
 4r320uQ2ZU1jigiD6vDaraWJnwUF4VRG1VFJmAqX/qu/GsKz2BI6/3RU
X-Gm-Gg: AYBFou2BpamvOVm4wTqSMEPHioBDVeVlXt/iNozCF4yQx6Vb7Vi85fpAGn8e1g7LmaQ
 LsMFhzS9PNhLNx+kthXH1pySAMcyVsPsddgyOuiSsQ8bON48goMhPggdF3wS0uj3zlyAVgSvu2z
 qDGtnYDRZIpaou/EhNtbvY16+gQjviKT8m5aWB8Gx5/1ZTGL/cVhqGPs6x2jBeaKvVfSLoF5tcR
 +CXYfy4B7epx9GGAM8w0efOsDbI2p99CgHTeSjbMtKh5hFU6+TqvrjJM0qFrfc9mwdp3Ektht0e
 H1uOCnlnt/7/BVaxm1vN5k7ymZkfOXNViz17a+kf3rpRYSbhg0V9qbtcalEb6NKk4Z1mgKXms3k
 hlAF4fZrd+90X2tAX+k807R5qGGrzZsQt1d+nADAoTu57IZ8Ud6KNfThvhyeC8NZ8IlLRSNnmMa
 L6FLdPJ5okjVA9C6299MpaGNY8jo5lYnONFVjrcu/q4rfEJsYRtX2vxTCzq7Y9VaDI8PJBBFDC3
 oQi69/0zHSOZU84fzYcJz9ax00xXYvfryGFZztSUyY2qFQa7cIzGdQrzRYx4+qVYgptSVkoxWd4
X-Received: by 2002:a17:903:2f8b:b0:2d6:fec3:bd57 with SMTP id
 d9443c01a7336-2d74df5cc6amr138892825ad.14.1787951321882; 
 Fri, 28 Aug 2026 14:08:41 -0700 (PDT)
Received: from
 runnervmgx7h7.1fzripawhdtutpjrtzqvefah5f.dx.internal.cloudapp.net
 ([68.220.61.193]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f8094dasm9033638eec.13.2026.08.28.14.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:08:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri, 28 Aug 2026 21:08:39 +0000
Message-ID: <20260828210839.3994-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120242.2367797-1-wakel@google.com>
References: <20260828120242.2367797-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup_fj: Check start_path before removing directories
 in cleanup
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

Hi Wake,

On August 28, 2026, Wake Liu wrote:
> cgroup_fj: Check start_path before removing directories in cleanup

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
