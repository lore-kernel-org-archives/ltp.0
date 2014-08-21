Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XKQv6-0003Zc-HF
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 11:52:44 +0000
Date: Thu, 21 Aug 2014 13:51:43 +0200
From: chrubis@suse.cz
Message-ID: <20140821115143.GA16159@rei>
References: <e70bae8bd74a29e9959cae96900a849254b37c9f.1408615314.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e70bae8bd74a29e9959cae96900a849254b37c9f.1408615314.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] safe_macros: turn functions with off_t parameter
 into static inline
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
> Some functions used to implement safe macros have parameters
> of type off_t or structures containing off_t fields.
> 
> We don't want these to be compiled into libltp, because
> some testcases are compiled with different flags such as:
>   -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t
> which then creates incompatibility and testcases can fail.
> 
> For example sendfile06_64 on i386:
>     sendfile06_64    1  TFAIL  :  sendfile06.c:90: sendfile(2) failed
>           to return expected value, expected: 17592186044442, got: 26

Looks good, acked.

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
