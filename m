Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2EEB64DC
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 01:57:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859FD3CDDCE
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 03:57:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB23B3C99AE
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 03:57:24 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C614E600087
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 03:57:23 +0200 (CEST)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so29278335ad.0
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689645442; x=1692237442;
 h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zpwYvBryKekjodYDIsqD2F2J1FH8FhSMhj0KMFUDpts=;
 b=PyC5itYPYjFB8EUfq/sZ8PT9+t0hU4PHacCGlqauyl/VWXiFOMEgNtExFuGt/s04SQ
 uW9fBR15QWzE5Ib5xcf9D7Pej7xuslfpVWT10KmmNwtnK9f7LbXoXSfBLLs5NnHwYUo+
 8ub7C0ZkfkGF2SU2lyke1UwOxbAGU7PM9vj3TQYrjzB0POW4LPSNh5eFKTFsxFCSi5yH
 bL+PKTQsNUK3f38N+oBc7gNZU3fx0moALggKAqvEu0R5z7v5scuvBW8XBK6vmqvU0ygd
 14erZcpwJ4k23QQbN3QED1AYGKsARnFGQ+HQxDs46nOz7weQKipxurhI7+R7FvgsTrWz
 OGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689645442; x=1692237442;
 h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zpwYvBryKekjodYDIsqD2F2J1FH8FhSMhj0KMFUDpts=;
 b=h+dcw/GbhLaT3I/GtqT2dYLYc+tZDcP4Q49X/z30b96aWQgmrPZ9sQf1sllkMWhb5k
 Gff9zEkFIz8G5wp00AamOnuyM9uWDD8I2BKuIJ/3injh3uMBtS1uOQKu27xkTnI9xfUO
 VcY26aoYYH1nqstA3yMtl6CxZ/jG8M/wcjl8wl7/fK05w5FUGYZh8g1aVp1nPBTHsROq
 BpbL++BCcmPokJQji+2DeB7IE7RQP3q+HHIJ5qYIJQSQUOuvB4gcxtZNz7Jv8Tf6pNZg
 0URSDzoigiRHkBu2Nc0BMXH+9Ubw3R3YDqMpckkZ8CYxctAqV8OwSkI7dDJ3giJPUeiY
 IwiQ==
X-Gm-Message-State: ABy/qLadFTuMwTd2kqsRcTLuxt4JNW+RgDJNfbJmqkXWZ1TPQHBVzNzO
 St65d98is3LMr0dmYzOy76A=
X-Google-Smtp-Source: APBJJlFgGWmuKWn5GFBhQDlQxlq4jLT9kF22MJBnNKr2ToSHiTCslUYnwdKsvmsmZBsYB3+p4ihjLA==
X-Received: by 2002:a17:903:244c:b0:1ba:ff36:e0d8 with SMTP id
 l12-20020a170903244c00b001baff36e0d8mr13122916pls.61.1689645442038; 
 Mon, 17 Jul 2023 18:57:22 -0700 (PDT)
Received: from dw-tp ([49.207.232.207]) by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001b882880550sm487420plb.282.2023.07.17.18.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 18:57:21 -0700 (PDT)
Date: Tue, 18 Jul 2023 07:27:16 +0530
Message-Id: <87h6q2nfr7.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <20230717213424.GB3842864@mit.edu>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
>> 
>> These can basically trigger in extremely low memory space and only when
>> such ranges exist in the PA rbtree. Hence, I guess it is a little hard
>> to tigger race.
>
> Ritesh, thanks for looking into this!
>
> Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> one on the ext4 dev branch, and one on linux-next 20230717, and I
> wasn't able to trigger the BUG.
>
> If you can trivially trigger it using LTP (perhaps with a low memory
> configuration in your test setup?), that would be useful to know.

Hi Ted,

Sorry for wrong choice of words. By low memory space I meant low disk
space i.e. ENOSPC test (fs_fill). I reproduced it like this - 

root@ubuntu:/opt/ltp# while [ 1 ]; do ./runltp -s fs_fill; sleep 1; done

For me it took around ~1-2 hours for it to reproduce when I tried again.
I am hoping if we run generic/269 (fsstress ENOSPC) in a while loop like
this maybe it can hit this bug. But I didn't give it a shot.

-ritesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
