Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XK5RG-0005ot-Lx
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 12:56:30 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XK5RD-0004Tl-VW
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 12:56:30 +0000
Date: Wed, 20 Aug 2014 08:56:21 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <663056555.9870858.1408539381311.JavaMail.zimbra@redhat.com>
In-Reply-To: <1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
References: <1070499573.9869577.1408539206966.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] open12 failing on i386 with EOVERFLOW
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
To: ltp-list <ltp-list@lists.sf.net>





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "ltp-list" <ltp-list@lists.sf.net>
> Sent: Wednesday, 20 August, 2014 2:53:26 PM
> Subject: [LTP] open12 failing on i386 with EOVERFLOW
> 
> Hi,
> 
> I'm seeing following failure in this testcase on RHEL-6.5 Server i386 GA
> distro:
> 
> # env PATH=`pwd`:$PATH ./open12
> open12      1  TFAIL  :  open12.c:104: test O_APPEND for open failed
> open12      2  TCONF  :  open12.c:123: test O_NOATIME flag for open needs
> filesystems which is mounted without noatime and relatime
> open12      3  TPASS  :  test O_CLOEXEC for open success
> open12      4  TPASS  :  test O_LARGEFILE for open success
> open12      0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/opexIqjV3)
> failed: lstat(/tmp/opexIqjV3/large_file) failed; errno=75: Value too large
> for defined data type
> 

Same issue in openat02:

# env PATH=`pwd`:$PATH ./openat02
openat02    1  TPASS  :  test O_APPEND for openat success
openat02    2  TPASS  :  test O_CLOEXEC for openat success
openat02    3  TPASS  :  test O_LARGEFILE for openat success
openat02    4  TCONF  :  openat02.c:242: test O_NOATIME flag for openat needs filesystems which are mounted without noatime and relatime
openat02    5  TPASS  :  test O_NOFOLLOW for openat success
openat02    6  TPASS  :  test O_TRUNC for openat success
openat02    0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/opeim4IKK) failed: lstat(/tmp/opeim4IKK/large_file) failed; errno=75: Value too large for defined data type


> Since it's linked from library, adding -D_FILE_OFFSET_BITS=64 to this
> testcase has
> no effect.
> 
> One simple way to fix it would be to unlink it in test, so that
> rmobj.c doesn't hit it.
> 
> $ diff -u open12.c /tmp/open12.c
> --- open12.c	2014-08-14 17:46:33.052044613 +0200
> +++ /tmp/open12.c	2014-08-20 14:48:35.655208417 +0200
> @@ -221,6 +221,10 @@
>  		tst_resm(TPASS, "test O_LARGEFILE for open success");
>  		SAFE_CLOSE(cleanup, TEST_RETURN);
>  	}
> +
> +	/* clean it up here, because lib/rmobj.c on 32bit will
> +	 * hit EOVERFLOW in lstat() */
> +	unlink(LARGE_FILE);
>  }
>  
>  static void cleanup(void)
> 
> Any thoughts?
> 
> Regards,
> Jan
> 
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
