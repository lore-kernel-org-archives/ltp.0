Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6899FFF886F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:06:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EED6F3E2536
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:06:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DA653C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:06:17 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E0DA200966
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:06:17 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8c70b5594f4so1211020685a.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777359976; x=1777964776; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Cn/VD1419DDNtwCFQeVhz6r+Er8MBemCAhF7GiVn5A=;
 b=S137LS31xguzFbjLP0iDE4X9sR8oJuwQXfTU78NVO+vh8V/3LZiX69vhYIXwiNGeBB
 3nIs8AeDe0QVFJEod1l7g9bmp0ryNCyr2Z+m7xPybmJt4GkDZD5nn2DQSxHGC9vBcU59
 W8k4YFsWOD6B7pTGOeFlpqeUcMD+Q5kYNxitRy+jAD18Yg2Ov1+xyCuQkKu3cpxwODH1
 Wa3qtVy8Tge7AOCrdMNAnVDWO2WTi6H9Yy39dHQtEdxGwzKlcmBoAu8iUePbAu5t27P3
 6V5nJ4xIMYIns4j5OjXMW68A7SeZANBV/e4KdDmnJxFpy4MzqStwCOvnYiKIa60l8/d2
 hAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777359976; x=1777964776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Cn/VD1419DDNtwCFQeVhz6r+Er8MBemCAhF7GiVn5A=;
 b=cr3SYzO/iX9pXdZvmuMsWgaPP2PJiwCo92XcBCWXXwpBFhHWB+GSfLKAcpZJtCyWMV
 Jzt5LdID8PNPq3rZCf5WIQaaqSmVz4OFSPTVKeu3lA1OouP1p+clGXvbY1A05UHgAa70
 pwiJ6YglC0Ati4gp5p/Es8tZZl7k0kyL7i2JVK3yM1gCJj9UgS9p4Ev2sgL6sMwuB0JV
 XcBd4f55/cVPdRlhL3cPBGt/AZTXgl2Ga+34I144BLXMQrC91oI3k9vxTOaDFI+QDDFC
 nHYyRw2PmKZFPEkDzkPUI2HAqTeVMr5YFNDIW5adbbvyoOf3NgPxsiNP5royvYmt3zc2
 33kA==
X-Gm-Message-State: AOJu0YyR+YdIaZ3uzoya6sc75LpEqu8dv8tdaJobnRFpcSSSHNd6vsX0
 Y45PtQmd4tRo6+N2UtWQZMQgftG56cM1eM29aarVx73DR9/A6XTSRCO4
X-Gm-Gg: AeBDieu4GshEyL/T/EnMHoEBilAxf81j7vSdQlXw9Q4Evs1HsGKdYfSZOFuqFYecVPd
 Je282gdNe5IKrNPc5yxzMY+Gll8PrT17UC0urtcf47NGPjgg6k3T4VDRGCH4bA/O8/6X2USxygA
 BMjul7VGdp0IflvXueJ4dMC76tpVp7XI1C2R5m0oUGb/EzH7BqOYigFeNhM+WQAJFssidH6u3yq
 2EBYaJIzx9DF0Jd1U49MR15S/z3C8x2AvhA7A4qPPaoJsevcadDr+gBlvcqxSFqS6EPk1rMd5io
 TKm8qVz9WqyQ9ygnLdVc+AD6AJyDKZ8DjnNpuGB9vsRNKRoe7Re1GD1kd15foSwjdIlpAhyE3Ok
 tXIxLME5HZrPXt51mjX1OLEiX47Lx6ACjqxaqkYqVa80RGqx33tS0U4AoE6yZm2h9+j/cDvJHlH
 iLQN7xi94CNcEpxB5pPcJz4CEWiTrwPSUdWpaa4w31F1tNAPl8X4C6rF6pK0WMAuXjzsAc3ErUV
 A8nj3LTvSVIw55JSTVol3BTjiI+B8fotlBIeVvsmAhila5szA==
X-Received: by 2002:a05:620a:2596:b0:8f2:31f3:975a with SMTP id
 af79cd13be357-8f7cd9746a5mr228366485a.18.1777359975881; 
 Tue, 28 Apr 2026 00:06:15 -0700 (PDT)
Received: from
 runnervmeorf1.l4lech3zw5cujgxo2oqdq1jysc.bx.internal.cloudapp.net
 ([40.76.117.240]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c8a9a92csm116208085a.45.2026.04.28.00.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:06:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Tue, 28 Apr 2026 07:06:14 +0000
Message-ID: <20260428070614.3979-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424121845.10914-1-sachinp@linux.ibm.com>
References: <20260424121845.10914-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: generate CVE catalog documentation
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Fri, 24 Apr 2026, Sachin Sant wrote:
> doc: generate CVE catalog documentation
> doc: Rename statistics page to 'Supported syscalls'

Both patches look good to me.

One minor note for future reference: the suppress_warnings entry added
in patch 1 silences all autosectionlabel warnings globally, not just
those from kernel-doc content as the comment implies. This is pre-existing
context and does not block this series.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

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
