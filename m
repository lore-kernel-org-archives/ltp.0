Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1StXtw-00061W-M1
	for ltp-list@lists.sourceforge.net; Tue, 24 Jul 2012 05:43:20 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1StXtu-0004Zf-AO
	for ltp-list@lists.sourceforge.net; Tue, 24 Jul 2012 05:43:20 +0000
Received: by pbbrq2 with SMTP id rq2so11330497pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 23 Jul 2012 22:43:12 -0700 (PDT)
References: <1343098694-8295-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1343098694-8295-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<500E1B37.2060309@casparzhang.com>
	<500E1E39.3050704@cn.fujitsu.com>
In-Reply-To: <500E1E39.3050704@cn.fujitsu.com>
Mime-Version: 1.0 (1.0)
Message-Id: <241B7B02-77E9-4181-B4BA-F2276F1DCBE2@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Mon, 23 Jul 2012 22:42:51 -0700
Subject: Re: [LTP] [PATCH 2/2] open_posix:aio_fsync:14-1: wait for aio_write
	completion
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
To: "gaowanlong@cn.fujitsu.com" <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Sent from my iPhone

On Jul 23, 2012, at 9:02 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:

> On 07/24/2012 11:49 AM, Caspar Zhang wrote:
>> On 07/24/2012 10:58 AM, Wanlong Gao wrote:
>>> Wait for aio_write() completion.
>>> If aio_fsync() sync the fd without the previous aio_write()
>>> completion, it will cause Segment Fault.
>>> 
>>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>>> ---
>>>  .../open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>> 
>>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
>>> index a9cd3bf..e15f084 100644
>>> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
>>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
>>> @@ -27,6 +27,7 @@ int main()
>>>  #define BUF_SIZE 111
>>>      char buf[BUF_SIZE];
>>>      int fd;
>>> +    int ret;
>>>      struct aiocb aiocb_write;
>>>      struct aiocb aiocb_fsync;
>>> 
>>> @@ -57,6 +58,14 @@ int main()
>>>          exit(PTS_FAIL);
>>>      }
>>> 
>>> +    while ((ret = aio_error(&aiocb_write) == EINPROGRESS))
>> 
>> I think checkpatch.pl would complain here.
> 
> Not really.
> It should be assigned in while() here, can't be split to two lines.

Or you could use a do-while..

>> 
>>> +        usleep(10000);
>>> +    if (ret < 0) {
>>> +        printf(TNAME " Error at aio_error() : %s\n", strerror(ret));
>>> +        exit(PTS_FAIL);
>>> +    }
>>> +
>>> +
>>>      memset(&aiocb_fsync, 0, sizeof(aiocb_fsync));
>>>      aiocb_fsync.aio_fildes = fd;
>>> 
>>> 
>> 
>> 
>> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

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
