Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A64CE7A8A
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 14:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 732673C9C98
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 16:27:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC7553C9BF5
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 16:27:47 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7AD121000A0A
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 16:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oREoElc5jpssB77N72uWfn2jY29hXFa5YHaPFH9Puuw=; b=IWivhL67SaSkoM1RHiUcFSYaZt
 441UcLnuKM0oMXllZKJbrhSv3pxPu3tOCw6kc+ssFgntO7gNzMdtRSFBculTNtOTN87yHxs2pu5aj
 5ijTqI1aKo6sL8KatAX/2BNKGVO/lZmBmo0peYc9Y+yYyc+bQxii56hAFFrrBwVdwPDQjmsZYMLfP
 +X1Emiemllw8W75KWaE7zKUjq1N0Js4hWNw20h9iwnpdQc1zmrRA8suwiLXAsPgLHQH2hjjTF2uQf
 SSRcOUXmwJKqnmX/ZhuBUELT1hH6LXunKITNkhkxkRc6Dlg3guHog68Va1UJZ9jHN3AMnOV++h/N+
 KKBTXUrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1qkQ4u-00DPlw-2K; Sun, 24 Sep 2023 14:27:20 +0000
Date: Sun, 24 Sep 2023 15:27:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <ZRBHSACF5NdZoQwx@casper.infradead.org>
References: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> Since you joined the discussion, you have the opportunity to agree or
> disagree with our decision to change readahead() to ESPIPE.
> Judging  by your citing of lseek and posix_fadvise standard,
> I assume that you will be on board?

I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
that's not what kbuild reported:

readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded

61:	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
62:	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);

I think LTP would report 'wrong error code' rather than 'succeeded'
if it were returning ESPIPE.

I'm not OK with readahead() succeeding on a socket.  I think that should
also return ESPIPE.  I think posix_fadvise() should return ESPIPE on a
socket too, but reporting bugs to the Austin Group seems quite painful.
Perhaps somebody has been through this process and can do that for us?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
