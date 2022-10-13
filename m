Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0807DC4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 02:32:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10633CAEE1
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 04:32:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C1753CAD00
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 04:32:42 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE3B6600A5C
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 04:32:40 +0200 (CEST)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MntjN4wpxzVhyn;
 Thu, 13 Oct 2022 10:28:08 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 10:32:36 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 13 Oct 2022 10:32:36 +0800
To: Petr Vorel <pvorel@suse.cz>, "Bird, Tim" <Tim.Bird@sony.com>
Thread-Topic: [LTP] [PATCH 1/2] lib: Add checking of needs_root
Thread-Index: Adjeqqt3VUxZflwMRSmqKvf7suw8Tg==
Date: Thu, 13 Oct 2022 02:32:36 +0000
Message-ID: <60876907d240408a9496aebde2a7a968@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hi,

If we neeed to run the test as a non-root user, the non-root user would belong to the root group.

Shall we add a checking of needs_root and needs_rootgroup?

Regards,
Gongyi

> 
> 
> > > -----Original Message-----
> > > From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf
> > > Of Petr Vorel
> 
> > > Hi all,
> 
> > > The subject "lib: Add checking of needs_root" is a bit misleading as
> > > it does not mention at all that it's for the loop device.
> 
> > > > We need to check needs_root is set when tst_test->needs_device
> or
> > > > tst_test->mount_device is set since access the /dev/* need a
> > > > privilege.
> 
> > > FYI we had some discussion about it, quoting Cyril [1]:
> 
> > > 	Well technically you can be added into whatever group is set to
> > > 	/dev/loop-control e.g. disk group and then you can create devices
> > > 	without a need to be a root.
> 
> > > 	So the most correct solution would be checking if we can access
> > > 	/dev/loop-control if tst_test.needs_device is set and if not we would
> > > 	imply needs_root. However this would need to be rethinked properly
> so
> > > 	that we do not end up creating something complex and not really
> > > 	required.
> 
> > > There is also possibility to add custom device via $LTP_DEV. That
> > > might allow to add permissions which allow to test without root.
> 
> > > I'll write to automated-testing ML (and maybe to LKML ML) to see if
> > > people prefers to test without non-root.
> 
> > I took a quick look at this, and don't like the change.
> 
> > I didn't investigate all the affected tests, and what device exactly is being
> protected.
> > But the overall sense of the change takes makes the authorization
> > checking for tests less granular.
> 
> > Fuego often runs tests as 'root', but it is also fairly common in
> > Fuego to have a dedicated testing user account on a device under test,
> > that has permissions for things like mounting, access to device nodes,
> > etc.  This change would cause tests to break for that account.
> 
> Hi Tim,
> 
> thanks a lot for confirming that people are using non-root users for testing.
> I'm not sure if we ever implement complex checks, but at least we should
> not merge this patchset.
> 
> Kind regards,
> Petr
> 
> > That's my 2 cents.
> >  -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
