Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YLqju-0006zM-6R
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 10:11:18 +0000
Date: Thu, 12 Feb 2015 11:10:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150212101057.GA10816@rei.suse.de>
References: <fa5f4e375e5c464d94ee43b94193054f@SGPMBX1009.APAC.bosch.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa5f4e375e5c464d94ee43b94193054f@SGPMBX1009.APAC.bosch.com>
Subject: Re: [LTP] fs tests causing extensive SD card r/w?
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
To: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I would like some clarity on which of the file system tests are doing
> most extensive r/w operations. I run these LTP fs tests on an SD card.
> For past sometime I face issue where the card gets disconnected with
> below errors at times and doesn't get detected again. This mostly
> happens on ftest* where sync/fsync is happening:

Most of the filesystem testcases are stress tests. There are a few
testcases for file permissions, extended attributes, procfs and so, but
the rest just hammers filesystem with various types of load. Especially
the aio testcases are all stressing the system with excesive I/O.

> 
> I/O error , DID_NO_CONNECT
> 
> [ 3277.237974] EXT4-fs error (device sdc1): ext4_put_super:861: Couldn't clean up the journal
>
> I am suspecting that these tests over a period of time have caused the
> card's flash memory life to near end, because when I used a newer card
> yesterday the results improved and these errors didn't come.

My guess is that the area used for the ext4 journal has died, which is
inevitable because the journal gets written over and over (it's a
circular log of fs operations). It's better to turn the journal off for
SD cards (and even better aling the filesystem to the card erase block
size). Have a look at:
https://blogofterje.wordpress.com/2012/01/14/optimizing-fs-on-sd-card/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
