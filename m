Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SO2V1-0008U5-TD
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:55:24 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SO2V1-0007FP-9A
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:55:23 +0000
Received: by dadz9 with SMTP id z9so2149183dad.33
	for <ltp-list@lists.sourceforge.net>;
	Sat, 28 Apr 2012 00:55:17 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1257)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <66ac99257dc97775fbb2b44287874ad43d408b4c.1335599279.git.zliu@redhat.com>
Date: Sat, 28 Apr 2012 00:53:14 -0700
Message-Id: <8E63F742-6077-421D-90F9-6C3BE08DEB8D@gmail.com>
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
	<66ac99257dc97775fbb2b44287874ad43d408b4c.1335599279.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] syscalls/move_pages: modified HAS_NUMA_H as
	HAVE_NUMA_H
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

On Apr 28, 2012, at 12:48 AM, Zhouping Liu wrote:

> HAS_NUMA_H should be HAVE_NUMA_H, and most functions are defined
> in numa.h and numaif.h, so added the include headers into
> move_pages_support.h
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Reviewed-by: Garrett Cooper <yanegomi@gmail.com


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
