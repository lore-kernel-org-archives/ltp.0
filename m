Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3909C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 06:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401103CFB61
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 08:32:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0A5C3CFB09
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 08:32:29 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=lpellecc@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0429D140517E
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 08:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713335547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=DFhLX/X76iKKUDWUU92Y9dKqSUEIwfIXkU5VxqbgnTY=;
 b=Fc9wb44F2ahPVm2DacAFz71dkGGwjlymRR6ZhIKQFSmJrXXTvaemY0Bs5LY7o1gIyx1xa6
 gHva4lRhVSBq3TrOQA4Tba7d4Mcl4akfOyy4Oo/dDhChlS9L2mVrNAlo0E90EgsT7vxEDj
 Ijz8UP59zRdixZhaO8knd4V9LkGuFvk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-D9RXu2gKNyaxZf0MmAvy-g-1; Wed, 17 Apr 2024 02:32:24 -0400
X-MC-Unique: D9RXu2gKNyaxZf0MmAvy-g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2dad964fadbso12680591fa.0
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 23:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713335543; x=1713940343;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFhLX/X76iKKUDWUU92Y9dKqSUEIwfIXkU5VxqbgnTY=;
 b=ddtxrPdKjgr8M7zk6NVJ2bvNiP7zjJDlyaP8sWOw2ffYWVIJmht4VM+wrgNCBAald4
 lnb0RYf9yJ53PeEUxPJtW04Xp5FdsXQh1OjzNxkevwKGgRvT6qn9S0aPl5roaPjPC8Wp
 DAj10b1hggoVdEU5k7/zEjdqFdHRpV3y+ghmO82d/bkbp/SFtrj356CiQufYlh5TOXxK
 DVtxdFY8CoVzikCbZOkPDA81RNG1A9iQoDQeKREqAoPqoFMDVzSAc5X1hC0z4hNjg6oP
 H5XJ9BzUlcScpgVl9+CzFZRmHdUc0ucrtcgXEJBlg4Ifx8GMLcma/xUe5Mj3RREOrOey
 WAPw==
X-Gm-Message-State: AOJu0YzXOM5nxRc4v8c6AODtq7APJBB4AofC0a+kZ7VDTx2xKE1a9BOF
 HXS/WWyTe9UZG1JUXz3p/PRikP+gvdvadh75qa2r1zCFywmk90hsaysKw7b4pnsjLpfGhDkaFPs
 4dS95exresExalYRaGJTM8JKJbc3FowZw4CvMkeDk6loy75F4+DVumYiPbnpOYYFVnUzWTL45wQ
 9VI65h8Y0IWXJTsOqqEMP5Ixk41DhpGaY7u2RW
X-Received: by 2002:a05:6512:98f:b0:516:cd83:a96a with SMTP id
 w15-20020a056512098f00b00516cd83a96amr8989397lft.37.1713335542828; 
 Tue, 16 Apr 2024 23:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtIm4N93njasJTpgW9ypO3UizpBleBK0YC7wQCt348Gp5uBPUUodXRPa5ZvXLHfzz9wF4I4/P804AT4fdJcAQ=
X-Received: by 2002:a05:6512:98f:b0:516:cd83:a96a with SMTP id
 w15-20020a056512098f00b00516cd83a96amr8989386lft.37.1713335542365; Tue, 16
 Apr 2024 23:32:22 -0700 (PDT)
MIME-Version: 1.0
From: Luigi Pellecchia <lpellecc@redhat.com>
Date: Tue, 16 Apr 2024 23:32:11 -0700
Message-ID: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Identify current test coverage and clarify contribution
 opportunities
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,
I'm Luigi Pellecchia, a Principal SW Quality Engineer at Red Hat.
I developed an Open Source Software Quality Management Tool, named "BASIL
The FuSa Spice" that can help the LTP keep track of the test case coverage
against man pages and to clarify contribution opportunities to new members.
I prepared an initial demo I shared on LinkedIn at
https://www.linkedin.com/posts/luigi-pellecchia_how-basil-can-help-linux-test-project-to-activity-7186248090129956864-d-vC?utm_source=share&utm_medium=member_desktop
This tool is under the hood of ELISA (Linux Foundation) github at
https://github.com/elisa-tech/BASIL

Any feedback will be greatly appreciated

Please let me know if you have any questions, or if you'd like to see a
live demo of the tool.

Regards

--
Luigi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
