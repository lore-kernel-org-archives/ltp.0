Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1R8X1g-0002Hr-KA
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 12:44:44 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R8X1c-00005p-UV
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 12:44:44 +0000
Received: by mail-vx0-f175.google.com with SMTP id fl17so5236906vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Sep 2011 05:44:40 -0700 (PDT)
Message-ID: <4E81C3BE.7000004@gmail.com>
Date: Tue, 27 Sep 2011 20:38:22 +0800
From: Romu Hu <huruomu@gmail.com>
MIME-Version: 1.0
References: <4E808A86.3020403@gmail.com> <4E81A27B.7030908@casparzhang.com>
In-Reply-To: <4E81A27B.7030908@casparzhang.com>
Subject: Re: [LTP] msgctl11 TBROK Not enough free pids
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
To: ltp-list@lists.sourceforge.net

On 2011/9/27 18:16, Caspar Zhang wrote:
> On 09/26/2011 10:21 PM, Romu Hu wrote:
>> Hi,
>>
>> msgctl11 in ltp-20110915 failed on 2.6.39 kernel:
>>
>> msgctl11    1  TBROK  :  Not enough free pids
>>
>> I found that before error out,
>>
>> MSGMNI is 32768
>> MAXNKIDS is 10
>> free_pids is 32611
>> maxnkids = ((free_pids / 4) / MSGMNI);
>> so maxnkids is zero, which is why msgctl11 failed.
>>
>> Is this problem of testcase or problem of the tested system?
>>
>> Thanks
>>
>
> I think it's a configuration issue.
>
> Cyril, do you think is it better to change TBROK to TCONF here?
>
> -                       tst_resm(TBROK, "Not enough free pids");
> +                       tst_resm(TCONF, "Not enough free pids");
>
> Thanks,
> Caspar

I changed MSGMNI in /proc to below 3000 and test passed.

Thanks

-- 
Regards,
Romu


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
