Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Yhf7z-0002YT-6s
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 14:14:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yhf7y-0006qP-7h
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 14:14:19 +0000
Message-ID: <552BCFDA.40301@oracle.com>
Date: Mon, 13 Apr 2015 17:16:58 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1428672725-13538-1-git-send-email-alexey.kodanev@oracle.com>	<552B2AFF.20107@cn.fujitsu.com>
	<552BC7C7.1010105@oracle.com>
In-Reply-To: <552BC7C7.1010105@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/fallocate04: add new fallocate() test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


On 04/13/2015 04:42 PM, Alexey Kodanev wrote:
> Hi!
> On 04/13/2015 05:33 AM, Xiaoguang Wang wrote:
>>> +
>>> +#define SEEK_HOLE			4
>>> +#define FALLOC_FL_KEEP_SIZE		0x01
>>> +#define FALLOC_FL_PUNCH_HOLE		0x02
>>> +#define FALLOC_FL_COLLAPSE_RANGE	0x08
>>> +#define FALLOC_FL_ZERO_RANGE		0x10
>> What about something like this:
>> #ifndef	FALLOC_FL_KEEP_SIZE	4
>> #define	 FALLOC_FL_KEEP_SIZE	4
>> #endif
>> In case, glibc have already defines these macro now or in future.
> Redefinition with the same values doesn't produce any warnings, but on
> the other hand what if we want to know when they are different?

In case glibc defines them as '1', etc. it will produce a warning, so 
it's better take your advice.

Best regards,
Alexey


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
