Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PauXG-0004e9-6Z
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:26:06 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PauXF-0003Kv-F7
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:26:06 +0000
Received: by iyj18 with SMTP id 18so15304237iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 10:26:00 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTi=-BZaz5UVc=M++PzZ9dYiZ7Q7hT4b2PG2ENp8Q@mail.gmail.com>
Date: Thu, 6 Jan 2011 10:25:53 -0800
Message-Id: <150789A0-235F-47FC-921E-D66D3018B79F@gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com> <4D25A136.2020400@cn.fujitsu.com>
	<AANLkTi=-BZaz5UVc=M++PzZ9dYiZ7Q7hT4b2PG2ENp8Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH 05/13]Add some preprocessor variables
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Jan 6, 2011, at 10:23 AM, Mike Frysinger wrote:

> On Thu, Jan 6, 2011 at 6:02 AM, tangchen wrote:
>> +#else
>> +int main(int argc, char *argv[])
>> +{
>> +    tst_brkm(TRETR, tst_exit, "KSM is unsupported");
>> +}
>> +#endif
> 
> i forget ... what did we decide for situations like this ?  tst_bkrm(TCONF) ?

TCONF makes more sense.
Thanks,
-Garrett


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
