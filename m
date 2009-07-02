Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MME08-0008Hw-4D
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 04:34:24 +0000
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MME06-0000yR-Fk
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 04:34:24 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n624Y4o2003462
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 10:04:04 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n624Y4MC2486446
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 10:04:04 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n624Y4nY024763
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 14:34:04 +1000
Message-ID: <4A4C38C3.5040104@in.ibm.com>
Date: Thu, 02 Jul 2009 10:04:11 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
In-Reply-To: <4A486E66.5050102@cn.fujitsu.com>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

Wei Yongjun wrote:

>> ------------------------------------------------------------
>>
>> Should we treat this as Test case issue or kernel bug?
> 
> The different of 'nobody' and 'bin' is bin->GID has the CAP_FSETID 
> capability, but nobody->GID has not, I think.


I tried with a small program to check out the capabilities of bin and nobody couldn't find 
any difference

This is what I tried
Program I used
------------------------------
int main()
{
	cap_t cap = cap_get_proc();
	printf("Running with uid %d\n", getuid());
	printf("Running with capabilities: %s\n", cap_to_text(cap, NULL));
	cap_free(cap);
	return 0;
}
------------------------------
Running the program under different user gave same information

mx3455a:/home/sharyathi # su bin
bin@mx3455a:/home/sharyathi> ./a.out
Running with uid 1
Running with capabilities: =
bin@mx3455a:/home/sharyathi> exit

mx3455a:/home/sharyathi # su nobody
nobody@mx3455a:/home/sharyathi> ./a.out
Running with uid 65534
Running with capabilities: =

Thanks
Sharyathi N

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
