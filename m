Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D532CA0FFE
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756809635; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xtj4+tkGsyu6Nbh/EgPDndGPbNNEWLSOfhol7IpzNOM=;
 b=EnFNSPhLhjCvtvS8f0bTS9DSu2fBXtfEHZnTxDjU0Lm/jrTgaCVkmbrH7WYDNBmT9Jy0z
 ELzlO2SAaM8S8AlH/ej0gZ4zO5p2flEJK1vl27zFN6RjZWU9V2HA3gopHRfq2U16SaxRpJP
 QFWvwIHPJdr4g2b7OUGe4EI9uD+R+Eg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E02C3CD1C8
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 12:40:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC3A3CD1C8
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:40:14 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 65F261400071
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:40:13 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3546183f8f.3
 for <ltp@lists.linux.it>; Tue, 02 Sep 2025 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756809613; x=1757414413; darn=lists.linux.it;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AcYhW6PwS8qz4nl9MjIxEHQqD/noLgZZ3zfHfEizSs=;
 b=bHwNK+qk4NWd7mjXCeXCJg6FYeX4Ei/bXUZ6MtBY0rWPn6iIZoxXYaVhHxH+gkV/tZ
 gH1K8oyjdO5yG+mLoGcD8tZStF/5DOdweCRbEbryIN3Bc6/kf8IeLdxwJDng+7fLNV2/
 vomXsPG/ueeDdYus8Bmyc8B6iRk2xi14S0M9z0BejZEgWqTn9UnlgCji5jaTRZc/dfPD
 J9uODKhYYc6LfX+MMoBfNx/6Egz2FvAOwNkUlL4B1DEHD8s9KqMD0G4AhV+HNW7UwSkb
 CAHmA7T8M/ueAHoeqsdEkxJPqtB1RKhX85FnZnRDjvtMcO7CU+QVRMlDAZ0ShJVwaKo8
 /rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809613; x=1757414413;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0AcYhW6PwS8qz4nl9MjIxEHQqD/noLgZZ3zfHfEizSs=;
 b=t7dvR3/A21W6/kCtWWh/eJ7Q1bIEaJeM787aoIeMMUIsXcDUyqPc3p+QPAzpHY/xM8
 uipP/IbE1DaD8onLun97APt3qQrEYViZiyv9liAIQeG+VQcmDkUSWEcxyVTiD1aFKWqM
 If+bjG48+4zWkzvoKFTxEcZsyNRGQd0ZIXU3je/KviE95S3ELm6fS1Q6DaJ7qpYUtQMj
 yOOeoHm+fGamZqxonUzLl1npf6crQ7xa8NlqRB028pAoeJyQkip4OjQIUTn3YYmazttq
 3tbVCCedTpJlpfHilFUd6PoMMpjD+eWW9e+FGYW/GwWFMK4BlZ5PChDpDnlK6Uin3OBJ
 gmGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz9kG9AivPj2nFdaHBoqRZDpDEBZCJq1Eq7G8h4vZcdF35iId7nVaxMTpapmIj387aDik=@lists.linux.it
X-Gm-Message-State: AOJu0YysuMYCGjZzj/6rruFfVJL9nuqyRhIjkICDItCctwUwSG4mAY2C
 tL838uEy5628mQIBdtxWKoaqMMXQgQ00zPvE2hm4kQG47hZ4fWkCL3cgS/cH9Tk1g28=
X-Gm-Gg: ASbGncur+8vi3XPI2wkmgshFQD3wrbYMV4ahfqPceFNYS1pMiOVIQyy+lVBMN/5zpqi
 dD5ZoOg9fWOxKqdB43XVrKRwQDzNnzZ+8Nj9oJowhoExSWrfwPVG2pZ0rmN6A+a2G0XAvgcJDo4
 oV0TP676y93Xb18pxhX4hnnfB266JlcMDaFDvN94k7FNAt37ikaoJUxfjsUIBqCav1VDIgmim2e
 ipTfoL6adp1VICkxoZoXe0jqB5rh5gRsCC/cwwjyTZKAAMIh+Xobbm8M+h/B6D2cDsC5EpaCV+5
 irVUrtdn63od0ehmeR56nItZSOIGQe0tJ/UhsvnSYXo0Gd5iUb/AIA9ao5Ok3PvUFnUzFDJ2EDG
 4mYaP0FlCRw==
X-Google-Smtp-Source: AGHT+IF/myRsOS+eLNKETDu0Bi210UqEXfRtdqZluul5YVruWX7HiGIvOCDrppc8ez+2aLHHwXGmvg==
X-Received: by 2002:a05:6000:250f:b0:3b7:9c79:32bb with SMTP id
 ffacd0b85a97d-3d1e01d54b6mr10385379f8f.44.1756809612792; 
 Tue, 02 Sep 2025 03:40:12 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-723a82d58c3sm4222097b3.7.2025.09.02.03.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:40:12 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 02 Sep 2025 07:40:06 -0300
Message-Id: <DCI913J2P8P6.2PAJP94GAZKSY@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Cyril Hrubis"
 <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <69ec2719-0603-4cf2-8774-9f3ceb70a3ca@suse.com>
In-Reply-To: <69ec2719-0603-4cf2-8774-9f3ceb70a3ca@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Sep 2, 2025 at 7:23 AM -03, Andrea Cervesato wrote:
> Hi!
>
> On 9/1/25 12:20 PM, Cyril Hrubis wrote:
>> Hi!
>> It's about the time we start to prepare for the September release. As
>> usuall I will go over the patches in the patchwork in the next week or
>> two. If there is something that you think should be part of the release,
>> please point it out so that I can have a look ASAP.
>>
> Thanks. It would be nice to merge these patches before release:
>
> - doc testing in CI: 
> https://patchwork.ozlabs.org/project/ltp/list/?series=454189
> - open_tree_attr() coverage: 
> https://patchwork.ozlabs.org/project/ltp/list/?series=471820
>
> Also @Ricardo has many patches sent which are waiting to be merged and 
> some of them are interesting.

There seems to be a glitch in patchwork... This submitter is not me:

https://patchwork.ozlabs.org/project/ltp/list/?submitter=77627

I only have pending lchown conversion and pthread_rwlock_rdlock fix:

https://patchwork.ozlabs.org/project/ltp/list/?series=471445
https://patchwork.ozlabs.org/project/ltp/list/?series=457701

Thanks !

>
> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
