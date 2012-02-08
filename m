Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rv36F-0003DF-ST
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:41:59 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rv36A-0005Z4-M0
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:41:59 +0000
Received: by iaby12 with SMTP id y12so656493iab.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Feb 2012 00:41:49 -0800 (PST)
Message-ID: <4F323531.3060105@casparzhang.com>
Date: Wed, 08 Feb 2012 16:41:21 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328689302-5506-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328689302-5506-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F3232EC.4030007@casparzhang.com>
	<4F32345F.5030909@cn.fujitsu.com>
In-Reply-To: <4F32345F.5030909@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/4] hugemmap01: auto mount the temporary dir
 for testing
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On 02/08/2012 04:37 PM, Wanlong Gao wrote:
>> > Hi, I just have another concern, that you might want to keep the initial
>> > value of nr_hugepages and restore it once the test is done.
> 
> as set_sys_tune defined in mem lib, this restore work should be done there,
> too.

no, set_sys_tune only set the value and verify the content if the third
parameter is setting to "1".

You should save the original value by using get_sys_tune in setup() and
restore it in cleanup() by using set_sys_tune again.

Thanks,
Caspar

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
