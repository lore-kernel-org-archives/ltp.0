Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23625C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 18:51:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88E8E3CD25D
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 19:51:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 624053CAF94
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 19:51:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5C6B61400206
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 19:51:41 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id
 2AEIjDc0024486; Mon, 14 Nov 2022 18:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=SZXz1O9qIiy++veVX6U0MnSLB+DU5wZd2Ak1xzm5924=;
 b=N6NvGvfA34N44OpIcxAjSztheiqH3o/Alhi8Ro52LX/AUXbWsTi9UaZhMw6Dv7qfg55/
 0PpE6bWQhDmpFMcVyDohPl5qfwC4z3VPPYiqyqLvTps1YBhyyBLsVXjwwI256BXl2bik
 seOXVZ7uJDsPxvdK+cZFntL6S4vrWXZ5IXzKzLB/EtyAAcFlGhGgm910pxY7DhoA24gu
 IbGctXfBu4n7F7Q01dtxYOHW1/VAsvZkEzQWD87zAh/cfAI5QDSTiXld96SPzl7+s4a0
 BHd1zTSst0fcL8DcHPBOp9dBi+scRivd7sJbBwlmH0r3DAtb/bzEPewh+qiRI/Q6UBzj Tw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuu7x04r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Nov 2022 18:51:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEIoS56014362;
 Mon, 14 Nov 2022 18:51:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjb3j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Nov 2022 18:51:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AEIpYlu3146478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Nov 2022 18:51:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D948C4C044;
 Mon, 14 Nov 2022 18:51:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83C234C046;
 Mon, 14 Nov 2022 18:51:32 +0000 (GMT)
Received: from tarunpc (unknown [9.43.95.207])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Nov 2022 18:51:32 +0000 (GMT)
Message-ID: <729b694b1e2f9786574974019d10df99c92a0685.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2022 00:21:31 +0530
In-Reply-To: <Y3IPKK4/RYc4DqF6@yuki>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-2-tsahu@linux.ibm.com> <Y2unWTTyFK8DS82w@yuki>
 <20221109212637.haxocrluexxhvktg@tarunpc> <Y2y0VzfJwFr0wiwC@yuki>
 <20221113184438.tmcepansvefom5bk@tarunpc> <Y3IPKK4/RYc4DqF6@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qDn3-XmBp9BUw67b--4_MsQkHkWcLK0d
X-Proofpoint-ORIG-GUID: qDn3-XmBp9BUw67b--4_MsQkHkWcLK0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140132
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Hugetlb: Migrating libhugetlbfs counters
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
Reply-To: tsahu@linux.ibm.com
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 2022-11-14 at 10:49 +0100, Cyril Hrubis wrote:
> Hi!
> > > I guess that we can also put the map() (touch()) test_counters()
> > > unamp()
> > > sequence to a do_test() fuction then call it from the for() loop
> > > in
> > > run_test(). That would make the code a bit cleaner.
> > > 
> > Instead, I am thinking of a defining a macro like this, 
> > 
> > #define CHECK_(fun) ({			\
> > 		if (fun) {					\
> > 				break;				\
> > 			}						\
> > 		})
> > 
> > inside test_counters:
> > 
> > do {
> > 	CHECK_(map(...));
> > 	CHECK_(touch(...));
> > 	CHECK_(unmap(...));
> > } while(0)
> > 
> > inside for loop of run_test:
> > 
> > CHECK_(map(...));
> > CHECK_(test_counters(...));
> > CHECK_(unmap(...));
> 
> While this is much better than longjmp() it still obscures the
> codeflow
> a little bit.
> 
> Also I do not think that we need all the braces in the CHECK() macro,
> it
> should be enough just to do:
> 
> #define CHECK(fun) \
> 	if (fun) \
> 		break;
> 
> or even:
> 
> #define CHECK(fun) if (fun) break;

This throws make check warning, It asks to put it in do..while
which is not preferable as we want break the parent loop, not the
loop added by macro. So I added those brackets.
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
