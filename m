Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C019606A32C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JowDGkW+
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45BFF3E9520
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:09:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC7213C1924
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:08:45 +0100 (CET)
Received: from mail-dl2-x09.google.com (mail-dl2-x09.google.com
 [IPv6:2607:f8b0:4864:38::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B51A60006D
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:08:45 +0100 (CET)
Received: by mail-dl2-x09.google.com with SMTP id
 a92af1059eb24-1397ad3d891so511629c88.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794830924; x=1795435724; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cXFGbKRiBaPIl+/xq5XStazrGHfU7Px4covMP8X88no=;
 b=JowDGkW+YUHnL/Z7dRUBMZ3nJRuV2kqy4nHsJ5oW1IDoWMy8cjT8E7RF5CTTmhZIF9
 DmX9xpsnZKE5NpO/T5fDSx/V0gLYUqkOwBvxBkVm9K+ukvc0TlILB9wxj4vqq7m/1EHz
 f9xJmbLMO35Y0wrVewu7xRie/mdX4xbKTqOq+T4SwAKDskZoj/DgijyMZ1EXd8qoNU5q
 +m0acCdjxDpI6+shfTb1zyykCFdL6qeDoYyJz98QlOcB1xs6pMM8yuISH1b+GNOcijLv
 lznM0kiUneAUyNc98byBq5s8Eebkq7n+AzEEob3XTt+kgtjqf3T1q4J9mPoHsiSgu98V
 317w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830924; x=1795435724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cXFGbKRiBaPIl+/xq5XStazrGHfU7Px4covMP8X88no=;
 b=K2mdw5j/y12VAqCAPSilH8b62szMhB/LcNWQOD5TbStTAk2ET0OE+eBkLTwhljUFFp
 q3BtuiZNgdyp7RTLvcC5FbiygSwXPtmdR9PT4RXf/uV5jSm37OtPMRF1fQM2vLmFcevh
 /iPSkZalD9ip4rw9PHaID6uB8rKXtKg5BVJug646bNoqclJfx7tjlfPVh/Q/Q3VLT+Pz
 rtw+s2Cz4/cuS/ADW4zttj84mySpRxGgovoVrl0nFaLAhRN1A1o9/ytrFqePUglsLoE6
 ixUpQaiFoZiwzAVqoJG7gT8x826DRiEjl6QgSkS8l44PAr6bFSSHCvmyUVATBQOYgn1U
 VFZg==
X-Gm-Message-State: APuU4Z+W0TmfJ4eRvQxa/OIwcxfAml2bSApV2FLi2HnrqeUa6QuFqfLN
 5w4jbV9MsIj0U6bCh9VzM0ouIJa0LsO83MS3f3IruCUmQ2TfBGZtAzpY
X-Gm-Gg: AZFdTZdA4hqAtE/QoiPH+AGd8HZxiZ4hCd9NuNdLIonKScaHYw+LnJPfJW+UlpfB2o+
 ezQrkbPYXlA37HdPA2x58cMOleUwqB7qNPXRzFSoteZfo1YjCHyuRsGISKEsAE9iuPgTtaWCQA4
 RS7zZEeW5prXN7JV+AiVMDqx0iecYBCEqvTS49JCq88zwl7+LvxKjeSg7Iztevz9p2sS7irfEkT
 Enwj5N5CHIHUt+oyuMgDyQsytR0/ACSMtkLUtDOdhvqxEieTepFkDQZ5VLssj3Nj7N8elwxWarJ
 hFsJVjub6BqpWdkCfwvJTOXv9bjQqJTXTtHQXYsaR1Fcy+vR6ykAy5qeyk1USlDJ4QGLcxfBUNL
 xczZ6NHz79KOT1JKc8WvC6l+BHRJpFbhHgtSy5f67sJmjS0AMoyPCObqMJr2gnFGNueTZIZejhy
 tgLC00s+92NY8ofwfigkiFHpBTHGfuDYJqWPmGYm1BaL1EXLFEsDaHS5kS6sVRaDghNtlmLgyM/
 dNPL+CW7dSSwqQrcm3qOGPP63jbUb1k+RDaGwi40uJ8poTIh2fv/Lu+OUNEWfikCxuqpsG1Src7
 2t+3pd0Ijik0X55Fq26PnAGgi/8j4PIF0nJYnpz9YdBv3b6hOYzSwH5lvVqNcBgpKvOdOcqPbv4
 rHQ4x4vSzhJoANiXSXD5YdEKgjkVvVtldmJVbny3+r2uV
X-Received: by 2002:a05:693c:414f:10b0:369:faa2:1fb2 with SMTP id
 5a478bee46e88-37965f9c4e4mr11652126eec.8.1794830923747; 
 Mon, 16 Nov 2026 04:08:43 -0800 (PST)
Received: from
 runnervmccnms.vi0v02agprgudeo341ai1k3xsc.phxx.internal.cloudapp.net
 ([20.169.103.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm61631101eec.21.2026.11.16.04.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:08:43 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon, 16 Nov 2026 12:08:42 +0000
Message-ID: <20261116120842.3734-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116093659.828828-1-avinesh.kumar@suse.com>
References: <20261116093659.828828-1-avinesh.kumar@suse.com>
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
Subject: Re: [LTP] pids.sh: Wait for killed tasks to leave the cgroup
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

Hi Avinesh,

On Mon Nov 16 10:36:58 2026 +0100, Avinesh Kumar <avinesh.kumar@suse.com> wrote:
> pids.sh: Wait for killed tasks to leave the cgroup

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
