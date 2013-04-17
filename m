Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lans.zhang2008@gmail.com>) id 1USNm0-0000JI-RT
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 08:31:24 +0000
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1USNly-0007Hk-Hk
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 08:31:24 +0000
Received: by mail-ie0-f171.google.com with SMTP id e11so1629097iej.30
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Apr 2013 01:31:17 -0700 (PDT)
Message-ID: <516E5ED8.10909@gmail.com>
Date: Wed, 17 Apr 2013 16:35:36 +0800
From: Lans Zhang <lans.zhang2008@gmail.com>
MIME-Version: 1.0
References: <516E2E6C.2000408@gmail.com>
	<849990288.1414874.1366184255066.JavaMail.root@redhat.com>
In-Reply-To: <849990288.1414874.1366184255066.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH V2] Fix short of nodemask array.
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 04/17/2013 03:37 PM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Lans Zhang"<lans.zhang2008@gmail.com>
>> To: "Zhouping Liu"<zliu@redhat.com>, "Jan Stancek"<jstancek@redhat.com>
>> Cc: "Wanlong Gao"<gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 17 April, 2013 7:09:00 AM
>> Subject: [LTP][PATCH V2] Fix short of nodemask array.
>>
>> Changes since V1:
>> 1. Enhance patch header.
>> 2. Use BITS_PER_LONG and set_node() to simplify the logic.
>>
>> In kernel, if user specified more nodes, e.g, 512 nodes, than the
>> supported, e.g, 4 nodes, kernel will check if the non supported
>> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
>> are overrunning "nmask", whose length is shorter than MAXNODES,
>> and where the unsupported bits should be cleared to pass the check.
>>
>> Signed-off-by: Lans Zhang<lans.zhang2008@gmail.com>
>
> Hi,
>
> 'v' should be probably dropped here, since it's not used and rest
> of patch uses 2 parameters anyway:
>
>> +static inline void set_node(unsigned long *array, unsigned int node,
>> +                            unsigned int v)
>> +{
>> +	array[node / BITS_PER_LONG] |= 1UL<<  (node % BITS_PER_LONG);
>> +}
>>
>
> Other than that, it looks good to me.

I will send a V3 if Zhouping Liu also gatekeep V2 except this minor
change.

Thanks,
lz

>
> Regards,
> Jan
>


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
