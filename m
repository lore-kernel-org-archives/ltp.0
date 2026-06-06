Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3FCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28393E4E80
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:13:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 685DA3C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:02 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 109741400E15
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:02 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so2342344f8f.0
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726261; x=1781331061; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8r8X8oylGshLaIHIAK1kgCpu4mjI5I9eQ7pptBpGukw=;
 b=VZeQ+JQ9i1IHXpOQBPpFORbqXanwlW+95j6tsiN62HNCqWtX/cJNUprZbe1FpGsS2G
 RaFYES+HNrZq7HhISKPVh4LE/zeMNk5HfNN15Ngr14y07dnN6MKYKeMExL3oFnq/nDqG
 53SbiWs//N7/V8tW9gT+vI9zC5sUEKFs6BrLGGMnj9Pa7WETklNOnfMVszolafGMihrQ
 1vJN+FkbhfzucofaIJBBh+dUeHKZBx4dNnYrg6NNvNgJOA62Z6JS2WWegpoZilAaEB/L
 e8vfRBlf6+w1sntjEwlS+laq41Obio0XWjIeDx5pKTLhkHLhEHyqJ1KugyQReJe9Yd1g
 Ru1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726261; x=1781331061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8r8X8oylGshLaIHIAK1kgCpu4mjI5I9eQ7pptBpGukw=;
 b=ljPOgqmZrXE71JbI/bbzpwVf/9Zh8547ZDhEn5gvtWZ0Og7Yd/uzMWLBk8wovoI9bU
 1I7OqNfIeskBJiHUhXzw02+bgeoP7dQOaFF9jN5lyVbECAkg+Rj03p3pRzmcewtS7a3p
 y4Tfb0Jm8EMI/EHrvbEKToOM/n6+F+X++LTO5sFOEMkmRCqNSw6xmRDrjIrg7uj+1FFF
 KIFhP/IzoKIiZpdU5EZxxiRnkqqLjd3By+KfM416e6ePZOjzYQabndXhaIfgiR3ArOm0
 wmas07WfLUVYPjL3xUABCLX208xLi4jCjkrfZqMoBcWJujgc7yAkPfSWp612ynV809LU
 MWgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8h00kycPPouuiZkfqd1tCGZy3fH7cANGdCz9dK3YtvYiHSKRFTNzp7WQKYptmcSsM61Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yzw4uHrjrOTMU6B92tf5xwbig2LNCmy5BUo7G7BpSZSgT4/l0Z3
 KfcSoPKaXU16zIaXFjkteO190fwJc9uws5mpBAaM+4GChFFOdEhNXV0j
X-Gm-Gg: Acq92OGQNLKx0jAn925ej9n75v7GPKv4WleoGPHf7CaYZ/d0DH2g/Wb5xlWRWtyzfHf
 uOVpdBoaWrzxinB6gcE00GCb3nXPzxkEBbkuKKrE/ues4WH1/K471+HJmFx3JLVUcwdWg/x+lTB
 YAbc7GZYI4jAOo9DXYmxJfVMyFVBtQKrXatAMe8k/xH0C1QEqY92ZbaZG0K2Oxi03mJ6ZwmzAkh
 gSv6aPhNi+FSDkEn48Vt17moMr5IRoSBv/+rjUd7WLXBHx7wJEScbPabV/IzA13bbKtoWfhJeml
 5JjYtAwE0IFtZF4XlbmK0l/L0upyaybda5vfqIRWnKplCFt2AanU71q42PFt/sydQQG2tDghxDG
 /j0T5sFJY1glhSLdwTgqDhFZ+SSb+bo5EknnXG/OFREnhR8hT8errFSF1+B8JxnhRpbnohDA12v
 RevNeZE+CweKVC2I/H5JS6hZE3Kfaefg==
X-Received: by 2002:a05:6000:41c4:b0:45e:f5b5:885 with SMTP id
 ffacd0b85a97d-46032b610d1mr8361361f8f.2.1780726261254; 
 Fri, 05 Jun 2026 23:11:01 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f360bd6sm34254711f8f.36.2026.06.05.23.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:11:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:26 +0000
Message-ID: <20260606061031.3744880-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous
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
Cc: The 8472 <kernel@infinite-source.de>, patches@lists.linux.dev,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Collin Funk <collin.funk1@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 David Laight <david.laight.linux@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, fuse-devel@lists.linux.dev,
 David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 ltp@lists.linux.it, Jens Axboe <axboe@kernel.dk>,
 Stefan Metzmacher <metze@samba.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patchset is for VFS. Of course, it depends on my previous vmsplice
patchset.

I fix some problems in my previous patchset.

1. Fix problem with CLASS(fd, f)(fd). See first patch for details.
This is probably not so important, but I fix it anyway.

2. Change "unsigned long" back to "int". See second patch for details.
Again, this is probably not important, but I want to fix this anyway.

3. Fix that LTP vmsplice01 bug.

See patches for details.

Please, run that LTP vmsplice01 test again.

Notes:

- I want to repeat: I change behavior around SPLICE_F_NONBLOCK.
Previously, vmsplice ignored whether pipe itself was opened as
non-blocking file. Now it is not ignored. And in my opinion
new behavior is better.
- vmsplice(2) now is in fs/read_write.c . It is very similar to
preadv2 and pwritev2 now, so I think it belongs to fs/read_write.c now.

Please, review this patchset carefully. I'm still new contributor.
In particular, please, review that do-while loop, I'm not sure I did
everything right.

Tested in Qemu.

Askar Safin (5):
  vmsplice: open-code do_writev and do_readv
  vmsplice: change argument type back to "int"
  splice: turn wait_for_space flags argument into bool
  pipe: move wait_for_space to fs/pipe.c and rename it
  vmsplice: make sure we don't wait after writing some data

 fs/pipe.c                 | 17 +++++++++++
 fs/read_write.c           | 61 ++++++++++++++++++++++++++++++++++-----
 fs/splice.c               | 19 +-----------
 include/linux/pipe_fs_i.h |  2 ++
 include/linux/syscalls.h  |  2 +-
 5 files changed, 75 insertions(+), 26 deletions(-)


base-commit: 8d86fcfc2857d64af85f5c87c193c25655c970af (vfs-7.2.vmsplice)
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
