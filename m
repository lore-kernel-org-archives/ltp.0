Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DE606A330
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y54soEs/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ACC73E9409
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 22:03:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F6353C00A4
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 22:03:35 +0100 (CET)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED6EB600477
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 22:03:34 +0100 (CET)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-36c9b5c6faaso48608eec.0
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795122213; x=1795727013; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZe4TA6+xHh/4WDnes4FL2KEEA7G0JwbgurR5EZSiDA=;
 b=Y54soEs/6J2+JnHMjjybcDSirYoT4JNfDG8MNtK1YpoV/7/VehBycrmYdLb+Emje7o
 z//5g5HDlPX5R+Wf/RhriFLvVexAokESWFN4S+v4Jg0Z+xZ1yfyC+wfIK11D6vTQPlRU
 02eHwZicx1Y5Zh4OQJskzmvnTLGowmBlzg1vJ+z8ULNOVFt67L7c+ldvBz+mkmct7JgY
 KFw2YzR1IpJdXKbYL4hUYKlr5EJgS6T4Xi4gWKz3QTDreqEEzHHGoYFU7A46tdJrOJeH
 F7+14bCQNPRcOIGIjVd9IqZtFbqxqULgt88qTXsciYuol5U/E/D7ZKbcz1+oL5m6novZ
 2Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795122213; x=1795727013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZe4TA6+xHh/4WDnes4FL2KEEA7G0JwbgurR5EZSiDA=;
 b=FfKvUUn8SODmHrO2ukS2mq0Xr3zu21b1NQ6EAwI1luMY+lOlaR1yvu9a/ikf0FgJVd
 iNUTn+nqJoXSQISRU6PowibhMknW6jEAlZFVNSP1jqd02o8NjgC2TOkY7grQDwSTIKFq
 dtBQIltiQRJgTGsV98VmX0SwZa5e83gCiF3SJ1Ep7BowoBfgiKDWWJPgcg0MFfPTtnJa
 Q8eHcKH8TBl2S9XgdukDzOOSH5jrM5Mqju/0y+En5FKCB7BMfXs1vizBUBh3DXhNfrBE
 RvozqMO0Tc5jPGqMOMpCzj5RY6uaOKSxvzuKysdmEa8bPFfJCUcm1aKmJP8zOgl0On5F
 JPYA==
X-Gm-Message-State: APuU4Z8z6go/3Z8yNLIQy/+AepU+EQSAKsZ2wFk83/u8RoIqT9Cg6/oi
 mm7rziphttPnwsEMkabKTBgvBkhWCN6QcfsxBCNhRX91O1QjKtOv5cwFgKT6hzhj
X-Gm-Gg: AZFdTZf4kntILpVt2Rf2Di6XSAHYo/N84R3dHIrgxwVkVYPwA31Q6azmSizC+I3cGoR
 s2QPKEcmzjlJVYh3CO+/ztl4RnT8ZDW2tNmT3uXmiwMMN6zMbCFgx4VSPsweuNyXyeCXti8dqo6
 ZPYVrqJGkOKRFbxDGjnzX+lwudOw+dfuGc7oFAnQWEGO18wzLfiZWTRJo9SIODaumAYKR6mcZBQ
 0zLU8YxmzGowdyOA+PNluVAeKDEoxcp3WSuxSwTiZokAQr/e4/chq7vL12HSyXYq26yD8FHEc/3
 NUy21saDR/HIMPwlIw5D4/ZBUf1YZng6Flvz3GEPdjWJcv8N8Jr8XoIMe3sVcg9P73sNN5MpgwM
 odmefl/LS7pX8KzHybCS1okGbmb5CHeT1hDN2wX3olmLZ3gSmJGfJ/PXxhZa3Oyv8k5zeXpdWOJ
 YUp5azFjVvpiCmcdIT4XWJ32FJoMKMzbFU9fvPebEjrnFuHmVbE2FFaV1zIjby2utCk1xNe9wsM
 5FTcZoxE4PKnQ5Ev20cajCfg6yCy5Fe+3XzMFEH/2/pC69EBNLOIRIFNo3S6WqXy0TzHCp+O1+V
 MiOkEA3aSPk/rZyyhXggFF81svnoYUNQ7LsmiSFa3FtKpB73nhdLVViXrr00Rdyn59JjZyYB/hG
 HILheFf24Ml6EA43C6NPZGeoFshfhspNn64oktOLjYJY=
X-Received: by 2002:a05:693c:87c4:10b0:36f:29bf:4326 with SMTP id
 5a478bee46e88-385692575e7mr479043eec.0.1795122213045; 
 Thu, 19 Nov 2026 13:03:33 -0800 (PST)
Received: from
 runnervmccnms.tfwys50uckle3nqgfeiqwd11rb.dx.internal.cloudapp.net
 ([172.185.55.131]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm1344272eec.26.2026.11.19.13.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:03:32 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Thu, 19 Nov 2026 21:03:30 +0000
Message-ID: <20261119210330.3876-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119134049.272956-1-avinesh.kumar@suse.com>
References: <20261119134049.272956-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pwnescape: Send untagged frames on kernels without nested
 VLAN 0 support
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

On Thu Nov 19 14:40:45 2026 +0100, Avinesh Kumar <avinesh.kumar@suse.com> wrote:
> pwnescape: Send untagged frames on kernels without nested VLAN 0 support

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
