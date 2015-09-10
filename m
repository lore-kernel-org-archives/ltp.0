Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanlong.gao@gmail.com>) id 1Za0NB-0000rH-5P
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 11:50:37 +0000
Received: from mail-la0-f41.google.com ([209.85.215.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Za0NA-0000UZ-Bq
	for ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 11:50:37 +0000
Received: by lamp12 with SMTP id p12so25592443lam.0
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Sep 2015 04:50:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO0kMxAv17kx5bg7L++dmQ=OT6nsidj_VCJWtvfF__xBgmJ0XA@mail.gmail.com>
References: <CAO0kMxAv17kx5bg7L++dmQ=OT6nsidj_VCJWtvfF__xBgmJ0XA@mail.gmail.com>
Date: Thu, 10 Sep 2015 19:50:29 +0800
Message-ID: <CAGxEiDC4J8yRjj+xj7bZVzTbh=-YrERnRZQxjswMH6ndggm8Fg@mail.gmail.com>
From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [LTP] Ltp user defined test-cases to run
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
Cc: ltp-list@lists.sourceforge.net

On 9/10/15, kamal p <pkamalbhaskar@gmail.com> wrote:
> Hi ,
>
>   Can anyone tell me the procedure how to run user defined set of
> test-cases(LTP) using runltp with "-f" option by creating command file

$ cat >runtest/myset <<EOF
# list the cases you like
accept01 accept01
accept4_01 accept4_01

access01 access01
access02 access02
EOF

$ ./runltp -f myset

Thanks,
Wanlong Gao


>
> Regards,
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
