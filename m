Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vdxqv-0000gx-B2
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 07:48:37 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vdxqu-0004sw-7h
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 07:48:37 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA67mTXu015659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 07:48:30 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA67mQck003927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 07:48:29 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA67mQ0O028832
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 07:48:26 GMT
Message-ID: <5279F42E.7080204@oracle.com>
Date: Wed, 06 Nov 2013 15:47:58 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <52736BE4.3080009@oracle.com>	<1383555538-1297-1-git-send-email-xu.simon@oracle.com>	<20131104172008.GA11841@rei>
	<5278297D.5090407@oracle.com>
In-Reply-To: <5278297D.5090407@oracle.com>
Subject: Re: [LTP] [PATCH V2] rwho01: fix getting hostnames from command
 output and $COUNT
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
To: ltp-list@lists.sourceforge.net

Could anyone help to review this and other LTP network test patches?

Thanks
Simon

On 2013/11/5 7:10, Simon Xu wrote:
> On 2013/11/5 01:20, chrubis@suse.cz wrote:
>> Hi!
>>> Fix the way the script gets hostnames from rwho/ruptime command output,
>>> and the mistake that $COUNT is used instead of $TST_COUNT in do_test().
>> The change from COUNT to TST_COUNT is pretty straightforward. Can you
>> please describe more verbosely why is the second change needed? Has the
>> output from rwho and ruptime changed over the time?
> rwho and ruptime are pretty old stuff, their output are not likely to
> have changed.  The author intended to use the awk commands to get the
> line containing the hostname, but the output of the awk commands are all
> empty strings.
>
> Thanks
> Simon
>
>>>        while [ $TST_COUNT -le $NUMLOOPS ]; do
>>>            rwho -a > $OUTFILE
>>> -        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
>>> +        HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>>>            [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
>>> -        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
>>> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>>>            [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
>>>    
>>>            ruptime -a > $OUTFILE
>>> -        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
>>> +        HOST=`grep $LHOST $OUTFILE | sed 's/ .*//' | uniq`
>>>            [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
>>> -        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
>>> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/ .*//' | uniq`
>>>            [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
>>>    
>>> -        tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
>>> +        tst_resm TINFO "Test $TST_COUNT of $NUMLOOPS complete"
>>>            incr_tst_count
>>>        done
>>>    }
>>> -- 
>>> 1.8.4.2
>>>
>>>
>>> ------------------------------------------------------------------------------
>>> Android is increasing in popularity, but the open development platform that
>>> developers love is also attractive to malware creators. Download this white
>>> paper to learn more about secure code signing practices that can help keep
>>> Android apps secure.
>>> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
> ------------------------------------------------------------------------------
> November Webinars for C, C++, Fortran Developers
> Accelerate application performance with scalable programming models. Explore
> techniques for threading, error checking, porting, and tuning. Get the most
> from the latest Intel processors and coprocessors. See abstracts and register
> http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
