Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanlong.gao@gmail.com>) id 1ZZuj3-0005Og-BJ
	for Ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 05:48:49 +0000
Received: from mail-lb0-f173.google.com ([209.85.217.173])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZZuj2-0000CY-EO
	for Ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 05:48:49 +0000
Received: by lbpo4 with SMTP id o4so17213558lbp.2
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 09 Sep 2015 22:48:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO0kMxDg1KJWzFMqyYOmP5xLe78pyf21MwizsM_P38Vbx02HeQ@mail.gmail.com>
References: <CAO0kMxDg1KJWzFMqyYOmP5xLe78pyf21MwizsM_P38Vbx02HeQ@mail.gmail.com>
Date: Thu, 10 Sep 2015 13:48:41 +0800
Message-ID: <CAGxEiDBih4Ged2+LST_30CM8dMMwwM3vMetx=0vwNPHaA-8hRQ@mail.gmail.com>
From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [LTP] Query related to LTP test suite run
Reply-To: wanlong.gao@gmail.com
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
To: kamal p <pkamalbhaskar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

On 9/10/15, kamal p <pkamalbhaskar@gmail.com> wrote:
> Hi,
>   I've query which is based on LTP test-cases running.
>   these days I've downloaded and installed LTP on my linux host machine.
>   while running the test cases using runltp script my system went to crash
> after running few testcases.
>   why I am facing these problem and Please clarify me anyone with relevant
> answer for these same.

It's possible that system crashes by some test case, you can check the LTP
result log to see which may cause it. And you can run the specific test case
suite under "runtest/" directory using the "-f" option of "runltp".

Thanks,
Wanlong Gao

> Regards &Thanks,
> Kamal
>

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
