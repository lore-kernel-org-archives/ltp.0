Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66748C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:52:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA2853CAEF0
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:52:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5FB33C0475
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:52:31 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EBDCD1A01127
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:52:29 +0200 (CEST)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mp1pQ2rrfzVj19;
 Thu, 13 Oct 2022 15:47:58 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:52:26 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 13 Oct 2022 15:52:26 +0800
To: Petr Vorel <pvorel@suse.cz>, "Bird, Tim" <Tim.Bird@sony.com>
Thread-Topic: [LTP] [PATCH 1/2] lib: Add checking of needs_root
Thread-Index: Adjeqqt3VUxZflwMRSmqKvf7suw8TgALcE5A
Date: Thu, 13 Oct 2022 07:52:26 +0000
Message-ID: <43b06441d7be49e6b3c06303abb3b41f@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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

Hi petr,

The testcases referenced mount_device and needs_device are more than 88 in kernel/syscalls:

./fsopen/fsopen02.c:57: .needs_device = 1,
./quotactl/quotactl04.c:164:    .needs_device = 1,
./quotactl/quotactl08.c:219:    .needs_device = 1,
./fsconfig/fsconfig02.c:96:     .needs_device = 1,
./ioctl/ioctl06.c:56:   .needs_device = 1,
./ioctl/ioctl05.c:69:   .needs_device = 1,
./statx/statx05.c:121:  .needs_device = 1,


./preadv/preadv03.c:137:        .mount_device = 1,
./mkdir/mkdir09.c:142:  .mount_device = 1,
./fanotify/fanotify22.c:300:    .mount_device = 1,
./fanotify/fanotify05.c:216:    .mount_device = 1,
./fanotify/fanotify06.c:244:    .mount_device = 1,
./fanotify/fanotify15.c:288:    .mount_device = 1,
./fanotify/fanotify14.c:227:    .mount_device = 1,
./fanotify/fanotify18.c:197:    .mount_device = 1,
./fanotify/fanotify09.c:513:    .mount_device = 1,
./fanotify/fanotify13.c:298:    .mount_device = 1,
./fanotify/fanotify19.c:287:    .mount_device = 1,
./fanotify/fanotify01.c:359:    .mount_device = 1,
./fanotify/fanotify10.c:756:    .mount_device = 1,
./fanotify/fanotify03.c:352:    .mount_device = 1,
./fanotify/fanotify17.c:261:    .mount_device = 1,
./fanotify/fanotify23.c:250:    .mount_device = 1,
./fanotify/fanotify16.c:790:    .mount_device = 1,
./msync/msync04.c:99:   .mount_device = 1,
./pwritev/pwritev03.c:136:      .mount_device = 1,
./creat/creat09.c:146:  .mount_device = 1,
./sync_file_range/sync_file_range02.c:122:      .mount_device = 1,
./fsetxattr/fsetxattr01.c:222:  .mount_device = 1,
./inotify/inotify08.c:176:      .mount_device = 1,
./inotify/inotify07.c:182:      .mount_device = 1,
./fsync/fsync01.c:51:   .mount_device = 1,
./fsync/fsync04.c:57:   .mount_device = 1,
./setxattr/setxattr01.c:211:    .mount_device = 1,
./open_tree/open_tree01.c:70:   .mount_device = 1,
./open_tree/open_tree02.c:51:   .mount_device = 1,
./prctl/prctl06.c:125:  .mount_device = 1,
./sync/sync01.c:54:     .mount_device = 1,
./writev/writev03.c:142:        .mount_device = 1,
./madvise/madvise12.c:82:       .mount_device = 1,
./madvise/madvise13.c:83:       .mount_device = 1,
./quotactl/quotactl06.c:224:    .mount_device = 1,
./quotactl/quotactl05.c:115:    .mount_device = 1,
./quotactl/quotactl02.c:152:    .mount_device = 1,
./quotactl/quotactl03.c:85:     .mount_device = 1,
./quotactl/quotactl09.c:182:    .mount_device = 1,
./quotactl/quotactl01.c:218:    .mount_device = 1,
./execveat/execveat03.c:72:     .mount_device = 1,
./fremovexattr/fremovexattr02.c:113:    .mount_device = 1,
./fremovexattr/fremovexattr01.c:90:     .mount_device = 1,
./copy_file_range/copy_file_range02.c:252:      .mount_device = 1,
./copy_file_range/copy_file_range01.c:231:      .mount_device = 1,
./ioctl/ioctl08.c:123:  .mount_device = 1,
./utime/utime05.c:70:   .mount_device = 1,
./utime/utime03.c:94:   .mount_device = 1,
./utime/utime02.c:83:   .mount_device = 1,
./utime/utime04.c:56:   .mount_device = 1,
./utime/utime01.c:68:   .mount_device = 1,
./ftruncate/ftruncate04.c:179:  .mount_device = 1,
./readahead/readahead02.c:403:  .mount_device = 1,
./preadv2/preadv203.c:279:      .mount_device = 1,
./statx/statx04.c:130:  .mount_device = 1,
./statx/statx06.c:157:  .mount_device = 1,
./statx/statx08.c:177:  .mount_device = 1,
./getxattr/getxattr04.c:110:    .mount_device = 1,
./fgetxattr/fgetxattr01.c:142:  .mount_device = 1,
./fallocate/fallocate06.c:263:  .mount_device = 1,
./fallocate/fallocate05.c:149:  .mount_device = 1,
./fallocate/fallocate04.c:308:  .mount_device = 1,
./fspick/fspick02.c:50: .mount_device = 1,
./fspick/fspick01.c:63: .mount_device = 1,
./mount_setattr/mount_setattr01.c:130:  .mount_device = 1,
./close_range/close_range01.c:194:      .mount_device = 1,
./fdatasync/fdatasync03.c:57:   .mount_device = 1,
./lremovexattr/lremovexattr01.c:122:    .mount_device = 1,
./utimensat/utimensat01.c:318:  .mount_device = 1,
./rename/rename12.c:60: .mount_device = 1,
./rename/rename04.c:48: .mount_device = 1,
./rename/rename13.c:47: .mount_device = 1,
./rename/rename06.c:39: .mount_device = 1,
./rename/rename10.c:39: .mount_device = 1,
./rename/rename08.c:40: .mount_device = 1,
./rename/rename05.c:39: .mount_device = 1,
./rename/rename01.c:80: .mount_device = 1,
./rename/rename07.c:40: .mount_device = 1,
./rename/rename03.c:70: .mount_device = 1,
./syncfs/syncfs01.c:63: .mount_device = 1,
./mmap/mmap16.c:177:    .mount_device = 1,

> 
> If we neeed to run the test as a non-root user, the non-root user would
> belong to the root group.
> 
> Shall we add a checking of needs_root and needs_rootgroup?
> 
> Regards,
> Gongyi
> 
> >
> >
> > > > -----Original Message-----
> > > > From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf
> > > > Of Petr Vorel
> >
> > > > Hi all,
> >
> > > > The subject "lib: Add checking of needs_root" is a bit misleading
> > > > as it does not mention at all that it's for the loop device.
> >
> > > > > We need to check needs_root is set when tst_test->needs_device
> > or
> > > > > tst_test->mount_device is set since access the /dev/* need a
> > > > > privilege.
> >
> > > > FYI we had some discussion about it, quoting Cyril [1]:
> >
> > > > 	Well technically you can be added into whatever group is set to
> > > > 	/dev/loop-control e.g. disk group and then you can create
> devices
> > > > 	without a need to be a root.
> >
> > > > 	So the most correct solution would be checking if we can access
> > > > 	/dev/loop-control if tst_test.needs_device is set and if not we
> would
> > > > 	imply needs_root. However this would need to be rethinked
> > > > properly
> > so
> > > > 	that we do not end up creating something complex and not really
> > > > 	required.
> >
> > > > There is also possibility to add custom device via $LTP_DEV. That
> > > > might allow to add permissions which allow to test without root.
> >
> > > > I'll write to automated-testing ML (and maybe to LKML ML) to see
> > > > if people prefers to test without non-root.
> >
> > > I took a quick look at this, and don't like the change.
> >
> > > I didn't investigate all the affected tests, and what device exactly
> > > is being
> > protected.
> > > But the overall sense of the change takes makes the authorization
> > > checking for tests less granular.
> >
> > > Fuego often runs tests as 'root', but it is also fairly common in
> > > Fuego to have a dedicated testing user account on a device under
> > > test, that has permissions for things like mounting, access to
> > > device nodes, etc.  This change would cause tests to break for that
> account.
> >
> > Hi Tim,
> >
> > thanks a lot for confirming that people are using non-root users for
> testing.
> > I'm not sure if we ever implement complex checks, but at least we
> > should not merge this patchset.
> >
> > Kind regards,
> > Petr
> >
> > > That's my 2 cents.
> > >  -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
