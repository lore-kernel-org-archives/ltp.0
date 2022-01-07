Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16971C433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EF7C3C909D
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:23:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55B483C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:22:54 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A42891400C64
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641547374; x=1673083374;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ut30IvXwp7wRHS1JjtsOOFeT4MV27el59kYuNC3mh5Y=;
 b=R220stokr0Jb0ZQ30f57sqbMXGiPBwsQM8wsaz3LjK3bofk8ap/Rjdtf
 UMKW1i748/wNO5d7VytPy870Ik/eDKw3amLYVZKa9OB7olJ0U2RxUjx62
 5J3KCU4ZIbZ7wRRiBwHXxav44GElsFsdyVwkLHeHJrOTZB67KrhPL+z+N
 VuiLgbvPziOrR2yPmeSAxUfalBKdnzfLFr4LHJ8BDE1xwu6PQVW8qzKDw
 sTpnjZKk+pwV6Ni6X9LiVE65q7hfmyngcqLYW8sYtBFnq3Rhs4jIFtXP6
 S3sZxuWxz8GLT91qODikJi5Gjg4QQnQvOUH8iuJVqSezM8l8bLggMw640 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="47191787"
X-IronPort-AV: E=Sophos;i="5.88,269,1635174000"; d="scan'208";a="47191787"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 18:22:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPMVacCFY+ykEixECUM6bAvD8qsOW+Kn+A9mpk8B2OwRNjDZu4eRR6SP7WJUr72+qz6dQ2U73lPMaos79L9koNI5qFqXY+agpcFcNE3mCxDXVtOjVq0RdVrl/K2zwK6A23zBqON2/JhvoUsC0OIs+zSUkLGUafQ3NXr3aHQivHDuntK2lCwvGAt4PfeqC1sguS1/i2kOo04JhWbr/Dls9uBV5qx1UT1ce+bfI8gOiBkCJVE5/LJ1PbCIj1BFnzGwG8XJMm+8BBXx50GVlERUa1Y/C3QGjp1Cl/95KZ0BB1O8j6Y/X/CKP44APbyYwobM0n5G5Ok+IJ3WNZYsLw3Xkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut30IvXwp7wRHS1JjtsOOFeT4MV27el59kYuNC3mh5Y=;
 b=ngzhqDQ9ERIH84bizA8M1H6ezVIwymQitwNEn161lxpi1EZOE6+HOA/57SnXAF9vWUs2jdN30Ni1dQV1N9YTKrJyyDa2q+Ys3Mrz33dtjxlI8mLTUjGDef8n2DE/mYP8kFsdTnSFPq7WlpY+N9yVjHF+BIA7L/ehsq5IjtUoKY6GCJOpXR21evMjyRNwLRUpnjGEufe58Coo12OnSoei53rnyrqVrfHx3F0F6ad6cqeryCViznDtCTvRaZceFs5/iB4+chlXAj0uLFrxAgBkDBQ4fyipfdbgSXHDI+IR1SsOcvwosMBgiJgInR41nLnK9ota0E+jigyS81GQt12ARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut30IvXwp7wRHS1JjtsOOFeT4MV27el59kYuNC3mh5Y=;
 b=IFERX8WGynAA0Sf9FMkN2DGOvPteiKoPQmFDCH40MuIzH3I2uqR4uO6Saoikcf7ACB1psJ1Ga1/BvXlWe+bry3aSe8Qhn1xuLXgDPMy/hyeXctnvDv34ZdPwRND1KMxnRUCoiGoKZJec2pIoPoj7M+CictO4zzJMwqnV5/wI/W4=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4940.jpnprd01.prod.outlook.com (2603:1096:404:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 09:22:48 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 09:22:48 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
Thread-Index: AQHYAt9Ym4q3iJDhlUyEGKaxT+lELKxV2LUAgAEWM4CAAAQggIAAMLkAgAAXlQCAAApPAIAABRWA
Date: Fri, 7 Jan 2022 09:22:48 +0000
Message-ID: <61D80693.6030501@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
 <61D7F9AA.9020401@fujitsu.com> <YdgCUBI6XQRGRWGh@pevik>
In-Reply-To: <YdgCUBI6XQRGRWGh@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77cf8d96-b73f-42c9-b173-08d9d1bf458e
x-ms-traffictypediagnostic: TY2PR01MB4940:EE_
x-microsoft-antispam-prvs: <TY2PR01MB49402DBE35851D98CABB0489FD4D9@TY2PR01MB4940.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeJTIgN4h/d8efZ0ZJADLJo095lG3fB33t+gEM+Nj6zw+vNKLjuoacCYqYjBhkhpVUKWnyoAUVWueGyBen9g0/sBIUenuEBJknizGtkrv46BUWs9WVSmOSv+pHOqBKapxPLjN9nmndKFfV+in2UP8b8iSXaC5dVf2e20Q5wx3qccJvDBrvq0Vd4hugqilksdndvzptruKjMZ5GSN9LVLiIvA5UrfirYXnxe28UhqCOE91bOfhhpuUl2ckDk8VH+3MEnnZ3fE3Q9FDP+qHYKwLQXChVblIuO9MQV7jCTFj4rc4S+GrX4p0DklSNviMkOmv+GupHPcr1lEqIcETZyvVvFl3bgAcvpbUtwGAdM8snTQ5ko0/wdpeTIGcKbtdJvXzZV8sF6m85jnqI0H8lL4MNP1hMHqwplWFwNamcY9WHQp6vcyAX/9ldJy+MjMIwCHRtMvYn0K6GwSCQq5AtpAm3XgiFFfjNwArxVpWx53pLD/vf0HtmRfS2Z4o0hEVBerzhEbxR03usy4Tjo5J09eVyOpjTJoPzoaYfXZUzSm8DOlDKv+jRtYBAqO7LdJDTgyV/90L+DouZDJVdLPCXpc7AC5X3eolq8FHQPd6zx6dWFjhxcJbvQu1g1Q1dKtRqxpmloNkcK5K2bpLustMfKBsgzKfAvktvQIAhAtEtJyiKN7YhN1+IgBlN9ltNfHMLHpwp6FVUQuxAyP2/i4hQOfoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(33656002)(66556008)(64756008)(2616005)(6506007)(26005)(91956017)(82960400001)(6512007)(186003)(8936002)(5660300002)(85182001)(66476007)(36756003)(87266011)(66946007)(6486002)(38070700005)(4326008)(8676002)(6916009)(76116006)(71200400001)(508600001)(54906003)(316002)(38100700002)(2906002)(122000001)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bWhLOXlEaWlWVnA1ODZXOHZyYmU3Y1RyWkxLUUE1R1lkVmtUckZJQkwrR0tY?=
 =?gb2312?B?VmpEWUdYZDFlSnJzcnRHS0hGNjRQNTlIbEEwM2VHc2ZMbUNVUHZYQlpQUzJP?=
 =?gb2312?B?b3AzS0EvUXVlR1ZVQlN4NXVhc0FRVFd5WVY4eTYvcFQwb1B2Q3BXdnMwWjhw?=
 =?gb2312?B?V0Rhbnp1d1pLYk1UMjR5TzQ3dm1hbU41NHo0RFlwcHQ1WXIwM21FVkZQeFZa?=
 =?gb2312?B?amF2ZlVncXV5ek85QWZwRXBISVhFdHhET254b3JxZUwwakhBY1RFQkpFbkZI?=
 =?gb2312?B?MkNJa1BJOWpxVEFuWEJIOEprZEd0SkZwdUczSHpYbUlnRk5lckRESTM0N2JY?=
 =?gb2312?B?TG91WU9yMnpSK3F3Qm9SaGJVUUtUOHFoNHBWRUx5QkwxWHZDT0Y1VGZwb2lv?=
 =?gb2312?B?d3Rwdlk1SVJ5N29QQjdBMTRCZFkzZDRKcmtWZkxIOFJCeE1HYnRnN3drMUtU?=
 =?gb2312?B?eXlCZGxLbDhaT1YxUDNPbmtEWW9Jb0NVS2hzeGZtTEU0WC85bGFOQUF6bC9h?=
 =?gb2312?B?MjVidGJTZnJHVUFha0g2Y2lQMW9PdnpaVk40L2xuaktmQ21zUDlFYlJVMTVB?=
 =?gb2312?B?Vmcrdm1CR3cwekVsRVFScmFCVCs1bVd0dWIzM01ZN3FXZ2N5bGRIOGFYYnV2?=
 =?gb2312?B?a2lGd2dSY0pleXp3SUw5YlpHSzRZYytBN095aGQ3YmtndHh5Z24weDZwTFVY?=
 =?gb2312?B?UDZ2NGExUDhQOWFJVHkxZG8vdDFzaldxdVA5Q1piQTZ3cXhvTjc3dlhyK2xp?=
 =?gb2312?B?ZFA0cjlvMk1JNG9CMEFjRjk2Y0tFRWVaRlBCcGRraWZCV3pBSkJWNXF4dyt4?=
 =?gb2312?B?SCtod2hxc3BkSXIxTTZGVWJJcGdmS3dTcW50YVBHWUpWYXVCZnh6Wi9GQUQ4?=
 =?gb2312?B?YmNPekhEazIzWE9EUXZmSEMyY2NGbXZqakpIZS9PMWxhNmpyOXMvT0N4YjZS?=
 =?gb2312?B?N2hmYWVybDVHY1podk42OTVIZmZWL2xiSWU4a0IvVkUyTHVEUUNYTEhScXZx?=
 =?gb2312?B?dlBwdnk5SVhLd2JUVWNXNjc1OE9rYmU5WS80cUR4RXlodWI1QUh0bDhrRjBk?=
 =?gb2312?B?U3BGVGV1WGNnMGlvWVExQWh2Vlh4d3g3RTVjMExzL000QlBLZ2ViUVAwaXRt?=
 =?gb2312?B?S1o5dTdzL20vVEJ0bHAyZlpENDJKT3hSSjhQNkF4Yk1vbjAwVTVwYkNnWkUx?=
 =?gb2312?B?dTRrc2pheGpIYnZuM3pWM0RqSWF3Zy9kcmZveGtQRXJDekZUUENhSGxHV200?=
 =?gb2312?B?RWFBbDdHTjJ5cWQxbmpKVmRsUGtIazJnb1dlTVUwc0tlQm5VcVhDTkhaQmhJ?=
 =?gb2312?B?NldvaGozV0pnRDRsYXZhK2l6UU1JQ2YyUUhsSHh0UjdlZ3FRTzhwNjh4dGNh?=
 =?gb2312?B?Y2xaZ1RUWHR5N2dqY29hYUQ2ejQwc0MzeXJRR1Z4MUtMOU9JL2ppeWpEUnhy?=
 =?gb2312?B?WnQ2Wmlxc2xRSnYwOCtlRmZvdXhsSXFiSGhIS1p0aUdmWXRGdlF6WHM2SU9T?=
 =?gb2312?B?Smh3bmlKQmZxUWlCRzhzbGFJQldxV2xHVlJkWjJvc21VNzBwUDNpanI3NVlp?=
 =?gb2312?B?d1FMS1d6clZjd1htSU9lYVJHNXlURXRCNEMvRzdhUU95K3FjRVVVanZqQUZD?=
 =?gb2312?B?N1V5aXl5WFBEbUVqTXVpMkd4Zkw0TkhpWlVDcUxkSWZYTjZvQjZ3NW81ZExY?=
 =?gb2312?B?ZkhtUitLOVdOalIyUEQzZHI4VjgvdDZwSjdmUEEvVXVDTGlTK2piUWNxSFl6?=
 =?gb2312?B?TjlYNmlLbVJFZlRJajMzbE9nVDYzQkNzTHJDSkk3cFpTQXR3U2c2VGxveWFq?=
 =?gb2312?B?Tkl1N3l2ZUVaNmFtSEdqR0VkYXR6Z05vdEJHbTNSMjRYSkdmVncxUVhKRCta?=
 =?gb2312?B?TCtFbm1xd2tZLzEzekdvanp5NzRpeGpqMjJZTU1MYWp0cFlSWjBRVlkySHJB?=
 =?gb2312?B?eU9HR2RTTzNkU0duS0ZNbko3MTkrcjFwcmg5NmVEdjhYV3BVdStXYnJ4NEZk?=
 =?gb2312?B?eURBNlcyRmQxeWZ4VEtPaThlL2hrUWRtMGpJWlpGQk94QjlvMUN2NzZob212?=
 =?gb2312?B?TzdIc0ZXVFV1ZytSN3VlLy9VZ2d2eHh3S0tJbkJEcjNBV0lCdVlMSHRtaWIw?=
 =?gb2312?B?c1BQelN2c2JmVC9FSEZ4WTZoaCtJZnROeG93RzJrbC9YRk5pM0dGM20zbVFX?=
 =?gb2312?B?SE1taXp2bDN5WXRmL2pETjRBVGVXTEkza3B0ZzBTalJXODljVW0zWnZKZWF1?=
 =?gb2312?Q?VLxgydZSEhc92ksZlfjXRDiD8T7NRX5UY+Apza3ZZY=3D?=
Content-ID: <777D961851E60447A0BB80E7724389A3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf8d96-b73f-42c9-b173-08d9d1bf458e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 09:22:48.4949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4itseVsrqdnjKkUkb11W1VO/jNMHlOPNylQYKsnOAlysfxlxB0Ooml2tgUSTBklEXmd4/8/YqB7XxdEYG+DJGWnOyiS6FTlJ9Pj/YWcDu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4940
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi all,
>
>>>> int main(int argc, const char *argv[])
>>>> {
>>>>            char delims[] = ",";
>>>>            char kconfig[PATH_MAX];
>>>>            char str[PATH_MAX];
>>>>            char *result = NULL;
>>>>            char *next = NULL;
>>>>            int i = 0;
>
>>>>            if (argc<   2) {
>>>>                    fprintf(stderr, "Please provide kernel kconfig list\n");
>>>>                    return 1;
>>>>            }
>
>>>>            strcpy(str, argv[1]);
>>>>            result = strtok_r(str, delims,&next);
>
>>>>            while (result != NULL) {
>>>>                    strcpy(kconfig, result);
>>>>                    printf("%s %s %d\n", kconfig,result, i);
>>>>                    const char *const kconfigs[] = {
>>>>                            kconfig,
>>>>                            NULL
>>>>                    };
>>>>                    if (tst_kconfig_check(kconfigs)) {
>>>>                             fprintf(stderr, "Kernel config doesn't meet
>>>> test's requirement!\n");
>>>>                             return 1;
>>>>                    }
>
>>>>                    i++;
>>>>                    result = strtok_r(NULL, delims,&next);
>>>>            }
>
>>>>            return 0;
>>>> }
>
>>>> But it must call tst_kconfig_check for every kconfig expression and
>>>> print many info "Parsing kernel config ..." because we need to create a
>>>> NULL terminated array for  tst_kconfig_check.
>
>>> Maybe we can combine the arguments into one kconfigs struct and
>>> just do once check? something like:
>> Yes, it works well. Thanks.
>
> LGTM. NOTE: Cyril suggested strchr() with loop, maybe he thought about even
> simpler solution.
>
>> I checked the kernel config, it seems comma can not meet the CONFIG_LSM
>> situation (Petr mention it but I don't notice before).
>> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
>> so I think we may TST_NEEDS_KCONFIGS_IFS variable and default value is
>> comma.
> Maybe use '|' as the default? That's very unlikely to be used
> (but I'd still have TST_NEEDS_KCONFIGS_IFS).
No, look test_kconfig01.c, we use '|' for a valid or operation.

Best Rgards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
