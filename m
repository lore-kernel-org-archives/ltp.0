Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45898C00145
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 07:14:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F079A3CBCA7
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 08:14:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3D773CBC83
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 08:14:43 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1FF8F1A00146
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 08:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671088481; x=1702624481;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=u5h9ujuUUHBCdwYYfv4+W+47bZhQ5779ySiz4Isf37g=;
 b=IgVFGx0CxwgiwUeDRFL1RzJZEkx8pxMJGSxUDE2k8P7vERGZrUp66/AE
 6W4R42vgNE48LRhNCjExSHNUHrOyHWxSOMNha0X5j6DzyT5YzqjBBa32H
 ylU8wC75whHvFN4n5m08PGf4pXyuGBMqqs4ayGKzY5fB3XdxC8btMIkNp
 SkmGSRgy4ntN7yZnEjj8ZBH+vasIlCXcfeUPD++82pkesdhJMxwyxK4bo
 ytRkr1ny+s950BNuzq51WYi9G8jHCK27VNnzDOc8ujxcxcfD4LhGKCATw
 wlEp6y0FQw+gutyWYtarplzkFDQAxq463B1QtKly1u1b01dvFTNL4M8pN A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="72617742"
X-IronPort-AV: E=Sophos;i="5.96,246,1665414000"; d="scan'208";a="72617742"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 16:14:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp4V4J29Q20UApn3iVDrpwNrlGNlQqIMIde3vZMd0VJqmbwOTg73zS7+YD/x0O3/EKirnxVxzs798M2ZbDb6AaeJaYTvmv98BV9tTlwWn+QIOwU9duM9DMWOm9c1hsuwu/au2pt8+03AcJitIZcUg5469uNcaS2dIEumX5n7nG+2B9TqChQ7K5/FHLY6R422BB7TaYfrwQRc+kmH5JEBHSTzN7s1VHHzbnkAYwJiUyiApQBZ1CwNQQYmhz49FhnhWakDfEBpRiOv2flVES+gC8YzS1EySbYfAd1m3+Q6CnFzQM9q7M8e2eEphorl2RGrb4B7QEiO3YSzlVQCTfclqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5h9ujuUUHBCdwYYfv4+W+47bZhQ5779ySiz4Isf37g=;
 b=aAsk60hF2hSUNsEASVws8Pmp0ybUZr9OC25Zqy8eRA9JR/anJe73vtzn6lAaCYKJygL++Q0swFBM6yg9seWbkVxI0VwzfXnmAdwVoyLM1aV6O7MNpE2b1upPLEEEc6iKA0i0cl8ob6pSSzR+DvfUd/ixLS6Lp6MLWpvQsaf41et1RooLWleKvPS1MA2qncYvmpSf8TO9+ovTkINrvQH0SSiup1Vdjw6+aBuI7P0WcRB/jzEw0OnyOyRCZk/hlcVvTRaoalZHdjOwkCI7B8beuTX2DlHlpIXwMWb3u0KPJf9Fc7HQVUGE5xX+XTWqrWkxbm5skPUZA+Q70LA+uu7jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB8917.jpnprd01.prod.outlook.com (2603:1096:400:16d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 07:14:36 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 07:14:36 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when
 parsing /proc/self/mountinfo
Thread-Index: AQHZDph3mKrGcjGlGkmvziVdoDwB+q5rprKAgAL3BAA=
Date: Thu, 15 Dec 2022 07:14:36 +0000
Message-ID: <ba8c6bd3-1a74-ec37-4ab5-f299975bd823@fujitsu.com>
References: <1670901258-1995-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87y1rbr2e9.fsf@suse.de>
In-Reply-To: <87y1rbr2e9.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB8917:EE_
x-ms-office365-filtering-correlation-id: fe062f41-4105-485f-bb3a-08dade6c060a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBe2ArfUTlNngS12dVw13YnCOlfW8wontLTJBu5uue+BNH9RpQB37mqc5nnkwnfaaWmfyxv4c719qMUcF0adMp1bWQZRZyT3ucHdD+qFmeQ7fBITZE1CVJsnpyM//u7ypQKgOisggxcARpKIDlRE16ZjH/JXjK5iuw9+j5WIUmUOCN4XzBVGm6qj2eTEDi6uOYRYpkPcyNzR34eaGvr3V4geHV93ZMU7tzSRcUQUKUEwNh28g8u8ceD6U86PVZbPpHuDtSAt9cNrj+SZdRerTynaPZwEJ4gDBbxRAQ5MCXmAlkixotrSAigV/D9yABA8dG2pB2/lT95+SjigHUZG9YEd6dcM7LM7fZ7sAGDzaECx41XuhcYAoZ0J7GMYbMR7FvGNOn1BkIHcBtwUkB6zd2JT1QP11s8MYWIYSH2MeSVCzBWjJArIK4Eji00b7Vj8rIujC6AFit+In1+Ultd0RzljoEMR21Z/dv2ue1OX7xZfX7yhtm6VWJ9Nxd4s4h7dauOBjmFnD4+Hr1Zhxzj+ReTuJv9Ir5iLC5rGIzXQvm1szMVgSqlXnoNvpncwmiOcE8L0yHxMCAaA8nHGaukO756/DvOkskHltw5dQgrlP36O2AV5lByWBkWGtkst5OaprdNb3hDEQ2FICJxp4v0yOkCZvu6+bdUZHD71bmB4vHkF030ggOZT7SMA3qIPNxE8tJrSiZB7IDOh+jz9Ivk5s1KFCnCAOv0vbeCrMxOTKz2uP8/6Ei/vKyb9en829v7W3IPhs4ikVDIGPPsGp+Nw8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(1590799012)(451199015)(71200400001)(31686004)(1580799009)(478600001)(6486002)(86362001)(31696002)(6506007)(122000001)(85182001)(36756003)(2906002)(82960400001)(186003)(38070700005)(26005)(6512007)(38100700002)(2616005)(41300700001)(83380400001)(8936002)(5660300002)(66446008)(66556008)(8676002)(64756008)(66946007)(91956017)(4326008)(6916009)(66476007)(76116006)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2pmei9MVWdNREwvcFplNml5TEVXTkk3YnZaZU45aUFsTDJGRkcydGF5SEph?=
 =?utf-8?B?cjc4Y2tGSGFmVE56N0JYQzJZaXpjOHhHc1EwMGwxNGZGbzNoeVU3dXdtSUty?=
 =?utf-8?B?MmJ0RlhQaE5Jai9VM2prT1FkTWV2WDZKaVd4b0dlQjEybjZBaDFQUUdCc2VX?=
 =?utf-8?B?eHZ3d3AzeXBsMi9IOGFubUsxQnZpS21xbkF0dWxwb0VIa1ZwcDFFSE9hYktX?=
 =?utf-8?B?allFMEo0TjNpeGZHY21LNVE3RlhyVnk5NmkwblhSNEgvOC84YVREcSszaDdy?=
 =?utf-8?B?djJ0Zngwcm5TdnJLZzlEcUp4MEpoeW94dVFzamljWWNITkozcWpVN1ppMThP?=
 =?utf-8?B?L0NvWjZOT25DNkk4QkFXdkdkbVBJZXQ4bzhGcklhdUhkandzUjd2T0NrZjZR?=
 =?utf-8?B?eUJ4MVEyS3A0aWlsSkJpTzhZUmlSNlBiMWk4Z1pvQThhTXVYeVJiUDZ2ZGdC?=
 =?utf-8?B?YUdDWU5ERklYQ3F5MW5PZGhiZnJsQllaZDFabXN2MzY4WVpPUnpIOEQvWlZq?=
 =?utf-8?B?TUVsSERWeUZzWW11ZHM4NVB2c3YxdWNSTzRrUmlSV2doTUo5UDNkL3BLNGdw?=
 =?utf-8?B?algyclJlZEdBVGt4SnpOSWZuUTZtQlkweS81RThjK2p4WmhsS041WE5Dd3RV?=
 =?utf-8?B?aGxrckNHeHJMbXpMTWpZeEZRUy9wYU1QNDUyMkFiRFNCdGp5RzFqVE9US0ds?=
 =?utf-8?B?VkpnZ1NyQVg2ekt5OCtDUitFSEZOdWNLMGRXcW1NZ0ZrVk5yMVZRU2NpMHE4?=
 =?utf-8?B?MXBvbFlmdDQ0U0FtWVJnSkNIWm9wVjlURGNxeE9rMVIxOFl3UDdaNTBlZjcz?=
 =?utf-8?B?MitnT2ZtdE5GeURCSVBHdjVTRWRZQXNkTXNwQ1VHdzAwYmpIU0pNMnpUOExn?=
 =?utf-8?B?VGpuYlJHekhYcTNjdW94ekRpdVRCU0FWUVB1TXhSaFlyVmpxQ21FU1J0V0J3?=
 =?utf-8?B?VEtLeFRRY3BCZDlKTUt6T3dkcjVObWI2NnBSWUNNNk9FdWxYNnFmeGlQbi95?=
 =?utf-8?B?L3J4QzFrRCtiWGlENlYxWkMvd2llTlZSMVBjSlZGY3FBMXNHUjZ0Ym9RTWR5?=
 =?utf-8?B?ZlFWaHVpamhBR3VMMHBGOFNtZU9lNW55NnF0eUEvZURRb0QzVDNjVGd6Ynlh?=
 =?utf-8?B?ZytMQTAxbUdQbVp4S3A3WHd0MjRTM3FPOUFaeWpHUlJzclRQbUE4aW9NV3lC?=
 =?utf-8?B?ekZFQ2ptQy9GVFMzOENubUM5WTVzdUpnRkhuaW45ODVoQXoxVFd5bVBKRVFk?=
 =?utf-8?B?MTUzbDFJOUo3cDZzMU1pSGpXNDAxN3VqdnFMWjd0WDQ5U0x4Y0F6VTZUMUZw?=
 =?utf-8?B?RUxmL2w3SGZVRjhaRURuUVJ0bFY3ekNvaXZqeUxXNSs0by81T0RyMmpQM1ZT?=
 =?utf-8?B?L3Z1ZUJsTzAvRXlGWk1obk5KREh3RHg5a3E4OVJQUk1vdmgxRStIelBrWm9k?=
 =?utf-8?B?Ym1UNkk3bjV1QkVFb3VhN1FwdXZzWFRyY21oK3lnUVRTZzFSa3RHVkZOVkZX?=
 =?utf-8?B?WlhzUlVsTENrRXRHSXo5THdzdHhrc3N1WG9DQTFmU1dPK0IwVW5wOCtPbUg0?=
 =?utf-8?B?YjlYSHJ6Mm9vV1pNYnIwU3J6Y3d2dDU1V0k4UkpEc3NVN0xJUjFtWUtkb1VW?=
 =?utf-8?B?dHNmbDJCTlV2SzZTZ2xoZ2FaU1VGQ3lPUERzNWdCUXBRZlgyK0ZQZEIvM09a?=
 =?utf-8?B?K3VCN01FYytWVDhLQTZNSjR5Z3NjZVBTR0lkT2RUTTZ0a2pNeUMvVUZ4cDNo?=
 =?utf-8?B?YldRbTgzN05lVVlsdzlwbHIxOUdVTHlQZVBaMlhIK1ppWUw0aURuWGlVRWZE?=
 =?utf-8?B?ekdSRkJRTnpCZDdlMWdzUTYzdGM4dzFLQjQ0YlhjbU1xdGdCNjk1d0t4ajNR?=
 =?utf-8?B?RjVuREhWNmpDYVA5MzVaMDllTFREQWcyQXRKL0lUZDVQZGVvYzFsekM4b0VL?=
 =?utf-8?B?Q1VRL0Z0N0lnU1YwYStoSWk5dkYvQ1pNcnhnWm5PS2UxN3FsdlZ5TWNkdnJS?=
 =?utf-8?B?SkNrY0pyTWJJOERjUU1GUVZiY0lLbnVGZDVQaUovTnVTbm8xQ2w4SVlJL1l2?=
 =?utf-8?B?aHZTc0lDemVLbjBIaGhiaEx0RW5jNlZ5UUZwZFFYS2s3R3N4a3BSWjhqLzRn?=
 =?utf-8?B?SFZuWVVsYzZ6Q0ptZ2VYNFRxQlNtUkpZMUJ5VFM2bGJCY2p5WWowekEzVmsz?=
 =?utf-8?B?S1E9PQ==?=
Content-ID: <7171A68D04291443B5031FE49AD99FD1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe062f41-4105-485f-bb3a-08dade6c060a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 07:14:36.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjF2CnZDt1RRPBtKHDDV9BiLd23WHi09wtUZNDt0H+S0f7RFcPb2lQ4Xhi/3dUbUg5pPwm5U0109nqi1wp16cbMM62JEE77/Alb00KMlqeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8917
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when
 parsing /proc/self/mountinfo
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

Hi Richard


> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> When using user filesystem such as overlayfs, the current parsing way can't
>> work well.
>>
>> 63 66 8:3 / /sysroot rw,relatime - ext4 /dev/sda3 rw,seclabel
>> 43 66 8:3 /ostree/deploy/rhivos/var /var rw,relatime shared:3 - ext4 /dev/sda3 rw,seclabel
>>
>> So add the exit condition for statx.mnt_id check so it can skip the
>> underflying filesystem and parse the correct user fileystem's mnt_id.
>>
>> Fixes: #1001
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>> v1-v2: change the fail message
>>   testcases/kernel/syscalls/statx/statx01.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>> index 60b50958b..e9677475a 100644
>> --- a/testcases/kernel/syscalls/statx/statx01.c
>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>> @@ -68,7 +68,8 @@ static void test_mnt_id(struct statx *buf)
>>   		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
>>   			continue;
>>   
>> -		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
>> +		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor &&
>> +				mnt_id == buf->stx_mnt_id)
>>   			break;
>>   	}
>>   
>> @@ -80,8 +81,8 @@ static void test_mnt_id(struct statx *buf)
>>   			mnt_id);
>>   	else
>>   		tst_res(TFAIL,
>> -			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
>> -			(uint64_t)buf->stx_mnt_id, mnt_id);
>> +			"statx.stx_mnt_id(%"PRIu64") doesn't exist in /proc/self/mountinfo",
>> +			(uint64_t)buf->stx_mnt_id);
> 
> The mnt_id may exist in mountinfo, but not the triple (mnt_id,
> dev_major, dev_minor). So really we should print all three here (unless
> we already display that somewhere else).
> 

Yes, so how about the following changes:

diff --git a/testcases/kernel/syscalls/statx/statx01.c 
b/testcases/kernel/syscalls/statx/statx01.c
index 60b50958b..8f3b01b32 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -53,7 +53,7 @@ static void test_mnt_id(struct statx *buf)
  {
         FILE *file;
         char line[PATH_MAX];
-       int pid;
+       int pid, flag = 0;
         unsigned int line_mjr, line_mnr;
         uint64_t mnt_id;

@@ -68,20 +68,26 @@ static void test_mnt_id(struct statx *buf)
                 if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, 
&line_mjr, &line_mnr) != 3)
                         continue;

-               if (line_mjr == buf->stx_dev_major && line_mnr == 
buf->stx_dev_minor)
-                       break;
+               if (line_mjr == buf->stx_dev_major && line_mnr == 
buf->stx_dev_minor) {
+                       if (buf->stx_mnt_id == mnt_id) {
+                               flag = 1;
+                               break
+                       }
+                       tst_res(TINFO, "%s doesn't contain (%"PRIu64") 
%d:%d",
+                               line, (uint64_t)buf->stx_mnt_id, 
buf->stx_dev_major, buf->stx_dev_minor);
+               }
         }

         SAFE_FCLOSE(file);

-       if (buf->stx_mnt_id == mnt_id)
+       if (flag)
                 tst_res(TPASS,
                         "statx.stx_mnt_id equals to mount_id(%"PRIu64") 
in /proc/self/mountinfo",
                         mnt_id);
         else
                 tst_res(TFAIL,
-                       "statx.stx_mnt_id(%"PRIu64") is different from 
mount_id(%"PRIu64") in /proc/self/mountinfo",
-                       (uint64_t)buf->stx_mnt_id, mnt_id);
+                       "statx.stx_mnt_id(%"PRIu64") doesn't exist in 
/proc/self/mountinfo",
+                       (uint64_t)buf->stx_mnt_id);

         pid = getpid();
         snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);

Best Regards
Yang Xu
>>   
>>   	pid = getpid();
>>   	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>> -- 
>> 2.27.0
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
