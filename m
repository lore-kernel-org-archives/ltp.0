Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MwCHL-0003qH-GI
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 10:00:51 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MwCHE-0004Gy-L9
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 10:00:51 +0000
Received: by pxi39 with SMTP id 39so6826860pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Oct 2009 03:00:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810910070413me5f0995j2540c28415f095d8@mail.gmail.com>
References: <f5a7b3810910070413me5f0995j2540c28415f095d8@mail.gmail.com>
Date: Fri, 9 Oct 2009 15:30:38 +0530
Message-ID: <d51f89b0910090300v4be94011qa354387834c59421@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] HTML not reporting number of Failed test cases
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi,

Thanks Naresh for pointing out the issue in the HTML report. I had
also noticed the issue in my test reports.

However, I wish to confirm that the issue being mentioned is not a
side-effect of the fix that I had posted for the pan driver.
If you compare the HTML reports from the previous releases and the
recent one, you can notice all the tags - FAIL, WARN, BROK, PASS,CONF
& RETR are now prefixed by ' T ' for reasons not known to me
(resulting in - TFAIL, TPASS etc).

Now, if you check ltp-full-20090831/tools/genhtml.pl file you can see
all that old tags (FAIL, WARN, etc) are used instead of the new
ones(tags). As a result the numbers are not updated in the summary in
HTML report. Also FAIL/WARN/BROK test-cases are not uniquely colored
like in the old versions of LTP.

Please check the same.
If possible I will generate a patch and submit the same.

On Wed, Oct 7, 2009 at 4:43 PM, naresh kamboju <naresh.kernel@gmail.com> wrote:
> Hi,
>
> I think you have noticed difference in the HTML file generation.
> HTML file is not reporting number of failure test cases
> in summary and failed column with different color.
> Some changes are made by Rohit recently.
>
> Rohit,
> Please investigate the changes made to HTML file generator.
>
> You can refer the results logs share in LTP release in the below link for
> X86
> (ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
> Ia64
> (ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)
>
> Link : http://sourceforge.net/projects/ltp/files/
>
>
> Best regards
> Naresh Kamboju
>



--
Regards,
Rohit

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
