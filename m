Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2Gbf-0005Ei-0t
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 10:18:07 +0000
Date: Tue, 9 Jun 2015 12:17:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609101703.GG24041@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150609100005.GB24041@rei.suse.de> <5576BB8A.2030809@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5576BB8A.2030809@oracle.com>
Subject: Re: [LTP] [PATCH 1/5] acl_test01: Fixes
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> This is because we call 'tst_require_root' twice. The first time is from 
> "FUNCTION MAIN:" and the second time when we execute do_setup.
> 
> So 'tst_require_root' in do_setup is redundant.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
