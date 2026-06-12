Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AAECD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781256958; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vz+p6wUuRoTiNYaYA0tM4lgeaHzInD+OpZKU4i67nEU=;
 b=iF8VpnsCPFxlVRn9dbbmSSdXIlpowkJwKhu5+it3luxD7QP+17CBslqRlyWLVHZOhkOqB
 K26H2ao+l61/+jBXFdKjR5r+t7zG9DZgVBpSglkjFUoy0J47nzrCLWCPGUuSKeMVfulRVzq
 qn6TUB5C8LI53x2QSDbZVC9R5TkqTac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C30E43E5E55
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:35:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB5273C1E1C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:35:38 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E06E1A00982
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:35:37 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so524936f8f.2
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781256937; x=1781861737; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0yOfmPfb997wnVRa8fTiJg3bZl5E+7E1NQCoh7qtTs=;
 b=DscIebktZWsk00g9LEA5IlwWpmGZ6Ywcffnp5K8JSEGufbe1x0wdIu59QiXfKWa7t9
 v+k1tYuUcPeuqvMvxfYuvxO5i0TekDAIXnXqT132pENhxA1SfOqwsDJKRbKEuPbXglGe
 zhzbVZ7atQmbbZbwX/0X8Lp8oidUrp3897gBN3QTY9xv1G6Nn8CtaAM9VX41hlCbkyoV
 /X9p2q9V4Flx8oCHBn8NcNFBfQA88pilLsOAChpWUCYnH7ldcrdHxahSiumJ6MD3MpQB
 LeIzlHDrdSormzdVU/mUgrgKzErDrruqP8sq63uYTJRwRWPWrEi1/zyM3BGdioXyt4bv
 6F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781256937; x=1781861737;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0yOfmPfb997wnVRa8fTiJg3bZl5E+7E1NQCoh7qtTs=;
 b=NdP/8PxcQpAE4SuAzmNcnn06SprvzLpAD05NJzQeETnCnqqkQC89gMLIKgKRGQrGXU
 FfzWeTnFav5JBf+aBsV9C3/ffiYpQLHbkaXn0r5BgNWRbT2iuNDkh6NOE/9W/8KYUvk/
 +Fukro0GzmJl1RWKPRp8Kh1ZUwPk30JtCirtjAwuwsGnK0lE5gkTlOM+CEFYZ3COm3En
 DQJciu9+CQSSjlLoTzowIA0Hka8hR/RiPG5dOfzEqIIkIa1Yi/od2ootvC5bMSgADK9K
 DlMspPjd02ivmjcYFcDeT/H9AtKnyq/ZC9Hzp52j2KBsohge/FA93XUiKjiAqgoLB1Vr
 9OuA==
X-Gm-Message-State: AOJu0YwbiFNJ7S2brhbpKc9kX0KmQmp6Ul+EHrFqzaIJfiKRK13upCWs
 ghK5mCeRKCVjwuIGcCn6XS3YFOPx4yuNFmVvlbiX49kZsKkdYgwMdAChIOzo4NM+npfZeOKFyHK
 KEJ//58x2nA==
X-Gm-Gg: Acq92OE3WtYvK/H5w+EDcsTOhYqHJdk2u4ZE1rhmNRrtPl64fYFDZTclAXkscJfm96F
 vu6vAj6Ja1N/bXPdFfADtUmhFw8nZqXC5Uhi4gli1/Om+RXo+lb+9wuvcOgGzIYI03+xQZr4Yjz
 qidRpMtegh3wmOVHN0rD/J/Dq7G0Aqdlb3Yx7E7XBrMC5wfSY0Z/aG0vJf37GkqSe9+gl9ji6lg
 pztiGkYur4hkPSwqubhZmgtQSeM2onZnLECU3HORAOMmEoiyAAwpgR/9lRnEda/6OzJKlkpFVy8
 +1hYh3GSmwe5p/1qRu4x08q1C5IwoBOPbDc4zxfM1hhorLIGWi+aovgvWjQBTScRDgIESIEpuku
 m0Z5ONlMYdYYjG51TE88kOm/4RbNJGEmvHSZqALLZUUZnEjNfXCBcrVMUq+ArAn5HHeyfm3qUiN
 k8TzFKvT822SsBcHIcTx6B1kSwUQiwQnHdi26pxIlN5KxesXMYZMROUwpw/u0F8hYwYZEbZJY0O
 QQdYbdluL2eYR1wsFygM9vDq97/FUa8g/0NF/GpzYq2m3EO4vTQ2WHeXVLyi4ytjdOsATz0VjFt
 qw==
X-Received: by 2002:a05:6000:4a06:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-4606dbad478mr2791204f8f.23.1781256937005; 
 Fri, 12 Jun 2026 02:35:37 -0700 (PDT)
Received: from p200300ef2f13eb00017f7d76deb7e8bb.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm4112287f8f.18.2026.06.12.02.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:35:36 -0700 (PDT)
Message-ID: <6a2bd2e8.139a0e3b.18b4f5.5117@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260525153352.188816-1-pavrampu@linux.ibm.com>
Date: Fri, 12 Jun 2026 09:35:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH V2] memcg/memcontrol04: Fix race in
 pagecache allocation measurement
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

> The test was failing with memory.current values much lower than expected:
>    TFAIL: (A/B/C memory.current=6684672) ~= 34603008
>    TFAIL: (A/B/D memory.current=5373952) ~= 17825792
> 
> Root cause:
> Child processes allocating pagecache were exiting immediately after
> allocation (via tst_reap_children()), causing the pagecache to be
> freed before the test could measure memory.current values.
> 
> Fix:
> Modified alloc_pagecache_in_child() to keep children alive during test:
> - Added TEST_DONE checkpoint for child lifecycle coordination
> - Parent waits for CHILD_IDLE checkpoint before proceeding
> - Child signals CHILD_IDLE after allocation and fsync
> - Child waits for TEST_DONE to keep memory allocated during test
> - Modified cleanup_sub_groups() to wake waiting children before cleanup
> - Changed alloc_anon_in_child() to use SAFE_WAITPID() for specific child
> - Added num_children_spawned tracking for accurate cleanup

This commit message is extremely verbose, please make it simpler the
next time. Something explaining the root cause it's there and it's ok,
but the Fix: section is self explained inside the diff code.


The rest LGTM.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
