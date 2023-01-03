Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208FAC3DA7D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 05:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4293CB68F
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 06:39:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00823CB688
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 06:39:19 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 19F87600057
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 06:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1672724357; x=1704260357;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R+pdIB//VbS20/YQFhF3ieItjXilzwhqIwscxn62xJY=;
 b=xBSWM+7nt0bDaBqWPrrARwOCwJW33o2FvC7IFIPYCK6AKvYbVDUkNHwT
 6PqDyTqsCRBOj0+Tf/4IFCtrk4aci3N5171+j8LCUCVKxmDm+pkLWhDzx
 WT8oox7fA6Haq9LqJ/2Pxb6CfT/8zPMe58PRlAm0hG03B/RGm4BuYllPY
 v/nFirnm7licdpT6mCho5KrAersVjqnxey1QWbMBYBTzz7GGOvj8qCFuz
 yQAWfg7t1lrtvbrWowgvy+ElQ+5EG3kX7f3uxwOlZZjjgpqSE/ZjwMg9U
 sq72iUYwoDr6pLckfqWTLWDyE/Qn7jOE2vu2JtqWWtyE0SFM/N9i8VQJU w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="73658343"
X-IronPort-AV: E=Sophos;i="5.96,296,1665414000"; d="scan'208";a="73658343"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2023 14:39:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns9rpXxL2vfp0N4bl4cWQ/dgtjxirsG/tclqMcwcJX2me3KNqZZkoEnBKf0qCuqD1ElEedYJuaz440/Bil9q2ImmbJXmU3wDkbTzpyDtUe2EaQ2qpRpLrWPCKPp/DNgipzlsDD7y/VGVrMSeElL1F2s0JraAsj6qFcVODnY7KpQUqK0LAjR3hZRu+Kzc0+UuX6DApHFvc7of35B7hCMjuxiRA2N3Eb/FXbblNtCwYwWm4irctVGm7Z1DRU18zG/inLnl4YSScilq+F4aK7ivnINnhRo6a0/KCgshQQWRzljvCPlFf3oXhBNxUf/VwrJsPaqDHZ0JECN5zVX1fJDAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+pdIB//VbS20/YQFhF3ieItjXilzwhqIwscxn62xJY=;
 b=kq+9raEA2fnRbqX3YWimEMU7CA3/H0Zszn7ZVqGL5VICJ4HjoGfGpYPXLoApEefu0SK/lT2/TJY05mLM//LGRtgme9Ytxe2/PXDKk5eZp8UaBhP9aeQ0YL+FrZxHGxk9cExw0Xq+FCoNKlojWDMWP98pAQtmK12O00BogK6URy+V8I79wTVXf3GkUx0lvXrJfOuOCFl1cyTPRU2KGmoNHOE2cWUUtXDliArjXPV34ht/z0/BRgCGYqqsexUOqQoWxPrd2TTz5j2jQ1QXhlqRqrzxRLdrtmHh0XFbvIKDH7B2KjjxiUdSzKqJ482uEBDKUmb73otZrov95/8QjG1KXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB9493.jpnprd01.prod.outlook.com (2603:1096:400:19a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 05:39:12 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 05:39:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
Thread-Index: AQHZGcv5/MLYrMMoeEGuFUDAjeBWT66K5/gAgAFg34A=
Date: Tue, 3 Jan 2023 05:39:11 +0000
Message-ID: <73619608-18ac-2fac-6db7-022ce00801a2@fujitsu.com>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y7KlxBSIvN3q576G@pevik>
In-Reply-To: <Y7KlxBSIvN3q576G@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB9493:EE_
x-ms-office365-filtering-correlation-id: d4477609-c10f-40d1-1725-08daed4cd7c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmQxiirIEvuR34qZgomsADkTE8dJ4QjX26dmXNmGmMBhGkjXDPY6/w8rdbLuKntrNXEZ96JFXMWeMO5Rv5p+zDE9C6KStd8+uZCATuJtxq4Rnpc3Bpl7IEM/eaD/sUTNiox7QsZNpCQJVow39xQzW12B8N7taqnOm+Wkpqc9OCKMB4g8i09u6tOa4mwsOdwQXsSvsRKcPAt7vMUAgv6jymHIRFglzrW+eTlQCh/LEuITOpiMnKhyS5k4puRkbJXLe5WYIkBZnmW8SVyk5TSqNjWhceYdETpdlgV8iUN1VysWP3OIYj5om7kiar5FktUhqssU9N8SYx431aNmTTPDFJTJ9UCIwGmbQ1zGNqnWD3DXgptpLWgcWRXtfloLGhonXx1SE9kuUD1lCYCXwyJFa/ehfubMgbcJqzwSqxkJUHHohTjsTnmWVGCK+q7UVx7Y3Po52f+iaN0/CG6L3kJpCbWhqxcsrqfZdHI+RTrZxUCLGvjCm0rja9quiIaAFHFM/EEmkz202USGEofE1LbIH2K0RauhqgcCQX/VbpT3A//+t7nbrWAwp1XQTgEl/jp6PI+amDW2J7CQibEOQxffK8zWdNvcM+Y6AJyClKRr9qyZGspknyVAA851CVF++MfP8wvGAAMQ36/IavbzOISAsKQcC6MbpzDe1Xn+o7lQ2ViCU/Q/IOM68C7a2bJhRYLAmECVYa7qaR1VWHn0WrtO957U9PQGba7CY0mxvucOySpyJFObYyNXzhKpm7k9/z+73Y0W7/3bjP7R+m1zBhHHqjhyyOwDONCnw+eDU7uiLpU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(1590799012)(451199015)(2616005)(6512007)(26005)(186003)(82960400001)(38070700005)(31696002)(86362001)(36756003)(38100700002)(122000001)(85182001)(6916009)(2906002)(76116006)(5660300002)(91956017)(66446008)(8936002)(4326008)(66556008)(66946007)(8676002)(64756008)(66476007)(31686004)(316002)(41300700001)(6506007)(71200400001)(478600001)(1580799009)(6486002)(22166006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzgvK0FtMmlNckZtc1luVnRMbE41ZnJwV1BzM25BZXFlZHY0VXhGMjdRVFY3?=
 =?utf-8?B?bVYraFkvdnhQY21GbXo4UERRVXFBUDZRUEJ4cmZwZmpjOTFxLzRrVkZBMmNh?=
 =?utf-8?B?bUdNOWZqQ2IycUFTdU5QVjhWOC92Q1kyakgzeEJlZnhWR2JZZzgxN3Jyenhh?=
 =?utf-8?B?ZitnZ0Yycnp4dFBQZWRpeEZOSCsvaGI1VGJuN0U5dHp5SXlkaS96ZXU2SlhD?=
 =?utf-8?B?dmRxUk9yUkNDWGZLRGdLMjQ2LzFDZ3hSei8zcEswUkJ0SG54SHY3djFHQU9j?=
 =?utf-8?B?WGkxbGxlMi9vUXpxTi9TNjM5Z2FPdEJtSDVmNXZ2UTRLSUxabTUxWDl4WjBS?=
 =?utf-8?B?UDF1Q3I2Rm92TnkzTFo2a241NVdpS1ExeDAzU0RIOVh3UmhndVh0SHRUMXRn?=
 =?utf-8?B?OExQcStJTVNZWTlHelVGY1JDQmNLWHlNWWUwUlVGZlcvQXVtMkF3MVFkYzRT?=
 =?utf-8?B?cUQ5ZEg0cGhyT0gvYXRQVDNENk9jVktINTA0czdnVW9ENVhXWUJ3R3pESlVo?=
 =?utf-8?B?cnNLVGRiK0QwYnBRZzdPbUtrV3lhalpaeXd1QVBtdGRoZkhHVlVDMFBVcnZv?=
 =?utf-8?B?VVZCMlJEN0RRTWpENWlKQ0ZKOE1yc1F0NXBrK3EwbEdqY2M0cUdlNk1mM2xz?=
 =?utf-8?B?SlR1SGsvbTNPcGdrd2JJT1RUaksyVnZrQ3FXVWNrc3ZIWTJvZ0RDMWdlZ0kr?=
 =?utf-8?B?MDVreFhnRDdyaFM5VThHcGdOVjcybFhSczU5MDFyVFZzaUtQbUk2eGZ6cG9l?=
 =?utf-8?B?aWU4WkZQdHA4WXVUZXo4M2ZsOEtzNmRaRWJ1cDNMUm1HNXUvam0rdHlMc2Nh?=
 =?utf-8?B?eGFXYk9jNHJyNGV2Mzk2Zi9KSE5wWjF0VjNIbUJBUFR6QklqallvLzlvZFRT?=
 =?utf-8?B?QUd3Z0RFMUV6TFFIaXMwTmRXU0hLMWwrTGdSMEMxVlJ6di9kMlFWanRWNFpm?=
 =?utf-8?B?eE0rQ3hLb2NGQjBrdk5Fc29TWUhUVWNXTHhlcmQ3Rys5RVlVS2NOUlMxbTZV?=
 =?utf-8?B?NVRqTUN1MjVQamdyU2pkdG5RcGFYZFB0NlVLVkU1eGY5NjZNMzdqM2pvMXdr?=
 =?utf-8?B?b1k3ZVZLbE5pMDRra2N1ZzV3dFlNY3JydFN0ampEUHdLL2h5UjEySDRjNHN1?=
 =?utf-8?B?RkFCMjlqMm1SR0FJeFJTUGVtWXprS3Bvb21FQVBvWERtSzRPUklINmZiYVlN?=
 =?utf-8?B?YXY5ODZWdE94dEd4ZkE4ZTBXZjBNVjFzUlQxVitubzFmZjNTdi81Z0I5OXh4?=
 =?utf-8?B?V1BSaDc0aVUxZ0x3Qnp2SGd1Mk8vWDA1Z05TT0NuSEdrc3NZU1k3ejRDd2tZ?=
 =?utf-8?B?aXNjKzRoMitlT2krLzdSVCtCcVA3MmVxMkVZRyt6eHBYNUEybUZrZDFINVkr?=
 =?utf-8?B?UXIzanFmRTkvNjBvQmhyUWtzeDZoSm1RVHZ1dFJmZ2cyZWh5SHA1eHRqcld2?=
 =?utf-8?B?aS9RQ3RxdlVWNzhCMXY4RExueTJIR2FiL1ZtbnRxVmJQYmhpWEl2NkEzQkNX?=
 =?utf-8?B?b0JUczZVU0V2dzdNRTBsMHUvM1BvSmJYK3N3SjhBUWg4dE14K09aYko2WW5q?=
 =?utf-8?B?d3lrS3hJaEhna3daM1BMMkY4TDJMSi9hZ1pBOEllNmJYTWF6NlpxYkJjMHo3?=
 =?utf-8?B?SVcwYllOakR6amFVMmpJVzNmanFsZ2F3RVhZYWdKZUtueG1zQ1p5cXFoSU9F?=
 =?utf-8?B?ZXM0RFBHTVByL1NtM2tnZ1dmczdlTk03S0toYWVqb1dDaUZlWVVSc2I5aDVI?=
 =?utf-8?B?QlJLQm9NcHBtRDNVb253OWxzbU4zWmRvNHp6MlF3ZkdWNEI4ZFlnUzFqNVRU?=
 =?utf-8?B?TXNnbW5HRlByVlpXcWlGU2xTa0N6c2kwUUhtQW1udTVnS3R4Y0UyMmgvSnQv?=
 =?utf-8?B?bHRvQXpvdC9OejhpRHJOVzk4L05IeGNldTFaUjNEWXZ1OXVoTzdlZ3BiOVF2?=
 =?utf-8?B?c3RRdWZzbDNFWDdSMk1RSmpEdkJZSzA5bEE0Rk5tZFBUclVCNTJVOUdXcWY1?=
 =?utf-8?B?WDRhaDlpa1Zua2VKU0ZsSzEyVGdKSjlIWnlabHBNbnB4bnZqVDZRV3N6d0tN?=
 =?utf-8?B?VFZkeG85MStURzhRSmRzbndmUThHaVlZVUlOYVlXRzFRMTBHNFNNMWdJRFRy?=
 =?utf-8?B?M1VxUTR2aVhQai9kRnFXc2Z1UFAwMnlySjRobGtzM1F4bUludUpsVjJuYkli?=
 =?utf-8?B?REE9PQ==?=
Content-ID: <E14F8A2E59738D409D4F9A881604C0EF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4477609-c10f-40d1-1725-08daed4cd7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 05:39:11.9546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOx6lnE8r5mWkCbZezZCfKRjDboNhpeFdtSuVXt9tn1J93/bf7YNRnDIeaDJWJBS/zh8+tKeaeEWBwS60y7EQqU6fkHXHdk3G9Dw0Ly6EmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9493
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
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

Hi Petr

> Hi Xu,
> 
> ...
>> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> @@ -21,8 +21,7 @@ DEBUGFS_WAS_MOUNTED=0
>>   DEBUGFS_PATH=""
>>   DEBUGFS_CONTROL=""
>>   DYNDEBUG_STATEMENTS="./debug_statements"
>> -EMPTY_FLAG="-"
>> -NEW_INTERFACE=0
>> +EMPTY_FLAG="=_"
> 
>>   mount_debugfs()
>>   {
>> @@ -55,11 +54,6 @@ setup()
>>   		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>>   	fi
> 
>> -	if tst_kvcmp -ge 3.4 ; then
>> -		NEW_INTERFACE=1
>> -		EMPTY_FLAG="=_"
>> -	fi
>> -
>>   	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
>>   }
> 
>> @@ -83,10 +77,8 @@ do_all_flags()
> 
>>   	for INPUT_LINE in $ALL_INPUTS; do
>>   		do_flag "+p" "$OPTION" "$INPUT_LINE"
>> -		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
>> -			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
>> -			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>> -		fi
>> +		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
>> +		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>>   		do_flag "-p" "$OPTION" "$INPUT_LINE"
>>   	done
> 
>> @@ -131,7 +123,7 @@ cleanup()
>>   		FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' $DYNDEBUG_STATEMENTS)
>>   	fi
>>   	if [ "$FLAGS_SET" ] ; then
>> -		FLAG_PREFIX=$([ $NEW_INTERFACE -eq 1 ] && echo "" || echo "+")
> FYI Original code was ugly, it should have been
> [ $NEW_INTERFACE -eq 1 ] || NEW_INTERFACE="+"
> (Now ignoring that local variables should use local keyword and be lowercase.)
> 
>> +		FLAG_PREFIX=$(echo "")
> This evaluates to FLAG_PREFIX=
> => please remove the variable as it's always empty
> 
>>   		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
>>   			/bin/echo -n "$FLAG_LINE" \
>>   				| awk -v prf="$FLAG_PREFIX" -F " |:" \
> change to:
>    				| awk -v prf= -F " |:" \
> 
> NOTE: I'm going to cleanup the test after you merge (/bin/echo + variables).
> 
> With these changes:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your review, I merged this patchset.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
