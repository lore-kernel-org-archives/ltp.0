Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05840C3DA78
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 08:49:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFCB83CC8AD
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 09:49:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59523CB49E
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:49:11 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A77001400779
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:49:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOXjW+njFBgleJApfVq5xohN5dcJSSY9ooEMcwxJPTduaZHHMSJ9VMfTX7XJrE+VV4qyxOMUwHvCGqi/PEGyPHf5N/hAgNy7Hsx/C4WLDVuCruCYCuq8X03y1KHGIBaAIFusIj1d7Csjmzv6XybNH1dUrddN/cSfRxyK/Iw9xy8htIbY9abk1/sLX75ppKL/8UgEdEPs8iH0m84eVwAuNVr48JE85JpFceNMybx2AYxKEUtz6ginovtCklUDxkIbnoQtf/NSrkTUffQfwsBtjA1srUNOLlVoK3XQ33z9EuWxunYXElBQcbldDQEWc8ZHbNA4rIpjU/GWWG+hiSeYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh/RDSjShhFSMDeqewl7MVx2CHvP9PeOhbJm8GuFASI=;
 b=jPF6PxTA7N7Wh13swBlLmU/38+DrpAg8KMeLnqaqaTmWpnaJXQS3Y8UKkah+h8DlKwgBpVTO/2Wd85hi2fOhyeewtr9cBIao/7mfD0H0q1+OPX3zqMSi2We2bE6OhCqNgTAqlWEOcOPH/O956oP4L7Ekhe7HGgoLYMqcj1FtD3yHgT5RklAIYO8gFKaiT8rCyIJToE1YDautRgJkrcTlT2HdiF8dszK/DFySbic+oLqJIwLHqfPPLKqQgXgzSfbDV2gwL9ngPxJjngB0TRjdyJuK4t11UyNNFoHX6/lMgday93q0HxZLiP5vSoEtyotHg5I6Mj2j/IcMOW2J2+StiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh/RDSjShhFSMDeqewl7MVx2CHvP9PeOhbJm8GuFASI=;
 b=gNK+1uDUyuBp/av4U9W0DgjL+W0JRWLeB0iLRGvbaFWBMJFF/uPGTzKpPHbXcvZoeeBvMQQLyH2XiRZZFeCaR0i8IktsjY50Wo128qErNjVoUeLtGv+/uHBtFP6pfDT2UP5UCLl8yI5VHE7JRyNfMyZUF7pqRKsCWyV45PMU75HabRrAnSujKkJ74oGiOg7iOcm6P/I8+4qHfMnLQEFehzygc45NOmtn/DwKPhUrtmj7TtOD6ycuvnWR3ZP/fUMKoKjoqyjyu268dGj8xsjCvzDGVmofVQCm5TA8FjO7YjpAn81fHwz15lvl7Ai3nPFOFuO+njT0h/tUE/b8qVTdfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by PA4PR04MB9589.eurprd04.prod.outlook.com (2603:10a6:102:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 08:49:08 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 08:49:08 +0000
Date: Tue, 17 Jan 2023 03:48:56 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y8Zg+PIzLUySx2BI@aa>
References: <20230117040132.5245-1-wegao@suse.com>
 <Y8ZdSla1SoyThtBj@pevik>
Content-Disposition: inline
In-Reply-To: <Y8ZdSla1SoyThtBj@pevik>
X-ClientProxiedBy: TYCP286CA0190.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::10) To AS4PR04MB9433.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9433:EE_|PA4PR04MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db7bef3-78cb-4cc1-2f59-08daf867b262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ecvmutzq0vOZc74nh5Q8qSJpmfPU60lN3SU+b4eFjdTFaGfhz2/1/acujsyp7svq4M3Q2IzN3dXWh9ynbZkdlE3G47DOhghOVm3KcHEjHlsiCUFtM3XDs/eE9u4FxZxOl+y6pl4af/BKuELcsYgskEnpWL3Jm6uOG/KpD+P/pS/laRZqExa/Zcxy6Cll6oy2Jz9+lQhLovUw3TJIOfWfki8LK4waetFyYCBpwWUCCptyZieV8CGB3+m2iowUFtwvo4ljyP1w6v55DHrgi4CgSobU8dMz9WrODNmajCVzc5M0O5CPhCptwbyNcOGh6qqh8mscoijSWcItmsnTMP3+L07Em8AWWlIp6t4KR1PmfAXYRqxqGePw5E+FghaiOxcWS7zm/AquyR/ntq7iwEDAdV41RsMhg6gj2btE0u1XPjpCEKJK0FfPI9PIYttkw+wIbTsVlJNXvc77daV1dr5CwYnp4g93tmVuhYe5zMvrDgGoOLg10oNlv4RCr17e4nn8eyMP8MkLAxzdkM9UEHA/i8MSg2Z3oomB4UjNmbqXKQdnP5xTPWgH9HtsluN8BwEZaRDsIwNcIxkZXIWaRocn0qZPY1AWbj8LJddw6zvBuRWhf/bhpDlA/f7wvMaUTASl5Bs4M/W7OerMa3bYEU8AhJHek0/tC88FwOOth1VNbzxt4DQ8UzTskVuXZSeETMBXxXYzSgx6AUjbPj6wxuxFifkRZezgA4fwPBshhJ2lcY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(86362001)(66946007)(316002)(478600001)(66476007)(4326008)(5660300002)(2906002)(8936002)(8676002)(83380400001)(38100700002)(6916009)(966005)(66556008)(41300700001)(33716001)(186003)(6486002)(6512007)(9686003)(6506007)(6666004)(26005)(21314003)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VWgO7+FJFGjSp+heCU7Fp0lpHaQ7wrIPxsG8BTzymwlYdENWLT3lO5j5KAMW?=
 =?us-ascii?Q?HyTuTzeoVyHjcIvNjHtPWtnLZvxUMan1TCZftOza5dj4k/ICBYJTQx9zceki?=
 =?us-ascii?Q?ugzsJV6HQfue7CrovPok6bh4KXeJmJKQ+IAGm+2TJbZHT71msApgxmSRBaih?=
 =?us-ascii?Q?AQ9GGCNwsx1IBlLJZBMPhjXtuC3jMuBLz8acLzm75uggCvcqR+sBZwSwCtbK?=
 =?us-ascii?Q?i0v5RkQepgvDch5mnE10fvLjr5vovlv7IcZNx9efV7ttg2IP4VTnIrkw85mi?=
 =?us-ascii?Q?pVa+6gRoXl/YgHVFB7r5RxvdRFOuf02kUFQ0BF4/66EbkLNW+3t+aCky5pxc?=
 =?us-ascii?Q?QVJWol2JCJ30BN0zx8qJxCaolUsxIQY8Sx125q8edKeFCAQMaUEEqulRReXM?=
 =?us-ascii?Q?SoZuty6X7220dcDdexQw2ffUXAt2Ng/6g2txrw9BzX6VfxUm5yi7gaECclxH?=
 =?us-ascii?Q?QJoyUhZUIm33uP11DEXsUENsIb28vGXF+3SceTbxNbvWJIl7fi5TjdhEJhOk?=
 =?us-ascii?Q?9OjCp4DGW0TP2Mr2NRX33suYYXYfCJbtf5W1oF++xUUdkl9i5dievLeDUuMk?=
 =?us-ascii?Q?uHimMvoODek1nuSKFHQtC7Nv8ZhO6ZW4rA2ldGJKndb004l3y6nZGi26zg21?=
 =?us-ascii?Q?K2ejiTtuvgQv+KjbMv+trv3GWY+r9QALXuDg5TloHn2LVGEOpUu8ODONjMTZ?=
 =?us-ascii?Q?NkMeUBS67afkChuWfF4dMceJwl5jD1mvUIPGmNcWDVBqznvDV1dof6pEYuxy?=
 =?us-ascii?Q?LmAWyGdoJg8VqYYqo+lxvVtOT28MD8M7HxFsfiDt/Zpb2EJGnUKa83dbeSDb?=
 =?us-ascii?Q?QZYr6z56tI2yQFRCG5m3l4KntD2wmD4Twrbbl9xRdeucMKKE+8Jq/RTHFBSC?=
 =?us-ascii?Q?zbGr5WeBj2jLPAkQr/4l1qCWGws1+/smVbgc9arHSnhMzFNbc1KXsiY/rkdy?=
 =?us-ascii?Q?7lbM1JfWpJAjt1aqVCZrXjwEbokTdXHbn2CdCt5j7rmxifpYMyAqiIv8qcW9?=
 =?us-ascii?Q?39Q4sNwWr/iHqJpIcpHWxzvCke92m/tJpcr8i7WsLYnzm0HC6JHrjCap1VlA?=
 =?us-ascii?Q?NgtB9e5j3bAOksT2zvakjfGwy2AfAb+uO/b1H4Re0gNC5qXu/8kPc/O4+B9k?=
 =?us-ascii?Q?bir7c83r4E9PTAUBH7AMLS0r23jY5yhVyGz6wk2KYT7XS2Zh+JjnjnaC3WR9?=
 =?us-ascii?Q?GHqY6cTaJC6pmJru5U5TheGRCtFCs3i2Upp2c5ImyHf/+iBnFZjRlNAS4DxT?=
 =?us-ascii?Q?KKZ6Ax+GPXnND1XmrT4nycCqAit1Br+HMr7JwBAp8u0l+TVDza6oVT6PmZUL?=
 =?us-ascii?Q?pE0BMH6++lF6WustmPibA/DUj/6mpTMwr6uw8IIRLiA2pHOsOQp+mLlVSXkg?=
 =?us-ascii?Q?2Dzr1vbQ4dYVc4YBRpq5ypwa0gQfHqUG18nzRnqLzZySE5dq+5N0nPW3XJTb?=
 =?us-ascii?Q?17foHKLTpJ9i0BZxsXG35Evf0R6OnRxxx77BLGeVArDRiusDgP4E5dMR9HvV?=
 =?us-ascii?Q?NmQWnmKbFs5btL4mhui9yW6iqVXpowASCT477P9hRkQ6saWT9CA2yoKgqq+5?=
 =?us-ascii?Q?JMnKgtlRxTwSVHpLKDg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7bef3-78cb-4cc1-2f59-08daf867b262
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 08:49:08.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuTEa8na52VdbXv/CXKxKT/Y+7U6JX21beP42Fd0meZPFrOan/G7ryieb9lBaETJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9589
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_net.sh: Add more tst_require_cmds check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 17, 2023 at 09:33:14AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > More strict check for ns_xxx etc will help avoid following issue:
> > https://github.com/linux-test-project/ltp/issues/991
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/lib/tst_net.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > index ceb45c98d..ec915ad74 100644
> > --- a/testcases/lib/tst_net.sh
> > +++ b/testcases/lib/tst_net.sh
> > @@ -205,6 +205,7 @@ tst_rhost_run()
> >  	sh_cmd="$pre_cmd $cmd $post_cmd"
> 
> >  	if [ -n "${TST_USE_NETNS:-}" ]; then
> > +		tst_require_cmds ip ns_create ns_exec ns_ifmove
> Why this? none of these commands is used here.
This line is the key to avoid wrong configuration(such as add ip inteface etc..) continue even ns_xxx not exist,
you can check following code, line 222 will execute ns_xxx with error but not exit test immediately, so if we add 
require_cmds here then we can avoid it. (line 222 $rcmd will contain command ns_xxx)

 218                 tst_res_ TINFO "tst_rhost_run: cmd: $cmd"
 219                 tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
 220         fi
 221
 222         output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
 223
 224         echo "$output" | grep -q 'RTERR$' && ret=1
 225         if [ $ret -eq 1 ]; then


> 
> >  		use="NETNS"
> >  		rcmd="$LTP_NETNS sh -c"
> >  	else
> > @@ -1006,6 +1007,7 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> >  # tst_net_iface_prefix -h
> >  # tst_net_vars -h
> >  if [ -z "$_tst_net_parse_variables" ]; then
> > +	tst_require_cmds tst_net_ip_prefix
> This is correct.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
