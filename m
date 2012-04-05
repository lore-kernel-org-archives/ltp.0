Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SFeo1-00006a-BY
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 05:00:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFeo0-0004Pg-8s
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 05:00:21 +0000
Message-ID: <4F7D26DC.5090605@redhat.com>
Date: Thu, 05 Apr 2012 13:00:12 +0800
From: ZhoupingLiu <zliu@redhat.com>
MIME-Version: 1.0
References: <4F794D8B.6050505@cn.fujitsu.com>
In-Reply-To: <4F794D8B.6050505@cn.fujitsu.com>
Subject: Re: [LTP] ksm03
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/02/2012 02:56 PM, Wanlong Gao wrote:
> Hi Caspar,
>
> Have you ever seen like below? It happens on ksm03,
> the page_sharing numbers is always incorrect, it
> occurs on RHEL7-Alpha, any ides?

hi, Wanlong

I caught this error, but it just only occurred in s390x,
and not 100% occurred, I will check the reason.
could you tell me which arches do you met the issue?

Thanks,
Zhouping

>
> Thanks,
> Wanlong Gao
>
> ---
>
> ksm03       0  TINFO  :  child 0 stops.
> ksm03       0  TINFO  :  child 1 stops.
> ksm03       0  TINFO  :  KSM merging...
> ksm03       0  TINFO  :  child 2 stops.
> ksm03       0  TINFO  :  wait for all children to stop.
> ksm03       0  TINFO  :  resume all children.
> ksm03       0  TINFO  :  child 0 continues...
> ksm03       0  TINFO  :  child 0 allocates 128 MB filled with 'c'.
> ksm03       0  TINFO  :  child 1 continues...
> ksm03       0  TINFO  :  child 1 allocates 128 MB filled with 'a'.
> ksm03       0  TINFO  :  child 2 continues...
> ksm03       0  TINFO  :  child 2 allocates 128 MB filled with 'a'.
> ksm03       0  TINFO  :  child 1 stops.
> ksm03       0  TINFO  :  child 0 stops.
> ksm03       0  TINFO  :  child 2 stops.
> ksm03       0  TINFO  :  check!
> ksm03       0  TINFO  :  run is 1.
> ksm03       0  TINFO  :  pages_shared is 2.
> ksm03       0  TINFO  :  pages_sharing is 95998.
> ksm03       1  TFAIL  :  pages_sharing is not 98302.
> ksm03       0  TINFO  :  pages_volatile is 0.
> ksm03       0  TINFO  :  pages_unshared is 0.
> ksm03       0  TINFO  :  sleep_millisecs is 0.
> ksm03       0  TINFO  :  pages_to_scan is 98304.
> ksm03       0  TINFO  :  wait for child 1 to stop.
> ksm03       0  TINFO  :  resume child 1.
> ksm03       0  TINFO  :  child 1 continues...
> ksm03       0  TINFO  :  child 1 verifies memory content.
> ksm03       0  TINFO  :  child 1 changes memory content to 'b'.
> ksm03       0  TINFO  :  child 1 stops.
> ksm03       0  TINFO  :  check!
> ksm03       0  TINFO  :  run is 1.
> ksm03       0  TINFO  :  pages_shared is 3.
> ksm03       0  TINFO  :  pages_sharing is 96528.
> ksm03       2  TFAIL  :  pages_sharing is not 98301.
> ksm03       0  TINFO  :  pages_volatile is 0.
> ksm03       0  TINFO  :  pages_unshared is 0.
> ksm03       0  TINFO  :  sleep_millisecs is 0.
> ksm03       0  TINFO  :  pages_to_scan is 98304.
> ksm03       0  TINFO  :  wait for child 1 to stop.
> ksm03       0  TINFO  :  resume all children.
> ksm03       0  TINFO  :  child 1 continues...
> ksm03       0  TINFO  :  child 0 continues...
> ksm03       0  TINFO  :  child 0 verifies memory content.
> ksm03       0  TINFO  :  child 1 verifies memory content.
> ksm03       0  TINFO  :  child 2 continues...
> ksm03       0  TINFO  :  child 2 changes memory content to 'd'
> ksm03       0  TINFO  :  child 2 stops.
> ksm03       0  TINFO  :  child 1 changes memory content to 'd'
> ksm03       0  TINFO  :  child 0 changes memory content to 'd'.
> ksm03       0  TINFO  :  child 0 stops.
>
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
