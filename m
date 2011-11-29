Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1RVHWN-0005Gi-92
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 06:50:27 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RVHWK-0007MY-MB
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 06:50:27 +0000
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Tue, 29 Nov 2011 06:36:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	pAT6knJW3641388
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Nov 2011 17:46:50 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	pAT6oEEZ030536
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Nov 2011 17:50:14 +1100
Message-ID: <4ED480A4.2000003@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2011 12:20:12 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <20111127201232.GB2268@nik-comp.lan>
In-Reply-To: <20111127201232.GB2268@nik-comp.lan>
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

On Monday 28 November 2011 01:42 AM, Nikola Ciprich wrote:
> I hope I won't be bothering with dumb question, but I wasn't able to find any solution to my problem...
>
> I'm playing with LTP, and it works nice for me (few tests fail, but with obvious reasons, which I will fix,
> so this is Ok), but I'm having problem with memcg_stress test. It always almost immediately gets host machine to
> heavy swapping, and never finishes... when I had 2GB of swap, machine usually got into totally unusable state,
> when I lowered swap to 512M, I'm at least able to kill test after some time...
> I guess this is not expected behaviour, but my question is, what should I check to get this working properly?
> I'm getting same results for latest x86_64 2.6.32.x and 3.0.x. Testing machine has 4 cores and 4GB of RAM.
>
> Could somebody help me with that please?
>

Hi Nikola,

I have also seen some hangs with memcg_stress test on some of my x 
machines. But this is not consistent for me as the same set of tests 
works fine on one machine and hangs on other. Yes this is not expected 
behavior and ideally tests should complete. Can you please give a try 
after changing swap space to twice the size of RAM? Also can you paste 
here the the exact process which is hanging for you i.e. paste the 
output of 'ps -ef | grep ltp' during the system hang state.

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
