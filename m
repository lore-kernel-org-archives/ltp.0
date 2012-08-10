Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzksR-0002AK-ED
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:47:27 +0000
Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzksQ-0003ey-Pf
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:47:27 +0000
Received: by mail-gg0-f175.google.com with SMTP id q1so1325963ggm.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Aug 2012 01:47:25 -0700 (PDT)
Message-ID: <5024C4AF.7020903@casparzhang.com>
Date: Fri, 10 Aug 2012 16:22:07 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<b9b0b345b3f8305ca1964914c0e1696c6106a0b1.1344492473.git.caspar@casparzhang.com>
	<5024BFF9.7050703@redhat.com>
In-Reply-To: <5024BFF9.7050703@redhat.com>
Subject: Re: [LTP] [PATCH resend 5/6] mm: use new numa_helper
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/10/2012 04:02 PM, Zhouping Liu wrote:
> Caspar, I found get_a_numa_node always return the first node id, which
> will make all cases called the function
> only run in the first node, I don't think it's a good way, it decrease
> the coverage.
>
> we should prefer to run cases on the second node, we can chose the first
> only if it just only has
> one node with NH_MEMS|NH_CPUS. do you think so?
>
> and others is good for me.

Jan and I discussed this issue before:

On 08/01/2012 06:23 PM, Jan Stancek wrote:
 >>> >> >Do you think it will affect test coverage if we always test first
 >>> >> >node?
 > > I'm leaning towards "no". I'm assuming oom01 is using default mem 
policy,
 > > so it can allocate memory from any node (including second one).

And I agree with this opinion. What you think?

Caspar


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
