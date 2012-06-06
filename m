Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ScHRi-0001FE-Ry
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 14:42:50 +0000
Date: Wed, 6 Jun 2012 16:41:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120606144136.GC20162@saboteur.suse.cz>
References: <CANoG8sX9dk4ztf=pK0JtFtn=qMMknociKAnN+_VEeQjCT8Wc6w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANoG8sX9dk4ztf=pK0JtFtn=qMMknociKAnN+_VEeQjCT8Wc6w@mail.gmail.com>
Subject: Re: [LTP] LTP filesystem related tests
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 1) What option should I use with runltp to test different filesystems?
>  -d TMPDIR and with TMPDIR on different filesystems?

Yes, that is pretty much how to do it.

I do remeber that some of the tests weren't utilizing TMPDIR and used
/tmp/ directly but that should be hopefully fixed now.

> 2) Which tests should I use to test if filesystem is working fine?
> I'm using the following:
> 
> filecaps
> fs
> fs_bind
> fs_perms_simple
> fs_readonly
> fsx
> 
> Are the above tests a good test suite for filesystem test?  Any other
> tests (e.g. aio, dio)?

Are you looking for stress tests or functionality tests or both?

As allready said, quite a lot of the tests in the syscalls runtest file
do something filesystem related.

Then there are some stress tests as growfiles and dio_* and aiodio_*
etc.

-- 
Cyril Hrubis
chrubis@suse.cz

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
