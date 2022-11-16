Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C16C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 02:52:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73CC73CD1BC
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 03:52:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72533CD159
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:51:59 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3C936002C8
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:51:57 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBnch2cVYz15Lxj
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 10:51:32 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:51:53 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Wed, 16 Nov 2022 10:51:53 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/fork02: new test for fork()
Thread-Index: Adj5ZZt1lEi4b8L5QUykWqbfLe1/Ow==
Date: Wed, 16 Nov 2022 02:51:53 +0000
Message-ID: <515431fcd75945108f09f98babcffef9@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: new test for fork()
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> 
> Hello,
> 
> Zhao Gongyi via ltp <ltp@lists.linux.it> writes:
> 
> > Verify that current workdir correctly inherited by child.
> 
> I'm not convinced by Cyrils comments that this should be included. I doubt
> LTP would work if the CWD wasn't inherited by children. At least in the
> common case. The test needs to do something more IMO.
> 
> Perhaps there has been a kernel bug involving fork and CWD? Perhaps
> relating to new file systems and mount options. I doubt we will see issues
> on a common setup. This isn't adding any test coverage in that case.
> 
> Also the path to the CWD and the CWD are two different things. The
> kernel generates the path on each invocation of getcwd IIRC.
> 
> Marking this as changes requested in patchwork. Although really, I think
> effort should be directed at clone3 which is lacking a lot of coverage.
> 
> --
> Thank you,
> Richard.

the pwd is one member of fs_struct:

struct fs_struct {
	int users;
	spinlock_t lock;
	seqcount_spinlock_t seq;
	int umask;
	int in_exec;
	struct path root, pwd;
} __randomize_layout;

And fs_struct is one member of struct task_struct:

	/* Filesystem information: */
	struct fs_struct		*fs;

In my opinion, the pwd will inherit from parent naturally if there is no a explicit change in fork.

Regards,
Gongyi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
