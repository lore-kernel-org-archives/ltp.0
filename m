Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDF0CA5FB1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790762185; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lEmLcQsq8xF4DJMIsQw3cMM4ECBxwpjo7anYCBt0JQw=;
 b=eXMhJti0Q2Hx35uW6u1FtnXP57Dr7SZs5afXtpieVOcDJAYsvLXYdtxxZVfjS9yrjGJJR
 qlzPTSdiaPWgOmVNRuODdK+wmDKLqeJAiu7umbWrvf6QMt6g/WskQKh+20bY3pqClESLci9
 xOKMZJDcePmbtDY1HfAtU+vOc5uzD4k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAF193E55F2
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 11:56:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4DE3E55D4
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:56:05 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C33D710007F5
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:56:04 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso141751f8f.0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790762164; x=1791366964; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vCln6BSkR8/gLVyvEPP9IV8rtMmzbAx6RrP2fwkzd7g=;
 b=aJnZx5osHqGs11PVpHE9q3LDsvwFC7eze46jbd5g+MKw1m7T7b02EUJ197tZfmZ4HP
 bHaO/BlTAINBHkTapgpKDV6pd9WLxUoyuPBxRDE8KZ6uBOXrMznxhpYC/7LbYZCw6O2w
 ROMLni+vsqoVKeidFL/I8npGb3o9sMGqTwnB1gWFIs/RmatABJ5scFqvZtE76g+lU0PV
 te9cREtxI0RC4s3QjcdvRsN83yG09iqsncKDq1lIGvyG5IK75DXQqbUSWw7aCFvF/czw
 Znjo1taMhFsKg+GnWsNJY3kkAQc8KsPbDzt5npr6vawu5IxbifpL903BAR0MJ8cJbaAP
 ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762164; x=1791366964;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vCln6BSkR8/gLVyvEPP9IV8rtMmzbAx6RrP2fwkzd7g=;
 b=0XcoPlH9Ahp7EYoMaKBG5ExDPGgHYRGgxqOuHFUHVMw9ayhg0j+U/S3gJcBA3eAUmp
 +HY2F6ZxszvlSGeZ9+iVwhgFIUQZU3dlCKIJnpmLPPggK6oD4MjGrJI/FS/Rnhviaotc
 pGYO03gpy77QlVcLQwkAFeK4GcaWzvdHnjhDKEezIoJUcrVrmxmp5JSpuX6RXc1LBAQd
 qs0UgLIB1BjxdZIijKDd4mCFchq3YG32QB3k/lKupCLFRjqkQWTwsVTbiq5suVG/101M
 6YpSTYknutSwZdWiPJAjiEU+Vilo2vZRagmhxxAT8PdbgkconX0CJhfIPTi9Jm6n2CMK
 hr6A==
X-Gm-Message-State: AFq9FYJ7ZWZ47GXXrrElufDGTWafbiGc9/+Sq7hRZxXbsXtfLanIH5Rf
 EIaYs5HnlS4MFjhOCnls8gfm93vaCP0sXYA3VnI0zAonABMoCYNMzHfWimf0LIAAC6A=
X-Gm-Gg: AYBFou2Zx2J4oZOb3KY4/4w+lMRIxgp+IN5fQWjlUpE7pYLTgX6B/kvaCRe8wP+xhK4
 lBHQToMWCNE7HVpgU06ET+cXDzpOIN1EtmAdbJZKto5Jf313EcnvY9ROsSqXF9WhRd8iJ0rfKmJ
 oewwu6BmMwSXubeDXTxivf2pCU7D2UG6+J2S+DWRdox5Ly77MhPKgTi5oK7qwt273+8or+5VVsy
 1PLQalTwJiVbv4Zvq4kV3TPdYQ1r6shdtOP3cO9eoeLGf+eK0X/ZuJvsZIgQ1ZlbIvRX5MrVBVs
 xdqUsISoq3i20R7t4Cf/T8qRta6RiZwNsad2Wa6Cz1tIYHAf5PpBteBi3D+UVTdIab2U0kTZ9Nu
 kKTRIexk1dp8qm0aC6uxMBfznGbuUH1lEwLRTi6jgzLK4K9fMrwOmG1wtfmwyUZ3LdcLmrKg2oq
 genf7XbxtfESo2QnkZDm0YRWxDLk7i2rpeG5CMGwskVqBaUGOqRb5/Ptb8r2ETE3NmLsausJZec
 Dqq3xTeb1/ntsYpgPLOa7Fb7MKUoz6gXP2/Nr4NFEUpEpn5BWk78r7YL7Ro3gwb++7vmVm3KNMp
 HQ==
X-Received: by 2002:a05:6000:41cb:b0:488:8aa5:b4a1 with SMTP id
 ffacd0b85a97d-48b024b4a4emr1888525f8f.14.1790762164064; 
 Wed, 30 Sep 2026 02:56:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029e0e16sm2374770f8f.17.2026.09.30.02.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 02:56:03 -0700 (PDT)
Message-ID: <6abcdcb3.c9eda3e9.140f10.71c1@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260930085914.GA2623399@pevik>
Date: Wed, 30 Sep 2026 09:56:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi: Update syscalls numbers to v7.3-rc5
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Andrea,
> 
> > Hi Petr,
> 
> > > Hm, this removes s390 31 bit support, which was removed in v6.19-rc1
> > > 8e0b986c59c67 ("s390: Remove compat support")
> 
> > > Quoting the commit message, it gives me confidence, that nobody will miss these
> > > syscall numbers. But I should note that into the commit message.
> 
> > did you use the script to update syscalls numbers?
> 
> Yes, I did.
> 
> > If so, we need to update it then, because this is an issue

Please take a look at the patch I sent here. It's resolving the problem
with the syscalls numbers updates.

https://patchwork.kernel.org/project/ltp/list/?series=1176684

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
