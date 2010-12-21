Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PUwkD-0004Au-V5
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:34:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUwkC-0002Hg-7c
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:34:49 +0000
Message-ID: <4D1057E0.4060000@cn.fujitsu.com>
Date: Tue, 21 Dec 2010 15:31:44 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <1920170050.25294.1292915503845.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1920170050.25294.1292915503845.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH]Fix building error.
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sourceforge.net



CAI Qian wrote:
>> Could you tell me which kernels are this test fit to?
> It is hard to tell. The old kernel might decide to back-port this feature.

I see.

Would you like tell me what's the test required? 

If the test is good, i think it should pass on old kernel which had back-port
this feature, otherwise the back-port procedure is incorrect.

>> If there is old KSM interface, and this test can not work correctly on
>> it, i think we should fix the test, it should not do anything but reports
>> "This test is unsupported!"
> Anyway, it would be more code to test here and there rather than kernel version. Isn't LTP's guideline to only support the latest and greatest kernels?
> 

En..., i do not know.  :)

Thanks
 Bian

> CAI Qian
> 
> 

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
