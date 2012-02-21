Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rzfiy-0005i8-3Z
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 02:45:04 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rzfiv-0004YW-Pi
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 02:45:04 +0000
Received: by pbcum15 with SMTP id um15so6909540pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 18:44:55 -0800 (PST)
Message-ID: <4F4304FE.50606@casparzhang.com>
Date: Tue, 21 Feb 2012 10:44:14 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <bb215812-518c-4d08-971d-7ed628347f4b@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <bb215812-518c-4d08-971d-7ed628347f4b@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 3/2] mm: fix possible node missing in write_cpusets
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 02/20/2012 09:49 PM, Zhouping Liu wrote:
> hi, caspar
>>
>>
>> If a system has noncontinuous nodes, or the node doesn't start from
>> 0,
>> write_cpusets() function may fail because it hard-coded second node
>> as
>> "node1". This patch fixes the function by fetching second node number
>> from the stored array.
>>
>> Tested-by: Caspar Zhang <caspar@casparzhang.com>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>  testcases/kernel/mem/include/mem.h |    4 ++--
>>  testcases/kernel/mem/ksm/ksm02.c   |    6 ++----
>>  testcases/kernel/mem/ksm/ksm04.c   |    6 ++----
>>  testcases/kernel/mem/lib/mem.c     |   21 +++++++++++++--------
>>  4 files changed, 19 insertions(+), 18 deletions(-)
>>
>>
> inside write_cpusets(),
>> 	fd = open(CPATH_NEW "/mems", O_WRONLY);
>> 	if (fd == -1) {
>> 		if (errno == ENOENT) {
>> 			fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
>> 			if (fd == -1)
>> 				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
>> 		} else
>> 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
>> 	}
>> 	if (write(fd, "1", 1) != 1)
> you maybe missed here, it should be:
> 
> snprintf(buf, BUFSIZ, "%ld", nd);
> if (wirte(fd, buf, strlen(buf)) !=strlen(buf))

you're right.

Thanks,
Caspar

> 
>> 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
>> 	close(fd);
> 
> others is okay for me.
> 
> thanks,
> Zhouping


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
