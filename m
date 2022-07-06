Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D1FC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 09:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75FB83CA249
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 11:38:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AE243C6FF1
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:38:02 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 634291000A12
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 11:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657100282; x=1688636282;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rNN9zqcpeEykT8IQeIw1cX07SiyoOtH71Sj6v9/Ee5s=;
 b=OIjDBDW9nXrsAaXgx4IYGM2Ll9PLT8CRav5AEKnfVDBGRdcX3OagsRMT
 McbIQxFx4kZcnG/d6AsGPYlDfiNpTVbfhiqgowur7czuq3m/Jt4sCRZIu
 ybYHcK8ukkERZx9NL2OB4Ejn6+KrV1xQNkeLkClH0zpZU/tN3to2FRvUr
 PzAQ7dnKP21Z8kaqJuBOsm4hFoc9ZzHvG3YQV48bKwhByw15QFzAmq7Yn
 13rbMB7UrsliGFhI+2+RNsAYOZopniPQ3lviVwv3EZkdLbdUWMZZByGBP
 YnSHUz2LmzMkaZKGW+64xkpBokD7GcyQM6t1B3hkQtQHPm1aIeKxElHCz w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="59722678"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; d="scan'208";a="59722678"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 18:38:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzgq3OXMPYc/FRMHPD3LPG3SxYB5Ixi0VW/FmVo6EnInJ+e8nZLA4WR3m06rwXLdB21v9Id3yCzUPxjYe6RQZ0JhVTZtp2KNSXi3ZJ4OGqygd4fERZh/zuBnkv0iaXCeNj3Cxo7sUu6pdDqOAOi7pTdC2AYppfl4rB5GTNjM3wr5QRPxmb40NzSpxHW5nHKrVaVKNQjvwqLUczFaIXCdMssWB9Xexp1fvJBaojYlxKVioNeigI+f0zck5No0QIFFmcbprh2kWVWZU03ZNCoF29UsodMzzjBitOzjwUGmaGxgAk3l+7Cr0Y8XjVVilSJas8QEKGyU8MOM8RSXKVxuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNN9zqcpeEykT8IQeIw1cX07SiyoOtH71Sj6v9/Ee5s=;
 b=ckArbqqNn3bxqXYqlgXMV01YwEsRfqQ7vv5oWjBjySA+Kaym71BP36xnY8fUrNd0sJHilflMtynrgqeL/DnQlqZDuwbxTO8VLsVK/3o3R3fmpjF8ubzK/DVLEPLzP/zltKqMpw+f+GK3cHA76sNiK8pFr1h/r6BtJxDg3/JTNivSedgLcLRXYWpNQ7MQyc/9+ilJknp28HHop1x1ZQLN7QEltckuAYjdaKUrZAC1wUWw+6gUMjkUmanAkA9wxi7c71EulN27TdFmUEnoGjicKYB+/dO1n1wlXHxZDzQEmAbTgaJSy9buei6BNvy+pAEHDmnY+NVvyNXdziMYs7hFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNN9zqcpeEykT8IQeIw1cX07SiyoOtH71Sj6v9/Ee5s=;
 b=RdzLCEqNze5eXOIeiez0kyJ2Qr2VxrrIKE3HrsuUNOtuTuXaMjNgRvNogVr3dN4RGMKD6MTW4CrZcfN+PwfaNLkpvmkEEVGj9Ygq26ZCB30tkmAshpQhoEYn0NQdkdZpE4PUVqmOnKAKRW1qZk+yHtX0kHeM2JwdxZQSypz1YQA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB5153.jpnprd01.prod.outlook.com (2603:1096:604:6b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 09:37:56 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 09:37:56 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
Thread-Index: AQHYN9eJWCFPwI5fE0G2efRMRz6TPa1x2XsA
Date: Wed, 6 Jul 2022 09:37:56 +0000
Message-ID: <62C5663C.2060009@fujitsu.com>
References: <20220314191234.12382-1-pvorel@suse.cz>
In-Reply-To: <20220314191234.12382-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbcd42e9-d22f-4b39-3c4f-08da5f3334d6
x-ms-traffictypediagnostic: OSAPR01MB5153:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGicW2STzQ/VjyodzeIwprfEsXCWg8q7OFSk6ssUZT10yYvbi+0ceUQJT8Re05Osiwa0pNqp7Zen9fdKXOa415CKyZeqHinEQG1b6ukcxGiNCrmxaN2u8JnAHzJOyZWRcoHGBzxEMBXWTeqZ0PE6RGoSoD+i48vUgFjp3VwWnZoJXs8r1UTJwWd19xMgfSqGViU6PB4WNF85Q30C83q7f+qUGjwQLfM38qinAcmlA0M2rNebMpFGtg+WxOJDFuhy+QoWgT0rNTkotkUgpwTHOa/45WjAB3s0REunhrdHwKbr0MDUUYVQ8DVD7K5Pe0HlhZ4PKCnRHLFZam5Ajv5vs+LGWQ0+JsDnooX0I5k4LZWzrqE+ZyBejJXWvySkmotvz/Y6G3JQVUhL/FgGV+ZHkwkNWv/5QfnFWcWQQSa6o3fmrEowmkRfQpetrnDlOYpdBv323BYyy2l6xBlHe04oOpO5syf5aO+oWcO/a4cQng6hWDoz4YmzcckgCbSYMhd9Yk615nUm3BBjim2HqBgZD9JombseMVOlsTVPNk6fC468v8LdWvnfZykrvZihwbX7t93lyLOvSu1xSoHEYG2BfaGo/8JPiJ1pQ70Z4msUiO0HHfSUQRiRkWkYBILYeXM6cTsB4sNUM8nvlL/UeawlsRRpKwKd4Oje5jAXQf/xIUZ16/QWyjHImWg9yFveulbQlz4UhA8RzafJbf6dmY0XOhxuYenViW4pKKNbsuc3fzsamuV5WhsqfiJrDJ8LwK1GqaZ6R7u26Cx37sbDU0/fLon0KFRlyUKGOHg2o4vWHXzURixlOIljaesph9GdXQnbU/7uhDHrB1ngVGrsBPeUQeSfH8kRpDWPq+pZpyERV4x45+/LSezecD4LN9uERpKI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(6512007)(2616005)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8936002)(4326008)(8676002)(91956017)(5660300002)(36756003)(85182001)(6916009)(41300700001)(33656002)(86362001)(6506007)(2906002)(6486002)(186003)(26005)(87266011)(478600001)(122000001)(82960400001)(38070700005)(316002)(54906003)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b21CWTh2SnVvUkhicTI3aXBMQWVCWGYvSXpQWlhvY1ZCbEE5MjdoZDlQQytY?=
 =?gb2312?B?WEhXZ0EwV3owNXpSM01Gcldaa1U0ZHVSemt1emkxaTVWRXFTTUFZWTk4SDU5?=
 =?gb2312?B?Z1ZoL1hISjE2UkZHUEhidzRSYWowM0Naa1FIdUU5bDdtNmFYOGxBZWhnR3Zl?=
 =?gb2312?B?WmxIK2pibGtrODFMUkxZK09UaThxcGxkZnRoVWVCbVQ5S256NmdDTVBSRTho?=
 =?gb2312?B?SkFFTERTcTBDdEovVlhsZFBTQUpPdC9YaWdnYi9ZNGdMSExjUnUvK2RlSmlJ?=
 =?gb2312?B?bVlBYUJsUmVJUEN0MEFzWGtYTy9MTFpORmlSaVE1WFdjeWdnWEdiYzk0eWVW?=
 =?gb2312?B?dGh0bTJGUlV4ejRCWFBTak5ZZzZDV3lBOUtwWmlvV04yMFRsUXNTUllwM21Y?=
 =?gb2312?B?MCtQWXBxY1JsQUVoS242RXpQeTR3UmVXMHBETHFxYkMzWFhTeUFpZlhraHhT?=
 =?gb2312?B?MHg1ZmJscjV6TEN3Smx5UENzNXl2dkUzUEpmQS9iWWQ1c1FpOEVxa0ZlZ3BN?=
 =?gb2312?B?VlE5WUFPdjAzNEJiRjIxSGZjQi9OcFFEZHg3Znc3dWlaSnhKK2ZDYi9wbnNW?=
 =?gb2312?B?ZjlDNmk4S3pkK0JPOS9wMDJoZFlxZmtpQzNwY2pmVGpWN0E0bFo2QkJZMlN2?=
 =?gb2312?B?QXJDcnZWNitKa09MeEZwUnhla1ZlMUQvNFUreXh2WTc3STN4SzFRRmpMMlEv?=
 =?gb2312?B?eUNvL3cwQUtPdjlvcytFNERsV1RQWHpqeGZic05TNk4rMnZqNHhVODVzNWUx?=
 =?gb2312?B?SG5xVVZwcHdUQ1lsZnF3clYyRlB2Unh6SHRJc2gvcHRsdU9DK1BqeCt5SU5P?=
 =?gb2312?B?K053Y0tpQ2krL3FaTVdhaE1JMkxSZTVFVEphK0s3UHE1SmcvL1F6V3hmK09l?=
 =?gb2312?B?eU90ZlJ2bEZoNE0rckxGMnZzR0V5S1RUNzRoRWlEczRPTThabUZndXVQclhN?=
 =?gb2312?B?M01uUzVvUE1pL3RkRnlYTXpDZE1hajQ0eXcxd05zWXZzV3p2VnR1OTNuV25E?=
 =?gb2312?B?TkdiTnIvZkdXVVUvTmN1WmllWTl2OS9keTVqTUpxUlVCc2FvQWZzSjhzL3BI?=
 =?gb2312?B?V3pLaWZ4QzZid2ZYdHRUdDRSN2VDNEVIbTJBZzg0c0xKSTkwMVdOZkN0S0ZB?=
 =?gb2312?B?bjVLVmRoMldVbzlvY25NdS9oWjVRd2pXN04wTCtvZXBQQUNaMDNUTDdiM0dR?=
 =?gb2312?B?WFQ0UngzSXdMenpkTlF1bWVzQk5UODNNcnVGc0lZOGlnVHlvY0o4UEs2eFRm?=
 =?gb2312?B?ZGd3QXJLK2NQWGs4Rkp0TjF6SW12ZVlscFhNK3cveHRBZDNGSkdNS20yNWda?=
 =?gb2312?B?L3poVURoaWxzczV3NjBJS3pReXZ3ZVlpRVN2Sys5K2xZMUR2LzhqZ216WlF5?=
 =?gb2312?B?S1c0TUh4MzRlV1hQR3JoNHprcFdiWFJuSnNSSjYwQTErTFI2c2IzYjh4Rm9z?=
 =?gb2312?B?cCtKN0xpSkdHUXc4eGc4UEtndG9HOFhBMXFFSld3V1E0WXNzb3RtRUhlYnNZ?=
 =?gb2312?B?bStYZWhUdFpZOE1JK211WE5PbUlRUk82dlNXMTc0Q1dCMzUva2dNZXpLVzIr?=
 =?gb2312?B?K3pMOXRsSVp2SUZLZmdXdXQwbGpiMk9UU3pjekVsNGYyTzk0cDFrQXhWNlJX?=
 =?gb2312?B?REdPQmFTRVk1djdCZlp4cEFISEswTm83ZTYxK2ZYRE1IcVZqeFhBMG80MzZx?=
 =?gb2312?B?cVl2ZjJjVlk1aWxCTTNTMHo1ZHVGWmV6QklaSml3WlltYXpUOElxSzlXV0hu?=
 =?gb2312?B?Z3VnWkhxZ09CdEo4eFFRN3BNWVRseFZxTU9LVndRWDYwSHlxTFJtSmlsaktM?=
 =?gb2312?B?VmhDa0k4U1N4ZHRPdGtheE5NVDJsNlBzMnVZdXVlZjROcFRueG1iay9ncnVD?=
 =?gb2312?B?ei9FOGlqYURwMXVVTDY4L01tQnZpSVJ4QmlQQkZTTnRlaVlxcXp5VjBjclBB?=
 =?gb2312?B?NmZyVUI4N1BOQzNNbFdTWlUxMG45Q2grc2lMTUloYkxoNG1SSmlBeWZLU21J?=
 =?gb2312?B?dlR6NWEzZ3NlR3VQN21hQ0JKUWRIZGF5YjVrazJSTEdVN2tkZFFCVzdtdXZn?=
 =?gb2312?B?RnpEL2NYcEliK3ZPZGM4cXE1K0pWKysxM043MkRLeEVaU21GMmxiZUo1T0xI?=
 =?gb2312?B?d0xDdHFLaThZemQxMVlteFhkRXBaekdVdHlJUm0wVU1TMHNoWmtXWlUvTzFq?=
 =?gb2312?B?T2c9PQ==?=
Content-ID: <375F6156E2FBEE48BF26D0E51AE4624F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcd42e9-d22f-4b39-3c4f-08da5f3334d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 09:37:56.0616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eylbTcoPqCZRrbSl7ijKLbhGvlyFKcaoqq9u9l5jzqkpjIDdaCQfkkTmSbgHXR/r9AlhlpcItADfl+H1HJ1rVywM2g0lfrssomoAvVcq50A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5153
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Share some process with you...

I have rejected this patch and a kernel patchset[1] is plan to fix this 
but doesn't merged to upstream kernel due to none continue to review 
this(It is about one month since v9...)

TBH, this case only tests simple creat file with open but miss
open with O_TMPFILE[2]
mknodat[3]

setgid strip logic is not only affected by umask but also include acl 
operations[4].


[1]https://patchwork.kernel.org/project/linux-fsdevel/list/?series=643645
[2]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=87cf32ad3fa234e3d5ec501e0f86516bef91d805
[3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=5328ab947ff4d2d492a6ac90b22d31ab02637bd8
[4]https://patchwork.kernel.org/project/fstests/list/?series=643643&state=%2A&archive=both

Best Regards
Yang Xu
> XFS fails on umask 0077:
>
> tst_test.c:1528: TINFO: Testing on xfs
> tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
> creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
> creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
> creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
>
> Thus clear the default umask.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/creat/creat09.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0e..70da7d2fc7 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -56,6 +56,8 @@ static void setup(void)
>   		(int)ltpuser->pw_gid);
>   	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>
> +	umask(0);
> +
>   	/* Create directories and set permissions */
>   	SAFE_MKDIR(WORKDIR, MODE_RWX);
>   	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
