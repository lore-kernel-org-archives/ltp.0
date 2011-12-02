Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1RWWwN-0006cf-2n
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 17:30:27 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RWWwL-0008BE-Rv
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 17:30:27 +0000
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Fri, 2 Dec 2011 17:24:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	pB2HQjKC3055680
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Dec 2011 04:26:45 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	pB2HUEGc011531
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Dec 2011 04:30:14 +1100
Message-ID: <4ED90B1C.8000204@linux.vnet.ibm.com>
Date: Fri, 02 Dec 2011 23:00:04 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <20111127201232.GB2268@nik-comp.lan>
	<4ED480A4.2000003@linux.vnet.ibm.com>
	<20111129220308.GA3953@nik-comp.lan>
In-Reply-To: <20111129220308.GA3953@nik-comp.lan>
Subject: Re: [LTP] LTP: memcg_stress_test hanging whole box
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
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: ltp-list@lists.sourceforge.net

On Wednesday 30 November 2011 03:33 AM, Nikola Ciprich wrote:
> Hello Shubham,
>
> I tried setting swap to 8GB, but the result is the same... the box gets into state
> that I can't login to it even after few hours, so hard reset is needed..
> When I have top started, I see a lot of memcg_process_stress processes.
> What is strange, when I start the test with swap disabled, memcg_process_stress processes
> just seem to eat all physical memory and then just sleep. OOM killer doesn't kill anything,
> but the box doesn't hang..
> weird..
> I'm wondering whether to report this to kernel list?
> or do You have any idea on where to look?
> cheers
> nik

Hi Nikola,

What I recently noticed was the controller test hang problem is coming 
with old versions of LTP. I tried with latest release of LTP on the same 
affected machine and I did not observed any test case or system hang. I 
hope you are using latest LTP downloaded from 'ltp.sourceforge.net'?

There might be a issue with oom that it is not able to kill the memory 
intensive process but you need to gather more information about the 
hanging process first. You might want to run only the hanging test i.e. 
memcg_stress and not complete LTP to narrow down the issue. Just check 
whether you are able to reproduce the issue when only memcg_stress test 
is running There are chances that test case itself has some issues.

Thanks,
Shubham



------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
