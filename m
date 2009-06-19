Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <leemgs1@gmail.com>) id 1MHWNd-0001hB-2S
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:11:13 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHWNc-0003tT-0q
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:11:13 +0000
Received: by yw-out-1718.google.com with SMTP id 5so799760ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 22:11:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245346296.5041.34.camel@subratamodak.linux.ibm.com>
References: <49b7c2350906120147p1a68cde1ua00b2875052ea99c@mail.gmail.com>
	<1245346296.5041.34.camel@subratamodak.linux.ibm.com>
Date: Fri, 19 Jun 2009 14:11:10 +0900
Message-ID: <49b7c2350906182211s34c84011qce55fab5845274f1@mail.gmail.com>
From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [LTP] I met "You can specify it with option -b" error message
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Andrew Vagin <avagin@parallels.com>

On Fri, Jun 19, 2009 at 2:31 AM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
>> remove test cases which require the block device.
>> You can specify it with option -b
>
> This is not an error message at all. See this:
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/runltp?r1=1.40&r2=1.41

I checked above site that you said. Thank you for sharing.
I summarized result of benchmark  using ltp-full-20090531.
----------------------------------------------------------------------------------------------------
 Linux RootFS        Linux Kernel             LTP        Result(Log)
         Result(HTML)
----------------------------------------------------------------------------------------------------
CentOS 5.3                2.6.24              20090531      Success
              Success
Fedora   11                2.6.29              20090531
Success(with+ctrl C)   Failed

#> cd ltp-full-20090531
#> ./configure
#> make
#> make install
#> time ./runalltests.sh  OR
     time ./runltp -v -l alltest.log  -o alltest.out -g alltest.html -x 4

        ....    No response  ......

I still can't view "#>" prompt in my Fedora 11 distribution after 24hours.
I don't know what is reason of this problem  in Fedora 11.


>
> Andrew would also explain you a bit.
>
> Regards--
> Subrata
>

-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
