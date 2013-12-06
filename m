Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VovVH-00084v-Uz
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 13:31:35 +0000
Date: Fri, 6 Dec 2013 14:31:01 +0100
From: chrubis@suse.cz
Message-ID: <20131206133101.GA2791@rei.Home>
References: <1385130616-1415-1-git-send-email-alexey.kodanev@oracle.com>
	<20131203135829.GA28700@rei> <529DF2D7.80909@oracle.com>
	<52A06A52.1070801@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A06A52.1070801@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: uaccess: test access to
 user-space memory
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >>> Test checks kernel API to safely access user-space memory using
> >>> +static const char user_str[]    = "User Data";
> >>> +static const char kern_str[]    = "Kern Data";
> >>> +static const int str_size    = 10;
> >> What about defining only one string and setting the size to sizeof() + 1
> >>
> >> static const char test_str[] = "Test string";
> >> static const int str_size = sizeof(test_str) + 1;
> >>
> >> I don't like constants that needs to be updated when surrounding code
> >> changes.
> > Yes, it looks much better!
> I missed it, do we need to add 1 to sizeof as it already counts null 
> character? If not, should I send a new version to fix it?

Ah my bad, we should not, I will fix that when I apply the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
