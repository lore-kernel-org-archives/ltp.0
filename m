Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Anupam_Srivastava@hcl.com>) id 1SK0vI-0005We-Tj
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:25:52 +0000
Received: from gws05.hcl.com ([203.105.185.23])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SK0vD-0007gH-JJ
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:25:52 +0000
From: "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Date: Tue, 17 Apr 2012 10:55:32 +0530
Message-ID: <0F68B52D2432864190BC72F760407FE93254B6D4F8@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
References: <0F68B52D2432864190BC72F760407FE9317D00DE57@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F55EF19.30000@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D20E@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F8CE612.40003@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D493@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>,
	<4F8CFA32.700@cn.fujitsu.com>
	<6F91E0FFDA542149961F7BDED2D2B94B568B9DE821@EXGMBX01.sasken.com>
In-Reply-To: <6F91E0FFDA542149961F7BDED2D2B94B568B9DE821@EXGMBX01.sasken.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Required git repository
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
To: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi,

We have ported LTP version ltp-full-20110228 on Andriod. I'm analysing the same and get back to you once I'll get info for the same.

Regards,
Anupam

-----Original Message-----
From: Rejish Rajagopala [mailto:rejish.rajagopala@sasken.com] 
Sent: 17 April 2012 10:47
To: Anupam Srivastava - ERS, HCL Tech
Cc: LTP List
Subject: RE: [LTP] Required git repository

Hi Anupam,

From the below mail chain, I could see that you have ported LTP on Android.

Even  I am also trying to port LTP on Android. But I am facing some issues can you please help me out.

Am using LTP (ltp-full-20120104) and Android NDK r-7b. While cross compiling IO module I am getting below error as:

-14/arch-arm/usr/lib/crtend_android.o -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -lltp -o rand_lines
../lib/libltp.a(random_range.o): In function `random_range':
/u/ltp/ltp-full-20120104/lib/random_range.c:336: undefined reference to `__aeabi_idivmod'
/u/ltp/ltp-full-20120104/lib/random_range.c:339: undefined reference to `__aeabi_idivmod'
/u/ltp/ltp-full-20120104/lib/random_range.c:373: undefined reference to `__aeabi_idiv'
/u/ltp/ltp-full-20120104/lib/random_range.c:373: undefined reference to `__aeabi_idivmod'
collect2: ld returned 1 exit status
make[1]: *** [rand_lines] Error 1
make[1]: Leaving directory `/u/ltp/ltp-full-20120104/tools'
make: *** [tools-all] Error 2

Also attached is my LTP configure script

Looking forward for your reply.

Thanks & Regards,
Rejish
________________________________________
From: Wanlong Gao [gaowanlong@cn.fujitsu.com]
Sent: Tuesday, April 17, 2012 10:35 AM
To: Anupam Srivastava - ERS, HCL Tech
Cc: LTP List
Subject: Re: [LTP] Required git repository

On 04/17/2012 12:31 PM, Anupam Srivastava - ERS, HCL Tech wrote:

> Hi Wanlong,
>
> We want to contribute to open source community. We have ported LTP on Android.
> I want to follow the below procedure to submit my code:
>
> 1) First clone the code from GIT repository
> 2) Changed the code as required
> 3) Commit the changes.


Then send patches to LTP List <ltp-list@lists.sourceforge.net> for reviewing, you are welcome.

Thanks,
Wanlong Gao


>
> Let me know the procedure for the same if above are not correct.
>
> Regards,
> Anupam
>
>
> -----Original Message-----
> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com]
> Sent: 17 April 2012 09:10
> To: Anupam Srivastava - ERS, HCL Tech
> Cc: LTP List
> Subject: Re: [LTP] Required git repository
>
> On 04/16/2012 05:57 PM, Anupam Srivastava - ERS, HCL Tech wrote:
>
>> Hi,
>>
>> When I am checking out the code of LTP, it's giving the latest version. I am looking for "ltp-full-20110228" version.
>> Please let me know that how to do the same.
>
>
> Since you don't want to get the log, it's not necessary to clone the 
> git repo, you can just get the source here, 
> http://sourceforge.net/projects/ltp/files/LTP%20Source/
>
> Thanks,
> Wanlong Gao
>
>>
>> Regards,
>> Anupam
>>
>> -----Original Message-----
>> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com]
>> Sent: 06 March 2012 16:34
>> To: Anupam Srivastava - ERS, HCL Tech
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] Required git repository
>>
>> On 03/06/2012 01:31 PM, Anupam Srivastava - ERS, HCL Tech wrote:
>>
>>> Hi,
>>>
>>>
>>>
>>> I want to check out LTP *(Version: ltp-full-20110228) * source code form git repository. Please share the path so that I can check out the ltp code.
>>>
>>
>>
>> git://ltp.git.sourceforge.net/gitroot/ltp/ltp master OR 
>> git://github.com/gaowanlong/ltp.git master
>>
>> Thanks,
>> Wanlong Gao
>>
>>>
>>>
>>> Regards,
>>>
>>> Anupam
>>>
>>>
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> --------------------------------------------------------------------
>>> ----------------------------------------
>>> ::DISCLAIMER::
>>> --------------------------------------------------------------------
>>> ---------------------------------------------------
>>>
>>> The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
>>> It shall not attach any liability on the originator or HCL or its 
>>> affiliates. Any views or opinions presented in this email are solely those of the author and may not necessarily reflect the opinions of HCL or its affiliates.
>>> Any form of reproduction, dissemination, copying, disclosure, 
>>> modification, distribution and / or publication of this message 
>>> without the prior written consent of the author of this e-mail is 
>>> strictly prohibited. If you have received this email in error please delete it and notify the sender immediately. Before opening any mail and attachments please check them for viruses and defect.
>>>
>>> --------------------------------------------------------------------
>>> ---------------------------------------------------
>>>
>>>
>>> --------------------------------------------------------------------
>>> ---------- Keep Your Developer Skills Current with LearnDevNow!
>>> The most comprehensive online learning library for Microsoft 
>>> developers is just $99.99! Visual Studio, SharePoint, SQL - plus 
>>> HTML5, CSS3, MVC3, Metro Style Apps, more. Free future releases when you subscribe now!
>>> http://p.sf.net/sfu/learndevnow-d2d
>>>
>>>
>>>
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>>
>
>
>



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to monitoring Big Data applications. Try Boundary one-second resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
