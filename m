Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YGHIu-00086L-Fu
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 01:20:24 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGHIt-0007QQ-7y
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 01:20:24 +0000
Message-ID: <1422407961.13104.13.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 28 Jan 2015 09:19:21 +0800
In-Reply-To: <54C7BD1C.8020104@oracle.com>
References: <54B7D920.7050402@oracle.com>
	<1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1421818093-24202-3-git-send-email-zenglg.jy@cn.fujitsu.com>
	<54C68975.8000709@oracle.com>
	<1422350191.1619.77.camel@G08JYZSD130126.localdomain>
	<54C7BD1C.8020104@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 3/3] iptables_tests.sh: Cleanup
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On Tue, 2015-01-27 at 19:30 +0300, Alexey Kodanev wrote:
> On 01/27/2015 12:16 PM, Zeng Linggang wrote:
> > Hi!
> > On Mon, 2015-01-26 at 21:37 +0300, Alexey Kodanev wrote:
> >> Hi!
> >> On 01/21/2015 08:28 AM, Zeng Linggang wrote:
> >>> * Use 'test.sh'.
> >>> * Use 'tst_*' which defined in 'test.sh'.
> >>> * Delete some useless comment.
> >>> * Delete 'RC' and 'TFAILCNT'.
> >>> * Some cleanup.
> >>>
> >>> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> >>> +	modprobe ip_tables > tst_iptables.out 2>&1
> >>> +	if [ $? -ne 0 ]; then
> >>> +		iptables -L > tst_iptables.out 2>&1
> >>> +		if [ $? -ne 0 ]; then
> >>> +			tst_brkm TBROK "no iptables support in kenrel."
> >>>    		fi
> >>>    	fi
> >> May be I missed something, but why we need to send output to the file,
> >> then, in case of errors, rewrite it with "iptables -L" command?
> >>
> > The output file is really not necessary here. Maybe it just make our
> > screen clearer. I think we need more discussion.
> >
> >>> +	lsmod | grep "ip_tables" > tst_iptables.out 2>&1
> >>> +	if [ $? -eq 0 ]; then
> >>> +		iptables -F -t filter > tst_iptables.out 2>&1
> >>> +		iptables -F -t nat > tst_iptables.out 2>&1
> >>> +		iptables -F -t mangle > tst_iptables.out 2>&1
> >>> +		rmmod -v ipt_limit ipt_multiport ipt_LOG ipt_REJECT \
> >>> +			 iptable_mangle iptable_nat ip_conntrack \
> >>> +			 iptable_filter ip_tables > tst_iptables.out 2>&1
> >>>    	fi
> >>> -	rm -fr $LTPTMP/tst_iptables.*
> >>> -	return $RC
> >>> +	tst_rmdir
> >> And here, writing output to the file, then removing tmp dir.
> >>
> > ...
> >
> >>> +	iptables -A INPUT -s 127.0.0.1 -p icmp -j DROP > tst_iptables.out 2>&1
> >>> +	if [ $? -ne 0 ]; then
> >>> +		tst_resm TFAIL "iptables command failed to append new rule."
> >>> +		return
> >>>    	fi
> >> At least, we could print 'tst_iptables.out' if the command failed.
> >>
> > OK. I will do that.
> >
> >>> +	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
> >>> +	if [ $? -ne 0 ]; then
> >>> +		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
> >> The same with tst_iptables.err file.
> >>
> > OK.
> >
> >>> +	iptables -F > tst_iptables.out 2>&1
> >>> +	if [ $? -ne 0 ]; then
> >>> +		tst_resm TFAIL "iptables did not flush all rules."
> >>> +		return
> >>>    	else
> >>> -		tst_resm TINFO "$TCID: iptables logging succsess"
> >>> -		tst_resm TPASS "$TCID: iptables can log packets to multiple ports."
> >>> +		tst_resm TINFO "iptables logging succsess"
> >>> +		tst_resm TPASS "iptables can log packets to multiple ports."
> >>>    	fi
> >> You don't need "else .. fi" block because you return in the first one.
> >>
> > I think "else ... fi" is necessary when "$? -eq 0".
> > I should remove the 'return' here.
> 
> What I mean here is that you could write TINFO/TPASS messages without 
> "else":
> 
> if [ $? -ne 0 ]; then
>      tst_resm TFAIL "error"
>      return
> fi
> 
> tst_resm TPASS "success"
> ...
> 

That's OK.
Thank you very much.

Best regards,
Zeng

> 
> Thanks,
> Alexey
> 



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
