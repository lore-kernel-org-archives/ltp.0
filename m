Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66906CDE008
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121923DAD17
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:27:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 037A83C255D
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:26:51 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9DFCF1A00CAE
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:26:50 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-5177b9a02bdso9453531cf.1
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782466009; x=1783070809; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNn+cnzPvFf8ORjri0dSQGp5PQ29NL7xYwNaaqnG8gc=;
 b=slqxK004kgbNX+ZNob3O5QwR+ISKYuFMRyho0K0z7MzOEeoDA2DYThOg/L2xp/qcAF
 59N2FcoEFw7v0SxiBgA5COoD5IwkCfu1760AQjZtXNxqy3HRa/4CLzXxHvHMpZPMAubX
 SuvHPh3hsY0b6zBTRuGMV1mm0Sbl+vSGjFibso08nJXHbhmDj+XqvEyhIrZj0aufqFXm
 4ayVoNLv7sutJVy68tXskDkSbViK2WvjpYdxBF470HAgS8slW5Co+8+Ga87OJe1NO0Xf
 MF13gjTWcpPMTXqs+FfhyRVNDceXXYElAaUkmKcJjWVjJgZloyADvy32g2zHp5Bynj4R
 ONOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466009; x=1783070809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNn+cnzPvFf8ORjri0dSQGp5PQ29NL7xYwNaaqnG8gc=;
 b=ief+HjPJ+EmwPD0MMddsxNEBU5qOkacDPnv5BJfZnLt0TnxifBO3Rqegt8kgNFOMy5
 8U+7BMYVvWl2PUbbjD3N281DBkAefXzAzHO4RvD5jY/D9x7pk7EowODpQQMnMZrQ3tPR
 inxlOeCyE9xmTOYKmZZIMkvVXU+FzQHXIBDuDplOxKS5rJndX7/ZOH1rY+S2HQf7V/Pl
 v9w/Gz/3Px/EmbDAnXkRGzWB6t7Gh958nhYvoeI//Pw4UAO0PK0TklRbiIXJfGFGOfnv
 zHIPPLclUg1OXnVAZ2KROvmb9nAuTCjU73ilUl3AAuhuiwolR2nRSI3UVur+8f09uQ1m
 BD9w==
X-Gm-Message-State: AOJu0YxA9+NWgdhtYvc6mNSSLkdGM0yqJe4PvjGAAkQ3mndtHh+vWa+W
 AOiLI/TIAqZ8YHNERcUBzm+N80T+LVtguvDW9VPbW4bf+10Kdl/UHznp
X-Gm-Gg: AfdE7cmoAb2ompyHpITLEZ9RcchFNSZP0MIUEkscy5oHhpjdWrxc9TG+kyXHBo1Vuc0
 yYVctInI9DiJCpkslKV3N58Z7aTGFIQHf69SEO5tVPutK8zeIk8CKvJtUYCOY3uF5fel0GEI9xI
 +UbXal41RDg7KcyFy8jO1iBHiL5lmtjKticAVEhArvLSRCm7yp0tnq35BvNuccmxvdXNkwMPmB0
 b3HC2I+k3kCze+4sU+q0GjyH7Bjc3rNjVFenNPauliR8FBhZUCQ51UyXJ1iXsqN6emBGirLb7F/
 c7fbX3J6UGN2ZZ+SrSALCBTDsKQkXdM8NjPRbdqe0E+dOF9BAPSghwhUiUxbCqYeKsmXHpJZrWf
 bGtmMw7srkU5YW12Wqd3JgpdV/0XhOq/ebBob0o+oWEeVouJR4wtIDF2qGG6sC4vrMypKyrmfuM
 DSZFAnuYMOMiyJXAUEreec0FmvJFWi72CqD0+PYGN5VsN8LW+qJBKQjqZ5kzUaoGrdz+C7KK1E7
 ctgZRt0AhALmoDzB62nQFF4Jg==
X-Received: by 2002:a05:622a:c18:b0:517:8528:e617 with SMTP id
 d75a77b69052e-51a726e3d9cmr84557371cf.3.1782466009298; 
 Fri, 26 Jun 2026 02:26:49 -0700 (PDT)
Received: from
 runnervmmklqx.umeiy342tu3uhnvuif2sqfdcqd.bx.internal.cloudapp.net
 ([20.25.34.38]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51addb1csm92134781cf.23.2026.06.26.02.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:26:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 26 Jun 2026 09:26:48 +0000
Message-ID: <20260626092648.3888-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626064341.196316-1-avinesh.kumar@suse.com>
References: <20260626064341.196316-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nfs: specify NFS version including the minorversion
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

Hi Avinesh,

On Fri, Jun 26 2026, Avinesh Kumar wrote:
> nfs: specify NFS version including the minorversion

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
