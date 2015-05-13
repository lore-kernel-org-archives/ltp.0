Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YsVKo-0005oY-BD
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 12:00:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YsVKm-0004oP-Lb
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 12:00:22 +0000
Message-ID: <55533D7C.7010404@oracle.com>
Date: Wed, 13 May 2015 15:03:08 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>	
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>	
	<554B7127.7000606@oracle.com> <1431067342.1760.10.camel@localhost>
In-Reply-To: <1431067342.1760.10.camel@localhost>
Subject: Re: [LTP] [PATCH 3/3] kernel/mem/mmapstress: fix resource leak
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,
On 05/08/2015 09:42 AM, Wei, Jiangang wrote:
> On Thu, 2015-05-07 at 17:05 +0300, Alexey Kodanev wrote:
>
>> In both above cases it'll call anyfail() after checking fileokay()'s
>> return value.
>> If it seems not obvious we can close 'fd' here and it'd be better to use
>> SAFE_CLOSE() macro from safe_macros.h.
> There's no cleanup function for SAFE_CLOSE().
> so,
> close() is the same as SAFE_CLOSE(NULL, fd).

tst_brkm() is using tst_rmdir() as a cleanup function.


Best regards,
Alexey


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
