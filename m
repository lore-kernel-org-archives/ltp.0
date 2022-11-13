Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D44C4332F
	for <ltp@archiver.kernel.org>; Sun, 13 Nov 2022 18:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2995D3CD33F
	for <ltp@archiver.kernel.org>; Sun, 13 Nov 2022 19:45:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D6AF3CD329
 for <ltp@lists.linux.it>; Sun, 13 Nov 2022 19:44:54 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 054786005D2
 for <ltp@lists.linux.it>; Sun, 13 Nov 2022 19:44:52 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id
 2ADIh0HJ027578; Sun, 13 Nov 2022 18:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WT1iB9nnIc+75xxP3cEROc686CxbeaxyE46brT2X/OM=;
 b=KnDORac3LZV8kYEM5NFgEyCLhxH++rnhZhmxAgPU3nVLTl9H/HNfJE4HB9Hmz3lw8/Id
 UoUxEdWo3RffFw7/B4LpjLxNrJd9h+inkNusEQvQu8TEuxJmXz8CkCCoMhawgJTOmp6V
 kTsD/h0hdaCiIml7Q/f9tvX9tbixIqzbwREGujxPj/7QNoAqsoEBP1wUQUw7np0x8+Y7
 kIwwdFQ5vVG5zsESVsYCVpMyegC79osu4JcaeWaS5WPaxJrwiXWlw9+VB7Ak4nuqfI/Q
 NgRJg84VorFMTKtuxwOOXjy8+qqtyK9PXtZaReHbJ8oxa4vNfp6Ig3T1Xy2lCtP3HGsK Yw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku63pg0t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Nov 2022 18:44:49 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ADIaPAR026301;
 Sun, 13 Nov 2022 18:44:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 3kt2rj9kuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Nov 2022 18:44:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2ADIii2835521140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 13 Nov 2022 18:44:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 408FF11C052;
 Sun, 13 Nov 2022 18:44:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B01511C04A;
 Sun, 13 Nov 2022 18:44:42 +0000 (GMT)
Received: from tarunpc (unknown [9.43.84.200])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun, 13 Nov 2022 18:44:41 +0000 (GMT)
Date: Mon, 14 Nov 2022 00:14:38 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221113184438.tmcepansvefom5bk@tarunpc>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-2-tsahu@linux.ibm.com>
 <Y2unWTTyFK8DS82w@yuki> <20221109212637.haxocrluexxhvktg@tarunpc>
 <Y2y0VzfJwFr0wiwC@yuki>
Content-Disposition: inline
In-Reply-To: <Y2y0VzfJwFr0wiwC@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s49NVRVOktxszRfOFWvwf7vA3CU4cUG8
X-Proofpoint-ORIG-GUID: s49NVRVOktxszRfOFWvwf7vA3CU4cUG8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130128
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 10 2022, Cyril Hrubis wrote:
> Hi!
> > > > +		prev_total = t;
> > > > +		prev_free = f;
> > > > +		prev_resv = r;
> > > > +		prev_surp = s;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	tst_res(TFAIL, "Failure Line %i: Bad %s expected %li, actual %li",
> > >                         ^
> > > 			Never print "Fail/Pass" with tst_res() it's
> > > 			printed based on the flag passed to it.
> > > 
> > > The output would contain Fail and Failed at the same time.
> > > 
Ok Will update it.
> > This doesn't say failed.
> > It says failure-line from which the failure originated.
> > like, 
> > hugemmap10.c:63: FAIL: Failure Line 321, Bad HugePages_Free: expected 5, actual 4
> 
> However that is still redundant information, right?
> 
> The meaning of "FAIL: line xyz" and "FAIL: failure line xyz" is the
> same, the second one is just longer. Let's keep the messages short
> and to the point.
> 
> > > I think that instead of the __LINE__ it would make more sense to pass
> > > the test description as a string as we do with test_counters()
> > > 
> > That will require each line inside test_counters to have unique string
> > description for map, touch, unmap, set_nr_hugepages calls, similiary inside
> > for loop. Which will make user hard to find where they have to look for
> > origin of issue, unless they search for string match.
> > 
> > like,
> > 
> > 	/* untouched, private mmap */
> > 	map(SL_TEST, 1, MAP_PRIVATE, "mmap private no touch");
> > 	unmap(SL_TEST, 1, MAP_PRIVATE, "unmap memory mmaped private no touched");
> > 
> > 	/* touched, private mmap */
> > 	map(SL_TEST, 1, MAP_PRIVATE, "mmap private followed by touch");
> > 	
> > 	touch(SL_TEST, 1, MAP_PRIVATE, "touch memory mmaped private");
> > 	unmap(SL_TEST, 1, MAP_PRIVATE, "unmap memory touched mmaped private");
> > 
> > But I agree, a unique description, will give more information on test run
> > logs. 
> > 
> > What do you think?
> 
> Sounds good.
> 
Ok, Will update it with custom msgs.
> > > > +	if (setjmp(buf))
> > > > +		goto cleanup;
> > > 
> > > This is way beyond ugly. I guess that it would be cleaner to actually
> > > return a pass/fail from the test_counters() function and break the for()
> > > loop based on that value instead of this longjmp trickery.
> > > 
> > > Also I do not think that the current code is correct anyway, because we
> > > skip the unmap() call. So I suppose the correct way would be:
> > > 
> > > 
> > > 	res = test_counters("Untouched, shared", base_nr);
> > > 	unmap(SL_SETUP, 1, MAP_SHARED);
> > > 
> > > 	if (res)
> > > 		break;
> > > 
> > 
> > I was thinking same first. But Thought of adding the checks at each line in
> > test_counters(...) and inside for loop, will make the code unclean. Hence,
> > I chose the setjmp/longjmp mechanism. Only drawback is that mapping was not
> > getting cleaned up (unmap), That we can add in per_iteration_cleanup.
> > 
> > What do you think?
> 
> The reason why I do not like the longjmp() is that it obscures the code
> flow. If we have explicit if () and break; it's clear what is happening.
> With setjmp() you have to search the code for corresponding longjmp()
> calls. It's not that bad in this case but I would still stick to
> avoiding longjmp() unless really necessary.
> 
> > > Or eventually we can make the desing better by unmaping any leftover
> > > mappings in the per_iteration_cleanup(). Then we can just do:
> > > 
> > > 	map()
> > > 	if (test_coutners(...)
> > > 		break;
> > > 	unmap()
> > > 
> > map and unmap do also require return checks, as they also perform
> > verify_counter on expected and original counters.
> 
> I guess that we can also put the map() (touch()) test_counters() unamp()
> sequence to a do_test() fuction then call it from the for() loop in
> run_test(). That would make the code a bit cleaner.
> 
Instead, I am thinking of a defining a macro like this, 

#define CHECK_(fun) ({			\
		if (fun) {					\
				break;				\
			}						\
		})

inside test_counters:

do {
	CHECK_(map(...));
	CHECK_(touch(...));
	CHECK_(unmap(...));
} while(0)

inside for loop of run_test:

CHECK_(map(...));
CHECK_(test_counters(...));
CHECK_(unmap(...));

> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
