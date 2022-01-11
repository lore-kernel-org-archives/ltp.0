Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0904AC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 05:34:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CFDC3C93BC
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:34:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCA1B3C0F6A
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:34:42 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2086F14010EB
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641879283; x=1673415283;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nSqsCe94U2oLfJDXcJK0LBI4K4cHGbq4XyeFtT6fV4I=;
 b=R2ox8cSEDrzNp1EONG25R1039dwAIN8Mw9a0RPTU6cfYd1Buz7TebQjH
 HR6XpIvflsaw2PmJmPuct1jqY13KaTvaKrcaYCwWMHCuCXHYT3vcfgr5i
 f5jsk363EEM34MIF43ETHkKgJfAg4m2unLfWsX27rjafiBo0w5W/9b1ur
 5fE4dzWIMuBbOnXLWjR2Mb2y7vB5UszPs5GhiqH1JzN3o56z1O92HRu/z
 Rwf8xeGt1yJfjY2g4G7kZsXz2ERNBSlj05MK3+SgCJc7N4wvQKQPW9WgT
 qp1eDSeMMvV8h5ZNK5r2FFDgvVNbkHEu03x3BrrULIgzRlVPbNshdcfto w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47205522"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; d="scan'208";a="47205522"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 14:34:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKFChm9gny4jjU7Lx9LaDcD/1vssn4nTDTEDxJHSyBrcy/tkU+k05PqKjzzpss02xiVzOg2nhkS4Q1YIgmDd6PAETn5pMxzqI1N3WwmW2i3EVBC9LRXaOEkF6Ysl4s9ouAIJplYTbgxzamf0/S43e5azN5LsfNJh8+xvmc90N5/mPQC6+Lurg3Mgi1+t/bDCVLWg9bkswgmFp5l78XvaWKEJNrUeh+71JUTKOFzo/MfQT6di2GWNV1z5NX/sUgSdgvBUp/HpPbOL5YZ4pAy7Jk7tTJdWGbjsWl3BULpKlEaOp4IJeaUKtW4jbE8fRsz6pv60JhAg6hr1cRVtO78vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSqsCe94U2oLfJDXcJK0LBI4K4cHGbq4XyeFtT6fV4I=;
 b=gy5t+4wY7w5QWvF85azA9fHd8jLdjVY3FHoqQloDir2r6LzIJS4SD5k0nBhMVmosOD3Ti0zUBeeVBMswTto0pfSg9H1cbawyrFM2WOedRoj1jUmVzXdAAXTC8hYZtwtP6Lvl0MenI0AtW+Np0q+yP8lHxqyUjG3oxwxcTqKqxrnJsx76aO4eN6H0h3Gd911RGOjRqeTaRH+QyuJ7gsSnfrjjyfOXJ8vF4p3G0lC7l1YaimxnhdkwP91IzxfXIBZFSYICJGhiZ4auKuWqVE0U8gx8h5h2cL9AT/o6jMloRmCLCho8HKNti1mJV4Q5ZIvEfb3laSDzTMM2OhdGjPXJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSqsCe94U2oLfJDXcJK0LBI4K4cHGbq4XyeFtT6fV4I=;
 b=hG24D2pT/B5olB8YAbBBjBxP2a2AejvaDlhWXWBkxunmeujUTwT1DN9OUIeERDoUsf6JABwbe69hke0lTlKDoeyOMLmEq5oK/UYRRDGO7K2mFBR/aW+5v+7Qg48P2P+zE7mOyE+8I0wWZxvUjjEaHABun2v/0N85xDI2RZEAJ/8=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5305.jpnprd01.prod.outlook.com (2603:1096:404:8034::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 05:34:37 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:34:37 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 4/4] sysctl/sysctl02.sh: Use kconfig shell api
Thread-Index: AQHYBeiy7Qqr3boZRkCDw+zjypNwc6xcTTuAgAEBB4A=
Date: Tue, 11 Jan 2022 05:34:37 +0000
Message-ID: <61DD171F.1020801@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ydw/g77bnGd1G/9I@yuki>
In-Reply-To: <Ydw/g77bnGd1G/9I@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214788e8-0e34-4f92-6dbc-08d9d4c40eb7
x-ms-traffictypediagnostic: TYAPR01MB5305:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5305090F835382E6EC7B5DC8FD519@TYAPR01MB5305.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2iKp8zmyBofSiDuSSSnOacLTdmI8jPBQ61UGrDPQnW1qaUPbnMTl9yWj6fce9KwBFmF3rwpX1cZQfwOT9f6NNPh4QCutI3HvKcF/e3Pif+TSYWWS4KtVAuHayNwBWHJL5himp3GX6URkw60tAXo/qoakByX+hDLvMQRrCiuWD7PJh/OkbuMIxekGgvgePbZSujAC73DUIXRZFyaGtpTvBAR1pMGHYeA+vsV1tL57f19GW4deDazv8is+mN0qiC1/z81U5sthOpbJ8oisvPH2vZAWPUPbgxfQpEMF9BcOJp9cXbJJGiQ8n+6ApyX6NyMX5QmU4wjZ3AiZ1ksgSp3/Kz2zIaue9igEW9om4Flaqkl79D+mq1NP3T72bJeSNMkbdBEj8kYeuugWdHB+suTO1lzHepj86jCHrBgovC2LbIfhhevlqpvfjZE6IgFqdh7NrPWUQUZmlvClTwHJihg1j650pKktDavoqXUXkjruQBnXWO4vy4svDb+PhnCpXoObwdlXyQSvrVY4cDh8SZCsG7cuMXzI5YznoRS4LrFGnUwSAqjMJcC/1pBsl9+WcBdlvcicF7yi+rbSQkAkyMt4mFjmp7B8Zut1b0K1aITMc7+pM+aQcuVjqQ2YYDtK5at0NO0FCE0pHVaIakTrmhsOTRNGPvsDX/JCj4GaWUWGu3NTrtSy6FsqGmetQwS2Efzi6ApS8EMlucssAJQjWLWSeSt9HiWylfUVhg1nicBFc65xp4JV4xFbx1ubUhoQyxHrxnqn8VKQbtBbq0i9FTzrBCjiwwik+/PzdXtDGvCU/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(66476007)(66446008)(508600001)(66556008)(6916009)(64756008)(186003)(36756003)(122000001)(71200400001)(4326008)(6486002)(966005)(8676002)(66946007)(2616005)(85182001)(76116006)(82960400001)(316002)(26005)(2906002)(33656002)(86362001)(83380400001)(38100700002)(8936002)(5660300002)(91956017)(38070700005)(6506007)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MEIrUEwyYUdOZlg3QnIrOHRybzl6R2tQSFlKTFBBTy9taVVrcnFYMTgrMnFZ?=
 =?gb2312?B?czJxZFI2djc5b3F1bkVqbVhNbkoxY0E5akdwZkE2NGlmVU02R24xN01mM3Fz?=
 =?gb2312?B?bk0wWnEwNEM0UnNKbXhnRndiZkN4b09mdStKbXd3VWtVbFdwdmxCZitISXkv?=
 =?gb2312?B?VTh3MjlGVjhUbDUzTXo1TlZ6UHBDL0ZEeVdRT3JsSUtJbzdFY01ZdUh6bUFM?=
 =?gb2312?B?bmQrdGJtMXNVZ294OWtiZHY4THp6dmo0RGpoRkpLbVhpQ0VEbGdnRE55dVk3?=
 =?gb2312?B?akozMzltYi9kQ0c1RFlDYkR5MGJWeVRDS1dCMkxVei9CQmdIUno0czRIN3dk?=
 =?gb2312?B?NDBocHUzK1hZZXpwcC9HK2hDSWJIakRqVU8vVzJ0L1hkZjVBUUUzNGFLVktq?=
 =?gb2312?B?b1hFVHNKNVJaQ1ZpT3lWT3NvYnlKLzJDR3lhVGFUYWVQMzdMVDBRdmhXemVJ?=
 =?gb2312?B?WHY1U3Z6WFhkSVZHMlJLTDQ0bWRlcEZFeGY5SzZlOXFqcHBETDVQWkpoZmJ3?=
 =?gb2312?B?VVBLcE01bWQyL1BXUElBTzZIdHptdVEwTUdsY0FqTmFIdUR3eGJLQWxHb3ps?=
 =?gb2312?B?aWpONm9rVXJSMy9hSTBSK1QrcXBEZ1RuaSs3WHhOU1FETkdMQ2dQbVdENEVv?=
 =?gb2312?B?dVVvY1dlbXF6SWJiNHMvSWY1WG04dnNMY0NJNTVrUW9PWGhyTmRVSVVGR3o5?=
 =?gb2312?B?TEF1UUhzVkhiY0ovR3hWMnRYODErZmZGK3p2dVZKK1Exa1hGanR2MjV0SGhO?=
 =?gb2312?B?d0FjVktmaHpRVkxwb0xGR3Bya0tGRXZUMWVDb2RxTmJ4d3VPK3F1a0NGaWZa?=
 =?gb2312?B?TC9KSldSbmp1dXJhUTZpYnc5WldOY3AzajNNWlhhM00yVmxYNWZ6S2xJaE5Y?=
 =?gb2312?B?T0NMQkdvRVBNR0Fib3ErTGVEcnRvMm16eGc0Sm9xelorRFhNdTJaWkdqMXlT?=
 =?gb2312?B?R01RdFFpb0xlV0RPeTlxTnNJU2xzTTZHUk1tMVFKLzNJYkVBZHg4Qm15NDMx?=
 =?gb2312?B?eXFodzFHV0ZQYVduTWtTYW00NVF0QUk4WHcrcnNsK1U2YmZwYmcrOCsxRkZs?=
 =?gb2312?B?RGxvUFoybkNaR2NFcGRSQ241Ti9EK3FEOEVDYTV3VXUyUmd2ZGZCNEJtdnlu?=
 =?gb2312?B?RHlieEd0NUdDbXZCNjVYb3MxQjIyTVphd0Rhd1pqbkEyNXBoNW9LbEF0Mnd4?=
 =?gb2312?B?MVFUM1haZ21NOWZ3OGVEbnpaQzhDOHNrUjgxZStYb2pyRlFGVytqS1VoTmht?=
 =?gb2312?B?YnVZaXlxZXRKclBoSlZDTDdMVzUzMUYxNWlYQUFsUXExV0FGeGtUbGZPbXEr?=
 =?gb2312?B?VW9uZ3BFUnB2cjZYTmtOaTFWRTJKYmdlMHY2ZUhCNDFwem1wekhZY3RYckh1?=
 =?gb2312?B?NGtZWEZYM2JrN3NaSEg1UmJVNWpJQlRqalI1M3JCcDF6VDlLQmJCK1RvWk52?=
 =?gb2312?B?TXRvMmRRT3RJMlA2c0FuY0VncTVuYTFndjA5RHFOdXpEcUVEbHRYaWMyaXVW?=
 =?gb2312?B?bnZuYWszeFJKMUhHa2piWnRXc2w0UGppWWo2MVNNVGh6RytUcTRvdGptRnJy?=
 =?gb2312?B?eSthNnJZVk1NSHJMbGhpRWZMT1BzN1NKQlNhakdrejZEWEozcm5EKzdNd0dq?=
 =?gb2312?B?bVd3bmRhM3hvb05iYW9Xa1VBdWszUUNsN2JoMVYveXdqZVV0T01VZm1qMHBC?=
 =?gb2312?B?aUp5MVpOQlI5MTdKYmZPdHpBR3RNSENkNVFQb2FRU0IwbCswM0s2ZCtqejc4?=
 =?gb2312?B?TFljWFJ4QUxqZEltM09lUU0rcjhJVjhXWThpMFBsQnJTOEljSEVlcEtNK0RN?=
 =?gb2312?B?MzFycmZWWDlnVjNreSt3a0ZXdStaeFlaVENtOVp2a0FyckJyTElPd3RvYTkr?=
 =?gb2312?B?TVZ1NGI4S3RGU2lXaDRpTmdyamUyNnBjWUJTYlhteDhuUjFpN2Q5enBGVjZ3?=
 =?gb2312?B?YjYyV002MVBMbFNiUCszK0ZsaE5sdDhsRGkzczdDMUk5emRHOWdEZmhrcHFX?=
 =?gb2312?B?TmVzOU9GM0gwcjROQ3VqMUlEK05MRHJZeHVvQjE2WUs2RFVRSVlmMUFhRWE0?=
 =?gb2312?B?UVdBRTVESUNqaUcybitVN0xvcmU3QmZLSGRUYkowR3lQREc5MVM1T2VtajdM?=
 =?gb2312?B?MnRPclJIMFg3MGl1UktDem1xeFNnR0NvN3dqTzNCRjE3RWxBelBneFdGQWdk?=
 =?gb2312?B?Vi84WkdXREwyRUxMN2tLQ1VsT2tyTFlhYllXcy90SWNxVXdoUjI0NnRJeWpG?=
 =?gb2312?Q?NxehfF3JGCRVgE/jOCG1pC38sHjZTOzxF+Ozq+/+sU=3D?=
Content-ID: <A907F4E50E2D324685BD8B2CC5933C12@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214788e8-0e34-4f92-6dbc-08d9d4c40eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 05:34:37.4904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2ykoSiAIyDG7d2TAUvEXADLKdsHLkV84530gpnQnxtEwEyslk+crsx/0rOB8mZVI1DgCOCD6nnwHDtQyoILyv53cN/aMeksN/Y1RFBCFCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5305
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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
>> +	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
>                                 ^
> 			       This should be a single string now,
> 			       right?
Yes.
>
> 			       Also we should pass the delimiter unless
> 			       we change the tst_check_kconfigs default
> 			       to ',' if no delimiter was passed (which
> 			       sounds reasonable).
Yes, I have modified tst_check_kconfigs and tst_require_kconfigs api, so 
if no delimiters was passed, tst_require_kconfigs will use 
$TST_NEEDS_KCONFIGS_IFS, tst_check_kconfigs will use comma.

Best Regards
Yang Xu
>
>> +		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
>> +
>>   	ROD sysctl -w -q $sys_name=0
>>
>> -	if grep -q kasan_report $syms_file; then
>> -		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
>> -			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>> -		else
>> -			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>> -		fi
>> +	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
>> +		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>>   	else
>> -		tst_res TCONF "kernel doesn't support KASAN"
>> +		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>>   	fi
>>   }
>>
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
