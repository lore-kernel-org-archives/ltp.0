Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479D6E6E7E9
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770114412; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=75gaSgvA0AVQy1eKfReZSG780sN5pupji4laPJUJOpE=;
 b=G1Zq1F6W7gE1jgvSqe428KMztJ2jwF7w4ls8k0sL+0x8h0Kj9X6Yjlb/x8iZxVSQ+KKT0
 v/Ho/d6o2bDJgKUbF2pt38R/HQycT2M8oEtxjJF/+/fi1tXzrzAGTGozCT/Se//WKuDWlAF
 Bu9x52HYeeRGgRNEmMGbDLuCJr1BmDo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7D093CD0DB
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 11:26:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73D53C4E04
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 11:26:29 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3688A600804
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 11:26:29 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so39787215e9.3
 for <ltp@lists.linux.it>; Tue, 03 Feb 2026 02:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770114388; x=1770719188; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJqL07PHZmfPagd/Eu0gAa5Ch8jZctCtXirIhc5gnWE=;
 b=CUcR7edP+1Ru/7f8eKT2KGEUa8u6vmeHATU1K03uki1bR8xbunJW7Lb/GDBSygxbAl
 QghkzrSiXGPp0mrHAfy18wrrqenih9yNJfkA4LaqC0vIEp4i8jcpbfzthN4qpByzEnEN
 +SumJcSiZn5MdXcVvI9kfAdePhcpZMguoSfWEo6a0ZU0VxexRqtThZTckt5OHA1vLR9V
 M4/9KvyxKkT3Z1FiL6Jt2JvhSwQQtQAX05/bRNcV1uCJ3L6hzvf2IuBQwphUeGk4SojG
 wF8Bu59hJvVAePPDNzSwHQwEQ4l4uSQILyMiJt4h+VFM6G7182+8Wy7vOuuO2LMpKYT7
 RfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770114388; x=1770719188;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wJqL07PHZmfPagd/Eu0gAa5Ch8jZctCtXirIhc5gnWE=;
 b=U1uza6lqf+Q/bYaJkDXEYIQ9OzO+ibOJsVubM+vuclrZEttC1lVLbFFJ1vmPoiThp8
 lwbfV5/0avlDiG7vRZoguMPodgeVIp9niDL/+ROAyiX8SDCScT6HloBcY9ZVHtM/9f0k
 fOSifUFoUZeviOixMEnByN1Ib0aou+pMmSONFU0Z91z5sXHBM2tFuJteCICct1p8O9rM
 1wKwwrz3IavpF9BU8zaYwYzCDcryYz0+I9kV+NZ1yHbb7VB+h5UXuHwMOfUtedP0oMOu
 Hm2s4uNLmjUv4NLmXiClfX2IoaXS3/MVWc6sS/6UiyEyDDVBp7lqB/BY8sxS57mtccuh
 I27w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJhSjfDhmfAvPkpJVFh69TS8vVflxAx4ENSglF6r5PhUMREIoBvbRdoCNjYraa1MA1Kxk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz3d8vsBAkswYcYe41nw2Hmc/QftbecedqBfLgIl29cbIUAEEcl
 1X9XMeWjMLqG67HJ8t5DDTRhXlUL0FEtfZVbQBk5pVnmPuXVrEJiwX6h8CzpH9tZEc8=
X-Gm-Gg: AZuq6aLdOYMeRwVVdxvOsEwQPg3rqB5F56dV1l0TQXqxZAeNPe5ydWU1GHpohO2mnva
 PMf3N2LF8drh0f9zqclzNs7g3DmIOd3F1VKiIYCRpjnTkUjJZ6NKhQUtbFwPRsKHqf6SQmUDals
 sYIfYF779n8JYLZJ5DD6kfhHbV7q6wPBRMaBQtPbefYpcx5Et+qbWyCuIdKMu21vl5x/3ohrVRn
 318n5RmvCvlbNcPer4IHAbOLOE/CaSpUHGOMy0z/0ydbvEmcnOZF4aBNvAPskknZDEZwkzWvK55
 9Tc9JJamESkVycohRLWLRdPlsWw5VscrT7eugRwodLFycHFIEBdt9oN3h3x6slhIByRoRky7bXR
 zs8icXw8ENXUbtc1h+bQ/BqxdxlhQ2H4+V40wduHMtI1eb4fwZ6WIkRmFRgi+R05cYkR7j/yF4F
 DcO5asLuOOgCQ7
X-Received: by 2002:a05:6000:2dc9:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-435f3a880edmr23583534f8f.25.1770114388446; 
 Tue, 03 Feb 2026 02:26:28 -0800 (PST)
Received: from localhost ([88.128.90.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436142de842sm2654513f8f.30.2026.02.03.02.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 02:26:28 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 03 Feb 2026 11:26:27 +0100
Message-Id: <DG596JIOEG2S.14PUR2IXLFTC5@suse.com>
To: "Vasileios Almpanis" <vasileios.almpanis@virtuozzo.com>,
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260203094317.685385-1-vasileios.almpanis@virtuozzo.com>
In-Reply-To: <20260203094317.685385-1-vasileios.almpanis@virtuozzo.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runltp: fix regex for disabled testcases
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

We are not supporting runltp anymore, as you can read in the
documentation: 
https://linux-test-project.readthedocs.io/en/latest/developers/todo.html#fade-out-old-tests-runner

And from its execution:

	~ $ /opt/ltp/runltp --help
	-------------------------------------------
	INFO: runltp script is deprecated, try kirk
	https://github.com/linux-test-project/kirk

Please use kirk instead, which is included in the LTP releases and it
can be installed it via pip/sources:
https://kirk.readthedocs.io/en/latest/users/quickstart.html

King regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
