Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DB5C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 01:44:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3113C22FE
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 02:44:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5E143C0551
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 02:44:32 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DDA741400755
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 02:44:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638841471; x=1670377471;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=I4S+gDlCLJTu5/H7o18nzkHV2T561qH8v7AK/vT1DOA=;
 b=FonRm5vri9wq3y2/mQN69LtjXN75+DLjaJo4l3QM8SaEdeicFcULGCQT
 h3jHA2ndjtmY2/kJgkFzlTvrbs7GeJMCAqYey6GGQa4D2sYVOWZogIUfP
 +s7JB6nceD8YR5dGu23661NtQFmbnuKNAWd1uyl+9wjhd53a4YRLGqBiA
 MvG6tzDhEzI2LxeQETfqxbb4iYRkfM2D8y8ELOnpQq3BO9QwbN68yHoSF
 3ZU7BKnmyw0P35R6rFB8dBm/GsVJw2f6eqo4En/z3rwXxyPKAwueseOKw
 KuhLzClrteHS75rU5KIov7WtU2DS4ziyqg5u+5I1Yuf8Efcz1LXsHHc1j w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="53392389"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; d="scan'208";a="53392389"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 10:44:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf5ZWFF3s5DMUm6Awr3g1j0PEDRxOTKzjtwvxcTpc/UWHwXvZBPbAVf/F5aFltoF+i8Mzvm0Bs599nYiYBVQ129dsny9o4c1H+G9nnmGDT+WNN2kskbzEnIrzxrBPYIHbWOLxl7zAIhIFYdz7JGxHFSdhL3UVPOMf0/LoUOvM+i495B8Ok4yMq6WAqH3o2Z7ykzJgY7K77mBuAteDwoKwdj2g45BEI62aL4tydDnvuXPvtX10GnJh5hFJ1ILChJt6uacEzK9/E3MVkYoNSG8h5R/YMFqs9DCr4xLj0hGoPvQdlGl1qmntgsvcUMKGHIh7QhL0e5fGwsk0IE9JLsxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4S+gDlCLJTu5/H7o18nzkHV2T561qH8v7AK/vT1DOA=;
 b=BwpjJSDr34Tmqw5Eh1BhhTwvaY6/zscauojaNMDlwED7wrv9C/D7TlXCQoPi8Yg6gwcNZ6Jj6zz8xTR16LQma0U4aTDiKht9r+B6ywugenuvCGZFJSntpWY0Dkg9FylEY6MobNVYISGFd7C3iyZdejyC+3o8yOD8YTfU+6YgbMoqvekcrTQdeOUUT3MQxFDYf2di4jAj7Psgmvz6iIUbddTAX5Eo+5dq+jpOJ6DaPeCPWCYXE4uNQxt48sN8FrCh+4GdQ6nV4pvVdA5eo2uSwIz8LdBVTKB3jQJxiJp1cgDtojKeFFP8BklzCydud3/9eTrkBfdnSkOpj+/etdKctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4S+gDlCLJTu5/H7o18nzkHV2T561qH8v7AK/vT1DOA=;
 b=ETrOqOKOW6dkvnNVCiAXPqk4YRZXHWjIXEVetr7MSlaKAjHCSz9huQEVmVS3eq2EVoIJLrZC81i7b6UlaW+GI8AZp60IfpuXN2xH4SjtahzSsC81jw+CvgLKyrEm5NF8yRVWya3Q2rKjR4V/dZ8Fm5R1ozvDfL+x9sC/keWohLw=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6126.jpnprd01.prod.outlook.com (2603:1096:400:49::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 01:44:26 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 01:44:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/statx05, 07: Move e4crypt, exportfs to
 tst_test structure
Thread-Index: AQHX6p6xhfduB5yyjE2+0yQVUkiCZawmQtiA
Date: Tue, 7 Dec 2021 01:44:26 +0000
Message-ID: <61AEBC9B.7070300@fujitsu.com>
References: <1638328511-2534-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ya4Fa01xi7/iKaC0@yuki>
In-Reply-To: <Ya4Fa01xi7/iKaC0@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5752fc1b-2724-4c85-54b4-08d9b9231a2d
x-ms-traffictypediagnostic: TYCPR01MB6126:EE_
x-microsoft-antispam-prvs: <TYCPR01MB61268DFF096C3CE3D144705FFD6E9@TYCPR01MB6126.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFt7JCbS8af/+J+TaZV3q51iLwS81it8GPoYU4Mfv95PPzbYaW2VUZIDng3do1vh15zQ0pM7uRklBU2tyqtq51YvHAWEIahjqIlOfCnTKL4ZTjtUmfbbhiKXHGZaN6GTud5qPAhSLsRc+ovqzyda4ctuwTiqantv6D497P8DM+fDHzQOBZpciQaBY1Z6GvaJpjsp9XCPMjOyZljr8jxoQUvZYwNSb/FbgML0Bm7WXgBzshUUo0B0WoU6wpyz8/muupZrxUODQfD3RC851FsyXMFYroFelE0bF+FBgXZJnXV+yDx3uwy7gKWsBMeorHiojlmD2HNT+rUHwlITMfgLS2Ypb+49gjOgWbHfM6e6CXze6Up0DE862LhTjujn8FnUgoPO224OjUcTNUF9Qx75gXmIYryUV5lhzqwOg9CIW/XgUIkY1Q3+MSOWC7S5YRDKx0U2io4nFG7OpLKtblkh/44gXGxyxLral2bCgw6knE4IbT5D9iNV7bQ53FWCpQpM4rtgXN4BAvNKqYHtdt9g+YOVENekl3iets28/1fg3ma6/MZ2FBPvY2JWLB4qe8JRoU1KwWdoFLJvUVgMtqIe2MbE1kp8CMK+mvLGin6JCzVBPZlLzvKnHvi5bfxwmwXk7shwls0Rgq2m4CSB84uKfFcu7YARYDejpNhCZLfB2+10rS2JkzUlwcfW8wXVlCkoJCM7jbCvNnicmfHMkCe1iTWsXBvNGEFriL1MceM7SWE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(8936002)(33656002)(85182001)(2616005)(8676002)(186003)(91956017)(26005)(6506007)(122000001)(38100700002)(82960400001)(508600001)(6486002)(4744005)(316002)(5660300002)(71200400001)(87266011)(4326008)(6916009)(6512007)(66946007)(64756008)(83380400001)(2906002)(66476007)(36756003)(86362001)(38070700005)(66446008)(66556008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bStvZS9NaUcrQk9oaWNhMFF1Mk9VZjhMMlhyTlJZOHlRSmFlYUZFUldjZ2l2?=
 =?gb2312?B?M3o1dVZld3piRU9GeFBldFlTYmpGVFN0cllFcHhXNTkvSE1xWVJUeWF4dzJ6?=
 =?gb2312?B?OVZhdXlIM1A1UTVZM1AzUnlIRFVvREE5eCtOUXk2bTRmd3hHUGNWWGtTTWxs?=
 =?gb2312?B?MnVuRlRwenVDYkxMYjZ3eFBCUjU4VWtXYWVtQlZNYXVmL29YUG1FeWw4TGRk?=
 =?gb2312?B?dWdscXRuZm42cWU5aDBjK3VlWDRCNHZDTUhkOGpVNDlYc2dBQU54Q2hwL282?=
 =?gb2312?B?b2xWWUl4YTFNV1pERjFzdnI5TlJMc05SWXNYM015enlOd2Z2U1RKVlFySkU5?=
 =?gb2312?B?dlVCUnk5YWhNYzl2dUs2ZnlTMzduUDBIVEdEdDdiUzRrai9tdm91aHRBaG5p?=
 =?gb2312?B?N1F6aW1MNFF1VVRFT1NWS0ZaWEJZL3FIaGtCanJQblM2ZlAwQjdhQTNFS1Q4?=
 =?gb2312?B?QzgrV2R4U0U4cmRiSUErQ2gvY25yKzVoSWVnRzgvdlZ5dWZqcTZaRFQ5d09h?=
 =?gb2312?B?YjlCdWd1MmlYMFZrNENSMER3K3MxdGI2WmVpVU9DTTM2ZFV2RTFuZ0thcVJS?=
 =?gb2312?B?TUlheE5EYTN6SVBkM1RWTHdzYUphdEdTd0UrWjBhSytNSi9OMEJEYkZwb3F6?=
 =?gb2312?B?bURxT3NyQ29vWU1nUFFrak9LN0VZZjBidVRpTVFPbEY0elkzRVBQYXl3MHZO?=
 =?gb2312?B?ZStwUHNFcTd4Z1lmVlhQb2YvVnBGNFJ2UG9rRmtYa0hDaFh5VGtNM0diQ2tV?=
 =?gb2312?B?ZUMzWlRhbTNLS1FjbU1sb0tKNFJjdEtTUC9IVVR0MUxKMXVrZVpOeWNlRzFK?=
 =?gb2312?B?S1pnUEtMQXNQOSt3YTAvalZESC9EU1YwMXR3VkhwZU80MGhuUHExNWtqc2JO?=
 =?gb2312?B?TEIwMDlFTW9jMmREdExJNjYyWW9kREw5SFJpZlBhS3dvYmp6WXkzT1I4QXBD?=
 =?gb2312?B?UUpDSDJJOEpydzZCUE5ZV2FrMDhVQUE3QlJ5VmJwVTVvanl6cW92Mi9PMUZl?=
 =?gb2312?B?Q2w5SVNOdVVOdWF2OWtxNFRDYTh0MjNWUmF5RE1tblQ2NU5jcXA2WTBpWERL?=
 =?gb2312?B?QlBLcTRPakZrYWptSE5LRk1NalowbTBFRk5pMEZYL0xOZ1hNa2VqWVI1OHAx?=
 =?gb2312?B?aC9DclpoWEI0RndzdDNvZ2diSzRycnJrNVg4aTZBZjZGeWplRTZaMEhpRGR2?=
 =?gb2312?B?ZS9ES0c0c1VtSXVPUnY1QUNzUUlSQ2l3cnpFSUdxOEZmVzR4dkhzaS9oYzMx?=
 =?gb2312?B?T01OUmdrUXhMRG55ck9jMzA5alhTaFVueGlHNmFNUUtyNUI2VzZ2QmhZSk1D?=
 =?gb2312?B?OG8wbmd5OHl2NXVSTzgvNUdRd3RrZlZOYnAwT21HUWk1NG5aN2xnM3FMK3Rr?=
 =?gb2312?B?Y3M3d25LdGRXOFZCaVc2Y0t4cTJqWUlYMlhGWVNVUWwrMnNNOUE5UW5pTlNX?=
 =?gb2312?B?dStwKzVUN3crUE9peVlMOFZFR3pSYW12eEZyYkxjcU1OVjVZa0l0TTdZMjJF?=
 =?gb2312?B?TWRocDE0WWRadXA2d3AwN3lwcUh2NEUrTW93cTJ5VTNFK3FWTjIrbEVkZkZs?=
 =?gb2312?B?VGUvWmxsSWlSZ2VJT01DRFVpU3pzZXlEM1YzR3dBTHpETVRCM3VCM2FpNzZr?=
 =?gb2312?B?STh6UjhmWENUMm5aQU9XdHFqTFR5bklHbnJpd1hhaytWaTNxRnUyWHdYVnlR?=
 =?gb2312?B?STQ3bHU5TG5pVE9Xd1ZXbXZ5UDAwb3RBZGFoUGpPNHJwWTI1ZGIxWE1DSzVx?=
 =?gb2312?B?eWpZSmtwWUV6SUZweXRjYkM2MXhyamRFbHM3ZlM3V1VQQ0RmNHFkdlFsaW1u?=
 =?gb2312?B?bW5EWHNxd0FEYzRVVDFaQW4xTm40S1BKcUNCczY3UTBSYmZVMEQ3UlBHS2hC?=
 =?gb2312?B?My9YOHNYT2ZDejdWR0o5a2pUcHpGV2ptTVlkSk14b2FQclpseC9pMDFIUzN2?=
 =?gb2312?B?cHBvMmErSndnUktWek5tZHVpSGlTcW8yanpjazY0ZW1nNUZRa0NGUFo5ajNs?=
 =?gb2312?B?THdiTEFZVlVNSDcvZ3pIMDBNMkxhWEF2ZElMOU92aUlZdzUyVVBZampyQzc0?=
 =?gb2312?B?RTlvT1ZlcUZJNENlN2dyUHcvTjg0aEpIR0l4M3MxbTJ0TjJpNnlWTURzc0RX?=
 =?gb2312?B?TmIzU2l4T1hteGlUbXBlai83VWxPSzhXV2Y1WWlucGRDQzBaL1BzSHVhenRF?=
 =?gb2312?B?RUZ4c1pMTkhmMGN2S01xeGduMExMakVLb05TN0Y0ckw0RmE2dUpNdy9CMi9Z?=
 =?gb2312?Q?xqNQNxTCKN3fW4F775yCHNJEtWmh/HUyzEKBp4Mu1M=3D?=
Content-ID: <F3CA5E417B68124EABD9264D8E6F6210@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5752fc1b-2724-4c85-54b4-08d9b9231a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 01:44:26.2922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfIs8J1IpfMJTkv+a2UjwwzF4Gm6xb642J7XdlJOTJPdMKaQYqLxATjM5VYXvbYnuBbH2HPi0Twhjcm/sonL8w94/0tfmZ6uM27yks+ctaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6126
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx05, 07: Move e4crypt,
 exportfs to tst_test structure
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
>> --- a/testcases/kernel/syscalls/statx/statx05.c
>> +++ b/testcases/kernel/syscalls/statx/statx05.c
>> @@ -10,8 +10,6 @@
>>    * Test statx syscall with STATX_ATTR_ENCRYPTED flag, setting a key is required
>>    * for the file to be encrypted by the filesystem.
>>    *
>> - * e4crypt is used to set the encrypt flag (currently supported only by ext4).
>
> Maybe we should keep the info that it's currently supported on ext4 only
> with something as:
>
> * Encrypted files are currently supported by ext4 only.
It seems this message refers to e4crypt tools(like xfs filesystem 
xfs_io/xfs_quota command supports foreign mode that can support other 
filesystem.).

e4crypt tools may supports foreign mode in the feature. So I prefer to use
"Using e4crypt to encrypt files are currently supported by ext4 only" 
message.

Best Regards
Yang Xu
>
>
> Other than this it's obviously fine:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
