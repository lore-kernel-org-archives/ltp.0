Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RBTT1-0005ML-NK
	for ltp-list@lists.sourceforge.net; Wed, 05 Oct 2011 15:33:07 +0000
Date: Wed, 5 Oct 2011 17:36:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111005153603.GA29960@saboteur.suse.cz>
References: <1317360651-19857-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1317362906-22726-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317362906-22726-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mtest06: avoid the segment fault of nul
 address dereference
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> If read_mem() goes before *map_address* has been mapped, dereference
> to the *map_address*(nul) will cause the Segment Fault.
> 
> So, let read_mem() yield the CPU when *map_address* hasn't been mapped.
> 

I've been reading the test sourece lately and IMHO this is wanted
behavior. As far as I understand the code the test creates two threads
one to read and one to map/unmap the memory concurently. Look for the
setjmp() and longjmp() in the read_mem() and signal handler that is
expected to do exactly what you are trying to achieve. So if the test
fails with segmentation fault, there is something wrong with the
signal/longjmp handling.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
