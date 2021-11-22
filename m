Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE34BC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 15:05:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1BBF3C8D87
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 16:05:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5CD23C104D
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 16:05:01 +0100 (CET)
Received: from IND01-MA1-obe.outbound.protection.outlook.com
 (mail-ma1ind01on0713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fea4::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5F671A010F4
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 16:05:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6o130C+9qWrOmx7ty0qhaiHtf0W2O/7+QNZWP4LeRKzplEeiMkBWEwQ7DYgMw/jcZaBHZePfhhz29Orf9ZNv3K2w2cJGfWfEAm5eKbDO0qN+Pin/aWEwSItQUDsJIWfj9HPvVItNLOKn0fLaVCv8tzLZC02jUENsDjK9Rl5B9XyG1z4gS8lJQwIPd0D1FC1LYaeLmNU+B4YVUGSCDhnUyESFWntYZCfpZya0OSk7HyRcRZVlUzku3L8ha/aeAAxxO2s1wsRp5k3x4DB7OlPru5Gy9g9ZbXISIt6b8S3lIIb3mULnwDHxvE0lg+sYLNpzscL6ITtIfItsm7IvXd9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04YI66h4UIO9pq+o1ICYpy7Mfw1o2SFy7MvMuwvvz/0=;
 b=BFmKT2iLJMMDTGniwWAsJerhuyZ8I/HOD8/0umqXW5KdHn3HUjAmF7v5q5b01yt6Cx64+9LOLUpLfQHJLYeA0B2bhh+FTZhBwgZTLCgksGv+7emDotvh3c3uzgAnvRbsDaFqlXj6sTDE3ikKHWF51oEYzx9/8LLp4gJSWqVKjW+l82bFzNG5Y2/fbGfwsGuo6GLFjnPn17PV61+28C9YilgvuCP6KEeB3R7GAl7J6VoKqHWFCUfPgUb1sJlzy5TzuuEqs7SFUdvAVnVvS4gKlp6VZyqE5oO2OMOGJCU5dAh3zu/pZKqyu2fB+40ASTuuYT/ZPop/PA8GoMfL14zvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04YI66h4UIO9pq+o1ICYpy7Mfw1o2SFy7MvMuwvvz/0=;
 b=NW38qBYIg6UcrhIitWl8bOvPcu2WoxAL3xAavWNv5Fe5v8Q/TywqtvgxElP74HumhnTUFCsM2YFnfthtHgiioCtDICSIJV8U5bw7ZPn3joZw0ptj1EJKCUJsBE2vJ/zxi6f6Jr3unB6RIRA70SvEdn49cGo5qDFR3Y1mX7DhFIw=
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:a::17)
 by BMXPR01MB0648.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 15:04:57 +0000
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d]) by BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d%2]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 15:04:57 +0000
From: "Ankita Anil  Kulkarni" <Ankita.AN@exaleapsemi.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] Netns tests failure
Thread-Index: AQHX36pfw+Dqw4kVMESobnKb+BBtjqwPnPqAgAAILM8=
Date: Mon, 22 Nov 2021 15:04:57 +0000
Message-ID: <BM1PR01MB46284EE17FF3EFCCC6605C14FA9F9@BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB46281E563C5D07544F965202FA9F9@BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM>
 <YZuqn+GfTlX2sRPB@yuki>
In-Reply-To: <YZuqn+GfTlX2sRPB@yuki>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: cdf1a544-7cb0-0345-a913-fbce1de339f0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3265b665-685b-4e66-07a5-08d9adc972bc
x-ms-traffictypediagnostic: BMXPR01MB0648:
x-microsoft-antispam-prvs: <BMXPR01MB0648065F2404EC38FDFFC36BFA9F9@BMXPR01MB0648.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRL35jk5HeO3vnj1IUfvKAE3G72fkzKRZPbfPtd7uAOCGvBvnHwGsUoO2DcnsVwLuyNilODLbPG8bTT8lP7Ve7yc03Uay/X4CVjDB3JivHkCk4LON2WhfB4Uo7cFa5Y4ALG4qxIxuYUmbMSK72dzAkmgOKQYY6Z6ka0CYid1VhbThXq9rRLKGLRVgmOmvH3ElEo0Gt8HVpzsSLd1eujlmdIDJbe/jy+NpkT0FUmD4lhYStGR9ewHA/WOU8Ao4dwHUscQ9S43FqJRRv89ZCrLx7D1UQmE4fNxvL2/n5g/biRopxFFcAIvHQkPaGwePnF0BeiO3LQDfOHEMSP1QgTZtU4nxcg/D0iIK086L+5YNXIbP+tUWDW8mGwrFnLt6+vvGT8iRsg+GUcYkoYMCKI2Kqvz43d1jnEQ4ZMSgg0T06wewLI02U1FXusbRRBuDSrllZf8wGG3iHEeHdw3MrYqHWOBy05H2G8g0/qvcJEFaBEBA9h5fSiUrnaNLyG9VXAghIHkpNSMCSxdX1y7qRHrDJ7FUFwwqEpieYoAK9lyIF5surdh51AJ389ykkHaG5UbnL3drRo9zv6jI6V8kDK1w0r3xuJwWF1CGlw04Upa9X7BSnMk+F35aP4E9dtjZ3KU5/QuJckQcotkRTM7/K3h8xOnCLMMVWXmx/FotdgYjmxnaXrCkSXw+XaAr9+Qs41UCLxhZ4ls58r6C98DFaG/Vg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(136003)(366004)(39830400003)(376002)(346002)(396003)(4326008)(7696005)(122000001)(76116006)(66946007)(38100700002)(86362001)(91956017)(64756008)(66446008)(83380400001)(66556008)(316002)(8676002)(66476007)(6916009)(6506007)(53546011)(71200400001)(55236004)(2906002)(508600001)(26005)(33656002)(19627405001)(5660300002)(9686003)(4744005)(8936002)(38070700005)(186003)(55016002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/uHKeQRqyd7q33OLChthmlNdKBiyhpp6K+HplKE7n51Nld15VOr5hQ5b1/A?=
 =?us-ascii?Q?ztcgy/BFRceFVHv9Q6oUYuSMNw0Z2jiWLCu9ps4/Ogwg/ozL9xmEAf0z6SP3?=
 =?us-ascii?Q?p8RiLMx1QadvmgypKrJmbBqAs5tjn7gOAogHX0Kh6p6UJnY7p34oBDOxFJ1S?=
 =?us-ascii?Q?NGfWe/eADXvHo+r1vPP8ciBzc7bezjL3QUSotRDoz1sV7dyPXwGriACrh7Rq?=
 =?us-ascii?Q?i4vj42PTYS2KLE9N2g4zqYETP4wvLdpNYAf6k5h/5BFezOEl5wrAj1GQxmCO?=
 =?us-ascii?Q?sjOyIXnpRkI1wQiSetYRPp7a+qrOb55Pp+98j1OzP4zMmNmPTRW7ADvse0Co?=
 =?us-ascii?Q?X9XomVXNgmVTSGKvAHx1QwycbPQTLwACfmlzZzJGJjR5ez5FwRslpd+XPFbJ?=
 =?us-ascii?Q?t4rQigwEJNtpjqO8Jmb9FGHlRClheAhpHLIuK6LFCxDCopSkmrretS15r+P7?=
 =?us-ascii?Q?hilfqIh0pNPf8hu23JCBwcbDDII0eugvz8alPZWh2NdUbgXTjIbDRqTOmkYI?=
 =?us-ascii?Q?vB3ZnRO2fX397yTZYWBu3nMWiOK2qbTkMfijnrynaoVsE0HdjEgJoUU0M0Fw?=
 =?us-ascii?Q?xYuO4gKoTsXICFPJzCWAxltqAGbwKZXP6XixgTjd//7mzGqjmXSwtg/dAis9?=
 =?us-ascii?Q?7BmAD883M9wLMMNUsHWXKZSVUGz/9fuC+ge+qPfPxx+32qLtb9BmdqdnOD06?=
 =?us-ascii?Q?DrkBFsZWp3oGMKxXhRhJW46boKtVmzbevAvILbkSe1VE/c0Cjk986L5SVDgv?=
 =?us-ascii?Q?M0L6azIs3ahCgXwwrO5wigjjj+tXMrV42CDz4Rs9EqOUKChUY23chmC2kS7r?=
 =?us-ascii?Q?3giR7mnoDTxdYoir7bDzTUvBGD/U747da8TNjRBMPezqeeBV5a8D9HEj0NBS?=
 =?us-ascii?Q?KFaP09tXAiR4BdrpY0pKrYQ4qUGKFPAnoSB9HD3+j6xucBsKPJBFPM2918dQ?=
 =?us-ascii?Q?8x2XS4iyaUkxXz1dxV4DD8XNMNjS5KmBjGYY7MyUP5EX+1i70CPMwjWJxa/Z?=
 =?us-ascii?Q?YmOR8HpmgXaTIDo+I0I0/WE1icdBvAlNrK8unMO4SQ7PJxsWApy4wd5pCLnY?=
 =?us-ascii?Q?F9MGYJBXyiOkG18OoGIBMZitHELUxBvgjR0vv3SVH2kjldsDCOy470VrXSMk?=
 =?us-ascii?Q?D8LLRkUHkmYQvB1CeTPuody5yKk+mMhIhUkAv2t4fBzMo0A5dy5DDS6LMBNl?=
 =?us-ascii?Q?o3vp9sBr5s2A9bJDU5jECDuTfl+nQbqnF3Fty6etkZFsrtfgRB7swW+01Oxd?=
 =?us-ascii?Q?UmXNtAY092DQTMneYVq/pMpyr7H2zTA5E+FZhmsME+A9A4+CLazpXOZK9g3b?=
 =?us-ascii?Q?5Jp73jdwR+gA6Fe+fCE8yKQzz8zwaYGbH2OUVb+BsnmnVh3yYunUx1v9Igk2?=
 =?us-ascii?Q?3RhQZJ2SDPnMOWfUniBH5qCCVhwgrdvxU+eytvEyJwE8125cRiU9gf8iRkfv?=
 =?us-ascii?Q?R5k4+yOWwn0a2ffjW47CS/3/FAWcusZm0ZnX7gzFWvpVGEXOEiZScEAVRC4w?=
 =?us-ascii?Q?6DG+9Nn2oyaRD46Jj+jvyGTdSAr+T3TQXFDMkj7CKUGiIrMrH7DTiqIWJU+p?=
 =?us-ascii?Q?IOLQVPSeRpj/lxFl2fAn7nUGCaI4F84OTZtmiqbzuyO5YxHulzxJ04bar2Ua?=
 =?us-ascii?Q?qWY4rE05NrZJm/DzQWsuP2Ubbq/tYjwF/eJQQqUl2Mm3Y/RUI7JeDq/phDeP?=
 =?us-ascii?Q?6SAuIw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3265b665-685b-4e66-07a5-08d9adc972bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 15:04:57.3733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/cw2MvnVFi4uhXOBk2ZWgRiUygmS6Tlp7c6Fdg+KQYtGfbwzo6hlSzP8mbi5ZK/sHxfTX3I4XKB2gq5xjN8BA3cZQdVaFqip4aFG7y7Cgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB0648
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Netns tests failure
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
Content-Type: multipart/mixed; boundary="===============1705230282=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1705230282==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_BM1PR01MB46284EE17FF3EFCCC6605C14FA9F9BM1PR01MB4628INDP_"

--_000_BM1PR01MB46284EE17FF3EFCCC6605C14FA9F9BM1PR01MB4628INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
iproute package installation fixed this for me.

Thanks,
Ankita
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: 22 November 2021 08:05 PM
To: Ankita Anil Kulkarni <Ankita.AN@exaleapsemi.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] Netns tests failure

Hi!
> ???What could be the reason of failure?
> How do I proceed on this issue?
>
> TBROK: unable to create veth pair devices
> ip: can't find device 'veth0'
>
> TBROK: don't obtain valid iproute version

That sounds like the ip command is not from the iproute package but
rather than that supplied by busybox or something similar and that it
does not support adding veth pairs.

What does 'ip -V' return for you?

--
Cyril Hrubis
chrubis@suse.cz
[EXT]

--_000_BM1PR01MB46284EE17FF3EFCCC6605C14FA9F9BM1PR01MB4628INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
iproute package installation fixed this for me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ankita<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cyril Hrubis &lt;chru=
bis@suse.cz&gt;<br>
<b>Sent:</b> 22 November 2021 08:05 PM<br>
<b>To:</b> Ankita Anil Kulkarni &lt;Ankita.AN@exaleapsemi.com&gt;<br>
<b>Cc:</b> ltp@lists.linux.it &lt;ltp@lists.linux.it&gt;<br>
<b>Subject:</b> Re: [LTP] Netns tests failure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi!<br>
&gt; ???What could be the reason of failure?<br>
&gt; How do I proceed on this issue?<br>
&gt;<br>
&gt; TBROK: unable to create veth pair devices<br>
&gt; ip: can't find device 'veth0'<br>
&gt;<br>
&gt; TBROK: don't obtain valid iproute version<br>
<br>
That sounds like the ip command is not from the iproute package but<br>
rather than that supplied by busybox or something similar and that it<br>
does not support adding veth pairs.<br>
<br>
What does 'ip -V' return for you?<br>
<br>
--<br>
Cyril Hrubis<br>
chrubis@suse.cz<br>
[EXT]<br>
</div>
</span></font></div>
</body>
</html>

--_000_BM1PR01MB46284EE17FF3EFCCC6605C14FA9F9BM1PR01MB4628INDP_--

--===============1705230282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1705230282==--
