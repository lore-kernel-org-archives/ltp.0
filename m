Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76493C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 03:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D62993C697C
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 04:41:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DDE53C1044
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 04:40:49 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B3D51400985
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 04:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638243649; x=1669779649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ydw+h8Irhr1mkz/Pwg5h/wrhz+IIR7IVG6rSR63Wscg=;
 b=n82Eyy6be0Gw0YrPJs6HOrkD58JxAm7feOxSTKkNKfK+22infA3EyAHO
 6YrDrVgj0m7IkYjYmKFRnUxPUavO9MmTduC2yC3OU41PM2XU5KMdPtjbd
 Fu4a12gL4DyLhDjHmpx7fiwC4abYNO/UUXBcveA8D5DUww/tnztM2U9kF
 m5wHlkebdSN3si93VEUKFHP8/kfacYHUju3R0qmX5rW3zsZ4dUPtSNtHe
 OEPKu9eVd1ci7H85UGj8itURnBTGmblIsIFdLkud84bobrOmw/CgIb+2+
 fEAQacky5tPK6cY0ey9OV9s0BU42CULbPBt6E496SN1BooDPPXxMP1/Z+ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="44835180"
X-IronPort-AV: E=Sophos;i="5.87,275,1631545200"; d="scan'208";a="44835180"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2021 12:40:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu7BgsZ1L2RSHA7BiXLIE+FmPVFuMxOOtRaTdu13oHa8EREjhnf4pQKDgFYFE7tQquYGUL7Y6HweuV/5UAdoXj4Pv6moh60WnJKgOGz9K6uhuf/XbspcVqGclpx7r0kbmswCN4Zyk8YETgvFhhvnsWGXJu8eHo9DsPTnMkTMHrbZ+6KUB/0kzOAOKBbY4WM4rCc/UjPrP/nM3IjbD4lqsCaQvbUWNOuL+CBGLVt6QPaMHRDFl+l2BMjter/kGsdXQS8qgu8bfNqOIklDa0U2ozll1hrgBzyjxfPhtHU7bhFS9sfu3R86sRXXNP47KgMNnYgGyXNn6cKmBBxJfH5Tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydw+h8Irhr1mkz/Pwg5h/wrhz+IIR7IVG6rSR63Wscg=;
 b=iMSM3nF+psuUHVLR5KvcY8f7do092G0zGl9xscDAtbj4yb9NsBLUMWPCy73u/foT9csnZxLTWfhJpUHfXBU8cuyizTTugKf48MoDzyVW2oJ42i3Y/p68201OaO4lG1RDCvEkudPuzPnamaMwVG9XMIHBB8KR1bZqcmiRHRZQlFH2Ltrz5Zflos8Vv70WiuhPBejD9vrIHDdihG95kIwqmaVvboXBsZ7zmv0n0RbzVJ0H9jQ+aDq7PyIYHwbB6V0zJTN46tgWucHIE2yVbeIVmnzWr1CQREYswtDoOovTkUBYbBnWje4TmM3MT9Du6FBNyQKpTC8ck4W9NE+edQgHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydw+h8Irhr1mkz/Pwg5h/wrhz+IIR7IVG6rSR63Wscg=;
 b=LM0uYYdpVp9JAL5b9mLbJVe6hRA+0HY58XFx6qdWFJQqic/f2lMabeH2MH3o5ERW76FVlTqjB/GhXoWqdYStquKVV23b6jG2ZtJmNOYs6rCQyZdzVqnpm7ffeU4Bo9KANmWAxGpjWQQS7jNJZO+6vnWvjaIoIAidSQvFEE5bZGk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6849.jpnprd01.prod.outlook.com (2603:1096:400:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 03:40:43 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:40:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/statx01: Add stx_mnt_id check
Thread-Index: AQHX4d/FTp7QLs8z/U66yMujt2jnE6waPc0AgAE2o4A=
Date: Tue, 30 Nov 2021 03:40:43 +0000
Message-ID: <61A59D4D.8020409@fujitsu.com>
References: <1637832900-4753-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YaSYuLV+XPW/pQ5/@yuki>
In-Reply-To: <YaSYuLV+XPW/pQ5/@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dbbcb66-fc8b-49d2-5551-08d9b3b32fd5
x-ms-traffictypediagnostic: TYCPR01MB6849:
x-microsoft-antispam-prvs: <TYCPR01MB68497B22B343FA7014DF692CFD679@TYCPR01MB6849.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJQ9irShIrag07qGzdY3RzGmfvxpzBhax47+agF9iNP314GNGGyYEfCruGDvRW6SpHVVFEKCXvxd20FC5df6uaRXvB4hCc8PjCbvoWW27eFrNCRvVVWpqqyxz3FAd89VC0gEQ/gtQ7CJ/jaCFfOmU1BBVUQxRl8oIXI1g+ZHLZbVL5QXWlMDeCyTlp4AnLaBrfCxWtWqEJDEFMKmqFE0A90QXtKKA+4tTR8n/Tb4ve16F0cWJ1eu7gF0nwWiyp9NHzAMMokBP4yNRX9ib7QwR0mVdJAnnmAXzxvo/3SEYN3WLgZlM07Zch+s2E0EfDMnevlp0S6jSsQkrtO55vizg8i26HJsx1kXMhu1zLKa5invH51BYEyFvslWRqkDToq0MClXv1KsH5gztOMAiSjgtZAQZrPalRHbGDonxehUlJL1b3zQs2TcR0E9J7Ie/d7ccMS8cdweD9QcJRao/bYE499jPbeoM7RExHOfWtxVI1t+EiedG8lVFx4tg1gmJRpfjL80wFq8zTjN9lzb5UC+JMxxnliCbyU/Bih5TJj+X4OT1A0nAkn1eWWjCzDC624PdR1CcApZRvM0TVDw6HD9c9U2F0k2J3pd5ThDvG1K7wWr2Na6A3G9dcFj8r4FChILEz8SpIkmpzOKAYId56O1rYO6RSK69+xcjoReF1IwqYKmfWJATtayka7IDe4mVVioBPGTM4wMXErS2RqtI0VaJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(4326008)(2616005)(6512007)(6916009)(5660300002)(186003)(33656002)(26005)(8936002)(8676002)(85182001)(87266011)(91956017)(6486002)(66556008)(82960400001)(66946007)(83380400001)(66446008)(86362001)(38070700005)(71200400001)(64756008)(66476007)(122000001)(6506007)(2906002)(316002)(38100700002)(76116006)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dWhYbU16T3FSZmdoaVFpZG5kQk1WNkhKeUFsaFdvWDdQNmlqYXhUTE9KZ3BH?=
 =?gb2312?B?OVNIeFlVTzRCVndVTy83bzRDVy9tRXBtMGQ2ZkFvVzdVZkF1eUxJMW8wNjk3?=
 =?gb2312?B?cU1BZHlYdGNNdS83VHFzbWNqVldGZGFTdzc5U0NmT0ZYZmFCbjRVb0ZHZnB1?=
 =?gb2312?B?MnJhVWRoNDVVTGJIRjZBTEh4WDdrK1orZVErbVpmdk1sVEhlN0tyNkUwZTI0?=
 =?gb2312?B?Nmtvc0YweUNJUm4xMCtEQ2dCQUt1L0ZWQlYvOWxyTWR3SVUxNnZROW16dkdJ?=
 =?gb2312?B?ejVod3JodVQ1ZkdJcVJ2clQ5Tlp3ckJia0p3UUVxU0IvaVd2dG1wd3ZZQ3Ar?=
 =?gb2312?B?bXhYYUdpeGppdVlYSHJ3cDc1aDJHcjg5L1NDbHhOd1JTU2JnampVQWpGdUYx?=
 =?gb2312?B?T0tadlh1U1FRbjNnZmZ6SkhNWk1sczBQTndsT3NYYUpnUTk2eDc0WitGL0xJ?=
 =?gb2312?B?WDNHTUloRHpuMGVMeXRCQjZOdkowVWthbVp1ZlFBZUxqRWZpS1ZPRWcvUC9q?=
 =?gb2312?B?dHlNTzc1WU9EWVMwQ281bHFuVnV5SGd0Wlk0cjdWUVlvOTRyeE9UcWZmRm91?=
 =?gb2312?B?Ym8wMFJ6dXNuY2VhODFSM1d6N0QweW4rNHJFUVVUdFZCTkNndU51cWp3REtl?=
 =?gb2312?B?RlZPeG4rUmZxRjFNNkk5a3o5WW9vNDBBVEk4emN4bUZ4eU5tcFZRWmpPS283?=
 =?gb2312?B?SEh3VXR5K1I5NmdUTUVmd1YvMFdIckVZUmc2NXMxdGpRV1RLaWN0WEJrRCsr?=
 =?gb2312?B?UGF6NEJPUnV5a2U3eVFCdVEwaEh2V3VPUzUvWkFrdFFjc3E5RGRRWGxxUE9V?=
 =?gb2312?B?Y2RFWG5VSTNVVTJVNmdjdW9iSXRJSkpPQ05tT3U5RTd3aVcrK2R4NHpKUjRq?=
 =?gb2312?B?R3lKdW9aWG5VeDEzMEJhQ0tUb1htd3NPNkVVM0JmMGhZSHVCVnhtdmY2cm1q?=
 =?gb2312?B?QVlnKzA5bDlSVVdmaVQxTXZsaE93TmViK1NUdjZuTkczd3NSUXBDOEtGMlVv?=
 =?gb2312?B?M1NEYVJ3VWNtU3JQOG9qMFpURmZEa2dJMytIcHdmaHI2d3M0c3BwYzRwV0tr?=
 =?gb2312?B?TEhNRTR3NE9hSkt6eE5jU0FrL3ZKczNhR1crNHRFdVcwZTZzVlFIY2JEekRW?=
 =?gb2312?B?UDRCU0I3azdwdEFiY09XZURrcGVlY2pFakpXbmlVampHaW9OVXRRR1lqc3Zk?=
 =?gb2312?B?YnF3RHFXaEY3d3U5U1EvYU55RWU0NWtycmlRTnZjZDZOMTh3RWYvQ0ZyQVl4?=
 =?gb2312?B?L2ZxRXFkSEg0WGRDV3dHUWlXa3NtRmJIL0plNjY3QUR6a2RCOGEwdFBpVUpV?=
 =?gb2312?B?RkEvVDFxTXRvakJNV0RiSXVMbWd4TFlPNlV4QXBLZllsQ1FmVDJsQlBZbXZ6?=
 =?gb2312?B?eXdHcHFIS29OV0hOWUNPVnhnVCtid2ZWUWdrMGhvZzI3N3JoYzE3Z2U0RjZ0?=
 =?gb2312?B?UEJ1c0k2ZnlaeThqOTFKVUIrdFJEMkpuN2pHVnhTT2NJUkJSZVZSbGxWTUZz?=
 =?gb2312?B?SVQ3RHRNNzNSRm9zbk0wUmNFMnQ3QWpncWR4dDFGUWlhRWRLY0ZZRU1BVUl4?=
 =?gb2312?B?bDFFRGpvSmRzaVl1Z0N6TjdYVEFxOWJqY1YvMzU1cnplTyt0eUhKL05TdDk0?=
 =?gb2312?B?UXAvS0k4OStiWWlTZkFEL2Znb001TzN4ODhCYlg4ODlFMW8zK0UwaTBGS01y?=
 =?gb2312?B?NktHT0FLRDNYSlU4ckxpNy83Tk8wNUpCalllNTJlRnVRMUtlNWZsT1VZd0hh?=
 =?gb2312?B?TEFLL0V3bnVJb0RvMmpJRkdoZmFMdWo5RUVWQTE0NEJhNlJrVE5qdUpNeVc2?=
 =?gb2312?B?czM4T3lRUXhVNm1CMHJhYkNtVUo2STF4ZzZDamVLb0ZEUFFmUEYybTE1TERQ?=
 =?gb2312?B?dnUxSmtnMEh2aTN4Yy8zOFVZWkFzb0t2YkIweVNkbnl1dHVEdUVnZmxtdTZ1?=
 =?gb2312?B?dTdQRTJCbzk4a3Rkd0p0cUtDZUpTVkhYbGJhVmdVSjdYN25rSW1meWNPQVIw?=
 =?gb2312?B?V2kxZjhrRTdmbkJCVTZSY1JnSWZ4Yy96VjRuWGtKaHRSQ0hwRXJXNTlnY2Jm?=
 =?gb2312?B?WFdtdjlyN3EzNTIvNld1WjRjVkhaZ0lpVEVXWUZOOE5wVTBrRTVRN1hsVGJY?=
 =?gb2312?B?T01iSXhGdnRwOE1xeG01c2ZkbFZGdEQvMWVwT2FvVUZFL3lNcVYybmU0Mkdt?=
 =?gb2312?B?Q29Yb2dQMldwK3JsTC92VjlFVmVTRjRSRCsrbFZDODVzdUJsV09keEhPQklk?=
 =?gb2312?Q?rpJ7ue0CLvgGpgq+9hol64sj3qIKA8Dg1uPwS9hy70=3D?=
Content-ID: <147B3DED96E21244A4F0B9EA83069D28@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbbcb66-fc8b-49d2-5551-08d9b3b32fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 03:40:43.1907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXWJes9r5wL8gWM4PyZN1LiAk94h2TRvX9llQiWom6HHSX9L6iZBHiD+S+plUT5ONvrJOX/NmK/j6yp4smoPsYYaVo8CqPq9ZnHjkUu0+Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6849
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx01: Add stx_mnt_id check
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
> Hi!
>> +static int file_fd = -1;
>> +
>> +#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
>> +static void test_mnt_id(struct statx *buf)
>> +{
>> +	FILE *file;
>> +	char line[PATH_MAX];
>> +	int pid;
>> +	unsigned int line_mjr, line_mnr, mnt_id;
>
> Shouldn't we check the STATX_MNT_ID bit here before we event attempt to
> continue? Otherwise if we compile the test with headers where stx_mnt_id
> is defined then run it on old kernel there will be garbage in the
> stx_mnt_id field.
Agree.
>
>> +	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
>> +
>> +	while (fgets(line, sizeof(line), file)) {
>> +		if (sscanf(line, "%d %*d %d:%d",&mnt_id,&line_mjr,&line_mnr) != 3)
>> +			continue;
>> +
>> +		if (line_mjr == buf->stx_dev_major&&  line_mnr == buf->stx_dev_minor)
>> +			break;
>> +	}
>> +
>> +	SAFE_FCLOSE(file);
>> +
>> +	if (buf->stx_mnt_id == mnt_id)
>> +		tst_res(TPASS,
>> +			"statx.stx_mnt_id equals to mount_id(%d) in /proc/self/mountinfo",
>> +			mnt_id);
>> +	else
>> +		tst_res(TFAIL,
>> +			"statx.stx_mnt_id(%d) is different from mount_id(%d) in /proc/self/mountinfo",
>> +			buf->stx_mnt_id, mnt_id);
>> +
>> +	pid = getpid();
>> +	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>> +	TST_ASSERT_FILE_INT(line, "mnt_id:", buf->stx_mnt_id);
>> +}
>> +#endif
>> +
>>   static void test_normal_file(void)
>>   {
>>   	struct statx buff;
>> @@ -106,6 +146,11 @@ static void test_normal_file(void)
>>   		tst_res(TFAIL, "stx_nlink(%u) is different from expected(1)",
>>   			buff.stx_nlink);
>>
>> +#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
>> +	test_mnt_id(&buff);
>> +#else
>> +	tst_res(TCONF, "stx_mnt_id was not supported until linux 5.8.");
>
> This is confusing at best, if we end up here we were missing the
> structure member during compilation regardless the kernel version.
>
> So this message really should be:
>
> "stx_mnt_id not defined in struct statx"
Will do it in v2.

Best Regards
Yang Xu
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
