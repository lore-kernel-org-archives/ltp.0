Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A6DD29FFA
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768464561; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ifvQTC4dKZRHp3iLylC6bkFuu4icKVntfx5GoNiuUpw=;
 b=mMJbUfrmTe8MRIZGbPuYKcFlpZLWY1cfxV13iaXCNtjSh30c6NS2DgZOcI4Hunt/NaA3L
 EUtwvEkya6I0ONBsLIkny8hYIiiZWid/ZkOOME5Um4EwzrMiUM17JbDk8KKAXm5kmaNV6Oa
 pRkBHnqnt13/W65MY3Pfqz0FYspcRls=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58C583C9B9E
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 09:09:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8DB33C2C23
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 09:08:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2BE8F1A0098D
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 09:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768464532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WIWvgrpHIupsXzbKLJJyp6TASlL9MN1+9XvBQf65dE=;
 b=E2Duzc6TYorvQVDqSeuZBE4G0QKd1GJCMdvVuk6EKjxshDcZrBPQdTjvqSoAkNIlVh6lae
 iFefjlUiwrJ+MDeNO8A3p1AS1aV42P7ZJ1FT+4mBdtH7DZguSgRuFWi4QwrScSNDM4PHno
 xxsVjGMnuuu5qGu9xsP6buVXKRaaP3I=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-thzs6O98NsiqnvQ5NZBjLQ-1; Thu, 15 Jan 2026 03:08:51 -0500
X-MC-Unique: thzs6O98NsiqnvQ5NZBjLQ-1
X-Mimecast-MFC-AGG-ID: thzs6O98NsiqnvQ5NZBjLQ_1768464530
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b21d136010so1119073eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 00:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768464529; x=1769069329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WIWvgrpHIupsXzbKLJJyp6TASlL9MN1+9XvBQf65dE=;
 b=w2TX3QqeLkFPDM+ObcYGhEaCHms9rPJF/9zk8UzFsp8dFVgMSYvdj5ZWmvRbA1zLfD
 dD0hfQ5tWVRJjA8LKLsV5JNhepY2WIXXU+lTsmH5buKjVcosYwPVL4iuzuU5loaEUFq+
 sBRad5OdefhI+MW/+WXR8OzYwG7IB0t2HMnic3RxVNPCsI8NGI3RVR6aYfZe6UQU/5kb
 nWKHSnSdqkjQ8yfVNgytcBaPV/gI1Gtcq9QBMuvRkh9mP6xZ/yXi4LGhegrMPl2gFJby
 ANyYFUpHDkJUiG0CHVW8d2X4n1yCCKHXa+SIc83dDa+1kx4VQ1jjQdmckUDVzVmQNe6x
 cz1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVryp9fj5Hk1XLdc1t+GUT8KwGbbt8TeJXLqTRQ9jdF17gCi9vtzVaiONYrCyHn4SciUU=@lists.linux.it
X-Gm-Message-State: AOJu0YxD5V9eArSJJlG6xb1H/15C1JWNsMPx8h2cwFOYlL3fR6QXCQ6u
 PuXzzGOEuXCHy9fQxJFbkeusw6Utu+bA9ezp/UX5yfMEmLspADcS+vu/45z7wnnDjLxEpr1AvGD
 LnZjPFBACR3IqBRuLWxQdMry0uyUd1b8xvZM0N2rHoVV9YO8oVSGjTgGeis0p7g0H3CrLWnYXmB
 h9jnqdfnxxowtQKwc3wVn9crzrumboCVGSRt1utw==
X-Gm-Gg: AY/fxX6K1TF7Lbg4pvlbzViKl8KmdSDQQq4xIpN/uA7TBGSK0HIICzDvuf2gSPY6w99
 XtEHXRxTrTSEI9a2/g4icpCaL48chiokDFLjYwPvx5/kq/FBC4KDKbmo8S4iOu2KgP6zjTnmrX4
 WkhAZMAi0z4hutIuDseI8wGmO0B3T4EuhhJxMEts/8SYmu1tW4OyqlvJaDOiX5FgeCFUo=
X-Received: by 2002:a05:7300:23c7:b0:2b1:7486:3a06 with SMTP id
 5a478bee46e88-2b486cb5dd8mr6551542eec.18.1768464529507; 
 Thu, 15 Jan 2026 00:08:49 -0800 (PST)
X-Received: by 2002:a05:7300:23c7:b0:2b1:7486:3a06 with SMTP id
 5a478bee46e88-2b486cb5dd8mr6551518eec.18.1768464529039; Thu, 15 Jan 2026
 00:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
In-Reply-To: <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
Date: Thu, 15 Jan 2026 16:08:35 +0800
X-Gm-Features: AZwV_QgAvOmr2wGDF-NwTlE29jeObY2H8H3f3T3HOzVUFl3PJ2kwsTQzHVh0qK4
Message-ID: <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tNpRPMIDhexgMRrSWNDP2B8LZtoH2IjqrXK9NAMCpZU_1768464530
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

A quick question on '--framework' changes in v3.2, since before we
use Kirk with set 'ltp:root' to find the correct LTP installation path.
  `kirk --framework ltp:root=${LTPDIR} --run-suite $RUNTEST -v
--json-report $OUTPUTDIR/$RUNTEST.json`

Aafter removing that --framework, I get an error when trying to use
--env for the installation path.
  `kirk  --evn LTPROOT=${LTPDIR} --run-suite $RUNTEST -v --json-report
$OUTPUTDIR/$RUNTEST.json`

===== Log =====
# ./kirk --env LTPROOT=/root/ltp-install/  --run-suite sched -v
--json-report sched.json
Host information

Hostname:   dell-per430-09.gsslab.pek2.redhat.com
Python:     3.12.12 (main, Jan  6 2026, 00:00:00) [GCC 14.3.1 20250617
(Red Hat 14.3.1-2)]
Directory:  /tmp/kirk.root/tmp1a062qkt

Connecting to SUT: default
Error: LTP folder doesn't exist: /opt/ltp

Disconnecting from SUT: default
Session stopped

==============

But once I put the LTPROOT=${LTPDIR} env separately, it works well:
  `LTPROOT=/root/ltp-install/  ./kirk  --run-suite sched -v
--json-report sched.json`

Did I miss something here, or is it a Kirk issue that should be fixed?


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
