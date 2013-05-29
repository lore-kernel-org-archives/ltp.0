Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Uhf0s-0001VV-H7
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 11:57:54 +0000
Received: from mail-pd0-f169.google.com ([209.85.192.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uhf0r-0007Se-KB
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 11:57:54 +0000
Received: by mail-pd0-f169.google.com with SMTP id y11so8858622pdj.14
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 May 2013 04:57:47 -0700 (PDT)
Message-ID: <51A5E61E.7000405@casparzhang.com>
Date: Wed, 29 May 2013 19:27:26 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <51A5C347.4020202@cn.fujitsu.com>
	<1098836685.51729.1369819107988.JavaMail.root@redhat.com>
	<51A5D7A9.3070801@cn.fujitsu.com>
In-Reply-To: <51A5D7A9.3070801@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach
 SHM_NORESERVE to shmflg
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/29/2013 06:25 PM, DAN LI wrote:
> On 05/29/2013 05:18 PM, Jan Stancek wrote:
>>
>> ----- Original Message -----
>>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>>> To: "LTP list" <ltp-list@lists.sourceforge.net>
>>> Sent: Wednesday, 29 May, 2013 10:58:47 AM
>>> Subject: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE to shmflg
>>>
>>>
>>> 1. Remove useless comments
>>>
>>> 2. Revise code to follow ltp-code-style
>>>
>>> 3. Add SHM_NORESERVE to shmflg to test
>>
>> Can you add some description why you are adding this flag?
>
> Actually, we are trying to complete test cases and expand
> the test scope of LTP.
>
> So, it is just for completeness of this case.

Would it be better to split the code-style fix and the 
functional/feature part?

Caspar

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
