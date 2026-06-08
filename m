Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63918CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 12:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780920372; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=d4yhIu3GGAJ3yXl0CaJ35t8YuzrOGWCO11qsUhrFZgw=;
 b=CZnAk6PI9folPi0McaggZYbDFFM8HLfn0Q5w9XDoyY4ufydCsJIvP2M4Mgigio8FBICkH
 ll51KB6Dp4E98qsBO72x1OZIz/yct8xJDmYLgwhvuDuRnlaben2CBfa2PgT+YK21znFbNFU
 W+jeyujEOstAqSBN4PMx45LBoumr8u4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4C113E5F89
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:06:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56963E2FBD
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:40:25 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17293140112E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:40:25 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso1931989f8f.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780918824; x=1781523624; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
 b=fBeV3v293JvejOw0ZeqkcMCjmWWVsibhlGZJh84tCBXXLGo8UMqd8Lxy3OTwhtFya0
 rpzxk4Qw9JmCngAKpeptchl04OKFiQ4heD8reJSnr/P8MGOqN0vXopqej0yDbhV/3B57
 lU0m9Fj7cz7eovX3IFKPOjk8S6jvytPBi1+OF3DvRSrbheasosv5ieAZcJnUxh7wAi/C
 rX6sgqWBFz3Y4dFf8vpBy958rJDWGgc4GGBoAV40e285ofCA97SMEreV4nUo0D384Ek7
 /WMaBc6ye0+NXdR4VUr+bGQAhZvDFdpSFL3mhWqpqtCyFIuPzlz6fQM69DW8vxU7YkSw
 jyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780918824; x=1781523624;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
 b=lYyF96Q2MuIh/PB+tskpSf+VtEgE8CE4sLUoOD9k40rURxnu/lBdknqyyLc+cKiptO
 lEl0LHyGMnxDAuuF2HbRGF5MnehAp7n3ceV16PtdvX+b61Gqlq7ImtandUAt1oVH2ljo
 quVka5vc1yQiCuCJ/NQ+O/cey2ku9MachXwqG+ejMRjeRGVo9akbYwwiTf8k2hvp54iL
 57sI9iUt1YxrpsUUMl68Lkt9GwiGj39//2oQzhTtdm9rNmNgOXRXTnXrc+1jkZzSf2+O
 6B6qq85ps1amBgdEm3oopcSEaahAx5f74A4BKZFG4OwHdZtANZ/CU9ia2gQL0Ky+Efup
 Dclg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qyXGHfKu9Ts9ddwg4qG5Z9xcque0/TYxHTQ8GyksZCAQaPFI3uq7Gbim+C+sIgDwsBIs=@lists.linux.it
X-Gm-Message-State: AOJu0YwqfDZAGKWD2FQvSDgiLNhToeWDF4A/+jRTDBf9GxoPorkcHZsg
 xqgd0bXLtTWLcKTLM/yq7AUyVYv4jTkshgsyuFGuEmEGJF180WOYEXaGjp9ayFWpMrc=
X-Gm-Gg: Acq92OHTtCnvhalxGCTmt99g0kS0Jykv/2efVxRRxdMrkI5uPko+hfU7pJwg2GvKryZ
 erEL0mXgBrhhLBF9niQ6Io8nSm4dBXzIj0jLvimaEPCkoapHgpufoDU6YilkLvksP6qx4wteez/
 CJLJXdc8yriaR5Wa+6VZTI3kytq4uusFyN4aEQP4flfrMZEKOlLMAcJe5QDIFkezxocs5S1ih28
 3XwCnRiMWCw/zcc+vnD1e3aLdmbmp4SRMVkBTZD8uqgJFB11Dj1E+QMqKaS5uXItOnBxvItaBJj
 aoP9dre/btO9pPF/1VA1e0FkwHSf0Pxir5x3+MEpwnYy4U3LZE8v9rYgZDlleVR/Bhkl/c0vkCR
 cxH3oFtAhyUsZ2N1/mJqDK+y2mfiZzkpkuvTUJoWBpbxnQHjV1QvM3laVJEhf9/0aJ4RuGgdqpZ
 QDqRbm03ZlC7jvJzpE5Bj1nPbJo0i/L5SwpsH8fnxLNMsjEfpIw+BJhPKC0IJvML1GdYjk6MJ6k
 Pwoica9e4Mei3tPcDmxRFKr/bYeXYwrXCAwEeshnO6eqA==
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id
 ffacd0b85a97d-4603063c591mr15377117f8f.34.1780918824402; 
 Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm40821903f8f.14.2026.06.08.04.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Message-ID: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
To: "Askar Safin" <safinaskar@gmail.com>
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
Date: Mon, 08 Jun 2026 11:40:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 14:05:53 +0200
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous
 vmsplice patchset
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
Cc: Jan Kara <jack@suse.cz>, The 8472 <kernel@infinite-source.de>,
 linux-kernel@vger.kernel.org, David
 Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Collin Funk <collin.funk1@gmail.com>, Joanne
 Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, David
 Laight <david.laight.linux@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Pedro Falcato <pfalcato@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, David
 Hildenbrand <david@kernel.org>, ltp@lists.linux.it, Jens
 Axboe <axboe@kernel.dk>, fuse-devel@lists.linux.dev,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 patches@lists.linux.dev, Andy
 Lutomirski <luto@amacapital.net>, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, Andrew
 Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Askar,

the patch-set doesn't apply:

error: fs/read_write.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Applying: vmsplice: open-code do_writev and do_readv
Patch failed at 0001 vmsplice: open-code do_writev and do_readv

https://github.com/linux-test-project/ltp-agent/actions/runs/27129052434/job/80065058557#step:8:21

Please update it to a new version after rebasing with the upstream master
branch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
