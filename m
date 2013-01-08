Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1TsSbS-0003yF-0T
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:24:02 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TsSbQ-0005mK-Dj
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:24:01 +0000
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Tue, 8 Jan 2013 16:16:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A78F02CE804D
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Jan 2013 17:23:47 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r086C9S55898618
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jan 2013 17:12:10 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r086Nk7U026121
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jan 2013 17:23:46 +1100
Message-ID: <50EBBB71.7060101@linux.vnet.ibm.com>
Date: Tue, 08 Jan 2013 11:53:45 +0530
From: shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <50EB99FB.5020100@tsdv.com.vn>
In-Reply-To: <50EB99FB.5020100@tsdv.com.vn>
Subject: Re: [LTP] Question mapping LTP testcases with Kernel setting?
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
To: duynv <duynv@tsdv.com.vn>
Cc: ltp-list@lists.sourceforge.net

On 01/08/2013 09:30 AM, duynv wrote:
> Dear Sir!
> I'm Duy.
>
> I am working with LTP to test our linux kernel.
> we want to collect LTP test cases to test our kernel base on the 
> kernel setting(configuration file create by "make menuconfig").
> (we want to omit unnecessary test case)
>
> But LTP has so many test cases. I can't mapping LTP test case with 
> appropriate kernel setting
> Could you please tell me the way to make a mapping list between LTP 
> test case with kernel setting
>
> Thank you
>

Hi Duy,

I believe its not possible to direct map LTP test cases with the current 
kernel settings. What you can do is select the subsystems or components 
you wish to test and than run only those tests by customizing the LTP 
test runs. For your information you can select the tests you wish to run 
from 'runtest' directory of the extracted LTP tarball.

Thanks,
Shubham


------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
