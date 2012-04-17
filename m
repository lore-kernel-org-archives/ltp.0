Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SK0y2-0005KH-H4
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:28:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SK0y1-0007m2-4l
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:28:42 +0000
Message-ID: <4F8CFF3E.2000309@cn.fujitsu.com>
Date: Tue, 17 Apr 2012 13:27:26 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <0F68B52D2432864190BC72F760407FE9317D00DE57@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F55EF19.30000@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D20E@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F8CE612.40003@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D493@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F8CFA32.700@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D4E3@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
In-Reply-To: <0F68B52D2432864190BC72F760407FE93254B6D4E3@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
Subject: Re: [LTP] Required git repository
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
To: "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/17/2012 01:15 PM, Anupam Srivastava - ERS, HCL Tech wrote:

> I have send the patched to the LTP List but didn't get reply from there.


Sorry, I didn't see your patches, please send them to ltp-list@lists.sourceforge.net 
again, note that you should make patches against the upstream git tree,

git://github.com/linux-test-project/ltp.git

Thanks,
Wanlong Gao

> 
> Regards,
> Anupam
> 
> -----Original Message-----
> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
> Sent: 17 April 2012 10:36
> To: Anupam Srivastava - ERS, HCL Tech
> Cc: LTP List
> Subject: Re: [LTP] Required git repository
> 
> On 04/17/2012 12:31 PM, Anupam Srivastava - ERS, HCL Tech wrote:
> 
>> Hi Wanlong,
>>
>> We want to contribute to open source community. We have ported LTP on Android.
>> I want to follow the below procedure to submit my code:
>>
>> 1) First clone the code from GIT repository
>> 2) Changed the code as required
>> 3) Commit the changes.
> 
> 
> Then send patches to LTP List <ltp-list@lists.sourceforge.net> for
> reviewing, you are welcome.
> 
> Thanks,
> Wanlong Gao
> 
> 
>>
>> Let me know the procedure for the same if above are not correct.
>>
>> Regards,
>> Anupam
>>
>>
>> -----Original Message-----
>> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
>> Sent: 17 April 2012 09:10
>> To: Anupam Srivastava - ERS, HCL Tech
>> Cc: LTP List
>> Subject: Re: [LTP] Required git repository
>>
>> On 04/16/2012 05:57 PM, Anupam Srivastava - ERS, HCL Tech wrote:
>>
>>> Hi,
>>>
>>> When I am checking out the code of LTP, it's giving the latest version. I am looking for "ltp-full-20110228" version.
>>> Please let me know that how to do the same.
>>
>>
>> Since you don't want to get the log, it's not necessary to clone the git repo,
>> you can just get the source here,
>> http://sourceforge.net/projects/ltp/files/LTP%20Source/
>>
>> Thanks,
>> Wanlong Gao
>>
>>>
>>> Regards,
>>> Anupam
>>>
>>> -----Original Message-----
>>> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
>>> Sent: 06 March 2012 16:34
>>> To: Anupam Srivastava - ERS, HCL Tech
>>> Cc: ltp-list@lists.sourceforge.net
>>> Subject: Re: [LTP] Required git repository
>>>
>>> On 03/06/2012 01:31 PM, Anupam Srivastava - ERS, HCL Tech wrote:
>>>
>>>> Hi,
>>>>
>>>>  
>>>>
>>>> I want to check out LTP *(Version: ltp-full-20110228) * source code form git repository. Please share the path so that I can check out the ltp code.
>>>>
>>>
>>>
>>> git://ltp.git.sourceforge.net/gitroot/ltp/ltp master
>>> OR
>>> git://github.com/gaowanlong/ltp.git master
>>>
>>> Thanks,
>>> Wanlong Gao
>>>
>>>>  
>>>>
>>>> Regards,
>>>>
>>>> Anupam
>>>>
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>> ::DISCLAIMER::
>>>> -----------------------------------------------------------------------------------------------------------------------
>>>>
>>>> The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
>>>> It shall not attach any liability on the originator or HCL or its affiliates. Any views or opinions presented in
>>>> this email are solely those of the author and may not necessarily reflect the opinions of HCL or its affiliates.
>>>> Any form of reproduction, dissemination, copying, disclosure, modification, distribution and / or publication of
>>>> this message without the prior written consent of the author of this e-mail is strictly prohibited. If you have
>>>> received this email in error please delete it and notify the sender immediately. Before opening any mail and
>>>> attachments please check them for viruses and defect.
>>>>
>>>> -----------------------------------------------------------------------------------------------------------------------
>>>>
>>>>
>>>> ------------------------------------------------------------------------------
>>>> Keep Your Developer Skills Current with LearnDevNow!
>>>> The most comprehensive online learning library for Microsoft developers
>>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
>>>> Metro Style Apps, more. Free future releases when you subscribe now!
>>>> http://p.sf.net/sfu/learndevnow-d2d
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Ltp-list mailing list
>>>> Ltp-list@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>
>>>
>>>
>>
>>
>>
> 
> 
> 



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
