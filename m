Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Yhx97-00018n-BU
	for ltp-list@lists.sourceforge.net; Tue, 14 Apr 2015 09:28:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yhx96-0002jb-A7
	for ltp-list@lists.sourceforge.net; Tue, 14 Apr 2015 09:28:41 +0000
Message-ID: <552CDCB0.90904@cn.fujitsu.com>
Date: Tue, 14 Apr 2015 17:24:00 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<551AB4B5.4020902@oracle.com> <551B4C2F.3040108@cn.fujitsu.com>
	<551B9B15.10302@oracle.com>
In-Reply-To: <551B9B15.10302@oracle.com>
Subject: Re: [LTP] [PATCH 1/6] lib6/runcc.c: use TCONF instead of TBROK when
 no C compiler is present
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net



On 04/01/2015 03:15 PM, Alexey Kodanev wrote:
> Hi!
> On 04/01/2015 04:38 AM, gux.fnst wrote:
>>>>       if (WEXITSTATUS(es) == 127) {
>>>> -        tst_resm(TBROK, "can't run C compiler: \"%s\"", cmd);
>>>> +        tst_resm(TCONF, "can't run C compiler: \"%s\"", cmd);
>>>>           if (unlink(filename) < 0)
>>>>               tst_resm(TWARN, "%s; unlink \"%s\" failed: %s", tname,
>>>>                    filename, strerror(errno));
>>>
>>> Why not 'tst_brkm(TCONF, ...)', do we need to proceed further?
>>>
>>
>> The function "runcc" has created a file named "filename" before
>> executing "cmd" command, so I think we should delete this file
>> after tst_resm(TCONF,...).
>>
>
> So, there is temp test directory... you could pass some cleanup function to tst_brkm().

Here we only remove the "filename" file, so I think it is not necessary to
create a cleanup function for this operation.`

Regards,
Xing Gu

>
> Thanks,
> Alexey
>
>

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
