Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SoD3i-0006KV-6k
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:27:22 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SoD3c-0004qm-KN
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:27:22 +0000
Received: by pbbrq2 with SMTP id rq2so18109985pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jul 2012 05:27:10 -0700 (PDT)
Message-ID: <4FFACE16.5080500@casparzhang.com>
Date: Mon, 09 Jul 2012 20:27:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
	<4FFAC93A.6080407@cn.fujitsu.com>
In-Reply-To: <4FFAC93A.6080407@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] mm/vma01: consider topdown and bottomup
	allocation
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Wang Sheng-Hui <shhuiw@gmail.com>

On 07/09/2012 08:06 PM, Wanlong Gao wrote:
> On 06/25/2012 03:33 PM, Caspar Zhang wrote:
>> +		if (topdown) {
>> +			x = get_end_addr(u);
>> +			printf("child : x = %p\n", x);
>> +			if (x == t + 3*ps)
>> +				exit(1);
>> +			else if (x == t && get_end_addr(x) == t + 3*ps)
>> +				exit(0);
>> +		} else {
>> +			x = get_end_addr(t);
>> +			printf("child : x = %p\n", x);
>> +			if (x == t + 6*ps)
>> +				exit(1);
>> +			else if (x == u && get_end_addr(x) == t + 6*ps)
>>   				exit(0);
>>   		}
>
> Looks good to me.
>
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>
> But why not use tst_resm(TINFO, ) instead?

This is in child process. We'd avoid potential race on libltp between 
child and parent. (see style-guide.txt)

Caspar

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
