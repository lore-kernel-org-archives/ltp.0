Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBFC61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787907785; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=81mDHco0bHl1KXydXyUg32oRMtM/+4bwrGieTUSr2gk=;
 b=kOubedMU1ZhRiXDxcDR+yp9GcMDEKi86y1goy9wLLJ4rqulUcVca6+n8pG2ZPNM66Ir7l
 ZI1Iyx4LW31hkQVLgpIykqsc0WICXQnL/gflS+0RXAwgbO+TnPOxMt1dufwshUSn6Q8sFkB
 XQSMZnuWzHfhlmP2e5dcveRn1Aslils=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AF623DFABE
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:03:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2FDE3CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:02:46 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3CDBE600A57
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:02:46 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so550103f8f.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787907766; x=1788512566; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TPD4W5UJgtHeW6rJbYOuUpAZy0hp4kll6HKd/Mp/F1Q=;
 b=NANN4Xt/9YMN9pD27NHRRpGZFtw2Q6gpEqdYdjZuLaxqrNt+u10nNYcq7/as7isGzX
 rtfC1jA6dYk7TBcIt6f9AW96Qz8U5N6v9nKjhCoFD/Jq2FhMnHtatNQixoKR5yMboH5w
 jsAvplBZ1fVcOJExntbuWVa1HeEAFVr/BCoWbEBYQ770jAnwyHshk6l8lQ/bfqVukKtI
 H5UuRhKSDkLdRDwdWny2Zm9IEtjONnodCqYlvE+WutFU5/i/4K84rBbqklO4xB/QFbRG
 FjJAPQ2eN3Y+AqkqKSXdNodgL7tijykg2FvlLte9mDdKs2mNXn4QDrDdp1H+SPEbqpTY
 C9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907766; x=1788512566;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TPD4W5UJgtHeW6rJbYOuUpAZy0hp4kll6HKd/Mp/F1Q=;
 b=JYVoEMesPD6ihUotxZAMJYwqQ0CGlT0tbMA1MMOzW4uxidQPzHul+CEG6VEZzdHAQf
 VgAH8jT2tuin07m+SR5JADg+J9ZMzq/eYzqfQf/+919ueF3oKryWzRPg+uXIfx4HOPQq
 EYRBkIMlyhPwy+LCOn+icgNHW1mO3pu4AUETbtTaX1e5TQ5dvK9qaKCZ0LvM/KK7/Iun
 5WF09l/jDMtLvWRFrdw+CzFodxqV4GVjF9uth12QMggFBmzsPh42o4qZ1Vh43bXXDQXR
 7/zGsD5KpRVrJ+LsK7OtYEdJOvtmCqZtU+bQPMJTfHSRLZ/HQAi2G2lm88xWe0ZuQ9bc
 lVBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTwu89UGDFgkMteFL+sOVyNxNp9geReWgCvM+S7+FNzxcap75lnfitr5MS8QCr70+1+rU=@lists.linux.it
X-Gm-Message-State: AFuF++ncL9p/t6+1vBoquBjumTzLv+47MctBc2MTa+kybVXmvRGdl+Xg
 +wN2vBKUTJ/JTP0VXMaP0EmDIwB/nno/0D0VlFX9fbxFcIPOSMXSnuGU0QvTBO+indg=
X-Gm-Gg: AR+sD13SHAlOzqqCGiMvXVUjKmKLfm57dNO9PQjMptxVh7g+JmzzYlL34I6DK8SBRkB
 Nf4lWaKZl0dUTO490TDDmc0qwGlggDVoz7VfGYYZouMkSGQdFRH2ygdmyClMhQugID3V2nrCqhE
 hnqGGi0/nRrdohkzU0FPwSu1B+sjtCA/iQluBlgehc54zR7LVQnjSsYymNrZyNBXnCANAv3P6tR
 EL0O9cOJO1V78HJw7ngd3s/VWMaTRkLE9yrjd5Oud9ET67Jk5tSH1RVA1gAf0LJr+KGNWmcIn4G
 N8XJCK2rKHFPkIzob561R+FVMN0esGzEmh4pdlVBtRXBwj5vVHUXpPKrJYKHHu1k0uKfbyeKKLa
 AA/lFm1xe1Arb9bEBaM5/sZhO+dkE2g4/7IeMquOeeqEZhZq7tHmScXw+NgRVh08SC0XaPqFqrP
 OCizHPagT1v/7h9tpxxi+Q94KDSFiTAARVoyttseLJc/1GmGP6Lk4rjzHEy450cjfci/UGxMXHi
 VfajyvegdPm+6YQ3zAuCvtpPB/HdIfjhO64q+ygUjFBaTp2Bw015YmBp3rPc+ewxT5gf6KsFf1Y
 4+vlvQ==
X-Received: by 2002:a5d:5f8d:0:b0:482:ee81:f0ca with SMTP id
 ffacd0b85a97d-482f79c94eemr7336968f8f.12.1787907765518; 
 Fri, 28 Aug 2026 02:02:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fba3cf65sm5384952f8f.0.2026.08.28.02.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 02:02:44 -0700 (PDT)
Message-ID: <6a914eb4.cfcabfe1.269b6.bc9c@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <apFOTreIdNbi2U72@linux.dev>
Date: Fri, 28 Aug 2026 09:02:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Great, this works!
> 
> I think the fsync after tst_fill_file() ensures all allocated blocks are
> flushed to disk, so stat() reflects the real block count.
> 
> Feel free to add my RBT with this change applied:
> 
> Reviewed-by: Li Wang <li.wang@linux.dev>

there we are :-) will send a new version with the R-B tags

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
