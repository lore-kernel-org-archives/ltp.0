Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C844C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 04:12:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072733C9528
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 05:12:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98B9F3C32DD
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 05:12:14 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 470C910009FC
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 05:12:12 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A347iPe030765;
 Thu, 3 Nov 2022 04:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=yEgs6fPf5DEqpw8YQ4cQUXF2PwQOp5kRUl+Ui0WEC8w=;
 b=TvZt0Ek/+fktDoT7mhrMm45Cge8sRJBrBY125+GOI0M4Dt3TGE3+VJHJI6K+kyDNRtAU
 xyJMOGONbPVeeozUd4G6vfsfvVWgaA9P5dADOrI1gjaXxeF4E1pXYwosKUt9j4dYBd0D
 04FIti9JjOUQ3CeoHePAAi0V0+h7sO34joybOg4ik61/aN0bjjCMoAEPwjlawPZx+IKn
 pr4MEnPzdPNH1zf3G4IQEx8C/miZORGvaLy87H/3ovNWyYZ5MyFjV++LuBozIjMwFBbL
 u6+bOm5fHXpzvhHRU715uA9mfsA0fWV9ySfa29jXoXl1tTnB73BM/xiiiIb7hGRiY5/m 3A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km3ym45hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 04:12:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A346Fdu004689;
 Thu, 3 Nov 2022 04:12:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 3kgut8x07n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 04:12:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2A346X0b49217916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 04:06:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B47D3A4062;
 Thu,  3 Nov 2022 04:12:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D044A405B;
 Thu,  3 Nov 2022 04:12:02 +0000 (GMT)
Received: from tarunpc (unknown [9.43.64.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  3 Nov 2022 04:12:02 +0000 (GMT)
Date: Thu, 3 Nov 2022 09:41:57 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221103041157.uevchef5gpawqqa6@tarunpc>
References: <20221102114923.447871-1-tsahu@linux.ibm.com>
 <20221102114923.447871-2-tsahu@linux.ibm.com>
 <Y2JyzD7vBxPSyeX4@yuki>
Content-Disposition: inline
In-Reply-To: <Y2JyzD7vBxPSyeX4@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fd9WxR3NKmgHMLSzshhwWPpuH6q8FzKO
X-Proofpoint-ORIG-GUID: fd9WxR3NKmgHMLSzshhwWPpuH6q8FzKO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030027
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 
Thanks for reviewing the patch.

On Nov 02 2022, Cyril Hrubis wrote:
> Hi!
--skip
> > +	 * If set, the test function will create a hugetlbfs mount point
> > +	 * at /tmp/xxxxxx, where xxxxxx is a random string.
> 
> This is no longer up-to-date I guess that this should be:
> 
> "If set hugetlbfs will be moutned at .mntpoint"
Yes, missed it. Will update it.
> 
> > +	 */
> > +	int needs_hugetlbfs:1;
> >  
> > +
--skip
> > +int tst_creat_unlinked(const char *path)
> > +{
> > +	char template[PATH_MAX];
> > +	int fd;
> > +
> > +	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> > +			path, TCID);
>                                  ^
> 				 Should be tid in new library code.
> 
Ok, I will update it to tid.

> > +	fd = mkstemp(template);
> > +	if (fd < 0)
> > +		tst_brk(TBROK | TERRNO,
> > +			 "%s: mkstemp(%s) failed", __func__, template);
>                                                       ^
> 						      This is not
> 						      necessary
> 
> The tst_brk() prints filename and line number already, there is no need
> to print the function name as well.
> 
Ok.

--skip
> > @@ -1299,8 +1326,12 @@ static void do_cleanup(void)
> >  	if (ovl_mounted)
> >  		SAFE_UMOUNT(OVL_MNT);
> >  
> > -	if (mntpoint_mounted)
> > -		tst_umount(tst_test->mntpoint);
> > +	if (mntpoint_mounted) {
> > +		if (tst_test->needs_hugetlbfs)
> > +			SAFE_UMOUNT(tst_test->mntpoint);
> > +		else
> > +			tst_umount(tst_test->mntpoint);
> > +	}
> 
> And I would just keep this umount part as it was.
> 
Ok, will update it, Anyway, it will throw warning on unsuccessful umount.
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
