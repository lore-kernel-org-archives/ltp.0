Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Ux7yL-0001Vy-CV
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 03:55:13 +0000
Received: from mail-pd0-f182.google.com ([209.85.192.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ux7yH-00024T-Te
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 03:55:13 +0000
Received: by mail-pd0-f182.google.com with SMTP id r10so7060583pdi.41
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jul 2013 20:55:04 -0700 (PDT)
Message-ID: <51DE2CA9.7060703@casparzhang.com>
Date: Thu, 11 Jul 2013 11:55:21 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<51DD99C2.9030205@casparzhang.com> <20130711033505.GJ27609@aaa.aa>
	<51DE2C0F.2090801@cn.fujitsu.com>
In-Reply-To: <51DE2C0F.2090801@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2 v3] xinetd/xinetd_tests.sh: cleanup tabs
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
Cc: ltp-list@lists.sourceforge.net, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

On 07/11/2013 11:52 AM, Wanlong Gao wrote:
> On 07/11/2013 11:35 AM, Hangbin Liu wrote:
>> On Thu, Jul 11, 2013 at 01:28:34AM +0800, Caspar Zhang wrote:
>>> On 07/10/2013 07:03 PM, Xie Lingyun wrote:
>>>> +defaults
>>>> +{
>>>> +instances      = 25
>>>> +log_type       = FILE /var/log/servicelog
>>>> +log_on_success = HOST PID
>>>> +log_on_failure = HOST RECORD
>>>> +disabled       = telnet
>>>> +}
>>>
>>> Generally looks good except here.
>>>
>>> better give a 4-space indentation inside the braces.
>>>
>>
>> 1-tab or 4-space, I always be confuse which should we use. Even a tab should
>> be 4 characters or 8 characters also have dispute. But the kernel coding style
>> said Tabs are 8 characters, and thus indentations are also 8 characters.
>>
>> So, should we also use this style in shell scripts? Because I'm tired
>> changing my vim config for each project.
>
> We are just following kernel coding style in LTP.

We are talking about shell coding style right? IIRC kernel coding style 
is just for C.

Caspar

>
> Thanks,
> Wanlong Gao
>
>>
>


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
