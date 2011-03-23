Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q2MsG-0004G8-9R
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 12:09:16 +0000
Date: Wed, 23 Mar 2011 13:31:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110323123146.GA4035@saboteur.suse.cz>
References: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
Subject: Re: [LTP] New member to mailing list ..
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
To: Naveen Joshi - C and Linux <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is Joshi . newer to LTP mailing list.
> 
> Right now doing am testing with LTP. having some issues related aio_return.
> In aio_return/2-1.c
> vi 2-1.c
> 
> *#define TNAME "aio_return/2-1.test"
> :
> Something
> :
> 
> retval = aio_return(&aiocb)
> if (retval != -1)
> {
>      close()fd)
>      printf(TNAME "Second call to aio_return() should return -1 :%d\n",retval)
>      exit()
> 
> }
> 
> Here i calling aio_return(&aiocb)for 3 times . but **if i call
> aio_return(&aiocb)2nd ti,e it should fail means it should return
> -1 . in my program its retuning other than -1 . SO test is failing
> here . Can any one suggest to fix the bug .

The POSIX [1] says, aio_return() _may_ fail, if called more than once.
The 'may' means that it's implementation defined if it fails or not so
the test as it is now is invalid. We were fixing these cases by
reporting TCONF rather than failure, if I remember correctly.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/aio_return.html

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
