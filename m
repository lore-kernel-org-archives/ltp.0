Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YudkK-0000UD-2l
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 09:23:32 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YudkI-0003cu-4f
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 09:23:32 +0000
Date: Tue, 19 May 2015 05:23:17 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1672705239.1608287.1432027397871.JavaMail.zimbra@redhat.com>
In-Reply-To: <1432006441.27486.26.camel@G08FNSTD140232>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1432006441.27486.26.camel@G08FNSTD140232>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mmapstress01: Modify readbuf's type and define it
 to	uchar_t
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "Jiangang Wei" <weijg.fnst@cn.fujitsu.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 19 May, 2015 5:34:01 AM
> Subject: [LTP] [PATCH] mmapstress01: Modify readbuf's type and define it to	uchar_t
> 
> readbuf is defined to char. That is different with the previous
> defined. If readbuf's value is more than 127, that would be regarded
> as negative number. And expbuf is uchar_t, the value is always
> nonegative. That will make the test fail because the different data
> type.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Applied.

Regards,
Jan

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
