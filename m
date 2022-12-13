Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3257FC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 03:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49F9A3CBE87
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 04:31:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62D363CBE07
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 04:31:41 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D25231A005FF
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 04:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670902299; x=1702438299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GlvQyoCF2iZVXx2VWsdlYE2Z1FMzVbbD4euWDYcwifI=;
 b=m159WvkPasNMh3vwpG3zTP7lCdjpEZwYms0+tWQ/Y2kH6glUfFrlKoCJ
 9MonM8PcBBQsTPgGJbN6HiioqGq2H8/JZzVL76tezVrSRLO0vFH8zOHnQ
 3X/j7snql+9lfAPm3Y8y+wFDjYRclAlRiqY5DOOsemRPCt2EuhiQQkwU/
 K1A+TkioNS+ghuSdSg6en1ZqkVLeo2uyrJmSqCMJlRGaL5KNDHRnaN8dH
 6xiQJAyzO6tKTnbVuyMupSvxvuJIK3L0gxPMnmbNlj04rA89dSFN5iu1q
 Ifv0b7u3D+QB76fih+b3PtNo00WKcRkoIIrZ9zOEZrUh2rUjWjgZMEWA5 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="72183546"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="72183546"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 12:31:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUqvtZUMgVN0BveriT+L4OKLpx4timGPJ1so9LKMnrZ0ADW+omIoCxPP2WlnkCDqBRSgSQtpwK0xokGAeAhiB/+DrGxq2sz2snEl8AEpeb+Cv3Rfuh4obvsxrSaebpsEsGJnpQElvZzcnZQezeeTiqGTeuc9t2ueKkiMTqIYyU0HW9oIUln71k1uP3QSvGlWFFy1JApZHZBIvzjxE+UBdk0OgFxmheOiGEDkz3vo/qy7UEw8giPIUNnP/ilFohnB3jjlVJC//UIanpJgu8QSvnLNZ8688cYjdAQnCoOi9I3FD6w1U/rWaiWTIssDsgH3pqcFdfNfKh00zqNRXDXuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlvQyoCF2iZVXx2VWsdlYE2Z1FMzVbbD4euWDYcwifI=;
 b=nSWxckRqGIepT164qsyfGBKazXsRe2jYGu4RJiCde9vf4wq7/DG5r4TTXgvKy3raZC9WFFK2bK56dbAAmbEKrnQFfVSTMpXzp0ARRz9ShewKuDgdCdno2wvz7KiTmdbR+XVD6kXtcMC0yVkQe0UZ2DKGZw4y02aBYILpTcjcQXo4DxcaZ0bcYLjOZuc3rU6NsABtGWXy7jatNsAajHPpw6I7iY34pWqCGwcKhlSQShwOMMrxtO0cRCxISmNVzYEm4imcH4J2C5Behw8Hr7Yvn4nPkJ466b8177lNeWJs05PPuVOc42GcBRAJymcYu3N/+4zdeZjVy5BtZtp+1dkxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 03:31:31 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 03:31:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 3/4] Remove old kernel version check in C case
 when using tst_kvercmp
Thread-Index: AQHZDhYTuF5/XeWGQEu5ZFOAKAGkNq5qY30AgADYOgA=
Date: Tue, 13 Dec 2022 03:31:31 +0000
Message-ID: <b632ce5a-31de-fe01-73f3-e1fbedd8cbbd@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1670845229-1981-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dLCmw1w8584W/D@pevik>
In-Reply-To: <Y5dLCmw1w8584W/D@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB6040:EE_
x-ms-office365-filtering-correlation-id: 8647dc1b-c33b-468c-4548-08dadcba86dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqNjR8R0KH1f4sxkoOJUPe6HZCuL0ablzORrvo1niZpQbyaoimGC9haMRaLKUR8PcmHqpSPuVuK4GyN4ajwLQ89+qZFPrcjWFmFeB6LaW1Pe5I5z+/IsAoNLgrdGKFhTB4jSMC+oG0LKe94Blt4+FiK4ElAnomLHmLbr1I8wbv0bBD6/noUIViK9g6GjZ719gc8oFD1d08LfHnLjQ9/qBJLCNVzw3OVLTcB2+1s3zWcEjlOt6vXTn5HUaEvcWL6yOJg5UJEMurV25UJYg2Vr4xfMEjySEUpkDI4lTF/VW3Qh/NeeIzoOa+vBHXjs8WCA9NkJ/WsYYq0iEba7bluxdVcvjruGm3Sl/wxeef1rNaUQELViN+vOFcDpmLOm+S7cgm9vRMqBmi6cjKPpuEE2DpyhjAe7S8JKBuVI0MFO3s05APYTFdyDygtCDRCidFt5j4VqYVpfkjen4id/4P1JsVWDLe5/PuxvSa9zkCGvL/2OuQehoJkyCR0cH3DeJgkmEM2UgsFiOsrDjhjRFUb3uLMdbJoOs15C+LHa4g1KE4qvIOp1U/+QBjLJc8T2t8duj9vIB4oQEmq5XLEsvGp8Cqz+BDX+vlDrH7SHYETVjwMgDHxunnOTx5rvLCrfUFS4lh+7+Quv3Pd7cex4lA/PwpvW/TYhbGWKgTa7IlYHy+MeIwkheNznazHrhsbJ6/v8a2E8wgo+P5Bh5BcHG8DcUS/ZDTdU5Wr+2GpkTHuX1UKKi6hBBfz3078nRTDXSCzqqd0lXFI3ZQxTYr22OXmppPm0gXO1eS+cwAMkP6fbT/s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(1590799012)(38100700002)(122000001)(83380400001)(31696002)(86362001)(2906002)(82960400001)(38070700005)(54906003)(76116006)(66946007)(66476007)(41300700001)(66446008)(66556008)(4326008)(8676002)(316002)(6916009)(8936002)(30864003)(5660300002)(2616005)(186003)(71200400001)(478600001)(966005)(6486002)(6506007)(6512007)(31686004)(64756008)(26005)(91956017)(36756003)(85182001)(1580799009)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ZvV2c2a3VITWE2NTlXT2NHUHJ6R0kzWXZWY1lVbEgyTms0ajFwNDlXU2po?=
 =?utf-8?B?M3JhY0luaTMrdU5Ic1M5TVVQMmZZTVN1UnZhdjZEVHZ4RWwveXdDTmJIZjR1?=
 =?utf-8?B?T0EyN3c2M0ZSYmh4NFJNd3p2bmhyY2FnaGVRc0FTUVh5T0pUbzVlL0FDWUg3?=
 =?utf-8?B?Z05Ya3dFM2dreHZ1eWc3MWdHZUtqa3RLU3M5SXpCOHdoS2ZwMGV0a3F4bGFm?=
 =?utf-8?B?WkY3MmpmVkVza1VmT3JzUVgxRDFoaWZUUVI3enZlVEFqQ1NRSjJKejJqOXZV?=
 =?utf-8?B?ZG5FZnZFKzc1czVlV3diVmhXZkRZam01Ylo3NzdRSCtmR1Q2YXBoTDhIY1d5?=
 =?utf-8?B?K2ZSeGdudGRZV0xLZzZRTGxMYXg5amFHcGRLZVJsRUNlcXFVQ1pEK3cwWldR?=
 =?utf-8?B?NE51dWFtcy9ScFdxWk9OTTVpYkMxeGtyRE9wK2xKeUlPOW9CWU42NGV0d3Mv?=
 =?utf-8?B?R0hNSkN0TnNSM1g0OFAzSWNZaFFuTGFqTlZGeEJQdTJjNThIZzJaNVRhVEZ4?=
 =?utf-8?B?R0lHVk5kTEYzWDhSY3cyQzFVYUU5bFRGOE5tSFNEU3JzUlE3NUxHZVhxa2JC?=
 =?utf-8?B?ZzhwTzM0UlMzNHpZWEpaZ3NFRE5IWER5Ty9hZ3NzbDVTdkY2UlBOSFVLMnlS?=
 =?utf-8?B?UFRHQUJwSWtQNlhhRVJXcm9pWGJheEZodnRSeG1hdFlPOERBTGlqbUM2UElQ?=
 =?utf-8?B?d3Q5VXdhQ0hTMEl6eUhLOU5EU3FDYzduNnBrUDdueXNDNG1mTWNLclB3SDdj?=
 =?utf-8?B?akZNSFhKb3prZ1ZCRE90ckVyNWdYcWQ4VDNaQUg5MlJJekFUUlMrMEY4TWdv?=
 =?utf-8?B?Q0VscE5rQXNzS3JQUENNcW1hazBFbXU1UGNZd1YvZXR2Q09ONFRHUU1OSFEr?=
 =?utf-8?B?SzM4bDAvMEQ5ZTFrQm1BYUdSeEltVDE2SDNkQ3ZLREs2YU1lTXhIejl2cFQx?=
 =?utf-8?B?T0piZVQ3VGllOWtoOW96a2RsUFpCU1FLWXUvUllrcm42blY3L3ltNXRvSmwr?=
 =?utf-8?B?VDFNNXZFSG80VHl5dVlVTEZkUW0yaEw4Q2tXVDBHamh4UytEWEEvelRsK0Z3?=
 =?utf-8?B?Nmk5emo3VDQwTHZNMzgxRndiWlUzZUNjRG0xUDI0WEtEdU41WE4vWWhZeXdx?=
 =?utf-8?B?WVdCVFJEVkttajFHcnJ5OTJBTHYrMUlVTGRod2lQK2FtNFJGdlRXNHkxTFdq?=
 =?utf-8?B?NTNxY2pTanF4UVVLNkZTeUxSb1lqbHFGN1VBQ2E2TmpBUndGYjFQUWZ1ak9E?=
 =?utf-8?B?UmtsOXM2VVJTVHM4aHRxOEtDcDZtQzVxNC9YSkxsMXJTaEMySkJBVUVlWHBz?=
 =?utf-8?B?MTQ2elFqaDJsUmo4bzVsQ3IzQW1VekJpL0dtK2FiaUsvWWZ6cDByditlc2FQ?=
 =?utf-8?B?MzBpUXZWUW9adG4vNnM4R0ViSktVREMvdWM3UHVienFRc2ZvV1V1TkpYVzNT?=
 =?utf-8?B?Vjg2VmI1Mk04citTN1ZXdDF0dEN2dk5jRlN6SmRROWIwb0tQVmh3L3dxdTE3?=
 =?utf-8?B?OC91ODlGRE5tSndmeDNZQjVtaThVczBjM21OM3prY2VQTjdTcnFubVJuL2hp?=
 =?utf-8?B?NlA0YTVENzlnOVZuL3RWU3VHcWV4Y01QcEVQWVFzcFFwbTFkSi9lTnZscVpo?=
 =?utf-8?B?NjZwdU0wOEtJVkZFb2NXL2hWTTV2azE3RXBDY0IrYmdZWGRaeG9KTFhJNm1s?=
 =?utf-8?B?ZmptNDJmVC95Q0R3SzQyZW9PMzhYU09DS3BLb3VZQlVJWDIxcE5aY25LOGMx?=
 =?utf-8?B?TjhPQ0JRejMxQVE4eVI0MmRjcG9jU1Ztd1huQnAxRWJzL2M4bzlzMmJzSFpr?=
 =?utf-8?B?Rnp6UHdsN3NrUXFDcndGNlliR093OHdGbGVUNGpUdHo1VDFUL1JDUVk2L1do?=
 =?utf-8?B?VkJHYjArU2QxWTdQRUJIS3dubFFtQ2RwYUZoTU1aVnlNRXRKaExjMlhKMTdY?=
 =?utf-8?B?YWtXUm1yWDFPdGpIOElqc0hGZGE5SmJNNTRVTXVKSktkQXNlSTVidnpBalZZ?=
 =?utf-8?B?YkJYc1VJWlBSc3JUdzkxSzlvWEZQRVdBclFDNVRJK1BMV2xwc1VGeG4yV1V4?=
 =?utf-8?B?L2MvbDdqUGpaOFNBbkJIYU1ybkViazJQaHY5YVF2Wll0c1dtU2w2ZzZQajkv?=
 =?utf-8?B?eFVVWE5ydy9mYXdQeXRCR2VuaFNoTWRYd09Beko3NlVMRHl3eFhkdjY0UHpB?=
 =?utf-8?B?OFE9PQ==?=
Content-ID: <45521F4E0BA0B84EBDD2C73688D0FEA8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8647dc1b-c33b-468c-4548-08dadcba86dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 03:31:31.0866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZD9U1e3zg3vX4dDCnK3LaO5Kv6v+W2ON18pU/GKlpGTgYlsXbad065NiMq0HZ1Hb7ePcSsvazXXNorNCN3jKTfLmC3S9VjRdxMkTM7dRpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/4] Remove old kernel version check in C case
 when using tst_kvercmp
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Xu,
> 
>> The oldest supported kernel version is 3.10, so remove them.
> Well, 3.10 is the oldest *tested* distribution [1], the document actually does
> not state what is the minimal supported version. If I remember correctly some
> time ago we agreed on ML on 3.0. 

Oh, yes, sorry, I misunderstand the old *test* distribution as the 
oldest kernel version.
It has been two years since we agreed on ML on 3.0.  I think it is time 
to raise to 3.10

>I'm OK, if we raise it to 3.10, but it should
> be stated.

Yes.

> 
> Also Cc automated-testing@lists.yoctoproject.org, in case somebody is really
> using new LTP on very old kernels (I hope not).

I will CC automated-testing@lists.yoctoproject.org on v2 if we all agree 
raise it to 3.10.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/common_timers.h                  |  5 ---
>>   include/lapi/init_module.h                    | 13 ------
>>   .../kernel/containers/mqns/mqns_helper.h      |  3 --
>>   .../kernel/containers/pidns/pidns_helper.h    |  3 --
>>   .../kernel/containers/userns/userns_helper.h  |  3 --
>>   testcases/kernel/containers/utsname/utstest.c |  3 --
>>   .../controllers/cgroup_xattr/cgroup_xattr.c   |  5 ---
>>   .../kernel/device-drivers/acpi/ltp_acpi.c     | 20 ---------
>>   .../block/block_dev_user/block_dev.c          |  5 ---
>>   .../device-drivers/pci/tpci_user/tpci.c       |  5 ---
>>   .../device-drivers/tbio/tbio_user/tbio.c      |  5 ---
>>   .../kernel/device-drivers/uaccess/uaccess.c   |  5 ---
>>   .../kernel/firmware/fw_load_user/fw_load.c    |  5 ---
>>   testcases/kernel/input/input_helper.c         | 18 ++------
>>   testcases/kernel/mem/vma/vma01.c              |  8 +---
>>   .../power_management/pm_get_sched_values.c    | 20 +--------
>>   .../security/prot_hsymlinks/prot_hsymlinks.c  |  4 --
>>   .../kernel/syscalls/adjtimex/adjtimex02.c     |  2 +-
>>   testcases/kernel/syscalls/clone/clone08.c     | 43 -------------------
>>   testcases/kernel/syscalls/eventfd/eventfd01.c |  3 --
>>   .../kernel/syscalls/eventfd2/eventfd2_01.c    |  4 --
>>   .../kernel/syscalls/eventfd2/eventfd2_02.c    |  4 --
>>   .../kernel/syscalls/eventfd2/eventfd2_03.c    |  5 ---
>>   .../kernel/syscalls/faccessat/faccessat01.c   |  4 --
>>   .../kernel/syscalls/fallocate/fallocate04.c   | 14 +-----
>>   .../kernel/syscalls/fchownat/fchownat01.c     |  3 --
>>   .../kernel/syscalls/fchownat/fchownat02.c     |  3 --
>>   testcases/kernel/syscalls/fcntl/fcntl29.c     |  4 --
>>   testcases/kernel/syscalls/fcntl/fcntl30.c     |  4 --
>>   testcases/kernel/syscalls/fcntl/fcntl31.c     | 32 +++-----------
>>   .../kernel/syscalls/fgetxattr/fgetxattr02.c   |  8 ----
>>   .../syscalls/finit_module/finit_module01.c    |  2 -
>>   .../syscalls/finit_module/finit_module02.c    |  2 -
>>   testcases/kernel/syscalls/fstatat/fstatat01.c |  3 --
>>   .../kernel/syscalls/futimesat/futimesat01.c   |  3 --
>>   testcases/kernel/syscalls/getcpu/getcpu01.c   |  7 ---
>>   .../kernel/syscalls/getxattr/getxattr02.c     | 11 +----
>>   testcases/kernel/syscalls/inotify/inotify02.c | 15 -------
>>   testcases/kernel/syscalls/inotify/inotify04.c | 14 ------
>>   testcases/kernel/syscalls/ioctl/ioctl01.c     |  8 ----
>>   testcases/kernel/syscalls/ioperm/ioperm01.c   | 11 +----
>>   testcases/kernel/syscalls/ioperm/ioperm02.c   | 15 +------
>>   .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     |  3 +-
>>   testcases/kernel/syscalls/linkat/linkat01.c   |  6 ---
>>   testcases/kernel/syscalls/linkat/linkat02.c   |  3 --
>>   testcases/kernel/syscalls/madvise/madvise02.c |  8 +---
>>   testcases/kernel/syscalls/mbind/mbind01.c     |  6 ---
>>   .../syscalls/migrate_pages/migrate_pages02.c  |  3 --
>>   testcases/kernel/syscalls/mincore/mincore01.c |  6 ---
>>   testcases/kernel/syscalls/mknodat/mknodat01.c |  3 --
>>   testcases/kernel/syscalls/mknodat/mknodat02.c |  5 ---
>>   testcases/kernel/syscalls/mlock/mlock02.c     | 31 -------------
>>   .../kernel/syscalls/mlockall/mlockall02.c     | 32 ++++++--------
>>   .../kernel/syscalls/move_pages/move_pages09.c | 23 ++--------
>>   .../syscalls/move_pages/move_pages_support.c  |  7 ++-
>>   testcases/kernel/syscalls/munmap/munmap03.c   |  7 ---
>>   testcases/kernel/syscalls/open/open12.c       | 22 ----------
>>   testcases/kernel/syscalls/open/open13.c       |  5 ---
>>   testcases/kernel/syscalls/openat/openat02.c   | 12 ------
>>   testcases/kernel/syscalls/pipe2/pipe2_01.c    |  4 --
>>   .../remap_file_pages/remap_file_pages01.c     |  9 ----
>>   .../remap_file_pages/remap_file_pages02.c     |  6 ---
>>   .../kernel/syscalls/renameat/renameat01.c     |  6 ---
>>   .../kernel/syscalls/signalfd/signalfd01.c     |  6 ---
>>   .../kernel/syscalls/signalfd4/signalfd4_01.c  |  5 ---
>>   .../kernel/syscalls/signalfd4/signalfd4_02.c  |  5 ---
>>   testcases/kernel/syscalls/socket/socket01.c   | 20 ---------
>>   .../kernel/syscalls/socketpair/socketpair01.c | 20 ---------
>>   .../kernel/syscalls/sockioctl/sockioctl01.c   | 11 +----
>>   testcases/kernel/syscalls/splice/splice01.c   |  6 ---
>>   .../kernel/syscalls/symlinkat/symlinkat01.c   |  7 ---
>>   testcases/kernel/syscalls/sysctl/sysctl03.c   | 12 ++----
>>   testcases/kernel/syscalls/tee/tee01.c         |  6 ---
>>   .../syscalls/timer_create/timer_create01.c    | 10 -----
>>   .../syscalls/timer_delete/timer_delete01.c    |  6 ---
>>   .../syscalls/timer_settime/timer_settime01.c  |  6 ---
>>   .../syscalls/timer_settime/timer_settime02.c  |  6 ---
>>   testcases/kernel/syscalls/timerfd/timerfd02.c |  5 ---
>>   testcases/kernel/syscalls/timerfd/timerfd03.c |  5 ---
>>   .../syscalls/timerfd/timerfd_create01.c       |  3 --
>>   testcases/network/netstress/netstress.c       |  3 --
>>   testcases/open_posix_testsuite/Makefile       |  4 --
>>   testcases/open_posix_testsuite/Makefile.linux | 20 ---------
>>   83 files changed, 48 insertions(+), 679 deletions(-)
>>   delete mode 100644 testcases/open_posix_testsuite/Makefile.linux
> 
>> diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
>> index 8d88ac47a..884c997a1 100644
>> --- a/include/lapi/common_timers.h
>> +++ b/include/lapi/common_timers.h
>> @@ -63,11 +63,6 @@ static inline int possibly_unsupported(clock_t clock)
>>   	}
>>   }
> 
>> -static inline int have_cputime_timers(void)
>> -{
>> -	return tst_kvercmp(2, 6, 12) >= 0;
>> -}
>> -
>>   #include "lapi/syscalls.h"
> 
>>   #include <time.h>
>> diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
>> index fe35ec3ae..650a9ddc9 100644
>> --- a/include/lapi/init_module.h
>> +++ b/include/lapi/init_module.h
>> @@ -21,17 +21,4 @@ static inline int finit_module(int fd, const char *param_values, int flags)
>>   {
>>   	return tst_syscall(__NR_finit_module, fd, param_values, flags);
>>   }
>> -
>> -static inline void finit_module_supported_by_kernel(void)
>> -{
>> -       long ret;
>> -
>> -       if ((tst_kvercmp(3, 8, 0)) < 0) {
>> -               /* Check if the syscall is backported on an older kernel */
>> -               ret = syscall(__NR_finit_module, 0, "", 0);
>> -               if (ret == -1 && errno == ENOSYS)
>> -                       tst_brk(TCONF, "Test not supported on kernel version < v3.8");
>> -       }
>> -}
>> -
>>   #endif /* LAPI_INIT_MODULE_H__ */
>> diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
>> index 605378d48..03f50aa36 100644
>> --- a/testcases/kernel/containers/mqns/mqns_helper.h
>> +++ b/testcases/kernel/containers/mqns/mqns_helper.h
>> @@ -36,9 +36,6 @@ static void check_mqns(void)
>>   	int pid, status;
>>   	mqd_t mqd;
> 
>> -	if (tst_kvercmp(2, 6, 30) < 0)
>> -		tst_brkm(TCONF, NULL, "Kernel version is lower than expected");
>> -
>>   	mq_unlink("/checkmqnsenabled");
>>   	mqd =
>>   	    mq_open("/checkmqnsenabled", O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
>> diff --git a/testcases/kernel/containers/pidns/pidns_helper.h b/testcases/kernel/containers/pidns/pidns_helper.h
>> index dad7a6d38..3b356768f 100644
>> --- a/testcases/kernel/containers/pidns/pidns_helper.h
>> +++ b/testcases/kernel/containers/pidns/pidns_helper.h
>> @@ -25,9 +25,6 @@ static int check_newpid(void)
>>   {
>>   	int pid, status;
> 
>> -	if (tst_kvercmp(2, 6, 24) < 0)
>> -		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
>> -
>>   	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWPID, dummy_child, NULL);
>>   	if (pid == -1)
>>   		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWPID not supported");
>> diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
>> index 2759d32c2..be47690ea 100644
>> --- a/testcases/kernel/containers/userns/userns_helper.h
>> +++ b/testcases/kernel/containers/userns/userns_helper.h
>> @@ -29,9 +29,6 @@ static int check_newuser(void)
>>   {
>>   	int pid, status;
> 
>> -	if (tst_kvercmp(3, 8, 0) < 0)
>> -		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
>> -
>>   	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
>>   	if (pid == -1)
>>   		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
>> diff --git a/testcases/kernel/containers/utsname/utstest.c b/testcases/kernel/containers/utsname/utstest.c
>> index d22db79c8..9ad19b6b2 100644
>> --- a/testcases/kernel/containers/utsname/utstest.c
>> +++ b/testcases/kernel/containers/utsname/utstest.c
>> @@ -69,9 +69,6 @@ static void check_newuts(void)
>>   {
>>   	int pid, status;
> 
>> -	if (tst_kvercmp(2, 6, 19) < 0)
>> -		tst_brkm(TCONF, NULL, "CLONE_NEWUTS not supported");
>> -
>>   	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUTS, dummy_child, NULL);
>>   	if (pid == -1)
>>   		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUTS not supported");
>> diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
>> index 71a03d12c..a870118f5 100644
>> --- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
>> +++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
>> @@ -150,11 +150,6 @@ void setup(int argc, char *argv[])
>>   	if (access("/proc/cgroups", F_OK) == -1)
>>   		tst_brkm(TCONF, NULL, "Kernel doesn't support cgroups");
> 
>> -	if (tst_kvercmp(3, 7, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 3.7 or newer");
>> -	}
>> -
>>   	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
>>   		if (!strcmp(tkeys[i].name, "security.")) {
>>   			tkeys[i].good = tst_kvercmp(3, 15, 0) < 0;
>> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> index f2dc6a4dd..7dba04552 100644
>> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> @@ -57,8 +57,6 @@ static int tc_acpi_str(void)
>>   	int res, ret = 0;
>>   	char descr[4096], sysfs_path[4096];
> 
>> -	int not_kver_3_7 = tst_kvercmp(3, 7, 0) < 0;
>> -
>>   	while (1) {
> 
>>   		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", ACPI_TRAVERSE);
>> @@ -86,19 +84,6 @@ static int tc_acpi_str(void)
>>   			continue;
>>   		}
> 
>> -		/*
>> -		 * Find device description in sysfs.
>> -		 *
>> -		 * New sysfs interface to export device description
>> -		 * implemented since Linux 3.7
>> -		 */
>> -		if (not_kver_3_7) {
>> -			tst_resm(TINFO, "sysfs _STR check required Linux 3.7+");
>> -			ret = TCONF;
>> -			/* continue, we can still traverse ACPI devices */
>> -			continue;
>> -		}
>> -
>>   		strcat(sysfs_path, "/description");
>>   		if (access(sysfs_path, R_OK)) {
>>   			tst_resm(TINFO, "can't find description file '%s'",
>> @@ -148,11 +133,6 @@ int main(int argc, char *argv[])
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(2, 6, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 2.6 or newer");
>> -	}
>> -
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
>>   	tst_module_load(NULL, module_name, NULL);
>> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
>> index 9e5e9c2c0..543c36795 100644
>> --- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
>> +++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
>> @@ -61,11 +61,6 @@ void setup(int argc, char *argv[])
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(2, 6, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 2.6 or newer");
>> -	}
>> -
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
>>   }
> 
>> diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
>> index 659c54261..96018f18c 100644
>> --- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
>> +++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
>> @@ -51,11 +51,6 @@ void setup(void)
>>   {
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(2, 6, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 2.6 or newer");
>> -	}
>> -
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
>>   }
> 
>> diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
>> index be1420b98..e882dc768 100644
>> --- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
>> +++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
>> @@ -88,11 +88,6 @@ void setup(void)
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(2, 6, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 2.6 or newer");
>> -	}
>> -
>>   	tst_module_load(cleanup, module_name, NULL);
>>   	module_loaded = 1;
> 
>> diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
>> index f7537ef4c..f682ff7f6 100644
>> --- a/testcases/kernel/device-drivers/uaccess/uaccess.c
>> +++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
>> @@ -96,11 +96,6 @@ int main(int argc, char *argv[])
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(2, 6, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 2.6 or newer");
>> -	}
>> -
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
>>   	tst_module_load(NULL, module_name, NULL);
>> diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
>> index e81d159f6..83648b625 100644
>> --- a/testcases/kernel/firmware/fw_load_user/fw_load.c
>> +++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
>> @@ -114,11 +114,6 @@ void setup(int argc, char *argv[])
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(3, 7, 0) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 3.7 or newer");
>> -	}
>> -
>>   	char fw_size_param[19];
>>   	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
>>   	char *const mod_params[2] = { fw_size_param, NULL };
>> diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
>> index c4736eadd..39ab29de3 100644
>> --- a/testcases/kernel/input/input_helper.c
>> +++ b/testcases/kernel/input/input_helper.c
>> @@ -249,27 +249,17 @@ int check_sync_event(struct input_event *iev)
>>   int no_events_queued(int fd, int stray_sync_event)
>>   {
>>   	struct pollfd fds = {.fd = fd, .events = POLLIN};
>> -	int ret, res, sync_event_ignored;
>> +	int ret, res;
>>   	struct input_event ev;
> 
>> -	if (tst_kvercmp(3, 7, 0) < 0 && stray_sync_event)
>> -		sync_event_ignored = 1;
>> -
>>   	ret = poll(&fds, 1, 30);
> 
>>   	if (ret > 0) {
>>   		res = read(fd, &ev, sizeof(ev));
>> -
>>   		if (res == sizeof(ev)) {
>> -			if (sync_event_ignored && check_sync_event(&ev)) {
>> -				ret = 0;
>> -				tst_resm(TINFO,
>> -					 "Ignoring stray sync event (known problem)");
>> -			} else {
>> -				tst_resm(TINFO,
>> -					 "Unexpected ev type=%i code=%i value=%i",
>> -					 ev.type, ev.code, ev.value);
>> -			}
>> +			tst_resm(TINFO,
>> +				"Unexpected ev type=%i code=%i value=%i",
>> +				ev.type, ev.code, ev.value);
>>   		}
>>   	}
> 
>> diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
>> index 31322918c..d220b636c 100644
>> --- a/testcases/kernel/mem/vma/vma01.c
>> +++ b/testcases/kernel/mem/vma/vma01.c
>> @@ -187,13 +187,7 @@ static void check_status(int status)
>>   		tst_resm(TPASS, "two 3*ps VMAs found.");
>>   		break;
>>   	case 1:
>> -		if (tst_kvercmp(3, 0, 0) < 0) {
>> -			tst_resm(TCONF, "A single 6*ps VMA found. You may need"
>> -					" to back port kernel commit 965f55d "
>> -					"to fix this scalability issue.");
>> -		} else {
>> -			tst_resm(TFAIL, "A single 6*ps VMA found.");
>> -		}
>> +		tst_resm(TFAIL, "A single 6*ps VMA found.");
>>   		break;
>>   	default:
>>   		tst_brkm(TBROK, cleanup, "unexpected VMA found.");
>> diff --git a/testcases/kernel/power_management/pm_get_sched_values.c b/testcases/kernel/power_management/pm_get_sched_values.c
>> index 32bacd789..e75c5852e 100644
>> --- a/testcases/kernel/power_management/pm_get_sched_values.c
>> +++ b/testcases/kernel/power_management/pm_get_sched_values.c
>> @@ -19,22 +19,6 @@
> 
>>   const char *TCID = "pm_get_sched_values";
> 
>> -int get_supp_sched_mc(void)
>> -{
>> -	if (tst_kvercmp(2, 6, 29) < 0)
>> -		return 1;
>> -	else
>> -		return 2;
>> -}
>> -
>> -int get_supp_sched_smt(void)
>> -{
>> -	if (tst_kvercmp(2, 6, 29) < 0)
>> -		return 1;
>> -	else
>> -		return 2;
>> -}
>> -
>>   int main(int argc, char **argv)
>>   {
>>   	char *param;
>> @@ -43,9 +27,9 @@ int main(int argc, char **argv)
>>   	else {
>>   		param = argv[1];
>>   		if (strcmp(param, "sched_mc") == 0)
>> -			return get_supp_sched_mc();
>> +			return 2;
>>   		if (strcmp(param, "sched_smt") == 0)
>> -			return get_supp_sched_smt();
>> +			return 2;
>>   	}
> 
>>   	return 1;
>> diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
>> index 369df2b22..20f33527c 100644
>> --- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
>> +++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
>> @@ -193,10 +193,6 @@ static void setup(int argc, char *argv[])
> 
>>   	tst_require_root();
> 
>> -	if (tst_kvercmp(3, 7, 0) < 0)
>> -		tst_brkm(TCONF, NULL,
>> -			"Test must be run with kernel 3.7 or newer");
>> -
>>   	if (eaccess("/etc/passwd", W_OK)) {
>>   		tst_brkm(TCONF, NULL,
>>   			"/etc/passwd is not accessible");
>> diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
>> index 747d83254..dab640ff3 100644
>> --- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
>> +++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
>> @@ -93,7 +93,7 @@ static void verify_adjtimex(unsigned int i)
>>   			if (tc[i].highlimit)
>>   				buf->tick = tc[i].highlimit + tc[i].delta;
>>   		}
>> -		if (tc[i].modes == ADJ_OFFSET && (tst_kvercmp(2, 6, 25) > 0)) {
>> +		if (tc[i].modes == ADJ_OFFSET) {
>>   			if (tc[i].lowlimit || tc[i].highlimit) {
>>   				tst_res(TCONF, "Newer kernels normalize offset value outside range");
>>   				return;
>> diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
>> index ad285a497..dd97f3ff1 100644
>> --- a/testcases/kernel/syscalls/clone/clone08.c
>> +++ b/testcases/kernel/syscalls/clone/clone08.c
>> @@ -28,11 +28,6 @@ static void test_clone_tid(int t);
>>   static int child_clone_child_settid(void *);
>>   static int child_clone_parent_settid(void *);
> 
>> -#ifdef CLONE_STOPPED
>> -static void test_clone_stopped(int t);
>> -static int child_clone_stopped(void *);
>> -static int stopped_flag;
>> -#endif
> 
>>   static void test_clone_thread(int t);
>>   static int child_clone_thread(void *);
>> @@ -57,10 +52,6 @@ static struct test_case {
>>   	 test_clone_tid, child_clone_child_settid},
>>   	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD,
>>   	 test_clone_tid, child_clone_parent_settid},
>> -#ifdef CLONE_STOPPED
>> -	{"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
>> -	 test_clone_stopped, child_clone_stopped},
>> -#endif
>>   	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM |
>>   	 CLONE_CHILD_CLEARTID | SIGCHLD,
>>   	 test_clone_thread, child_clone_thread},
>> @@ -147,40 +138,6 @@ static int child_clone_parent_settid(void *arg LTP_ATTRIBUTE_UNUSED)
>>   	return 0;
>>   }
> 
>> -#ifdef CLONE_STOPPED
>> -static void test_clone_stopped(int t)
>> -{
>> -	pid_t child;
>> -
>> -	if (tst_kvercmp(2, 6, 38) >= 0) {
>> -		tst_res(TCONF, "CLONE_STOPPED skipped for kernels >= 2.6.38");
>> -		return;
>> -	}
>> -
>> -	child = clone_child(&test_cases[t]);
>> -
>> -	TST_PROCESS_STATE_WAIT(child, 'T', 0);
>> -
>> -	stopped_flag = 0;
>> -
>> -	SAFE_KILL(child, SIGCONT);
>> -
>> -	tst_reap_children();
>> -
>> -	if (stopped_flag == 1)
>> -		tst_res(TPASS, "clone stopped and resumed as expected");
>> -	else
>> -		tst_res(TFAIL, "clone not stopped, flag %d", stopped_flag);
>> -}
>> -
>> -static int child_clone_stopped(void *arg LTP_ATTRIBUTE_UNUSED)
>> -{
>> -	stopped_flag = 1;
>> -	tst_syscall(__NR_exit, 0);
>> -	return 0;
>> -}
>> -#endif
>> -
>>   static void test_clone_thread(int t)
>>   {
>>   	pid_t child;
>> diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
>> index c24aa3197..9b60434a2 100644
>> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
>> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
>> @@ -720,9 +720,6 @@ static void setup(void)
> 
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
>> -	if (tst_kvercmp(2, 6, 22) < 0)
>> -		tst_brkm(TCONF, NULL, "2.6.22 or greater kernel required");
>> -
>>   	tst_tmpdir();
> 
>>   	TEST_PAUSE;
>> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
>> index c9ecdc58e..85ad86d42 100644
>> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
>> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
>> @@ -85,10 +85,6 @@ int main(int argc, char *argv[])
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
> 
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	fd = tst_syscall(__NR_eventfd2, 1, 0);
>> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
>> index 2125b528e..5f3b6ee67 100644
>> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
>> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
>> @@ -82,10 +82,6 @@ int main(int argc, char *argv[])
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
> 
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	tst_count = 0;
>> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
>> index e26714ddc..909004edb 100644
>> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
>> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
>> @@ -119,11 +119,6 @@ int main(int argc, char **argv)
>>   			return 1;
>>   		}
>>   	}
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF,
>> -			 NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	if ((fd1 = eventfd2(0, EFD_SEMLIKE)) == -1 ||
>>   	    (fd2 = eventfd2(0, EFD_SEMLIKE)) == -1) {
>>   		perror("eventfd2");
>> diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
>> index 1ab494e7a..d11e8cf12 100644
>> --- a/testcases/kernel/syscalls/faccessat/faccessat01.c
>> +++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
>> @@ -72,10 +72,6 @@ int main(int ac, char **av)
>>   	int lc;
>>   	int i;
> 
>> -	/* Disable test if the version of the kernel is less than 2.6.16 */
>> -	if ((tst_kvercmp(2, 6, 16)) < 0)
>> -		tst_brkm(TCONF, NULL, "Test must be run with kernel 2.6.16+");
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
>> index 568a9e3f1..ff372a9bf 100644
>> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
>> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
>> @@ -103,11 +103,6 @@ static void test02(void)
>>   	tst_res(TINFO, "read allocated file size '%zu'", alloc_size0);
>>   	tst_res(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
> 
>> -	if (tst_kvercmp(2, 6, 38) < 0) {
>> -		tst_brk(TCONF,
>> -			"FALLOC_FL_PUNCH_HOLE needs Linux 2.6.38 or newer");
>> -	}
>> -
>>   	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>>   	    block_size, block_size) == -1) {
>>   		if (errno == EOPNOTSUPP) {
>> @@ -126,13 +121,8 @@ static void test02(void)
>>   			tst_brk(TFAIL | TERRNO,
>>   				 "fallocate() or lseek() failed");
>>   		}
>> -		if (tst_kvercmp(3, 1, 0) < 0) {
>> -			tst_res(TINFO, "lseek() doesn't support SEEK_HOLE, "
>> -				 "this is expected for < 3.1 kernels");
>> -		} else {
>> -			tst_brk(TBROK | TERRNO,
>> -				 "lseek() doesn't support SEEK_HOLE");
>> -		}
>> +		tst_brk(TBROK | TERRNO,
>> +			"lseek() doesn't support SEEK_HOLE");
>>   	} else {
>>   		tst_res(TINFO, "found a hole at '%ld' offset", ret);
>>   	}
>> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
>> index a658f07db..3b29f1e75 100644
>> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
>> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
>> @@ -86,9 +86,6 @@ int main(int ac, char **av)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 16)) < 0)
>> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	TEST_PAUSE;
>> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
>> index 701623dd7..c39b0a919 100644
>> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
>> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
>> @@ -71,9 +71,6 @@ static void setup(void)
>>   {
>>   	struct stat c_buf, l_buf;
> 
>> -	if ((tst_kvercmp(2, 6, 16)) < 0)
>> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
>> -
>>   	tst_require_root();
> 
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
>> index 587476454..c94c9e748 100644
>> --- a/testcases/kernel/syscalls/fcntl/fcntl29.c
>> +++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
>> @@ -84,10 +84,6 @@ int main(int ac, char **av)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 24)) < 0) {
>> -		tst_brkm(TCONF, NULL, "Kernels >= 2.6.24 required");
>> -	}
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	tst_tmpdir();
>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
>> index 27f464389..c4c3f81f1 100644
>> --- a/testcases/kernel/syscalls/fcntl/fcntl30.c
>> +++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
>> @@ -93,10 +93,6 @@ int main(int ac, char **av)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 35)) < 0) {
>> -		tst_brkm(TCONF, NULL, "kernel >= 2.6.35 required");
>> -	}
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	TEST_PAUSE;
>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
>> index f6e2b01ff..f6f625e85 100644
>> --- a/testcases/kernel/syscalls/fcntl/fcntl31.c
>> +++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
>> @@ -45,9 +45,6 @@ static void setown_pid_test(void);
>>   static void setown_pgrp_test(void);
> 
>>   #if defined(HAVE_STRUCT_F_OWNER_EX)
>> -static int ownex_enabled;
>> -static char *ownex_tconf_msg = "F_GETOWN_EX and F_SETOWN_EX only run on "
>> -			"kernels that are 2.6.32 and higher";
>>   static void setownex_tid_test(void);
>>   static void setownex_pid_test(void);
>>   static void setownex_pgrp_test(void);
>> @@ -126,15 +123,11 @@ static void setup(void)
>>   		tst_brkm(TBROK | TERRNO, cleanup, "getpgid() failed");
> 
>>   #if defined(HAVE_STRUCT_F_OWNER_EX)
>> -	if ((tst_kvercmp(2, 6, 32)) >= 0) {
>> -		ownex_enabled = 1;
>> -
>> -		/* get original f_owner_ex info */
>> -		TEST(fcntl(test_fd, F_GETOWN_EX, &orig_own_ex));
>> -		if (TEST_RETURN < 0) {
>> -			tst_brkm(TFAIL | TTERRNO, cleanup,
>> -				 "fcntl get original f_owner_ex info failed");
>> -		}
>> +	/* get original f_owner_ex info */
>> +	TEST(fcntl(test_fd, F_GETOWN_EX, &orig_own_ex));
>> +	if (TEST_RETURN < 0) {
>> +		tst_brkm(TFAIL | TTERRNO, cleanup,
>> +			 "fcntl get original f_owner_ex info failed");
>>   	}
>>   #endif
> 
>> @@ -204,11 +197,6 @@ static void setownex_tid_test(void)
>>   {
>>   	static struct f_owner_ex tst_own_ex;
> 
>> -	if (ownex_enabled == 0) {
>> -		tst_resm(TCONF, "%s", ownex_tconf_msg);
>> -		return;
>> -	}
>> -
>>   	tst_own_ex.type = F_OWNER_TID;
>>   	tst_own_ex.pid = tst_syscall(__NR_gettid);
> 
>> @@ -226,11 +214,6 @@ static void setownex_pid_test(void)
>>   {
>>   	static struct f_owner_ex tst_own_ex;
> 
>> -	if (ownex_enabled == 0) {
>> -		tst_resm(TCONF, "%s", ownex_tconf_msg);
>> -		return;
>> -	}
>> -
>>   	tst_own_ex.type = F_OWNER_PID;
>>   	tst_own_ex.pid = pid;
> 
>> @@ -249,11 +232,6 @@ static void setownex_pgrp_test(void)
>>   {
>>   	static struct f_owner_ex tst_own_ex;
> 
>> -	if (ownex_enabled == 0) {
>> -		tst_resm(TCONF, "%s", ownex_tconf_msg);
>> -		return;
>> -	}
>> -
>>   	tst_own_ex.type = F_OWNER_PGRP;
>>   	tst_own_ex.pid = pgrp_pid;
> 
>> diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
>> index c3cff0aab..1a9a39c9b 100644
>> --- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
>> +++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
>> @@ -188,14 +188,6 @@ static void verify_fgetxattr(unsigned int i)
>>   				fname);
>>   	}
> 
>> -	/*
>> -	 * Before kernel 3.0.0, fgetxattr(2) will set errno with 'EPERM'
>> -	 * when the file is not a regular file and directory, refer to
>> -	 * commitid 55b23bd
>> -	 */
>> -	if (tc[i].exp_err == ENODATA && tst_kvercmp(3, 0, 0) < 0)
>> -		tc[i].exp_err = EPERM;
>> -
>>   	if (tc[i].exp_err == TST_ERR) {
>>   		tst_res(TPASS | TTERRNO, "fgetxattr(2) on %s passed",
>>   				fname);
>> diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
>> index 21c35f101..f960b2e40 100644
>> --- a/testcases/kernel/syscalls/finit_module/finit_module01.c
>> +++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
>> @@ -25,8 +25,6 @@ static char *mod_path;
> 
>>   static void setup(void)
>>   {
>> -	finit_module_supported_by_kernel();
>> -
>>   	tst_module_exists(MODULE_NAME, &mod_path);
> 
>>   	fd = SAFE_OPEN(mod_path, O_RDONLY|O_CLOEXEC);
>> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
>> index b3437b5d0..a7434de7d 100644
>> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
>> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
>> @@ -81,8 +81,6 @@ static void setup(void)
>>   {
>>   	unsigned long int i;
> 
>> -	finit_module_supported_by_kernel();
>> -
>>   	tst_module_exists(MODULE_NAME, &mod_path);
> 
>>   	kernel_lockdown = tst_lockdown_enabled();
>> diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
>> index 28e3d472f..c18ffacf2 100644
>> --- a/testcases/kernel/syscalls/fstatat/fstatat01.c
>> +++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
>> @@ -86,9 +86,6 @@ int main(int ac, char **av)
>>   	static struct stat statbuf;
>>   #endif
> 
>> -	if (tst_kvercmp(2, 6, 16) < 0)
>> -		tst_brkm(TCONF, NULL, "Test must be run with kernel 2.6.16+");
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
>> index 9b1e75b7f..46bd57c48 100644
>> --- a/testcases/kernel/syscalls/futimesat/futimesat01.c
>> +++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
>> @@ -66,9 +66,6 @@ int main(int ac, char **av)
>>   	int lc, i;
>>   	struct timeval times[2];
> 
>> -	if (tst_kvercmp(2, 6, 16) < 0)
>> -		tst_brkm(TCONF, NULL, "Test must be run with kernel 2.6.16+");
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> index fcc273e29..85ab11bb4 100644
>> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
>> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
>> @@ -156,13 +156,6 @@ static void run(void)
>>   	}
>>   }
> 
>> -static void setup(void)
>> -{
>> -	if (tst_kvercmp(2, 6, 20) < 0)
>> -		tst_brk(TCONF, "kernel >= 2.6.20 required");
>> -}
>> -
>>   static struct tst_test test = {
>>   	.test_all = run,
>> -	.setup = setup,
>>   };
>> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
>> index dca6b13be..a42057d0a 100644
>> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
>> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
>> @@ -91,16 +91,7 @@ int main(int argc, char *argv[])
> 
>>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
>>   		tst_count = 0;
>> -
>> -		/*
>> -		 * Before kernel 3.0.0, getxattr(2) will set errno with 'EPERM'
>> -		 * when the file is not a regular file and directory, refer to
>> -		 * commitid 55b23bd
>> -		 */
>> -		if (tst_kvercmp(3, 0, 0) >= 0)
>> -			exp_eno = ENODATA;
>> -		else
>> -			exp_eno = EPERM;
>> +		exp_eno = ENODATA;
> 
>>   		for (i = 0; i < TST_TOTAL; i++) {
>>   			TEST(getxattr(tc[0], XATTR_TEST_KEY, buf, BUFSIZ));
>> diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
>> index 576ef431c..cd1cb97bd 100644
>> --- a/testcases/kernel/syscalls/inotify/inotify02.c
>> +++ b/testcases/kernel/syscalls/inotify/inotify02.c
>> @@ -133,21 +133,6 @@ void verify_inotify(void)
>>   		struct inotify_event *event;
>>   		event = (struct inotify_event *)&event_buf[i];
>>   		if (test_num >= test_cnt) {
>> -			if (tst_kvercmp(2, 6, 25) < 0
>> -					&& event_set[test_cnt - 1].mask ==
>> -					event->mask)
>> -				tst_res(TWARN,
>> -					"This may be kernel bug. "
>> -					"Before kernel 2.6.25, a kernel bug "
>> -					"meant that the kernel code that was "
>> -					"intended to coalesce successive identical "
>> -					"events (i.e., the two most recent "
>> -					"events could potentially be coalesced "
>> -					"if the older had not yet been read) "
>> -					"instead checked if the most recent event "
>> -					"could be coalesced with the oldest "
>> -					"unread event. This has been fixed by commit"
>> -					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
>>   			tst_res(TFAIL,
>>   				"get unnecessary event: "
>>   				"wd=%d mask=%08x cookie=%-5u len=%-2u "
>> diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
>> index c4fce399c..70c7fecfd 100644
>> --- a/testcases/kernel/syscalls/inotify/inotify04.c
>> +++ b/testcases/kernel/syscalls/inotify/inotify04.c
>> @@ -124,20 +124,6 @@ void verify_inotify(void)
>>   		struct inotify_event *event;
>>   		event = (struct inotify_event *)&event_buf[i];
>>   		if (test_num >= test_cnt) {
>> -			if (tst_kvercmp(2, 6, 25) < 0
>> -			    && event_set[test_cnt - 1].mask == event->mask)
>> -				tst_res(TWARN,
>> -					"This may be kernel bug. "
>> -					"Before kernel 2.6.25, a kernel bug "
>> -					"meant that the kernel code that was "
>> -					"intended to coalesce successive identical "
>> -					"events (i.e., the two most recent "
>> -					"events could potentially be coalesced "
>> -					"if the older had not yet been read) "
>> -					"instead checked if the most recent event "
>> -					"could be coalesced with the oldest "
>> -					"unread event. This has been fixed by commit"
>> -					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
>>   			tst_res(TFAIL,
>>   				"got unnecessary event: "
>>   				"wd=%d mask=%04x cookie=%u len=%u "
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
>> index 26b603ebe..2989c0e9b 100644
>> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
>> @@ -79,14 +79,6 @@ static void setup(void)
>>   		tst_brk(TBROK, "You must specify a tty device with -D option");
> 
>>   	fd = SAFE_OPEN(device, O_RDWR, 0777);
>> -
>> -	if (tst_kvercmp(3, 7, 0) < 0) {
>> -		for (i = 0; i < ARRAY_SIZE(tcases); i++) {
>> -			if (tcases[i].request == INVAL_IOCTL)
>> -				tcases[i].error = EINVAL;
>> -		}
>> -	}
>> -
>>   	fd_file = SAFE_OPEN("x", O_CREAT, 0777);
>>   }
> 
>> diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
>> index 8f2cc684d..4bc30ff4f 100644
>> --- a/testcases/kernel/syscalls/ioperm/ioperm01.c
>> +++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
>> @@ -42,16 +42,7 @@ static void verify_ioperm(void)
> 
>>   static void setup(void)
>>   {
>> -	/*
>> -	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
>> -	 * from kernel 2.6.8 to permit 16-bits ioperm
>> -	 *
>> -	 * Ricky Ng-Adam, rngadam@yahoo.com
>> -	 * */
>> -	if (tst_kvercmp(2, 6, 8) < 0)
>> -		io_addr = IO_BITMAP_BITS - NUM_BYTES;
>> -	else
>> -		io_addr = IO_BITMAP_BITS - NUM_BYTES;
>> +	io_addr = IO_BITMAP_BITS - NUM_BYTES;
>>   }
> 
>>   static void cleanup(void)
>> diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
>> index 33c501904..eab701d95 100644
>> --- a/testcases/kernel/syscalls/ioperm/ioperm02.c
>> +++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
>> @@ -45,19 +45,8 @@ static struct tcase_t {
> 
>>   static void setup(void)
>>   {
>> -	/*
>> -	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
>> -	 * from kernel 2.6.8 to permit 16-bits (65536) ioperm
>> -	 *
>> -	 * Ricky Ng-Adam, rngadam@yahoo.com
>> -	 */
>> -	if ((tst_kvercmp(2, 6, 8) < 0) || (tst_kvercmp(2, 6, 9) == 0)) {
>> -		tcases[0].from = (IO_BITMAP_BITS - NUM_BYTES) + 1;
>> -		tcases[1].from = IO_BITMAP_BITS - NUM_BYTES;
>> -	} else {
>> -		tcases[0].from = (IO_BITMAP_BITS_16 - NUM_BYTES) + 1;
>> -		tcases[1].from = IO_BITMAP_BITS_16 - NUM_BYTES;
>> -	}
>> +	tcases[0].from = (IO_BITMAP_BITS_16 - NUM_BYTES) + 1;
>> +	tcases[1].from = IO_BITMAP_BITS_16 - NUM_BYTES;
> 
>>   	struct passwd *pw;
>>   	pw = SAFE_GETPWNAM("nobody");
>> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
>> index f4bca5ec8..d2d1a882a 100644
>> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
>> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
>> @@ -247,8 +247,7 @@ static void setup(void)
>>   {
>>   	msgkey = GETIPCKEY();
> 
>> -	if (tst_kvercmp(3, 8, 0) >= 0)
>> -		msg_copy_sup = 1;
>> +	msg_copy_sup = 1;
>>   }
> 
>>   static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
>> diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
>> index 044a275ae..57cfbcfc6 100644
>> --- a/testcases/kernel/syscalls/linkat/linkat01.c
>> +++ b/testcases/kernel/syscalls/linkat/linkat01.c
>> @@ -201,12 +201,6 @@ int main(int ac, char **av)
>>   	int lc;
>>   	int i;
> 
>> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
>> -		tst_resm(TWARN, "This test can only run on kernels that are ");
>> -		tst_resm(TWARN, "2.6.16 and higher");
>> -		exit(0);
>> -	}
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
>> index 796190fef..47383acec 100644
>> --- a/testcases/kernel/syscalls/linkat/linkat02.c
>> +++ b/testcases/kernel/syscalls/linkat/linkat02.c
>> @@ -138,9 +138,6 @@ static void linkat_verify(const struct test_struct *desc)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 16)) < 0)
>> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
>> -
>>   	tst_require_root();
> 
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
>> index 29e0ace00..d6c06c344 100644
>> --- a/testcases/kernel/syscalls/madvise/madvise02.c
>> +++ b/testcases/kernel/syscalls/madvise/madvise02.c
>> @@ -97,14 +97,9 @@ static void tcases_filter(void)
>>   #endif /* if !defined(UCLINUX) */
>>   		break;
>>   		case MADV_REMOVE:
>> -			if ((tst_kvercmp(2, 6, 16)) < 0)
>> -				tc->skip = 1;
>>   		break;
>>   		case MADV_MERGEABLE:
>>   		case MADV_UNMERGEABLE:
>> -			if ((tst_kvercmp(2, 6, 32)) < 0)
>> -				tc->skip = 1;
>> -
>>   			/* kernel configured with CONFIG_KSM,
>>   			 * skip EINVAL test for MADV_MERGEABLE. */
>>   			if (access(KSM_SYS_DIR, F_OK) == 0)
>> @@ -114,8 +109,7 @@ static void tcases_filter(void)
>>   			/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
>>   			 * anon mem doesn't return -EBADF now, as now we support
>>   			 * swap prefretch. */
>> -			if ((tst_kvercmp(3, 9, 0)) > 0 &&
>> -					tc->exp_errno == EBADF)
>> +			if (tc->exp_errno == EBADF)
>>   				tc->skip = 1;
>>   		break;
>>   		case MADV_FREE:
>> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
>> index 5f3c5d7c0..4b8d168cd 100644
>> --- a/testcases/kernel/syscalls/mbind/mbind01.c
>> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
>> @@ -197,12 +197,6 @@ static void do_test(unsigned int i)
>>   	tst_res(TINFO, "case %s", tc->desc);
> 
>>   	if (tc->policy == MPOL_LOCAL) {
>> -		if ((tst_kvercmp(3, 8, 0)) < 0) {
>> -			tst_res(TCONF, "%s is not supported",
>> -				tst_mempolicy_mode_name(tc->policy));
>> -			return;
>> -		}
>> -
>>   		if ((tst_kvercmp(5, 14, 0)) >= 0)
>>   			tc->check_policy = NULL;
>>   	}
>> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
>> index 4d5b2b8d5..780aae1b5 100644
>> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
>> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
>> @@ -273,9 +273,6 @@ static void setup(void)
>>   	if (num_nodes < 2)
>>   		tst_brk(TCONF, "at least 2 allowed NUMA nodes"
>>   			 " are required");
>> -	else if (tst_kvercmp(2, 6, 18) < 0)
>> -		tst_brk(TCONF, "2.6.18 or greater kernel required");
>> -
>>   	/*
>>   	 * find 2 nodes, which can hold NODE_MIN_FREEMEM bytes
>>   	 * The reason is that:
>> diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
>> index e2dfe04cf..03ec3b4e6 100644
>> --- a/testcases/kernel/syscalls/mincore/mincore01.c
>> +++ b/testcases/kernel/syscalls/mincore/mincore01.c
>> @@ -145,12 +145,6 @@ static void setup4(struct test_case_t *tc)
>>   	tc->addr = global_pointer;
>>   	tc->len = as_lim.rlim_cur - (rlim_t)global_pointer + pagesize;
>>   	tc->vector = global_vec;
>> -
>> -	/*
>> -	 * In linux 2.6.11 and earlier, EINVAL was returned for this condition.
>> -	 */
>> -	if (tst_kvercmp(2, 6, 11) <= 0)
>> -		tc->exp_errno = EINVAL;
>>   }
> 
>>   static void setup(void)
>> diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
>> index bff2c6a4e..6500ca362 100644
>> --- a/testcases/kernel/syscalls/mknodat/mknodat01.c
>> +++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
>> @@ -118,9 +118,6 @@ static void setup(void)
>>   {
>>   	char *tmpdir;
> 
>> -	if (tst_kvercmp(2, 6, 16) < 0)
>> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	TEST_PAUSE;
>> diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
>> index 28c5c8a4b..eda247fda 100644
>> --- a/testcases/kernel/syscalls/mknodat/mknodat02.c
>> +++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
>> @@ -105,11 +105,6 @@ static void setup(void)
>>   	int i;
>>   	const char *fs_type;
> 
>> -	if (tst_kvercmp(2, 6, 16) < 0) {
>> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
>> -			 "that are 2.6.16 and higher");
>> -	}
>> -
>>   	tst_require_root();
> 
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
>> index 1119e7ad0..50ee31d1c 100644
>> --- a/testcases/kernel/syscalls/mlock/mlock02.c
>> +++ b/testcases/kernel/syscalls/mlock/mlock02.c
>> @@ -98,24 +98,6 @@ static void test_enomem1(void)
>>   	void *addr;
>>   	struct rlimit rl;
> 
>> -	/*
>> -	 * RLIMIT_MEMLOCK resource limit.
>> -	 * In Linux kernels before 2.6.9, this limit controlled the amount
>> -	 * of  memory that could be locked by a privileged process. Since
>> -	 * Linux 2.6.9, no limits are placed on the amount of memory that a
>> -	 * privileged process may lock, and this limit instead governs the
>> -	 * amount of memory that an unprivileged process may lock. So here
>> -	 * we set RLIMIT_MEMLOCK resource limit to RLIM_INFINITY when kernel
>> -	 * is under 2.6.9, to make sure this ENOMEM error is indeed caused by
>> -	 * that some of the specified address range does not correspond to
>> -	 * mapped pages in the address space of the process.
>> -	 */
>> -	if ((tst_kvercmp(2, 6, 9)) < 0) {
>> -		rl.rlim_cur = RLIM_INFINITY;
>> -		rl.rlim_max = RLIM_INFINITY;
>> -		SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
>> -	}
>> -
>>   	addr = SAFE_MMAP(cleanup, NULL, len, PROT_READ,
>>   			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> 
>> @@ -129,13 +111,6 @@ static void test_enomem2(void)
>>   	void *addr;
>>   	struct rlimit rl;
> 
>> -	if ((tst_kvercmp(2, 6, 9)) < 0) {
>> -		tst_resm(TCONF,
>> -			 "ENOMEM error value test for this condition needs "
>> -			 "kernel 2.6.9 or higher");
>> -		return;
>> -	}
>> -
>>   	rl.rlim_max = len - 1;
>>   	rl.rlim_cur = len - 1;
>>   	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
>> @@ -159,12 +134,6 @@ static void test_eperm(void)
>>   	void *addr;
>>   	struct rlimit rl;
> 
>> -	if ((tst_kvercmp(2, 6, 9)) < 0) {
>> -		tst_resm(TCONF,
>> -			 "EPERM error value test needs kernel 2.6.9 or higher");
>> -		return;
>> -	}
>> -
>>   	rl.rlim_max = 0;
>>   	rl.rlim_cur = 0;
>>   	SAFE_SETRLIMIT(cleanup, RLIMIT_MEMLOCK, &rl);
>> diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
>> index f2eca09c0..e301bcb03 100644
>> --- a/testcases/kernel/syscalls/mlockall/mlockall02.c
>> +++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
>> @@ -191,29 +191,25 @@ int setup_test(int i)
>>   				 "for mlockall error %s\n", TC[i].edesc);
>>   			return 1;
>>   		}
>> -		if (tst_kvercmp(2, 6, 9) >= 0) {
>> -			ltpuser = getpwnam(nobody_uid);
>> -			if (seteuid(ltpuser->pw_uid) == -1) {
>> -				tst_brkm(TBROK, cleanup, "seteuid() "
>> -					 "failed to change euid to %d "
>> -					 "errno = %d : %s",
>> -					 ltpuser->pw_uid, TEST_ERRNO,
>> -					 strerror(TEST_ERRNO));
>> +		ltpuser = getpwnam(nobody_uid);
>> +		if (seteuid(ltpuser->pw_uid) == -1) {
>> +			tst_brkm(TBROK, cleanup, "seteuid() "
>> +				"failed to change euid to %d "
>> +				"errno = %d : %s",
>> +				ltpuser->pw_uid, TEST_ERRNO,
>> +				strerror(TEST_ERRNO));
>>   				return 1;
>> -			}
>>   		}
>>   		return 0;
>>   	case 1:
>> -		if (tst_kvercmp(2, 6, 9) >= 0) {
>> -			rl.rlim_max = 0;
>> -			rl.rlim_cur = 0;
>> -			if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
>> -				tst_resm(TWARN, "setrlimit failed to "
>> -					 "set the resource for "
>> -					 "RLIMIT_MEMLOCK to check for "
>> -					 "mlockall error %s\n", TC[i].edesc);
>> +		rl.rlim_max = 0;
>> +		rl.rlim_cur = 0;
>> +		if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
>> +			tst_resm(TWARN, "setrlimit failed to "
>> +				"set the resource for "
>> +				"RLIMIT_MEMLOCK to check for "
>> +				"mlockall error %s\n", TC[i].edesc);
>>   				return 1;
>> -			}
>>   		}
>>   		ltpuser = getpwnam(nobody_uid);
>>   		if (seteuid(ltpuser->pw_uid) == -1) {
>> diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
>> index 5c2d8d320..308249146 100644
>> --- a/testcases/kernel/syscalls/move_pages/move_pages09.c
>> +++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
>> @@ -102,25 +102,10 @@ int main(int argc, char **argv)
>>   		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
>>   				      status, MPOL_MF_MOVE);
> 
>> -		/*
>> -		 * commit e78bbfa8262424417a29349a8064a535053912b9
>> -		 * Author: Brice Goglin <Brice.Goglin@inria.fr>
>> -		 * Date:   Sat Oct 18 20:27:15 2008 -0700
>> -		 *     mm: stop returning -ENOENT from sys_move_pages() if nothing got migrated
>> -		 */
>> -		if ((tst_kvercmp(2, 6, 28)) >= 0) {
>> -			if (ret >= 0)
>> -				tst_resm(TPASS, "move_pages succeeded");
>> -			else
>> -				tst_resm(TFAIL | TERRNO, "move_pages");
>> -		} else {
>> -			if (ret == -1 && errno == ENOENT)
>> -				tst_resm(TPASS, "move_pages failed with "
>> -					 "ENOENT as expected");
>> -			else
>> -				tst_resm(TFAIL | TERRNO, "move_pages did not "
>> -					"fail with ENOENT ret: %d", ret);
>> -		}
>> +		if (ret >= 0)
>> +			tst_resm(TPASS, "move_pages succeeded");
>> +		else
>> +			tst_resm(TFAIL | TERRNO, "move_pages");
> 
>>   		free_pages(pages, TEST_PAGES);
>>   	}
>> diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
>> index 717321a48..1604e91f6 100644
>> --- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
>> +++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
>> @@ -400,13 +400,12 @@ void check_config(unsigned int min_nodes)
>>   	if (ret < 0)
>>   		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes(): %d", ret);
> 
>> -	if (numa_available() < 0) {
>> +	if (numa_available() < 0)
>>   		tst_brkm(TCONF, NULL, "NUMA support is not available");
>> -	} else if (num_allowed_nodes < min_nodes) {
>> +
>> +	if (num_allowed_nodes < min_nodes) {
>>   		tst_brkm(TCONF, NULL, "at least %d allowed NUMA nodes"
>>   			 " are required", min_nodes);
>> -	} else if (tst_kvercmp(2, 6, 18) < 0) {
>> -		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
>>   	}
>>   #else
>>   	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
>> diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
>> index 3b88b531e..23875e7b3 100644
>> --- a/testcases/kernel/syscalls/munmap/munmap03.c
>> +++ b/testcases/kernel/syscalls/munmap/munmap03.c
>> @@ -127,13 +127,6 @@ static void test_einval2(void)
>>   	char *addr = global_addr;
>>   	size_t map_len = 0;
> 
>> -	if (tst_kvercmp(2, 6, 12) < 0) {
>> -		tst_resm(TCONF,
>> -			 "EINVAL error value test for this condition needs "
>> -			 "kernel 2.6.12 or higher");
>> -		return;
>> -	}
>> -
>>   	TEST(munmap(addr, map_len));
> 
>>   	check_and_print(EINVAL);
>> diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
>> index 02ef5b5b0..2ec53ae15 100644
>> --- a/testcases/kernel/syscalls/open/open12.c
>> +++ b/testcases/kernel/syscalls/open/open12.c
>> @@ -89,14 +89,6 @@ static void setup(void)
>>   	if (tst_path_has_mnt_flags(cleanup, NULL, mount_flags)) {
>>   		const char *fs_type;
> 
>> -		if ((tst_kvercmp(2, 6, 30)) < 0) {
>> -			tst_resm(TCONF,
>> -				"MS_STRICTATIME flags for mount(2) needs kernel 2.6.30 "
>> -				"or higher");
>> -			skip_noatime = 1;
>> -			return;
>> -		}
>> -
>>   		fs_type = tst_dev_fs_type();
>>   		device = tst_acquire_device(cleanup);
> 
>> @@ -144,13 +136,6 @@ static void test_noatime(void)
>>   	char read_buf;
>>   	struct stat old_stat, new_stat;
> 
>> -	if ((tst_kvercmp(2, 6, 8)) < 0) {
>> -		tst_resm(TCONF,
>> -			 "O_NOATIME flags test for open(2) needs kernel 2.6.8 "
>> -			 "or higher");
>> -		return;
>> -	}
>> -
>>   	if (skip_noatime) {
>>   		tst_resm(TCONF,
>>   		         "test O_NOATIME flag for open needs filesystems which "
>> @@ -184,13 +169,6 @@ static void test_cloexec(void)
>>   	int status;
>>   	char buf[20];
> 
>> -	if ((tst_kvercmp(2, 6, 23)) < 0) {
>> -		tst_resm(TCONF,
>> -			 "O_CLOEXEC flags test for open(2) needs kernel 2.6.23 "
>> -			 "or higher");
>> -		return;
>> -	}
>> -
>>   	TEST(open(TEST_FILE, O_RDWR | O_APPEND | O_CLOEXEC, 0777));
> 
>>   	if (TEST_RETURN == -1) {
>> diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
>> index 3838221e1..e777a305d 100644
>> --- a/testcases/kernel/syscalls/open/open13.c
>> +++ b/testcases/kernel/syscalls/open/open13.c
>> @@ -95,11 +95,6 @@ int main(int ac, char **av)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 39)) < 0) {
>> -		tst_brkm(TCONF, NULL, "This test can only run on kernels "
>> -			"that are 2.6.39 or higher");
>> -	}
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	tst_tmpdir();
>> diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
>> index b0a6ff78f..98ef61e0d 100644
>> --- a/testcases/kernel/syscalls/openat/openat02.c
>> +++ b/testcases/kernel/syscalls/openat/openat02.c
>> @@ -144,12 +144,6 @@ void testfunc_cloexec(void)
>>   	int status;
>>   	char buf[20];
> 
>> -	if ((tst_kvercmp(2, 6, 23)) < 0) {
>> -		tst_resm(TCONF, "test O_CLOEXEC flags for openat "
>> -						"needs kernel 2.6.23 or higher");
>> -		return;
>> -	}
>> -
>>   	TEST(openat(AT_FDCWD, TEST_FILE, O_CLOEXEC | O_RDWR, 0777));
> 
>>   	if (TEST_RETURN == -1) {
>> @@ -223,12 +217,6 @@ void testfunc_noatime(void)
>>   	const char *flags[] = {"noatime", "relatime", NULL};
>>   	int ret;
> 
>> -	if ((tst_kvercmp(2, 6, 8)) < 0) {
>> -		tst_resm(TCONF, "test O_NOATIME flags for openat "
>> -						"needs kernel 2.6.8 or higher");
>> -		return;
>> -	}
>> -
>>   	ret = tst_path_has_mnt_flags(cleanup, NULL, flags);
>>   	if (ret > 0) {
>>   		tst_resm(TCONF, "test O_NOATIME flag for openat needs "
>> diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
>> index 6597162e7..87e81a455 100644
>> --- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
>> +++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
>> @@ -54,10 +54,6 @@ static void verify_pipe2(unsigned int n)
>>   	int get_flag = 0, i = 0;
> 
>>   	tst_res(TINFO, "%s ", tc->message);
>> -	if ((tc->flags ==  O_DIRECT) && (tst_kvercmp(3, 4, 0)) < 0) {
>> -		tst_res(TCONF, "O_DIRECT needs Linux 3.4 or newer");
>> -		return;
>> -	}
> 
>>   	SAFE_PIPE2(fds, tc->flags);
>>   	for (i = 0; i < 2; i++) {
>> diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
>> index 631db51a7..09143a2d0 100644
>> --- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
>> +++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
>> @@ -113,15 +113,6 @@ int main(int ac, char **av)
>>   {
>>   	int lc;
> 
>> -#if defined (__s390__) || (__s390x__) || (__ia64__)
>> -	/* Disables the test in case the kernel version is lower than 2.6.12 and arch is s390 */
>> -	if ((tst_kvercmp(2, 6, 12)) < 0) {
>> -		tst_resm(TWARN,
>> -			 "This test can only run on kernels that are 2.6.12 and higher");
>> -		exit(0);
>> -	}
>> -#endif
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
>> index 1d8f620ca..d296022ce 100644
>> --- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
>> +++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
>> @@ -121,12 +121,6 @@ static void setup(void)
>>   {
>>   	unsigned int i;
> 
>> -#if defined (__s390__) || (__s390x__) || (__ia64__)
>> -	if ((tst_kvercmp(2, 6, 12)) < 0)
>> -		tst_brk(TCONF,
>> -			 "This test can only run on kernels that are 2.6.12 and higher");
>> -#endif
>> -
>>   	page_sz = getpagesize();
> 
>>   	fd = SAFE_OPEN("cache", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
>> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
>> index 9df4b7086..3de103563 100644
>> --- a/testcases/kernel/syscalls/renameat/renameat01.c
>> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
>> @@ -133,12 +133,6 @@ static void setup(void)
>>   	const char *fs_type;
>>   	int i;
> 
>> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
>> -		tst_brkm(TCONF, NULL,
>> -			"This test can only run on kernels that are "
>> -			"2.6.16 and higher");
>> -	}
>> -
>>   	tst_require_root();
> 
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
>> index 3df941785..48a17a634 100644
>> --- a/testcases/kernel/syscalls/signalfd/signalfd01.c
>> +++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
>> @@ -263,12 +263,6 @@ int main(int argc, char **argv)
>>   	int lc;
>>   	int sfd;
> 
>> -	if ((tst_kvercmp(2, 6, 22)) < 0) {
>> -		tst_resm(TWARN,
>> -			 "This test can only run on kernels that are 2.6.22 and higher");
>> -		exit(0);
>> -	}
>> -
>>   	tst_parse_opts(argc, argv, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
>> index 7909f587a..76f3be27f 100644
>> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
>> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
>> @@ -129,11 +129,6 @@ int main(int argc, char *argv[])
>>   	int lc;
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF,
>> -			 NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
>> index 4c9c2022a..18f86b4a7 100644
>> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
>> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
>> @@ -125,11 +125,6 @@ int main(int argc, char *argv[])
>>   	int lc;
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF,
>> -			 NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>> diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
>> index 467154834..4724609d1 100644
>> --- a/testcases/kernel/syscalls/socket/socket01.c
>> +++ b/testcases/kernel/syscalls/socket/socket01.c
>> @@ -66,27 +66,7 @@ static void verify_socket(unsigned int n)
>>   	tst_res(TPASS, "%s successful", tc->desc);
>>   }
> 
>> -/*
>> - * See:
>> - * commit 86c8f9d158f68538a971a47206a46a22c7479bac
>> - * ...
>> - * [IPV4] Fix EPROTONOSUPPORT error in inet_create
>> - */
>> -static void setup(void)
>> -{
>> -	unsigned int i;
>> -
>> -	if (tst_kvercmp(2, 6, 16) >= 0)
>> -		return;
>> -
>> -	for (i = 0; i < ARRAY_SIZE(tdat); i++) {
>> -		if (tdat[i].experrno == EPROTONOSUPPORT)
>> -				tdat[i].experrno = ESOCKTNOSUPPORT;
>> -	}
>> -}
>> -
>>   static struct tst_test test = {
>>   	.tcnt = ARRAY_SIZE(tdat),
>> -	.setup = setup,
>>   	.test = verify_socket
>>   };
>> diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
>> index 7c301f681..675eb535d 100644
>> --- a/testcases/kernel/syscalls/socketpair/socketpair01.c
>> +++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
>> @@ -70,27 +70,7 @@ static void verify_socketpair(unsigned int n)
>>   	tst_res(TPASS, "%s successful", tc->desc);
>>   }
> 
>> -/*
>> - * See:
>> - * commit 86c8f9d158f68538a971a47206a46a22c7479bac
>> - * ...
>> - * [IPV4] Fix EPROTONOSUPPORT error in inet_create
>> - */
>> -static void setup(void)
>> -{
>> -	unsigned int i;
>> -
>> -	if (tst_kvercmp(2, 6, 16) >= 0)
>> -		return;
>> -
>> -	for (i = 0; i < ARRAY_SIZE(tdat); i++) {
>> -		if (tdat[i].experrno == EPROTONOSUPPORT)
>> -				tdat[i].experrno = ESOCKTNOSUPPORT;
>> -	}
>> -}
>> -
>>   static struct tst_test test = {
>>   	.tcnt = ARRAY_SIZE(tdat),
>> -	.setup = setup,
>>   	.test = verify_socketpair
>>   };
>> diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
>> index 486236af9..be09910a2 100644
>> --- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
>> +++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
>> @@ -185,13 +185,7 @@ static void setup0(void)
>>   				 "errno: %s", strerror(errno));
>>   		}
> 
>> -		/*
>> -		 * kernel commit 46ce341b2f176c2611f12ac390adf862e932eb02
>> -		 * changed -EINVAL to -ENOIOCTLCMD, so vfs_ioctl now
>> -		 * returns -ENOTTY.
>> -		 */
>> -		if ((tst_kvercmp(3, 5, 0)) >= 0)
>> -			tdat[testno].experrno = ENOTTY;
>> +		tdat[testno].experrno = ENOTTY;
>>   	}
>>   }
> 
>> @@ -211,8 +205,7 @@ static void setup1(void)
>>   	sinlen = sizeof(fsin1);
> 
>>   	if (strncmp(tdat[testno].desc, "ATMARK on UDP", 14) == 0) {
>> -		if ((tst_kvercmp(2, 6, 39)) >= 0)
>> -			tdat[testno].experrno = ENOTTY;
>> +		tdat[testno].experrno = ENOTTY;
>>   	}
>>   }
> 
>> diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
>> index 82407743f..f5b2cbe17 100644
>> --- a/testcases/kernel/syscalls/splice/splice01.c
>> +++ b/testcases/kernel/syscalls/splice/splice01.c
>> @@ -79,12 +79,6 @@ static void setup(void)
>>   {
>>   	int i;
> 
>> -	if (tst_fs_type(".") == TST_NFS_MAGIC) {
>> -		if  (tst_kvercmp(2, 6, 32) < 0)
>> -			tst_brk(TCONF, "Cannot do splice on a file"
>> -				" on NFS filesystem before 2.6.32");
>> -	}
>> -
>>   	for (i = 0; i < TEST_BLOCK_SIZE; i++)
>>   		buffer[i] = i & 0xff;
> 
>> diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
>> index 711f10aec..d510872f0 100644
>> --- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
>> +++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
>> @@ -134,13 +134,6 @@ int main(int ac, char **av)
>>   	int lc;
>>   	int i;
> 
>> -	/* Disable test if the version of the kernel is less than 2.6.16 */
>> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
>> -		tst_resm(TWARN, "This test can only run on kernels that are ");
>> -		tst_resm(TWARN, "2.6.16 and higher");
>> -		exit(0);
>> -	}
>> -
>>   	tst_parse_opts(ac, av, NULL, NULL);
> 
>>   	setup();
>> diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
>> index ea41f9d09..73f98f0b1 100644
>> --- a/testcases/kernel/syscalls/sysctl/sysctl03.c
>> +++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
>> @@ -68,14 +68,10 @@ static void verify_sysctl(void)
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 32)) <= 0) {
>> -		exp_eno = EPERM;
>> -	} else {
>> -		/* Look above this warning. */
>> -		tst_res(TINFO,
>> -			 "this test's results are based on potentially undocumented behavior in the kernel. read the NOTE in the source file for more details");
>> -		exp_eno = EACCES;
>> -	}
>> +	/* Look above this warning. */
>> +	tst_res(TINFO,
>> +		 "this test's results are based on potentially undocumented behavior in the kernel. read the NOTE in the source file for more details");
>> +	exp_eno = EACCES;
>>   }
> 
>>   static void do_test(void)
>> diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
>> index dd4d8bfa5..87a7ecd09 100644
>> --- a/testcases/kernel/syscalls/tee/tee01.c
>> +++ b/testcases/kernel/syscalls/tee/tee01.c
>> @@ -84,12 +84,6 @@ static void setup(void)
>>   {
>>   	int i;
> 
>> -	if (tst_fs_type(".") == TST_NFS_MAGIC) {
>> -		if ((tst_kvercmp(2, 6, 32)) < 0)
>> -			tst_brk(TCONF, "Cannot do tee on a file"
>> -				" on NFS filesystem before 2.6.32");
>> -	}
>> -
>>   	for (i = 0; i < TEST_BLOCK_SIZE; i++)
>>   		buffer[i] = i & 0xff;
> 
>> diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
>> index 1cb9a9fdc..d56e68c23 100644
>> --- a/testcases/kernel/syscalls/timer_create/timer_create01.c
>> +++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
>> @@ -59,16 +59,6 @@ static void run(unsigned int n)
>>   		evp.sigev_signo  = nt->sigev_signo;
>>   		evp.sigev_notify = nt->sigev_notify;
> 
>> -		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
>> -			clock == CLOCK_THREAD_CPUTIME_ID) {
>> -			/* (PROCESS_CPUTIME_ID &
>> -			 *  THREAD_CPUTIME_ID)
>> -			 * is not supported on kernel versions
>> -			 * lower than 2.6.12
>> -			 */
>> -			if (!have_cputime_timers())
>> -				continue;
>> -		}
>>   		if (clock == CLOCK_MONOTONIC_RAW)
>>   			continue;
> 
>> diff --git a/testcases/kernel/syscalls/timer_delete/timer_delete01.c b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
>> index 6e5fc9940..bdc2e44cc 100644
>> --- a/testcases/kernel/syscalls/timer_delete/timer_delete01.c
>> +++ b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
>> @@ -30,12 +30,6 @@ static void run(void)
>>   	for (i = 0; i < CLOCKS_DEFINED; ++i) {
>>   		clock_t clock = clock_list[i];
> 
>> -		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
>> -			clock == CLOCK_THREAD_CPUTIME_ID) {
>> -			if (!have_cputime_timers())
>> -				continue;
>> -		}
>> -
>>   		tst_res(TINFO, "Testing %s", get_clock_str(clock));
> 
>>   		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer_id));
>> diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
>> index 599ef2891..5aee8b38a 100644
>> --- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
>> +++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
>> @@ -98,12 +98,6 @@ static void run(unsigned int n)
>>   	for (i = 0; i < CLOCKS_DEFINED; ++i) {
>>   		clock_t clock = clock_list[i];
> 
>> -		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
>> -			clock == CLOCK_THREAD_CPUTIME_ID) {
>> -			if (!have_cputime_timers())
>> -				continue;
>> -		}
>> -
>>   		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
>>   		if (TST_RET != 0) {
>>   			if (possibly_unsupported(clock) &&
>> diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
>> index 564f1c2ce..3309a81ad 100644
>> --- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
>> +++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
>> @@ -87,12 +87,6 @@ static void run(unsigned int n)
>>   	for (i = 0; i < CLOCKS_DEFINED; ++i) {
>>   		clock_t clock = clock_list[i];
> 
>> -		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
>> -			clock == CLOCK_THREAD_CPUTIME_ID) {
>> -			if (!have_cputime_timers())
>> -				continue;
>> -		}
>> -
>>   		/* Init temporary timer */
>>   		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
>>   		if (TST_RET != 0) {
>> diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
>> index 9d2e3ff3c..936cdbc53 100644
>> --- a/testcases/kernel/syscalls/timerfd/timerfd02.c
>> +++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
>> @@ -127,11 +127,6 @@ int main(int argc, char *argv[])
>>   	int lc;
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF,
>> -			 NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>> diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
>> index ca70d1759..89dec325f 100644
>> --- a/testcases/kernel/syscalls/timerfd/timerfd03.c
>> +++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
>> @@ -123,11 +123,6 @@ int main(int argc, char *argv[])
>>   	int lc;
> 
>>   	tst_parse_opts(argc, argv, NULL, NULL);
>> -	if ((tst_kvercmp(2, 6, 27)) < 0) {
>> -		tst_brkm(TCONF,
>> -			 NULL,
>> -			 "This test can only run on kernels that are 2.6.27 and higher");
>> -	}
>>   	setup();
> 
>>   	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>> diff --git a/testcases/kernel/syscalls/timerfd/timerfd_create01.c b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
>> index b9fe38954..3d70b84f0 100644
>> --- a/testcases/kernel/syscalls/timerfd/timerfd_create01.c
>> +++ b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
>> @@ -66,9 +66,6 @@ int main(int argc, char *argv[])
> 
>>   static void setup(void)
>>   {
>> -	if ((tst_kvercmp(2, 6, 25)) < 0)
>> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.25 or newer");
>> -
>>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
>>   	TEST_PAUSE;
>> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
>> index 7c222531d..6a888f2ee 100644
>> --- a/testcases/network/netstress/netstress.c
>> +++ b/testcases/network/netstress/netstress.c
>> @@ -882,9 +882,6 @@ static void setup(void)
>>   	if (!clients_num)
>>   		clients_num = sysconf(_SC_NPROCESSORS_ONLN);
> 
>> -	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0)
>> -		tst_brk(TCONF, "Test must be run with kernel 3.7 or newer");
>> -
>>   	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0)
>>   		tst_brk(TCONF, "Test must be run with kernel 3.11 or newer");
> 
>> diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
>> index affabf9f7..8b4c8c0a2 100644
>> --- a/testcases/open_posix_testsuite/Makefile
>> +++ b/testcases/open_posix_testsuite/Makefile
>> @@ -27,10 +27,6 @@ TEST_MAKE=		env $(TEST_MAKE_ENV) $(MAKE) -k
> 
>>   all: conformance-all functional-all stress-all tools-all
> 
>> -ifeq ($(shell uname -s), Linux)
>> -include Makefile.linux
>> -endif
>> -
>>   AUTOGENERATED_FILES = include/mk/config.mk
> 
>>   .PHONY: ac-clean
>> diff --git a/testcases/open_posix_testsuite/Makefile.linux b/testcases/open_posix_testsuite/Makefile.linux
>> deleted file mode 100644
>> index 77e20a958..000000000
>> --- a/testcases/open_posix_testsuite/Makefile.linux
>> +++ /dev/null
>> @@ -1,20 +0,0 @@
>> -cmd_disable = @set -e; \
>> -	echo "Disabling: $(1)"; \
>> -	echo "\#!/bin/sh" > $(1); \
>> -	echo "echo $(1) skipped" >> $(1); \
>> -	echo "echo $(2)" >> $(1); \
>> -	echo "exit 0" >> $(1); \
>> -	chmod a+x $(1)
>> -
>> -BROKEN :=
>> -
>> -kver_cmp = $(shell $(top_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
>> -ifeq ($(kver_cmp), 1)
>> -BROKEN += t_sigaction_16-1
>> -endif
>> -
>> -filter-known-fails: $(BROKEN)
>> -
>> -t_sigaction_16-1:
>> -	$(call cmd_disable,conformance/interfaces/sigaction/sigaction_16-1.run-test, \
>> -	  This fails on old linux because sem_wait always be interrupted by a signal.)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
