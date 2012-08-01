Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SwX3T-0004Xj-3q
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 11:25:31 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SwX3S-0003iQ-Bk
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 11:25:31 +0000
Received: by mail-pb0-f47.google.com with SMTP id rq2so862702pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Aug 2012 04:25:30 -0700 (PDT)
Message-ID: <50191221.5070301@casparzhang.com>
Date: Wed, 01 Aug 2012 19:25:21 +0800
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
>> >Do you think it will affect test coverage if we always test first
>> >node?
> I'm leaning towards "no". I'm assuming oom01 is using default mem policy,
> so it can allocate memory from any node (including second one).

OK, I think I'm agreeing with you now. If there's no objection, I'll 
update my patch to choose 1st node to simplify the code.

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
