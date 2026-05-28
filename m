Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A6CD6E4A
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780062068; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jK0DoI3FA17mIOWXnA3fW4tZ6f1oBPYa2gO4u3oPDT4=;
 b=Q3/U0+4XlgdtV4qGRFtcdkrfc8p5q5P3k1zbl5vT5TASJAsPI2SVs+eg93dexXHmspFDa
 hZpK97Sr+ehjp88Ac+FVKDCYp7xJO4kXukJIqQqa3eRh65+2eUjAigrUDlf1KLHbHu5UHuP
 jPHR+yHE48no/y1npnocLr9dVvt9/fM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31CB3E765F
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 15:41:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDD023CC25D
 for <ltp@lists.linux.it>; Thu, 28 May 2026 07:24:53 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1980610006AC
 for <ltp@lists.linux.it>; Thu, 28 May 2026 07:24:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL5zo6tfil7SPztyWB54b+DI+mBcLRYOd1byXnWwfRv5q8+dh6dzTKY0fxAqPyyT1qHgMS4QarZSD+8zmDfHFuiPZXdkW/X4UuYmw43LJb9jRWohDOWyEOAXqyJbQU7ijIngW66j+2Hb9IRkDK2d7Irs5LEMpRK5QpNcBKSG3SeEdPGA86jyik0mFd9eykg+WrNHW2CW3OwnY3OgaeKt/expPtilBDZrXRbX8upEF/4+8Uiq9RkO4o+uAcMsYtSgfyZQr/F5GnOZGRocpKfl4sd4sj0WsKNr0NiDwjl3/1jq3++8ExWgwW4sh+Xi2qTQiaU11uMsg3IoyODHALwqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqpgNGDtdTDT6lC+yaGO6FKRqHPBnX75bVaFiL4WbZk=;
 b=zOb+gc1waDIT/kNiHDDLxC7nJ5Sn3BvJr96uDqxII7HCZZnGvwBrvJOJ3frULLjMUWYKR7B1zqaep2fL3wV1J1x6maPAHiZdi/Cf/rhLizLoxmezooX/I+FL3oVy1LbWD3GTIiIcfN/UpQsNtfXsS1wwaiDTnPZTYHqo8EbVHG0F3FKMZBRjIeDgjB1j40DdCjI+t8zXbTWmv8kgqz3rGNurB9ksz7PSorMb4o77Vq2IMXN8PI9xeG8C7Izdc6K/jKlnDTkdgXqAd6CVsT8BmugBLICPFEIlCjzUb0kdONvhThFFkiYI4Ebbs4KZ5Aw75Tr0ATCkMO3RSjDp7Y2nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqpgNGDtdTDT6lC+yaGO6FKRqHPBnX75bVaFiL4WbZk=;
 b=gWFGINQJ2EICdXQE5/BhZpKR0AbxU+Q6iva34G7kNWiwm+ygVMy7iaf+c5hDxkkxPb9wW9180IEIlLsxYHGGR0enDiP1dxclUjxBuQSblVHkectM6BCvbDaeb14FXNMwTIYzwDgbrOUeqKCvnmG8cmzIMMZQ+pdsxnttUisHaMo=
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:24:40 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::3f) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:24:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:24:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:24:37 -0500
Received: from [10.136.36.222] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 28 May 2026 00:24:29 -0500
Message-ID: <b79c3933-495a-43d2-a68c-4e25386c9a5f@amd.com>
Date: Thu, 28 May 2026 10:54:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <oliver.sang@intel.com>, Xiao Feng via B4 Relay
 <devnull+xiaofeng5.xiaomi.com@kernel.org>
References: <202605281011.2ba77cc3-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202605281011.2ba77cc3-lkp@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a28229-36d0-41af-573f-08debc796a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vbs/OC9iW+PLve30cxG+QYzlGxPeD7GqpN3RkCCbueDJ2TBfXYbcTXNVMNaCELWA26NE2UnppjH8ouELsQM3N7H63EYgvffJHkiAFW9TAX02Ha3OJHFZ3mo9aUVxW1k6US8fkV7Ju0t3tWx04/F7IM6XGxPj5ZLTRmDMH5afj1WMo+av2Xt9ftzOBvP2PWTvHs72fbaLG2To0aCbe6J97boJofWKXxBWTdd1x4c/uIIlnTH1ZDDCnHLrkcNuVCT/4WwtRcsibu3BfB6rJ+EFyPdNx0gAq4KVgbRF1JpcwEc5vuwK36H+10NYeZvBhlJTkfonPQorKiS8uNqWErwbFLWlH89/B+c1xPGx8nNGgSn0H52qCIXVy7C99d/uf4nnqAs6x9qLUCNICK0fy/P6ppnK5I4lBsFhynMgNjeZY+2VDNk5DZS9k/O5g6a6Z81WYJhdPZV2cEXDV7BSyI50yLzR44i+NPOYKEGVttI7jRepFXJMa09Cf+teNAYYxwburuFtoJ9fDZ6cY08r/acmTy8W1nZI5Q3OJWvyfwluJvoaynn7AwQk5G1Xs2JQFVmoHFA3TY4bJSelozFDYNPCc8F/FUYTqhf4N/CPHoPDo0/cppfBTMu2J+EhwjimcVaJKDN+sv1HOTFLKgYuNm+G5MOFKVMLl71t+pkmIh0zTwfPSewD31Ee1xoteqCLccH/qrgT21Uc57F5sKrYcqOWVkLqas9rE/tXtGbznV9yXNg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ZqA4Qky1vOKhKwJX4a5R4FxO0xMAXSEejAzFgTHJAmVbmzSU4Z9Ri3o68Mey7k0uKU0rRiYwElJ3BGO76sPjsJyFDjB76dW2NZlBkgHmXyauGJaNPOUcfFLlp994ISrnoRicVynELyPSnhg8tmxzaeiEn8Ffez6uqOxsNpSzBgIp9tlAMc93RfsXpjfJCxYd4Gc+lxsr3ok6j97wsaBVZSzWIdts0qXI+ipHy3FR2FVwUIv3x42+lLG778U0WPrgLiSI41f1m6Tai3heB5Mmm9lpnisvXlOIKQ++iqJKGw9iofkg9lU75+t/ayQ7PbzGcvK2klq7Lhel9BaTnQPPNjIL68KYYy5rf2mgWvwF7oMwOC1RaZ83FC/hk/NsbbB25Kp/AJakb7jm5SalhiI/506sYJ5w36itzb8BMhdoVgM+Jfd0gDQTjZ+v5GvoN91
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:24:39.3613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a28229-36d0-41af-573f-08debc796a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 29 May 2026 15:40:29 +0200
Subject: Re: [LTP] [PATCH] sched/fork: Fix timer_slack_ns inheritance for RT
 tasks
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
From: K Prateek Nayak via ltp <ltp@lists.linux.it>
Reply-To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Xiao Feng <xiaofeng5@xiaomi.com>,
 Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Ben Segall <bsegall@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 lkp@intel.com, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Vlastimil
 Babka <vbabka@kernel.org>, aubrey.li@linux.intel.com,
 Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 ltp@lists.linux.it, yu.c.chen@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@kernel.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gT2xpdmVyLAoKVGhhbmsgeW91IGZvciB0aGUgdGVzdCEKCk9uIDUvMjgvMjAyNiAxMDoy
MCBBTSwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4gU3VpdGU6IHN5c2NhbGxzLTA1Cj4g4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gCj4g
Li4uCj4gCj4gG1sxOzM3bXByY3RsMDI6IBtbMG0bWzE7MzJtcGFzcxtbMG0gfCAbWzE7MzNtdGFp
bnRlZBtbMG0gICgwLjAxMXMpCj4gG1sxOzM3bXByY3RsMDg6IBtbMG0bWzE7MzFtZmFpbBtbMG0g
fCAbWzE7MzNtdGFpbnRlZBtbMG0gICgwLjAxMXMpICAgPC0tLQoKSSB0aGluayB3ZSBhcmUgZmFp
bGluZyBoZXJlCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2Iv
bWFzdGVyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJjdGwvcHJjdGwwOC5jI0w4NgoKZm9y
OgoKICAgIHtjaGVja19pbmhlcml0X3RpbWVyc2xhY2ssIDcwMDAwLCA3MDAwMCwgIkNoaWxkIHBy
b2Nlc3MifQoKVGhpcyBjaGVja3MgaWYgdGhlIGRlZmF1bHQgdGltZXJzbGFjayBpcyBzZXQgdG8g
dGhlIFBhcmVudCdzIHRpbWVyc2xhY2sKYXQgdGhlIHRpbWUgb2YgZm9yayBhbmQgcHJjdGwoUFJf
U0VUX1RJTUVSU0xBQ0ssIDApIGluIHRoZSBjaGlsZCBwcm9jZXNzCmV4cGVjdHMgdGhlIHRpbWVy
IHNsYWNrIHRvIGdvIGJhY2sgdGhhdCBpbmhlcml0ZWQgdmFsdWUuCgpXaXRoIHRoaXMgcGF0Y2gs
IGluc3RlYWQgb2YgaW5oZXJpdGluZyBpdCwgd2UgYXJlIHJlc2V0dGluZyBpdCBhdCA1MHVzCmF0
IHRoZSB0aW1lIG9mIGZvcmsuIFNpbmNlIHRoaXMgaXMgZG9jdW1lbnRlZCBpbiBtYW4gcGFnZSwg
SSBiZWxpZXZlIHRoZQp0ZXN0IGlzIGNvcnJlY3QgYW5kIHRoaXMgd2lsbCBpbmRlZWQgYmUgYSBi
ZWhhdmlvciBjaGFuZ2UuCgotLSAKVGhhbmtzIGFuZCBSZWdhcmRzLApQcmF0ZWVrCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
