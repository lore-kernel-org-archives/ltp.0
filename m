Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FF7C6FA99
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:06:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50DE23CB7B3
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 08:06:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2513CB05E
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:05:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABDEB200DC0
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678431944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nne9fA3rIMZAzAG0/J1nmTTyqvKjIKccm5z+mh3IgMo=;
 b=Z8X3zH2Fwyt+K24xLPRTCruDf8+9DgUlBUGg7sa9lETce/SZtp8qAAEUHIUNL8ZmtpqnyG
 hen8zTeDIBcnxwfLHtpsxyjuRwsKP6nsHmSCKumTCjvYASqabw7UKZcrNiW+nhP7XM36RH
 dBWlvdtG82lEEVF9CE92JTc/GaQucb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-HFAvvojiNWiyoj0xi-fWhg-1; Fri, 10 Mar 2023 02:05:42 -0500
X-MC-Unique: HFAvvojiNWiyoj0xi-fWhg-1
Received: by mail-wm1-f72.google.com with SMTP id
 4-20020a05600c024400b003eb2e295c05so1450003wmj.0
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 23:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678431940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nne9fA3rIMZAzAG0/J1nmTTyqvKjIKccm5z+mh3IgMo=;
 b=avsQrvGE4RzNq7DavaQCyBCvYBl111CU/eGKFlvvySpndXaVNQu1vIJFOuyjgLNl/H
 fFak+RKAsSaxfuKMz7zePqPdM0nPDfrIAQBDl2PWb/YE2AWW/liVqBLRGxgzNYlsv52X
 T6cBT8YiVK+gej9xVHYB5ERzDlZizLL4XAw0/w7BBXzjVPVBH9T3anNo0iONem9KCM80
 ah4yq8yT+7R6K5PrEfdS/IOAGvPjZBtvNhbHA6of2NdJ/HstDs3UOKnB1Rbmg9gEh804
 C7vXQ2rM2QoqV4gSHqBvcDg+5Z8iDFOAxC+0M9hoeTdn1j33Wx1k4WDm/Rq/yhWb0iIb
 R3KQ==
X-Gm-Message-State: AO0yUKW2urHO23sTGn7m8Jh+ZiwWwgFhGEgLklyR1en6j7TnHl8ZmL9e
 KBY9AmDeCZ9HwTZHUHnnO9MuYBBZPn9RxNW/IRb/dzUjp94r5LCvYXXDpJs0kYAejcaGGnWAaA6
 vBLgnpp0zIYH864W+m4sONlKmD1k8xX2FzPymmcIc
X-Received: by 2002:a1c:7910:0:b0:3eb:4cbe:1e87 with SMTP id
 l16-20020a1c7910000000b003eb4cbe1e87mr262818wme.3.1678431940607; 
 Thu, 09 Mar 2023 23:05:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/5bfFCEBlwMggw0LKZg0iERjGgeGDLfVDk6s0X2gl05HCP5aylXyJb/bfzXd/MHOTFlqDRFuScwAm2G2Rdioo=
X-Received: by 2002:a1c:7910:0:b0:3eb:4cbe:1e87 with SMTP id
 l16-20020a1c7910000000b003eb4cbe1e87mr262815wme.3.1678431940328; Thu, 09 Mar
 2023 23:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1678427695-12871-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1678427695-12871-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Mar 2023 15:05:28 +0800
Message-ID: <CAEemH2f5ZCXLB+0W1bgHK+yMkOAZKFJvr9qWYyDqgiutJroBrw@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] memcg_lib.sh: Add fallback for RHEL8
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

Accepted.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
