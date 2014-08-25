Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XLtp4-000214-UW
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 12:56:34 +0000
Date: Mon, 25 Aug 2014 14:55:32 +0200
From: chrubis@suse.cz
Message-ID: <20140825125531.GA13044@rei.suse.cz>
References: <76c5a7f9b5adf86f92c575e3673e3f6a4fa57586.1408951056.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76c5a7f9b5adf86f92c575e3673e3f6a4fa57586.1408951056.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] lib/rmobj: avoid using lstat
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> rmobj() is failing for _64 version of testcases, which use large
> files, where it hits EOVERFLOW in lstat():
> 
> open12      0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/opexIqjV3) failed:
>        lstat(/tmp/opexIqjV3/large_file) failed; errno=75:
>        Value too large for defined data type
> 
> Avoid using any *stat functions, instead try to open "obj"
> with open(O_DIRECTORY | O_NOFOLLOW,..). If it succeeds,
> we know we are dealing with directory, otherwise assume
> it's a file or symlink.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

This builds fine back to the SLES9 and works also fine. Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
