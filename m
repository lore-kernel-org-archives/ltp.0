Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B9EC369D7
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745325378; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xm5hKgucUuBcXDHeoQaBoNOTlxv8Nsjp+dqD47atbZE=;
 b=DWsBSsMxsBJFpB55FivtcIcmiRhmBiWvWa67ErcqMTGcdff3PsNKpkNoHmp9tRaI+/osD
 S1IOycw0U5Q7sqU+Vl1+Afczkr5HRXpxz61snGDLS++Xa+xr0aFCFrrlNURJq6wL8pbjMP2
 VOu9JQ73nL40ePekEkj2C1jTisnsilI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D9A3C2991
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD78F3C0229
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:35:56 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2B16600942
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:35:55 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so717230966b.0
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745325355; x=1745930155; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZqPvxfwc3yO2G+vd1cUd0mExfXQAU2ZogYilhhI7XM=;
 b=cE2YZLZbq4k2TqDiyC0cHK0AKHMD2/VpQNd/PQxrzmeUsO1fXSUp+ci4DYZ44/+RKa
 Vw2g31kzG/0c52F9oPuhiz9F0PQmoXrV2oLtOXjEOg40mUB34NqEx7NeebcmHx+XrQyy
 aFOGzxz8aOQhu0KUaUxJa7I34N9f2ysVeU4+4aBcnydemvmWt4efsZgvEtuwhr9i20un
 oQokFgA7Sl9d6I1UNVwA1XnZ42J5c4BFiGJQCW5gDcXLaSOdyAVTifALy45GZBO3k32H
 MQvCIwicvbdD77CRNuXl6C4ylkFq3ZnegwgpdWL6P4nYFgZR74YFtSDLszvu4kT2UHjC
 KK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745325355; x=1745930155;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lZqPvxfwc3yO2G+vd1cUd0mExfXQAU2ZogYilhhI7XM=;
 b=KmZcEop+uwKMckErkjdDgkFtDhVSoybpAqFYxjbMkltyzhgs3gv0uGubnwv2qUKdli
 v1DhKWNugMD50teBTIXr8JxSQticY0VN5zflRou+HGFtimpED/lZnR0+lH0XDETQu4MW
 xqOHlL2qZ+IxnKeYb3WuGErvQ3flXFDISaNoEeH2hIn9tkc+Ygshzs/Kuu0mLZreWC8U
 NL4BsH6w8xFWWgagjtK6HdpdfRW9O/AsSIpVZ2DREYHmcDRyBMgqNBa7Um6A7NUrBFhb
 EOYxyU7j3XdS4tU+XgWyNbs5UEt41j9nuzTlHeHFV7f1U9VcJlYN0BtvNLG92nnGMC+s
 Iu8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSSqRsrhFPGC54BHDzPZLoiA/KY9PYoCA1UeS2fp74gj7BXu0s2R57QX4mjM3+kIEpGtw=@lists.linux.it
X-Gm-Message-State: AOJu0YynKzKJ1pXdDg/eUV+CYXf+0m6gn4vCOvwJGyq+uaRAGOAQxZDj
 hnxuHZQE7YUPPVIjn85d+zx+eCYQltIHMf/yXAl054Ym0SL/+6Esp11fO1DLtWqrRZbTcqsRd5j
 V
X-Gm-Gg: ASbGncvH19c5gI+4b6zsYe5Bf05vcAoyyTtDEDT+kNNvrE3TnEE4sO1umiQcyMOscph
 X2kDxQeOpzQA2NpJmnk0dOBX5XSI/YkysJmNqYPjDyA0t+IwGELvKSKW3/5+iRcVGxOVWl8flSt
 d2K8UVSfRmSG+vi0iUk8N4A2G5hOXzUpYjsOY5kYYUPVGN3LfSz+xIQtQ/hfDPlt0sn61hJjwOw
 bh4cO81kHkRB5ulUGwYAoNdespzYhIZGEZQRTQ5Mw/znYsuE//reY3XZCk+Z4pirV1cvaKj/jMV
 9Io5VkmmCBay0i8CvzD4iZqjjVSOP1p1Biv9zu+p
X-Google-Smtp-Source: AGHT+IHh4yS2xDVMpa+Ui0Tuyi+NYp6bH9e/dEAk8r3MS2bo45QCmFFItf2bEFJdquK2RMi0bDJm4Q==
X-Received: by 2002:a17:907:1c90:b0:aca:96a7:d373 with SMTP id
 a640c23a62f3a-acb74ddd2f4mr1209082166b.57.1745325355056; 
 Tue, 22 Apr 2025 05:35:55 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73dbfaab93asm8680817b3a.131.2025.04.22.05.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 05:35:54 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 22 Apr 2025 09:35:52 -0300
Message-Id: <D9D679V6YID4.1V0K965QC9EYJ@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
In-Reply-To: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open LTP meeting 24th of April
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
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Apr 22, 2025 at 9:17 AM -03, Andrea Cervesato via ltp wrote:
> Hello everyone,
>
> this is a friendly reminder for the LTP mailing list about the next LTP
> meeting.
> As previously discussed.
>
> Next meeting it's supposed to be on the 24th of April 09:00 UTC.
> Platform: https://meet.google.com/jon-gytf-uei
>
> But we should start to take into account an another starting hour, so
> Ricardo Marliere can join as well (he lives in Brazil). If it's ok for
> you, we can move it to 10:00 UTC.
>

10:00 UTC would be perfect for me, thanks!

> Thank you,
> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
