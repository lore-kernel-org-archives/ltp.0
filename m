Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18891C46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704783581; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ehIBqng2zflGzkp4hINml2osJuxx9vqEWtHCju6Qeis=;
 b=mS7y7z3p2B7ihfKGPkksWpVohQ0GEE6If9ICJMZDx+Bqy2jQsikRHTw9TTuPTqdmyLpRZ
 Ql7Uaq7qyB1JFP02VIu/OcM4oGgSezWrp2INUpNUrOvTq4Chbxm9gvVaex8o9qaD9XW1jqs
 OlejNv43PX5N1Xuoju2SYFS7XginQgU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765FB3CE4F4
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 07:59:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E3533C8B50
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:18 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A11E60081A
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 07:59:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxuLdToES1zjFVHn1DJe8L5TTU/PMjaIoQ1s/XHi6hMAzGpsVMNV+C7sk/OtFwbeNgNZ9HrPVwnuzLzI8VHCqh3+zRaUwfVE8LFvVsP3hN87jCnspWDmc2kGHA4nmqhNvX69+yo8xl7yTWt7sOQq2Jr4wll8xONULdmu3jz3qH4IkRxNmYF4if5477AjEm4eNhtVb7B5VRIWfcuKQqnh2kPE+pt91ueb+TYXfkPjJUAcHk6q6rhGGxWnqqy9TG5r6udX4H9i3P6ybiZeMbct9O1TlPSNw7EzQqBqkytBbC0oi4baAgTKLB1fuUEjS1BQ1oIREfa1sCNS9xkGXwOIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwMgDnO+FAl43suDKChp3yeK3xlSyVypX0UielA84DY=;
 b=LAQGGhpEYEd8RskFmG8HsqrT42qHp2qsHB+OWR8G9KEyQcA4JfppFIKHY7FeQouUonXsh3rRFamGmuFFA0SmNJpl4nUVfXvBRvfolngqeTtY5v408bG9snRt7RTQ9WTKajZpaXsng/ek74vHbvmn7a2w4irvoKfiiMrLlBd2xpfNrQ/8rQkkNtfew9lusiroR0zjCkstS5BXGExx7yfV3GEz6uDhN+7qs0e9n+59ZwvEpXSH7uVktML9xZK25KBfpapXdG5I8svLwPoPEkjwQcVmYufqYbQKS4FG97cDUvwRrdxPF+N7JGjzq6tfQb5e1sAb2o6B22qC4X4dD6Pi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwMgDnO+FAl43suDKChp3yeK3xlSyVypX0UielA84DY=;
 b=GlCPwnXgiNyTUY/Km50ExDe0o5Vmo3Hwr/+roJl5MRcJ3nB0ePrOSzl5bn87qcge9kOqV48ZFfVPUYFVlTOU47tZk+4oMS+4L222GaoLFA07qgAYcz62ynrJfiY6CT+I0gpIcuPh6Damb+8QKaTOF/G9z8BPJXhQgDjKidQ2extP6uBD3MVlxeYIwOXEkwsU0k5apB/A6/OMeFsD8qczR+cwAb0SEev0YgR6gbKpoANr9ikIWACLE3APjSpbzkMXv/mQRHhjO/qjrJe0IcOS/YtX6eqpT/4bIUVYlYxtNtRGKA3J5a115EaSBQvBAnonqbPjpOblF0XRiZ4S0sRjNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:59:14 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:59:13 +0000
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 01:59:02 -0500
Message-Id: <20240109065904.18117-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025083706.13767-1-wegao@suse.com>
References: <20231025083706.13767-1-wegao@suse.com>
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 06669567-9c0b-4230-7741-08dc10e07d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzQlavFj0iEwduz7kYADiHFxDdpTlpiQSIgUmdW0VnPl/uUwP3NWcQgdGmot0oqoPDz9jWQc4DCUIcE+gjzZ5PUgRzTPxn/LCKhmWll7sJAP545pP+s3zvvyMlz6iHJIeT/AixUrUyrlZuvjVzW5p2f/BlviPzdkoN9qmeGDQWiIAu1efHBK/J6hjuqmMMDnulBWWBHkiQp/0YkBDKeI9i0cjlNiJsVu0Tl129cZkR9uefudpmFJeUtWOFgWNQbb2Yphn2GbxDAjjVMKgyyI+Y2VBQZdOcjbQz2Y8hPeI+774YQHsfTJe0Jqg/NdLswv2cZoqwIjNq1I8liGP0ZrQfhVS4qiCiuuccOQv5OHrsE5w54eAs/yxYeZUh/RafwnaBHslPQ2ljhXxTIeh8dFAACP2S+vo1ayp5+Fiu86vJwJljiWKkn7H0mMaPskXaj+1jei0y0MfxuCSjl1caFXfhQYfWn5/VlrGQXmgU3aKqlRQXsxlPH5MBKlAG2gsgxOmOipGeCObISxMZy4YGse7fMW9I8blRjVQVlgE9R91BBIjQfWr7bQqfEo5G1aJruSjbo7vLO7f5QMemLUdea9YcJdPtIGc9YG1rnrK4DwnisJ8vejaPkWiTbL9f//yxnF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(2906002)(558084003)(36756003)(86362001)(38100700002)(478600001)(6486002)(83380400001)(2616005)(107886003)(6512007)(6506007)(26005)(1076003)(6666004)(4326008)(316002)(8936002)(8676002)(41300700001)(66946007)(66476007)(6916009)(66556008)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+9wmHUeEikJ1qOPYRWtCZHeirk8+MCPQkQEgr6cs2VCiv5jhKQdh1O90Rlv?=
 =?us-ascii?Q?i1rFYjxdzsbPSOY4xMRhubBmR/I7S7JLL5ib4HpCvea7Xuc7k0cfj4Kgkw9a?=
 =?us-ascii?Q?GAWESojyd6U88kCI7l/LGyo3vOqoooUDzF4AE67WGPV7MXoO9g2XdlTrIDAL?=
 =?us-ascii?Q?D0dTM6eNC1fxg53VQmCds7I9/gofhd8HzswBwsF3WG3lGhCOwrYDQZNm3Q8h?=
 =?us-ascii?Q?fmqSLBlZyJCx5a3bLtIvLXhI7lhZq4OlTFbfRm1Ruqg/U90bcRvhCYnhVn6f?=
 =?us-ascii?Q?H6ywORwCqaqvEVop+DvGEB0thpquFfzwsdQpBm9h6VHdrXPRt/WnsHBXoyFW?=
 =?us-ascii?Q?wTymNjRWNJ4tTiQ4R2CUyWjwoGlkpuhEuUlSUDbfDVeYJlmjvURXLzMIaK5Z?=
 =?us-ascii?Q?pJAxU8QYc4QCtcLyCVgrTzsDhirbDED8JFSsAMxTQxwmvlMAQr/pWNgxKaWD?=
 =?us-ascii?Q?2c5GwYxa/p/HJR+Q1WgIQEIBB6qtYSDxpKDZNEHLOFfjz+4wY93ik14TTKKY?=
 =?us-ascii?Q?F8ITqXyfTJyqNU20NGHWsGAin0+oUpEWvsosqqF0HYeJ7khpOH8Mnt0VHVne?=
 =?us-ascii?Q?dBecRsPoufW0ipKykn3NjFMtFcFz7LqP6g4CBMTv/hh7vVSgYqM9+WG7xFK3?=
 =?us-ascii?Q?J/DY+f5inWlaJ80/yhepGmuDyzsvA4UCI2B5nufLzcwU/F4C5IWT4nBuOIwQ?=
 =?us-ascii?Q?uYKpssuxtCvcnbTnsh1N+4Vie5+/81ZeHLv4byuZnYX4GzgFN1xWAcdUiLyT?=
 =?us-ascii?Q?bW++4opXM749YTjSK43HQjvpbExbw+wcZMxZ1RmXut/q4R3M1+xhVdgn9LKR?=
 =?us-ascii?Q?Xev1jDOni9tuQeQQEFyQj+PzlzgfM4WPq+bNUZYITymWXVSac/9R4AYmhukl?=
 =?us-ascii?Q?HiD3I72GVwHAgwnGSzmMY2R3ZH0cuY9aBJA9MOM5z/2Pgh7pbf21HiYVt+3g?=
 =?us-ascii?Q?UgBI4Cwx7oc0RZAIRiuYhfyQCRmydu4ykk4ICSUbCM970ZiXyxK9Z4dgk0ew?=
 =?us-ascii?Q?eLYGi68FUaM/lwo0ax2HoijGr1dD/3idfONg4TaP9qzcnsvhalxUP/MyzNUw?=
 =?us-ascii?Q?sj1YczDsW5J2dJhjyK4a2NHn3mKD0rgi7jDKeFuhW+Z4jUfDvidOrfdKEFi1?=
 =?us-ascii?Q?de1BMba1bejVlAPuUba4S7PJeShBprAZV0tVaHXfS87v2U5ur4eP4QDRa5Ka?=
 =?us-ascii?Q?TsGg3TEFa+sGo2mvLov7fo/8m4QYscSUdKJiWpe0G5mfXfwoqE1/q/yCX0X1?=
 =?us-ascii?Q?W63Jlh3bdxtajpXc+UjXD1kyzWgeq7Qre91MuRgndXO+uMf7GxyhrHfwN5nB?=
 =?us-ascii?Q?rrkL9ctArJi21R2e1vhcK/H5cirU5aMJFmxZ0APAQgVlhvZ7gOMH4rOrlBxV?=
 =?us-ascii?Q?e7uEycQl6EyeleDgITiQNNj0hGhxJYrOE664YNSIy5LQRLO5suTXlokmVW4R?=
 =?us-ascii?Q?+zd4RRdIQWV2SU+w+R797ti0c/RW043JVhrtcPx9CIGVsnGkC60sKbfRk7PF?=
 =?us-ascii?Q?piCoHUX4NB3bZ5Q806OXPyRFFHCsttgIA/UVwYfO1K4br5x+zuHYXG5UA5+1?=
 =?us-ascii?Q?81PTH99oo4gPe+MhjIc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06669567-9c0b-4230-7741-08dc10e07d15
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:59:13.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/zoco13j6iMZ3/gxmnxtaq6GockoLVC+APiiTUX307H+UAB9IZl0nRMCGf2SB3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Lib add .ulimit setting
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  lib: Add .ulimit
  execl01.c: set stack to unlimited

 doc/C-Test-API.asciidoc                   | 18 +++++++++++++
 include/tst_test.h                        | 16 ++++++++++++
 lib/tst_test.c                            | 32 +++++++++++++++++++++++
 testcases/kernel/syscalls/execl/execl01.c |  4 +++
 4 files changed, 70 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
