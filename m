From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 13:56:32 +0100
Subject: [LTP] [PATCH v2] syscalls/add_key01: test the length of payload
In-Reply-To: <0b715eaf-cb87-8604-a305-5443f4741c9f@163.com>
References: <20200121151342.GD6337@rei>
 <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200123111347.GE27845@rei>
 <0b715eaf-cb87-8604-a305-5443f4741c9f@163.com>
Message-ID: <20200123125600.GA6762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't run this test under an unpriviledged user. Seeing keyrings 
> manpages, it said "
> /proc/sys/kernel/keys/maxbytes (since Linux 2.6.26)
> This  is  the  maximum  number of bytes of data that a 	nonroot user can 
> hold in the payloads of the keys owned by theuser.
> The default value in this file is 20,000.

Hmm, that means that we should write a test for this limit as well.

> I perfer to add .needs_root in this flag and check this in a new case.
> What do you think about it?

Sounds good, I was thinking the same. So I will fix this and a few minor
things as well and push this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
