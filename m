Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A4C433FE
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 08:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3D553CAD6B
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 09:39:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D873C4C32
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 09:39:21 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 811A06006C5
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 09:39:19 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A37affG006215;
 Thu, 3 Nov 2022 08:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=J605elnZFX+Ugrw7UrKh8Xox93w5dpOK1VH7dHHHjN8=;
 b=fyazKP9lY4bsPVH5iyHg1PEFJXCyqu+FtKPePZy2R8ANgUljfZvE0qXAHkAltHmJUgII
 KK58yOUF4y2S8j2GmI3u1b3Lq6wJzpudeZiWh8aaIOsGhgNRUczxY4Ss7w7xauttWlW5
 iEZwi5wLY8evqAA7uyJDCyOuyEvSm5CSzE3FIvVXPS+TiO9jjDqYz3N2kMGA1jahv2uC
 Ak8HqQZ6go9bIzdRNIByzD9ZxffmOxN0nnyQ1uli2RRTnUsi0XewJrI9yXH10Fbal7/a
 ekvOIEZULSulX4HRernf0wZSrCS5W7/lrI4p+xTb42jjQA2nZJuC2zqihj4hCujytRit Jw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km6pgp96b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 08:39:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A38ZrGH028525;
 Thu, 3 Nov 2022 08:39:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 3kgut90dr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 08:39:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A38dDAw2163392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 08:39:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14FC24C058;
 Thu,  3 Nov 2022 08:39:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5A274C040;
 Thu,  3 Nov 2022 08:39:10 +0000 (GMT)
Received: from tarunpc (unknown [9.43.48.43])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  3 Nov 2022 08:39:10 +0000 (GMT)
Date: Thu, 3 Nov 2022 14:09:07 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221103083907.wclfyb5jpruer6qn@tarunpc>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-5-tsahu@linux.ibm.com>
 <Y01EOw44z65j+quq@yuki>
Content-Disposition: inline
In-Reply-To: <Y01EOw44z65j+quq@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ZvJyMwTUudWc_KVp6T2-WHZ2XJQRSHV
X-Proofpoint-GUID: 6ZvJyMwTUudWc_KVp6T2-WHZ2XJQRSHV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030059
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/29] Hugetlb: Migrating libhugetlbfs counters
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
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 
I am now working on this test after recently posted series,
Looking at your comments on this, I got the following question.

On Oct 17 2022, Cyril Hrubis wrote:
> Hi!
> > +static void bad_value(int line, const char *name, long expect, long actual)
> > +{
> > +	tst_res(TFAIL, "Failure Line %i: Bad %s: expected %li, actual %li",
> > +			line, name, expect, actual);
> > +	tst_brk(TBROK, "Breaking.. as once one of counter is not expected, "
> > +			"it will cause other failure anyway");
> > +}
> 
> Never ever create wrappers around result reporting functions like this.
> This break the best feature these function have, i.e. they print file
> and line number where the problem has happenend.
Sure will update it,
> 
> > +static void verify_counters(int line, long et, long ef, long er, long es)
> > +{
> > +	long t, f, r, s;
> > +
> > +	/* Read pool counters */
> > +	read_meminfo_huge(&t, &f, &r, &s);
> > +
> > +	if (f < r)
> > +		tst_res(TWARN, "HugePages_Free < HugePages_Rsvd");
> 
> Why exactly do we warn here?
> 
Yeah, Will remove this check.
> > +	/* Check actual values against expected values */
> > +	if (t != et)
> > +		bad_value(line, "HugePages_Total", et, t);
> > +
> > +	if (f != ef)
> > +		bad_value(line, "HugePages_Free", ef, f);
> > +
> > +	if (r != er)
> > +		bad_value(line, "HugePages_Rsvd", er, r);
> > +
> > +	if (s != es)
> > +		bad_value(line, "HugePages_Surp", es, s);
> 
> We do have rather nice macros exactly for this TST_EXP_EQ_LI() that
> would work nicely as long as you name the variables with something more
> reasonable than a single character.
> 
Q: TST_EXP_EQ_LI retuns with TPASS if counters matches. Only issue is
these counters are getting checked around 4*4*95=(1520) times in the test.
so to avoid printing PASS for so many times, I propse to avoid use of
it and only print TFAIL in case of failure and exit with help of goto
statements (because once counter are not expected, further checks will
not matter as they will be checked again corrupted counter values).
With this, PASS will be reported only once when all counters will be
checked and test will will be finished without any failure.
> 
> > -- 
> > 2.31.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
