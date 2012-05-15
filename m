Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SUGTe-0003wr-9w
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 12:03:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUGTY-0003Cr-2z
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 12:03:42 +0000
Message-ID: <4FB245C8.2040801@cn.fujitsu.com>
Date: Tue, 15 May 2012 20:02:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
	<1336655089-26941-3-git-send-email-marios.makris@gmail.com>
	<4FB0B348.3020601@cn.fujitsu.com>
	<CAMYrgfQUi_LziMsMsAkSnQdYS6FAryf71dHx6CHX_z5xJDPQmg@mail.gmail.com>
In-Reply-To: <CAMYrgfQUi_LziMsMsAkSnQdYS6FAryf71dHx6CHX_z5xJDPQmg@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/3] Changed nconv variable from long to int in
 /lib/bytes_by_prefix.c
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Marioh mrs <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05/15/2012 07:51 PM, Marioh mrs wrote:

> On 14 May 2012 10:24, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>>
>>
>> But Marios,
>>
>> In the previous patch, you changed the library function
>> from str_to_bytes to bytes_by_prefix, if you'd prefer
>> the latter name, please also replace the using of str_to_bytes
>> with the new name, if not, it'll not be compiled.
>>
>> Thanks,
>> Wanlong Gao
>>
> 
> Hello Wanlong,
> 
> The replacement of usages of the str_to_bytes (now bytes_by_prefix)
> is already done and are part of the previous patch as well.
> 
> Quoting that part from the previous patch:
>> Furthermore any call to the file or its functions by other functions,
>> manpages etc. have been modified to comply with the new names.
> 
> Furthermore i have tested compiling it (clean compile of the repo and then
> applying the patches and recompiling as well as clean compilation with
> my commits) on two computers and it compiled well.
> 
> I hope i didn't misunderstand your comment, please tell me where i am
> wrong if that is the case.
> 
> Thanks a lot for reviewing.


At least you can take a look at here ./testcases/kernel/fs/doio/iogen.c

Thanks,
Wanlong Gao


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
