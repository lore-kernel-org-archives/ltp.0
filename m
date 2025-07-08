Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67C7C8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751954426; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Houu2klne5N0iLa5ijgmlA+zI4HXzp7724yue3Zb/DU=;
 b=hRJfplVE+ku+0WL4AzJaLD6dguyomCq7EhierOqBkCXgYBbMOsjTw1qqqc4kWPZZVn+AA
 mp0lMOuFWZo6l5rl/Sj73TdY4NflveYQt4seMW7dCXDZT8xn2h4XAewKl4uB7/pMjhHvqNd
 zdFgfDBnIiZOx+poDRAD/NXhvLv/Ra0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED40F3CA33B
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 08:00:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D94773CA182
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 08:00:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22F52C420D7
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 08:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751954399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=qnHezoufGfhoWY87g+SQ2mh9fecbRak9a4cxqsfSZ44=;
 b=LnHYdgC0mBY1YiP5o18Mxdfwf7eLLc+l2iXZImXzXuZDyc8aB2JSt6xo6ESotW2HdFKby3
 W44NBif5DHhl5iHRTSawmJ+feBVZ8LWQ2ssn3xc5qxAdtjYuvWMb5rsyXf0yjaxkmAc7QK
 bvbWYaVUKNucqyzIA2hkb18fLameYsQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-W8JijhP-PjK2lB7J7h5lKg-1; Tue, 08 Jul 2025 01:59:57 -0400
X-MC-Unique: W8JijhP-PjK2lB7J7h5lKg-1
X-Mimecast-MFC-AGG-ID: W8JijhP-PjK2lB7J7h5lKg_1751954396
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b2fb347b3e6so4805401a12.1
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 22:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751954396; x=1752559196;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qnHezoufGfhoWY87g+SQ2mh9fecbRak9a4cxqsfSZ44=;
 b=tePrwCxowg9whSDTdTmXNn+nUtzIAtItFC6AUQdYkczpiz+P6lj0D3yKraNZv5InTt
 WITerwo93dBdhfKt2wEIvF/7UGq25UZrQlUj8vOrhtBFgoPP14eGuh6KWe5JZI9bfzm9
 SQQrS67AzsIV4awvyody3NhkvKhwj2EppGv9bKN9t3QxlG6XgTdL7mS5CYWNdGYM5ztX
 L/l7Ebip67s6W2BR+/yOY2+/jxtKaTywhnYhi3qDK26SqmLpwA5/nG5QngoCgthSG3V6
 R6vpc7ltvitXUJvwVlpsrULOrjsA1pmEd0Xy0Vjq4ZjrjAUQV/jAz3kB+aBK4uXtU+2U
 Iz8Q==
X-Gm-Message-State: AOJu0Yx2g08gVUEVqjeOzkhS/yoC82KZadipTbveQ2NT8VsaFVhG1JyH
 TN9I6XZVrremhwJ2NAk0L4ZfcIAa3Mos+80ajwYrqEthIC/QtYn7dXUW+DXHTbo+fq9IaB62d1c
 hxUc2K25KXZjS0eEJCeK7Fh5jBBXCCC8XQsjc6xUoHLEhPp6mWTUQCAWHWCW5SbqK+nlSZ6k/Ed
 lzo01eeg/7/wqYbFVvTClYlorKDvYAYtNT
X-Gm-Gg: ASbGncvvd/feKw16d+NlKfAGEYoDmerYk9GvIZ6i0Pa+lMwo6onAFMkRNVKCBc2YyUb
 T5wXZkVFX8Bcx72yaAIsfwQIdrBsPbriF/Wso2bVM1xozlqbxPHEUJIIpkskJfcaTvNQOgixwBn
 H/30++t9FBYtndmn74u8GFievvBVnr9GbDHIiAJBTJZv7NB0hVvIfxW55xZYhhdI/c4govAvxPt
 lbJzYUBy4U0GbwKHuH1itsga+FjI9mWwK/vzYXQkle6tKUzXw/eWWzNvM/CUUOSspaeQvQfgcew
 VWUa4yZXXF1mEG8U0wyqlDqvgWCe3OJJmI+ygOTs1GLtCBMcKQcdQGKPr9EtzyQ=
X-Received: by 2002:a05:6a20:9153:b0:1f5:717b:46dc with SMTP id
 adf61e73a8af0-22b43bca8f0mr2888215637.27.1751954395996; 
 Mon, 07 Jul 2025 22:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1WgjHrZAvLQ8LCHK5/2ji1wbse7wSNo75Jcmpq7bikCaYeK2W01UB0pnSvW9yqn8C2kbXMw==
X-Received: by 2002:a05:6a20:9153:b0:1f5:717b:46dc with SMTP id
 adf61e73a8af0-22b43bca8f0mr2888163637.27.1751954395154; 
 Mon, 07 Jul 2025 22:59:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b38ee5f5d8csm10518675a12.39.2025.07.07.22.59.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 22:59:54 -0700 (PDT)
Date: Tue, 8 Jul 2025 13:59:50 +0800
To: ltp@lists.linux.it
Message-ID: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tO9o5J0XILUvYWlnzQ2G3QmOh5H9mA51f4cKr5hbBZk_1751954396
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

When I run ltp's fs_readonly command file with kirk, I always hit:

  /var/lib/ltp/testcases/bin/test_robind.sh: illegal option -- W
	usage: /var/lib/ltp/testcases/bin/test_robind.sh -c command [ext3,ext2,jfs,xfs,reiserfs,ramfs]

	This script verifies ReadOnly-filesystem, by mounting block device and
	executing the filesystem tests.

	OPTIONS
		-h    display this message and exit
		-c    command to be executed

Looks like kirk can't treat "..." as an entirety and give it to test_robind.sh.
Although it can be fixed by:

  -test_robind01 test_robind.sh -c "growfiles -W gf01 -b -e 1 -u -i 0 -L 5 -w -C 1 -l -I r -T 10 glseek20 glseek20.2"
  +test_robind01 test_robind.sh -c \"growfiles -W gf01 -b -e 1 -u -i 0 -L 5 -w -C 1 -l -I r -T 10 glseek20 glseek20.2\"

but old runltp fails with that. So I'm trying to ask is there a
better way fix this issue on kirk side.

Thanks,
Zorro


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
