Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Slxk8-00018f-LB
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 07:41:52 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Slxk3-0005mq-4p
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 07:41:52 +0000
Received: by pbbrq2 with SMTP id rq2so8547972pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jul 2012 00:41:41 -0700 (PDT)
Message-ID: <4FF2A225.7070304@casparzhang.com>
Date: Tue, 03 Jul 2012 15:41:25 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <dce1058c-b9d4-4670-aee2-c39c7cf970a1@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <dce1058c-b9d4-4670-aee2-c39c7cf970a1@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
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
Cc: LTP List <ltp-list@lists.sourceforge.net>, CAI Qian <caiqian@redhat.com>

On 06/29/2012 12:37 PM, Zhouping Liu wrote:
> and I tested get_allowed_nodes(), it didn't fix the error,
> with above setup, I expected get_allowed_nodes_arr() can mark node1 is a unavailable node,
> but in actual it didn't, and it's the similar with count_numa() inside testcase/kernel/mem/lib/mem.c.
> so, Jan, do you have any thoughts to avoid the issues? if get-allowed_nodes* can fix these issues, I also suggest we can
> define them in ltp/include/numa_helper.h or other file name, comments?

Hi Zhouping, can you propose a patch for this?

Thanks,
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
