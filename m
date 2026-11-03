Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBD606A335
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=pYpBM4Ft;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F6UAtv6i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793722319; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=G5Z5/UcWbiNfVQwoh0PENgU0zK1QySyJZ1fyLw24eFM=;
 b=pYpBM4FtJp7zbgBUAqb8t1Mvyb/tgbGIZXWx7NmL1vxtM/pgwZieMq6Se8sqAKULMA4DA
 u+F1H4+G8dcYcx4WHoNMsOjfnsLFUGlGaR6/XK0LNSTmAZ2QRJrloXbYAkzdfA7Ut45/936
 YrQh+7HxJd7K/JjlxTF13zpjY+yr8I0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257FE3C8315
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 17:11:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 811CD3C8315
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 17:11:38 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6EB7140020C
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 17:11:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJCmAlGaKtgCNivTV5nhf9ETYyOWF0JiCWVM8FXeoedw0GS62inkEQX/IwOYMIOEsXFlIGNoANNKvqtdUlcY1N5VPyuyPEqvRQzPx6XFNSgCyrjt+P2M1LTHa0oQCKtV1kN7uUelp575ipaUA3ZrcOBgLJujSKA9WGY1ssbDVD+TcS7uLrhLa4tYHZiRbeMrYam8Z0bzJ5/wd/NAroYC0xKwz7aehPq1fuC4TSsoct6AzEmn7Ph97zSrCvxz3nhRlDzJyAgVrA/kFeHBeE/3U2HYS8xSVYov6jI1Id3dDsBSjLj6K/Srb549Zzk22JWVGBZiVhwBEJgqldQ1PkFwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM6rHo1NRSa2HjWTQRlzEZoCMc4OfA+U+JTqlLomGX4=;
 b=Mb0mAvFKcr1Bo3C10CCPAcCQowCAQ7WJ4uIsIPz/nnqxoBGztTfAhXCI/60jQ6lASf7QusKqPBpGNu8s5kzvARirSoXInw00y1/LyEkh77gucMJphP2W0WMKyiWkFZH7YmXIMAC/OITe9N2GV52iKr3EVp5m+oLkBHEnc8vUKD9W6ytNUzY7HqTFtxzA5iN8yprETLsK+n5uxz18L/x15rjb06D5tHTlz8TuZh9vuBSb4uOeXZPb+8Lq3rJniUrNbCAEPhEvFeULgFGPglS8RpMyOHjZo+sRcv5KaVgTK/KNHU/8rXkTF55JCHEY0i3k2fslR0C8y6/bG7uFuIzNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM6rHo1NRSa2HjWTQRlzEZoCMc4OfA+U+JTqlLomGX4=;
 b=F6UAtv6i3zZIoWMIGS8+CjXeVix3vHkMcflXcDNFUDM5uFq9EESapJK+vVZ6siAcGbmSAb8hfu550b2fGIWUJV267FQTzqnidLMjFqI2PSC08xzmZ7DyzyLqskSpVJBUqrO5FK3hLHvYXoElnQchM5CyZrBX1G1ctkJX+iNeRoTO4OWVJvuQ0awqZPkrwjhve5OeVuLVteSWcrO1MIERd3Ap1UfIL2Gvpyfa2epEzYZLTc2PgSeJxubw0DnSOCEYgNxpbEiD+vriqv0jDJTnqleyvhWnA6nPjT9Z0GpFodj+t9GrooqvJc5D13IQlgz2HDG5zXhiMsG76IszW79mQA==
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by AT6PR12MB522127.namprd12.prod.outlook.com (2603:10b6:170:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:11:29 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::47) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 16:11:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:11:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:11:09 -0800
Received: from [10.191.53.38] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:11:07 -0800
Message-ID: <d725b26a-689e-44d7-8d52-543a13a427ba@nvidia.com>
Date: Tue, 3 Nov 2026 17:11:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20261005131807.904833-1-nirmoyd@nvidia.com>
 <20261005131807.904833-2-nirmoyd@nvidia.com> <auoGUsdb03dC7THX@yuki.lan>
Content-Language: en-US
In-Reply-To: <auoGUsdb03dC7THX@yuki.lan>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|AT6PR12MB522127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7849b58e-1827-44f6-3a37-08df39c51e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|10067099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 57+qVljbbYpQGwR4qYMV7ikvdKc3HiV/EQTaIQcMmJWMf3U9gBfekGzo2Mrvy4NPLDP9hcXEUmIoWz5+Qb5czgpSxtIQYWxzejSvayE9WaMYU+59cv7+fv+bLHKbruED8EIn37q9YUd6CgQUfgmiDRarsIm7pgg6g1sxZjtWySd95USRHB1HcRZyyb/ZHInRFWmVPD995BqYSajprKnrBt4KW4lnnd2s7oVq/K+ZVu2ynYbCrfCHJk+moFY/qKe2gBpxHse96O6XNGu8gWISxt+u305EzP9KFI3Ljv3AHSRA/0laGwRPoKSsD8xoiw6oXksjGa/ZN4Hj1WsZhX44047S3b06vy8ITiyHy8hK796KkqAD6L8DicubTiB5rXU5EuDRr5YwC0shtIIaYtvBKsWvLGgWLrCBdqdkWGVCV+eI5md8cqTZwC6SB8nld8k6BroRFLrxmCMP6bBQZolJG4mJ/mL+5/IF+6OM5FYFpGdlydYy7i56HoTpfBw1qNnMILcsbCFSk5Xg2Wi71NSBQp/qPUk0PAcuwyDvQm5YFZxb9tLzg5YzPAUJkoEBiS4Jm2a1TW/45eCz/eopLHOQEM5H6t60YtX2+MhTwzzG2BI3E69AN1sT5xfkYUPSIrAeyw7z8Tv97at8IdGXZHH1MLPHpkI0K0hP4Rrq4o1HpOWiI2l9DgZ578qZb5UoUmQQQbxBnZ7XRHMUPkAEc67c1A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3b0GDtXHV+IePmxdqCead6/4VFiJj1/pqOd+fkexCyXFnQ8X9TAgYjKDosrk292yjq5Ur73chvlM5BuZnhJaQNdHbKh/Efw4UTzZhVw1e1a4IUhEIEz9/n0rlmYdSeYwRK6J2obbeVYCwF5zXgbLFHCo4+4aJ9QigrA28FzIbHmU1nB5s7pE26rpQcto+ziIgJRkUV+y9d0Gr4NaV+jQhOzIc6twgTwZYeRPnGoVUUPhrPlDGgAOCODqnXg1E7oWWdSjXSzgxQXHmEMKhhAhVmHZjGVRJDEQpy8oy66YzHQ/u3Lc6Gr0RWUuNqOIvbhtdQKbety6poRiSg1RtQGB4c9uakgTDqa5wNgEuxFj9iKrAHzv53LtOfw18oC/xK5k8kDfyASwVgBHC8SvL06SJeXf525mHcZkvSgAZMhekSqy32kDXZFImpUK8YsBzIj3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:11:28.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7849b58e-1827-44f6-3a37-08df39c51e42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB522127
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] getrusage03: account for percpu RSS
 counter batching
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Nirmoy Das via ltp <ltp@lists.linux.it>
Reply-To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks, Cyril!


On 03.11.26 17:05, Cyril Hrubis wrote:
> Hi!
> Pushed with minor adjustenment to the comment, thanks.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
