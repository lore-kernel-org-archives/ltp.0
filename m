Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Rb47E-0002hn-7B
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:44:24 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rb47D-00026E-9I
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:44:24 +0000
Received: by ggnh1 with SMTP id h1so2030330ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Dec 2011 21:44:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EE963A9.7030100@cn.fujitsu.com>
References: <4EE95F75.6030909@cn.fujitsu.com> <4EE963A9.7030100@cn.fujitsu.com>
Date: Wed, 14 Dec 2011 21:44:17 -0800
Message-ID: <CAGH67wQxgxm01PQVGyaMTDgThGU8pNUSMsrAkVMX2MBiAX48JQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong use of mlock
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Wed, Dec 14, 2011 at 7:04 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 12/15/2011 10:46 AM, Peng Haitao wrote:
>
>>
>> mlock and munmap will return -1 when ERROR.
>>
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
