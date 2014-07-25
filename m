Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XAbE3-0008NF-LT
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 08:51:39 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XAbE2-00027B-AQ
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 08:51:39 +0000
Message-ID: <53D21A7D.5020704@oracle.com>
Date: Fri, 25 Jul 2014 12:51:09 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <4506ACC2AE90484D87F9A883BA36C21C2ADF02C2@LCHQEX03.lancope.local>
	<53D20F4D.5000702@oracle.com>
In-Reply-To: <53D20F4D.5000702@oracle.com>
Subject: Re: [LTP] More observations on HEAD
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Joseph Beckenbach <jbeckenbach@lancope.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>



On 07/25/2014 12:03 PM, Stanislav Kholmanskikh wrote:
>
>
> On 07/19/2014 01:35 AM, Joseph Beckenbach wrote:
>> Hi, all!
>
> Hi!
>
>>
>> Feel free to ignore this -- it's an experience report of a cluster of runs I've just done against 3.12.24 kernels.
>>
>> The default test set runs move_pages* twice.
>>
>> setfsuid04_16 and setregid{02,04,05,07}_16 TFAIL rather than TCONF on no-16-bit-syscalls systems.
>
> Hmm. Indeed, in my environment (OL6 + 3.8.13-26.2.3.el6uek.x86_64)
> setfsuid04_16 fails, but setregid{01,02,03,04}_16 don't. And there are
> no setregid{05, 07}_16
>
> I'll look at setfsuid04_16.
>

Sorry, I overlooked that thread "[PATCH v2 1/2] lib/tst_res.c: introduce 
tst_record_childstatus()" already addresses these issues.

>
>>
>> run_cgroup_test_fj.sh hangs on heavy-load systems with $LTPROOT/output/ not present.
>>
>> Some test under container_test.sh (sourcing childns.sh) attempts to create veth pairs without verifying veth functionality supported.
>> Other tests under container_test.sh fail to source files (childns.sh cannot source cmdlib.sh;  child_1.sh and childipv6.sh cannot source initialize.sh).
>>
>> Many tests under cgroup_regression_test.sh blindly log to hard-coded $LTPROOT/output/ directory without making sure it's there.
>> Also, subtest #7 "fails to mount hugetlb" because it seemingly did not first check whether the functionality was enabled.
>>
>> Under cgroup_fj also seems to have some tests which do latency tests and other tests, outputting "TINFO" and "FAIL" and "PASS" not in standard format.
>> I will see if I can bisect it down and work out which tests those are.
>>
>> dma_thread_diotest invocations all claim to be "dma_thread_diotest07" in the runltp outputfile.
>>
>> Thanks!
>>
>> Joseph
>> Joseph Beckenbach, senior QA engineer : Automation
>> x97166
>> M 678-602-3192
>>
>>
>> ------------------------------------------------------------------------------
>> Want fast and easy access to all the code in your enterprise? Index and
>> search up to 200,000 lines of code with a free copy of Black Duck
>> Code Sight - the same software that powers the world's largest code
>> search on Ohloh, the Black Duck Open Hub! Try it now.
>> http://p.sf.net/sfu/bds
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
