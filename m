Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SxHxj-0000E8-NV
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 13:30:43 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SxHxi-00040I-K9
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 13:30:43 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q73DUa1I005112
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Aug 2012 09:30:36 -0400
Date: Fri, 3 Aug 2012 09:30:36 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1893607568.8224293.1344000636463.JavaMail.root@redhat.com>
In-Reply-To: <1830812880.8215441.1343999990387.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: [LTP] failing syscall testcases with kernel 3.5.0
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi,

These are failures I currently see with kernel 3.5.0 (likely same in 3.6-rc1):

sockioctl01    1  TPASS  :  bad file descriptor successful
sockioctl01    2  TFAIL  :  not a socket ; returned -1 (expected -1), errno 25 (expected 22)
sockioctl01    3  TPASS  :  invalid option buffer successful
sockioctl01    4  TPASS  :  ATMARK on UDP successful
sockioctl01    5  TPASS  :  SIOCGIFCONF successful
sockioctl01    6  TPASS  :  SIOCGIFFLAGS successful
sockioctl01    7  TPASS  :  SIOCGIFFLAGS with invalid ifr successful
sockioctl01    8  TPASS  :  SIOCSIFFLAGS with invalid ifr successful
^^ posted patch today

mbind01     0  TINFO  :  (case00) START
mbind01     1  TPASS  :  (case00) END
mbind01     0  TINFO  :  (case01) START
mbind01     2  TPASS  :  (case01) END
mbind01     0  TINFO  :  (case02) START
mbind01     3  TPASS  :  (case02) END
mbind01     0  TINFO  :  (case03) START
mbind01     4  TFAIL  :  (case03) END: errno=???(0): Success
mbind01     0  TINFO  :  (case04) START
mbind01     5  TPASS  :  (case04) END
mbind01     0  TINFO  :  (case05) START
mbind01     6  TFAIL  :  (case05) END: errno=???(0): Success
mbind01     0  TINFO  :  (case06) START
mbind01     7  TFAIL  :  (case06) END: errno=???(0): Success
mbind01     0  TINFO  :  (case07) START
mbind01     8  TFAIL  :  (case07) END: errno=???(0): Success
mbind01     0  TINFO  :  (case08) START
mbind01     9  TPASS  :  (case08) END
mbind01     0  TINFO  :  (case09) START
mbind01    10  TPASS  :  (case09) END
mbind01     0  TINFO  :  (case10) START
mbind01    11  TPASS  :  (case10) END

get_mempolicy01    0  TINFO  :  (case00) START
get_mempolicy01    1  TPASS  :  (case00) END
get_mempolicy01    0  TINFO  :  (case01) START
get_mempolicy01    2  TPASS  :  (case01) END
get_mempolicy01    0  TINFO  :  (case02) START
get_mempolicy01    3  TPASS  :  (case02) END
get_mempolicy01    0  TINFO  :  (case03) START
get_mempolicy01    4  TPASS  :  (case03) END
get_mempolicy01    0  TINFO  :  (case04) START
get_mempolicy01    5  TPASS  :  (case04) END
get_mempolicy01    0  TINFO  :  (case05) START
get_mempolicy01    6  TPASS  :  (case05) END
get_mempolicy01    0  TINFO  :  (case06) START
get_mempolicy01    7  TFAIL  :  (case06) END: errno=???(0): Success
get_mempolicy01    0  TINFO  :  (case07) START
get_mempolicy01    8  TFAIL  :  (case07) END: errno=???(0): Success
get_mempolicy01    0  TINFO  :  (case08) START
get_mempolicy01    9  TFAIL  :  (case08) END: errno=???(0): Success
get_mempolicy01    0  TINFO  :  (case09) START
get_mempolicy01   10  TFAIL  :  (case09) END: errno=???(0): Success
get_mempolicy01    0  TINFO  :  (case10) START
get_mempolicy01   11  TPASS  :  (case10) END
get_mempolicy01    0  TINFO  :  (case11) START
get_mempolicy01   12  TPASS  :  (case11) END

move_pages01    1  TFAIL  :  page 0 on node 1, expected on node 0

mbind01, get_mempolicy01 and move_pages01 are all related to mbind().
It appears that starting with following commit mbind has no effect.
--------------------------------------------------------------
commit 05f144a0d5c2207a0349348127f996e104ad7404
Author: Mel Gorman <mgorman@suse.de>
Date:   Wed May 23 12:48:13 2012 +0100

    mm: mempolicy: Let vma_merge and vma_split handle vma->vm_policy linkages
--------------------------------------------------------------

Bug 845268 - mbind reports success, but has no effect
https://bugzilla.redhat.com/show_bug.cgi?id=845268

Regards,
Jan

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
