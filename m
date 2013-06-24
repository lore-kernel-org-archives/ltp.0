Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Ur3b8-0001Sl-Qh
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 10:02:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ur3b7-0007Lp-4G
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 10:02:10 +0000
Message-ID: <51C81903.2030905@oracle.com>
Date: Mon, 24 Jun 2013 14:01:39 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
	<201306221415.17130.vapier@gentoo.org>
In-Reply-To: <201306221415.17130.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tst_module: create new library functions for
 kernel modules
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
On 06/22/2013 10:15 PM, Mike Frysinger wrote:
>
>> +/* declared in tst_tmpdir.c */
>> +const char *tst_get_startwd(void);
> use a proper header instead.  extern func decls only leads to bit rot and hard
> to debug crashes.
But, there is no header for this function in LTP, it is declared inside 
c file, and I
used it in the same way as it was already used in tst_resource.c.

Thanks,
Alexey

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
