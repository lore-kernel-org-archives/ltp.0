Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1O3yuT-0003Fp-61
	for ltp-list@lists.sourceforge.net; Mon, 19 Apr 2010 21:53:41 +0000
Received: from mail-ww0-f47.google.com ([74.125.82.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3yuS-000160-7p
	for ltp-list@lists.sourceforge.net; Mon, 19 Apr 2010 21:53:41 +0000
Received: by wwb18 with SMTP id 18so2788635wwb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Apr 2010 14:53:34 -0700 (PDT)
Message-ID: <4BCCCAD4.5090300@mvista.com>
Date: Mon, 19 Apr 2010 14:27:48 -0700
From: Henry Yei <hyei@mvista.com>
MIME-Version: 1.0
References: <h2v72fb0a5c1004160422iaadc7f8p53f73a00d5af088e@mail.gmail.com>
In-Reply-To: <h2v72fb0a5c1004160422iaadc7f8p53f73a00d5af088e@mail.gmail.com>
Subject: Re: [LTP] problem : please help !!!
Reply-To: hyei@mvista.com
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

On 04/16/2010 04:22 AM, rahul agarwal wrote:
> I am running the ltp suite on my embedded system and the following two tests
> are failing :-
> 
> 
> falloc01 , falloc02 , falloac03   ->   TFAIL : TEST_ERRNO=EFBIG(27): File
> too large
> 
> clone02, clone03, clone05, clone06  ->  TBROK : Unexpected signal 11
> received
> 
> 
> I have tried everything to figure out the cause of these test failure but I
> still couldn't get the problem solved .
> 
> 
> With Regards
> Rahul Agarwal
> +91-9999721591

I assume you mean fallocate01, 02, 03, etc. Are you running these on
ext4 or other filesystem that supports the fallocate calls
(preallocation feature)?

Your architecture may also hit a problem with the tests.


Here are some notes I had with the fallocate tests from a few months
back that may interest you:

On a couple of architectures (arm, mips) that the original authors never
tested on, fallocate calls are returning EFBIG (file too large) rather
than EOPNOTSUPP(not supported) like they are on pcc, and x86 architectures.

I've run it on x86_64 Ubuntu 9.04 with an ext4 system, and the tests
also seem to fail with EFBIG, when they should pass AFAICT.


-- 
Henry Yei <hyei@mvista.com>

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
