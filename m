Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XK8uP-0002Sy-2E
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 16:38:49 +0000
Date: Wed, 20 Aug 2014 18:37:48 +0200
From: chrubis@suse.cz
Message-ID: <20140820163748.GC23887@rei>
References: <2034790660.10002643.1408549800988.JavaMail.zimbra@redhat.com>
	<2040651060.10018391.1408550993826.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2040651060.10018391.1408550993826.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] sendfile06_64 failure on i386
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> this testcase is currently failing on i386:
> 
> sendfile06_64    1  TFAIL  :  sendfile06.c:90: sendfile(2) failed to return expected value, expected: 17592186044442, got: 26
> 
> It's using SAFE_FSTAT from libltp, which is not compiled with 
>   -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t as the testcase.
> 
> The testcase can pass if I turn SAFE_FSTAT into plain fstat:
> 
> -       SAFE_FSTAT(cleanup, fd, &sb);
> +       TEST(fstat(fd, &sb));
> +       if (TEST_RETURN != 0)
> +               tst_brkm(TBROK | TTERRNO, cleanup, "fstat");
> 
> but I'm wondering if we can fix this at global level, so users
> of safe_macros don't have to worry about this.

I guess that turning the safe_fstat() into static inline function and
putting it into the safe_macros.h header should fix the issue. That way
the fstat would use struct stat64 corectly if corresponding macros are
defined.

Anything else would need more ifdefs and would be fairly tricky to
maintain.

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
