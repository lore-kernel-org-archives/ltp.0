Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T6dgs-0004gh-JL
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 08:31:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6dgr-0004EM-1z
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 08:31:58 +0000
Message-ID: <503DD300.309@cn.fujitsu.com>
Date: Wed, 29 Aug 2012 16:29:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1768335107.59483055.1346044605729.JavaMail.root@redhat.com>
	<503C36CC.20201@oracle.com> <503CBEBF.2040101@redhat.com>
In-Reply-To: <503CBEBF.2040101@redhat.com>
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: ZhouPing Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net


> yes, you are right.
> I tried to fork several processes to hog memory, but I don't think it's 
> a better way, so a good solution(I think) is included in below patch.
> 
>>
>> And we can also patch the overflow issue which I mentioned before:
>>
>> The type of total_mem "unsigned long" is not suitable with nowadays
>> memory ,it will overflow(with i386) in line 177:map_count = total_mem
>> *
>> KB / MAP_SIZE and the value of map_count is not correct.
>> Using "unsigned long long" could fix this issue.
> 
> after re-check the code, I found map_count was not necessary, so I 
> removed it,
> at the same time, it fixed your the overflow issue.
> 
> please review the patch again, if you agree the fix, I will send a 
> formal patch set in new subject:


So, please, thank you.

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
