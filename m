Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1TtEkQ-0005IF-IT
	for ltp-list@lists.sourceforge.net; Thu, 10 Jan 2013 09:48:30 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TtEkO-0008Mw-G5
	for ltp-list@lists.sourceforge.net; Thu, 10 Jan 2013 09:48:30 +0000
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Thu, 10 Jan 2013 19:42:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8D7EF2CE8053
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Jan 2013 20:48:01 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r0A9m0cm61997190
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Jan 2013 20:48:01 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r0A9m09H015515
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Jan 2013 20:48:00 +1100
Message-ID: <50EE8E4F.3080506@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2013 15:17:59 +0530
From: shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <34855531.post@talk.nabble.com>
In-Reply-To: <34855531.post@talk.nabble.com>
Subject: Re: [LTP] sendfile commands fails for LTP tcp network stress test
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
To: bhushan kumar <Bhushan.Kumar@mphasis.com>
Cc: ltp-list@lists.sourceforge.net

On 01/03/2013 09:25 PM, bhushan kumar wrote:
> Hi,
> As i was  running network stress test for tcp_cmds
>   then sendfile01  test script gets hangs.As after obseving output it seems
> that it hangs during execution  of below mention statment.i.e
> =========
> rsh -n -l root $IPADDR "$TCsrc/SF_Server $IPADDR $PORT $TCsrc"
> ==================
>
> I shall be thankful for any suggetion or any hints.
>
> Thanks and Regards,
> Bhushan kumar

Can you please paste the setup you performed before running these tests? 
Also please paste the "output/logs". I'll have a look at them.

Thanks,
Shubham


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
