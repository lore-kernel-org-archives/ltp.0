Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YkvbI-0006Lw-HR
	for ltp-list@lists.sourceforge.net; Wed, 22 Apr 2015 14:26:04 +0000
Date: Wed, 22 Apr 2015 16:06:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150422140630.GB32660@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
	<20150401143314.GA23093@rei> <551CB5CD.5030903@huawei.com>
	<20150402083344.GA27984@rei> <552D112E.4040104@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <552D112E.4040104@huawei.com>
Subject: Re: [LTP] [PATCH v4 2/2] syscalls/utimensat01: "chattr" command
	error
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi!
> The "chattr" command in case failed in some file system (such as memory fs):
> 'chattr: Inappropriate ioctl for device while reading flags on'
> 
> I learn that chattr command only can be used in ext2 or ext3 (ext4 is ok now).
> So we check it before running.

Do all of the testcases fail or only some of them?

If the latter is case it would be better to set some variable and skip
only the testcases that will fail otherwise
(i.e. tst_resm TCONF "chattr not supported").

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
