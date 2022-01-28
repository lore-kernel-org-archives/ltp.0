Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74791C433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 04:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58B193C975C
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 05:08:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 638253C0214
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 05:07:55 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED8441000959
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 05:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643342872; x=1674878872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Cp22y/Pz7YYyyK7YlVmnU+4xjmZEoSdfYlsnNpotcro=;
 b=OdGMelz54DoSNQx1vIZQoi2746X+N0rTMH7jJEa/SiS3w+6qz8Us/fnI
 Ep6ItWEg48ReGqnFPDibBoFXOO7igLtKBxKAo9pu/JYQZj5OkFI80Ps1s
 BPZ73nK65JhYF0qEvVRropFlafrxb/HIXeveb57rf+onS7GrOgIgQ07Pn
 7FegD18vk9i7MXNb/yxBeC44h5HrJKU7i/Dj/gzHQTzL6legz/jOwlYXW
 Hp834vZ35qqBpa3TamB3ZFACGnME5xmTVCbTapmn0byJriBRWOgiuFEQ0
 g41QwGpRoYcNPdJ3WMjTeLnxSBqN6OxktW5eJECB7OhAtS/uaNa42Dx3g w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="48550172"
X-IronPort-AV: E=Sophos;i="5.88,322,1635174000"; d="scan'208";a="48550172"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 13:07:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqgk0Rjd5jur3arlP3QWSRYzM+VA9m1Ptn9nqpvhph86PvN4ZUTa7DfoCF8GES1oVBRy0yW4wF7INOjDERU0m75LRRP1XRBHSuSjS6gz+4oldmapUxohFVWhXNqts/FuoJ22zZmX4tOwmKwtvGvm3TVFMKc8VBxZcwc+gWX7vuim6d3/UBfvAZq3I5LSmLXqAfgtSvBL6Wk3zp0v5R8+xGgyfMdaYioIuRtBs+Bpnyt35Gb6PQ9FeSQnje1H8e1yymvEmzgQTrhhBUftdFrlmi7+ELiT8ORY+jlcX1fGraiapFsIvPnlyMigU56oBSB70XrYDMCWl8SqFn/+tgRdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp22y/Pz7YYyyK7YlVmnU+4xjmZEoSdfYlsnNpotcro=;
 b=EUySXSg7RUuD8NC6z9cAJ/WS40Cq3ntObw+cUV33rXBBQT8KvlT3Nkq+fqZsjR5gZfZzGfLm5wxzVjN8qeNQoJb0sGVx+M6MJC1C2drwfLmrNEB+9eK4BLCrc9BmdpJBn+Xh4nZPjG+HorDKMIZzR4qGtys6fw+MKX54SIroO/qgmlUwmITcSeKmZ7Tc+hyrqsvV7FLnMD6VqvNrVXwA+K1tG/IlT+ytjG68wXJ4yLalcO/IRezbeyUCXQjgyCcQTGbY9mCmiPIjDvohNvK5qwVzwjFqGyiS9L8gJsUtDSn8k7H+PBrEUB5QIbzuMVFy4RdXpONBNEe1iBxNRrMF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp22y/Pz7YYyyK7YlVmnU+4xjmZEoSdfYlsnNpotcro=;
 b=GUeDQmMIwRq5/fYHgbt2QF4aNP1zcOd3AcIL2s5I2iUx3XCxfoX2stL31S2kUbB6tQp/CzDCRwRsyjwBXAIMFbuIhPuzzV+OuMIs6qkixYOc7e9+A1HBcqsXYlgI6rvQGd1VO9sKCyzhd40L0zzZbEkN4Lbe+BpwK0aNjeQPcCk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB6986.jpnprd01.prod.outlook.com (2603:1096:604:13a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 04:07:45 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 04:07:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [LTP] [PATCH v3] syscalls/statx09: Add new test
Thread-Index: AQHYE/OZeCTmBTjp2EihaJYi60VOHax30X2A
Date: Fri, 28 Jan 2022 04:07:45 +0000
Message-ID: <61F36C39.9030806@fujitsu.com>
References: <YfKkxx1y4Ctgn0IX@yuki>
 <1643338947-1436-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1643338947-1436-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6d55832-c739-4688-25b2-08d9e213bd3c
x-ms-traffictypediagnostic: OSZPR01MB6986:EE_
x-microsoft-antispam-prvs: <OSZPR01MB698677ACA13C9A795DF589B1FD229@OSZPR01MB6986.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3uKLtLSdpkEk9lGxGvB+9szYymRn4nnEWB7rSjyLvUY2H5l7O/QxOgvI068hocH+nyKUAl/alzsq3aV2+BGqr5oyxv9GN//7ehw1VH/vfuxwyOYtf6X6rTT72ItHd2llWIkxUcmriRRjaBJWPxe5AKX834EguliD6gW4IhhAjhcxprYg3aCwXKmNteRz6Y7J7G7VJPeq+wEp0DLCncgMFUqwJ8+62/defgzkHjXFHEVLdA0eZsDIj/N8FlPS6CT+viOyJDziKmev8Ynvzl0h5MBHxKyppS/uRH+62+RD/vVTxM0z2zyP/dwbXg5EMSFS6uLIRDcWg7EW71jp55jp9EvKJ/Q6mi41wJLs0d9yJJen71Stf8oM2aRU99oEJpzjslM5r7269FmrMUvA4vPfZWq//A+PdDjJf7xJ/XQs9kRGlWEwqjF7PpwPNpqLE6408xMc104A/kLi/aQcfk5n3/boIAX6ZOfYC4z1iaEkfX+XonkQMkHSBBSXE6ZekBL2hWkEIIFmQ8zjMGAy4cOvzL/bDz1sPOWblOCmtdJuDkQPIggTv5Q3WQzyb4O8reFDtB86ccYodhoDQtg8J8XnZCqll6NuYAOSsRMXzznMiPWG4lcL+vJmReuN2WTuDYUldh/a3+V//LtaJVYwmuPyNxrIBZX4JHd0mAs3CRa76yuvfdcvbZYByvB++sS9B1jWgE9n5VapqQieIYN7SoP6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(71200400001)(87266011)(82960400001)(38100700002)(6506007)(122000001)(2906002)(36756003)(33656002)(85182001)(26005)(2616005)(186003)(5660300002)(37006003)(6636002)(6486002)(508600001)(86362001)(83380400001)(4326008)(316002)(8936002)(66476007)(66556008)(66946007)(8676002)(6862004)(66446008)(64756008)(91956017)(54906003)(76116006)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MzlrUkQ2VkpFQVU0L1k5VEZ2cGJjcVBjN0xwUm0yb0ZxK1RXTDBBZGw5c3VB?=
 =?gb2312?B?a2hWUml5d2JwZVNWMlU0T1NNZmxxdXorL3pnRTB3MjRnRVU5SWt1Sy9iVXRX?=
 =?gb2312?B?QkhjVTd5cmw1SVdaMlQ4ck9qL01hMXNKenIzRjJJbzJ3TG8yVmNDcnhTYmNL?=
 =?gb2312?B?eWpielhtNTFVbk9ZakcramVrUVlkdDZoK0VrcTVCb3UrSnVmQ2tvenMrVkp0?=
 =?gb2312?B?QTdsU0lDdCtadSt1eUhNU2NXcHNTMVJ1TzVvbFJrdXdCRHhjZ2Ewd1pTeEpT?=
 =?gb2312?B?c3NHcjU1NVVYS1oyZ290aG1CVSs2UWNyaWxLRElqWEFwREYwRmlMUmRBOUhR?=
 =?gb2312?B?Z2dOMGVWYkV3QWNsVExTVzAyM3hzbmtjQ2Zza0VGSWRLeUM4UFhORVMwTW5G?=
 =?gb2312?B?RTFJRmR1MThHdE9nMW9uK2MxZ1dvUEU5RmpLUXRMdGkzMjZrcmVaYS9sRkhB?=
 =?gb2312?B?d0dtZHZhUnBDOFdRUFhXc0pOK1VDZnY5bXo1S0tsQmU2RnVlM0NIVmo4MkVq?=
 =?gb2312?B?NDZjMmdmRzgwd3B1UUNUR2xYUERZemxUUnFhdm0yQk5LbDY0SWwrN0JSZjBu?=
 =?gb2312?B?aFZnalNpQXBtUzhVRGVXdEFYd2FTZEpHQXZIeDJkTm55eFVoVDBYU3NQWDhq?=
 =?gb2312?B?b1ZTRW5jalFKWWxBa0FOb3hHaTNwOWhodlE0Wmg1TmhOMlVHR0RJcmcrRmlt?=
 =?gb2312?B?Mk5UaHY0akR5ZHl0SDl1TVR4bS9DRnBJbzFLeWo3dUkvbzlBQlFtcXgxQmhB?=
 =?gb2312?B?N0F4STNFNE11aG4yOU1iMUpHblBxODBPWVJOK1hVRWo0OWdHdEtPenJMRlh3?=
 =?gb2312?B?RkFHdldkTVJUUnByVG91cGZNMngvamI0LzVnUGdIanBMQWljemtMUWZSVldL?=
 =?gb2312?B?anFBUHhkRGlGb3VORm8rVkRYNHNUenAvUmlkWVptcklFWGZZMlJkU1daL1k4?=
 =?gb2312?B?Tk5Pc3ZIUmFQL2NNcTMvNXVRT3ZXRTNYRnI3cW1kdTZoVmo0WkFwRitJZVBP?=
 =?gb2312?B?ZFl6SWlaMFpYNkUyL0trY3RuMFpXMmpxZEZuTHRESzdYdVhYTyt1OTEvM1N3?=
 =?gb2312?B?YXNDZkY3aE04UThJSm1GK2JQWGJiZGY3WHZSY3RFUUkweGJrRndPT2krbjB6?=
 =?gb2312?B?YVF0ekV5bWM2SSt4NnJ3MUR2WDU0QVA0N3l6aDY0SnRMM0tEVjJjZTdhbTNa?=
 =?gb2312?B?WmJHQVhwd3NCVEY1akwrMU9RSzNIMmFETVhWYUJ3NHg5TENUMHo4eWpYOC9a?=
 =?gb2312?B?RmJlbjJqWDljZ1pYaFNzNjRQV3ZBblJlZ1NPcS9OcDJHRUYyU002b1BHZXNl?=
 =?gb2312?B?MmpXQ2F2YUhqdVBnL28yUGI5ZzRDZFhnNTU3cnVHclRDcnlMbVRJVlVLL0lB?=
 =?gb2312?B?Y3p2eTJQak1LOERwbCtTWEFheVRtMWJZY3krM0Y2VGlJdzFVUTBYeGZEdEE0?=
 =?gb2312?B?bFNuUjBJWk1vNktyOWlRUXVKM0JFRVRCY0htN29MakhPZDhBc0dXLysxMlBp?=
 =?gb2312?B?MnVqUEErT24rdnc0enhUZjBHdkZkNW4wbFZSbjRGVTNtZndhMDQyUzZmQlB3?=
 =?gb2312?B?WUY5TnVMaGRmZHdLdU9VbTUyUk9iM1o2cjVFZ3I1NE9sT01XaUlPTEppU2xs?=
 =?gb2312?B?d092RkxTbytVNVVuakRQdGVWODh0Q3RDYzhOc3VEcXdMSXVld3FFRHIzdGx2?=
 =?gb2312?B?VlEvNzlOajZTckRuNWIxT3hGR0hGUDlkZTdQc1JLUWlVTE9UaGwwY2hiYXls?=
 =?gb2312?B?RUVoTllpOVN0MHh4QS9xb2piT3Y3MTdicTRuM0JoRG15UGlVT1ZqZjZpQ05w?=
 =?gb2312?B?UEs5ajJxQjVrOHJ1MmpDd051Y1FzTFJJUjR6Um1tYkErYmxDQm0xcVJ1bzlV?=
 =?gb2312?B?ODVydkdjQzRJZXF0MTNOdUJEOS9yQVRTUkZUeXQ0NGpJUXprYXh1NkJEWXpC?=
 =?gb2312?B?bnlScjRReU0rOUVrOWFpUnNwYk42WS9OVHVFRURCLzduV3dTM2JjU3JWYVp5?=
 =?gb2312?B?SHBCV0R6TG5wV2dKTklIT1diNXR3WlBPMkhCc20yWlVBSC9HZzJwNDhZT0xJ?=
 =?gb2312?B?VjJtNzEwZDZoWXN4WVd0K01IblBoVVpzVzlKNVBTQS9za1BPbVhxTS9NaUZQ?=
 =?gb2312?B?UStBOWVjczhkSkpacWdFRGV0VFdNUjE2OUJ0VFNieklETGUzUi9SMTNZT2V1?=
 =?gb2312?B?OUNjYzI0Y0liOGx5NHFiczJ2VmphSDdobkdoeVI2VjN6RHpxdkVNaFdZcjE2?=
 =?gb2312?Q?q0cbilM2TY6WvXTudkDl5WFLNc/hgDgpCy2fK720sQ=3D?=
Content-ID: <05BF92CC1486FA46A69E2EABF16AE96B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d55832-c739-4688-25b2-08d9e213bd3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 04:07:45.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rClTIsF8sKjRnWVpF4Zxsj6XyBcbz2GxRelPFEsDaplLUM5C8fqBUw9Eq5adSHIGLFbKrnWLNKTD83Y/oNkuWnCHlO35S1etyeTEWDzrOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6986
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/statx09: Add new test
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

Hi Dai
> This test is basically the same as statx04 but here we check for the
> STATX_ATTR_VERITY flag which is currently only implemented on ext4.
>
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   configure.ac                               |   1 +
>   include/lapi/fs.h                          |   4 +
>   include/lapi/fsverity.h                    |  38 +++++++
>   include/lapi/stat.h                        |   4 +
>   m4/ltp-fsverity.m4                         |  10 ++
>   runtest/syscalls                           |   1 +
>   testcases/kernel/syscalls/statx/.gitignore |   1 +
>   testcases/kernel/syscalls/statx/statx09.c  | 161 +++++++++++++++++++++++++++++
>   8 files changed, 220 insertions(+)
>   create mode 100644 include/lapi/fsverity.h
>   create mode 100644 m4/ltp-fsverity.m4
>   create mode 100644 testcases/kernel/syscalls/statx/statx09.c
>
> diff --git a/configure.ac b/configure.ac
> index 3c56d19..aeb486f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -367,6 +367,7 @@ LTP_CHECK_SELINUX
>   LTP_CHECK_SYNC_ADD_AND_FETCH
>   LTP_CHECK_SYSCALL_EVENTFD
>   LTP_CHECK_SYSCALL_FCNTL
> +LTP_CHECK_FSVERITY
>
>   if test "x$with_numa" = xyes; then
>   	LTP_CHECK_SYSCALL_NUMA
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> index aafeab4..27b3a18 100644
> --- a/include/lapi/fs.h
> +++ b/include/lapi/fs.h
> @@ -41,6 +41,10 @@
>   #define FS_NODUMP_FL	   0x00000040 /* do not dump file */
>   #endif
>
> +#ifndef FS_VERITY_FL
> +#define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
> +#endif
> +
>   /*
>    * Helper function to get MAX_LFS_FILESIZE.
>    * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
> diff --git a/include/lapi/fsverity.h b/include/lapi/fsverity.h
> new file mode 100644
> index 0000000..66bea15
> --- /dev/null
> +++ b/include/lapi/fsverity.h
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili<daisl.fnst@cn.fujitsu.com>
> + */
> +#ifndef LAPI_FSVERITY_H__
> +#define LAPI_FSVERITY_H__
> +
> +#include "config.h"
> +#include<stdint.h>
> +
> +#ifdef HAVE_LINUX_FSVERITY_H
> +#include<linux/fsverity.h>
> +#endif
> +
> +#ifndef FS_VERITY_HASH_ALG_SHA256
> +# define FS_VERITY_HASH_ALG_SHA256       1
> +#endif
> +
> +#ifndef HAVE_STRUCT_FSVERITY_ENABLE_ARG
> +struct fsverity_enable_arg {
> +	uint32_t version;
> +	uint32_t hash_algorithm;
> +	uint32_t block_size;
> +	uint32_t salt_size;
> +	uint64_t salt_ptr;
> +	uint32_t sig_size;
> +	uint32_t __reserved1;
> +	uint64_t sig_ptr;
> +	uint64_t __reserved2[11];
> +};
> +#endif
> +
> +#ifndef FS_IOC_ENABLE_VERITY
> +# define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
The _IOW definition is in <sys/ioctl.h>, so we should include it in here.
> +#endif
> +
> +#endif
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index d596058..ce1f2b6 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -223,6 +223,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_ATTR_AUTOMOUNT	0x00001000
>   #endif
>
> +#ifndef STATX_ATTR_VERITY
> +# define STATX_ATTR_VERITY	0x00100000
> +#endif
> +
>   #ifndef AT_SYMLINK_NOFOLLOW
>   # define AT_SYMLINK_NOFOLLOW	0x100
>   #endif
> diff --git a/m4/ltp-fsverity.m4 b/m4/ltp-fsverity.m4
> new file mode 100644
> index 0000000..7104886
> --- /dev/null
> +++ b/m4/ltp-fsverity.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2022 Fujitsu Ltd.
> +dnl Author: Dai Shili<daisl.fnst@fujitsu.com>
> +
> +AC_DEFUN([LTP_CHECK_FSVERITY],[
> +	AC_CHECK_HEADERS([linux/fsverity.h], [have_fsverity=yes], [AC_MSG_WARN(missing linux/fsverity.h header)])
> +	if test "x$have_fsverity" = "xyes"; then
> +		AC_CHECK_TYPES(struct fsverity_enable_arg,,,[#include<linux/fsverity.h>])
> +	fi
> +])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3b2deb6..7ba0331 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1744,6 +1744,7 @@ statx05 statx05
>   statx06 statx06
>   statx07 statx07
>   statx08 statx08
> +statx09 statx09
>
>   membarrier01 membarrier01
>
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 4db060d..1cea43c 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -6,3 +6,4 @@
>   /statx06
>   /statx07
>   /statx08
> +/statx09
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> new file mode 100644
> index 0000000..230176b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili<daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This code tests if the attributes field of statx received expected value.
> + * File set with following flags by using SAFE_IOCTL:
> + *
> + * - STATX_ATTR_VERITY: statx() system call sets STATX_ATTR_VERITY if the file
> + * has fs-verity enabled. This can perform better than FS_IOC_GETFLAGS and
> + * FS_IOC_MEASURE_VERITY because it doesn't require opening the file,
> + * and opening verity files can be expensive.
> + *
> + * Minimum Linux version required is v5.5.
> + */
> +
> +#define _GNU_SOURCE
> +#include<sys/mount.h>
> +#include<stdlib.h>
> +#include<linux/ioctl.h>
This can be removed if we use <sys/ioctl.h> in lapi/fsverity.h.
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include "lapi/fsverity.h"
> +#include "lapi/stat.h"
> +#include<inttypes.h>
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE_FLAGGED MNTPOINT"/test_file3"
> +#define TESTFILE_UNFLAGGED MNTPOINT"/test_file4"
I think using MNTPOINT"/testfile_flagged" or test_file1 is meaningful.


Best Regards
Yang Xu
> +
> +static int mount_flag;
> +
> +static const uint32_t hash_algorithms[] = {
> +	FS_VERITY_HASH_ALG_SHA256,
> +};
> +
> +static void test_flagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_FLAGGED, 0, 0,&buf),
> +		"statx(AT_FDCWD, %s, 0, 0,&buf)", TESTFILE_FLAGGED);
> +
> +	if (buf.stx_attributes&  STATX_ATTR_VERITY)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ",
> +			(uint64_t)buf.stx_attributes);
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
> +}
> +
> +static void test_unflagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_UNFLAGGED, 0, 0,&buf),
> +		"statx(AT_FDCWD, %s, 0, 0,&buf)", TESTFILE_UNFLAGGED);
> +
> +	if ((buf.stx_attributes&  STATX_ATTR_VERITY) == 0)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is not set");
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is set");
> +}
> +
> +static struct test_cases {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&test_flagged},
> +	{&test_unflagged},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
> +
> +static void flag_setup(void)
> +{
> +	int fd, attr, ret;
> +	struct fsverity_enable_arg enable;
> +
> +	fd = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
> +
> +	ret = ioctl(fd, FS_IOC_GETFLAGS,&attr);
> +	if (ret<  0) {
> +		if (errno == ENOTTY)
> +			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
> +
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
> +	}
> +
> +	memset(&enable, 0, sizeof(enable));
> +	enable.version = 1;
> +	enable.hash_algorithm = hash_algorithms[0];
> +	enable.block_size = 4096;
> +	enable.salt_size = 0;
> +	enable.salt_ptr = (intptr_t)NULL;
> +	enable.sig_size = 0;
> +	enable.sig_ptr = (intptr_t)NULL;
> +
> +	ret = ioctl(fd, FS_IOC_ENABLE_VERITY,&enable);
> +	if (ret<  0) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk(TCONF,
> +				"fs-verity is not supported on the file system or by the kernel");
> +		}
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd);
> +	}
> +
> +	ret = ioctl(fd, FS_IOC_GETFLAGS,&attr);
> +	if ((ret == 0)&&  !(attr&  FS_VERITY_FL))
> +		tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> +	if (TST_RET) {
> +		if (TST_ERR == EINVAL)
> +			tst_brk(TCONF, "fs-verity not supported on loopdev");
> +
> +		tst_brk(TBROK | TERRNO, "mount() failed with %ld", TST_RET);
> +	}
> +	mount_flag = 1;
> +
> +	SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");
> +	SAFE_FILE_PRINTF(TESTFILE_UNFLAGGED, "a");
> +
> +	flag_setup();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.dev_fs_type = "ext4",
> +	.dev_fs_opts = (const char *const []){"-O verity", NULL},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_FS_VERITY",
> +		NULL
> +	},
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4>= 1.45.2",
> +		NULL
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
