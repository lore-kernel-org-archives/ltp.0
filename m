Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SwX1j-0004TV-0r
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 11:23:43 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SwX1f-0006zW-77
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 11:23:43 +0000
Received: by pbbrq2 with SMTP id rq2so861016pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Aug 2012 04:23:33 -0700 (PDT)
Message-ID: <501911AB.2080508@casparzhang.com>
Date: Wed, 01 Aug 2012 19:23:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <17388238.6846564.1343816635852.JavaMail.root@redhat.com>
In-Reply-To: <17388238.6846564.1343816635852.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/01/2012 06:23 PM, Jan Stancek wrote:
> I noticed you put call to "get_a_numa_node()" to "oom()" and "testoom()",
> which is called also from oom01. As I understand from your previous
> email, this test should not be NUMA-aware, correct?

I missed a `if (mempolicy)` inside oom() {....} :-(

Nice catch! Thanks!

Caspar

>
> <<<test_start>>>
> tag=oom01 stime=1343713154
> cmdline="oom01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> oom01       0  TINFO  :  set overcommit_memory to 2
> oom01       1  TCONF  :  require a NUMA system.
> oom01       2  TCONF  :  Remaining cases not appropriate for configuration
> oom01       0  TINFO  :  set overcommit_memory to 0
> <<<execution_status>>>
>
> Regards,
> Jan



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
