Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rejish.rajagopala@sasken.com>) id 1SK0r3-0006jt-Lo
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:21:29 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SK0qy-0000EJ-7a
	for ltp-list@lists.sourceforge.net; Tue, 17 Apr 2012 05:21:29 +0000
From: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Date: Tue, 17 Apr 2012 10:46:45 +0530
Message-ID: <6F91E0FFDA542149961F7BDED2D2B94B568B9DE821@EXGMBX01.sasken.com>
References: <0F68B52D2432864190BC72F760407FE9317D00DE57@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F55EF19.30000@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D20E@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<4F8CE612.40003@cn.fujitsu.com>
	<0F68B52D2432864190BC72F760407FE93254B6D493@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>,
	<4F8CFA32.700@cn.fujitsu.com>
In-Reply-To: <4F8CFA32.700@cn.fujitsu.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_"
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Anupam,

From the below mail chain, I could see that you have ported LTP on Android.

Even  I am also trying to port LTP on Android. But I am facing some issues =
can you please help me out.

Am using LTP (ltp-full-20120104) and Android NDK r-7b. While cross compilin=
g IO module I am getting below error as:

-14/arch-arm/usr/lib/crtend_android.o -L/u/ltp/android-ndk-r7b/platforms/an=
droid-14/arch-arm/usr/lib -lltp -o rand_lines
../lib/libltp.a(random_range.o): In function `random_range':
/u/ltp/ltp-full-20120104/lib/random_range.c:336: undefined reference to `__=
aeabi_idivmod'
/u/ltp/ltp-full-20120104/lib/random_range.c:339: undefined reference to `__=
aeabi_idivmod'
/u/ltp/ltp-full-20120104/lib/random_range.c:373: undefined reference to `__=
aeabi_idiv'
/u/ltp/ltp-full-20120104/lib/random_range.c:373: undefined reference to `__=
aeabi_idivmod'
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
> We want to contribute to open source community. We have ported LTP on And=
roid.
> I want to follow the below procedure to submit my code:
>
> 1) First clone the code from GIT repository
> 2) Changed the code as required
> 3) Commit the changes.


Then send patches to LTP List <ltp-list@lists.sourceforge.net> for
reviewing, you are welcome.

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
>> When I am checking out the code of LTP, it's giving the latest version. =
I am looking for "ltp-full-20110228" version.
>> Please let me know that how to do the same.
>
>
> Since you don't want to get the log, it's not necessary to clone the git =
repo,
> you can just get the source here,
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
>>> I want to check out LTP *(Version: ltp-full-20110228) * source code for=
m git repository. Please share the path so that I can check out the ltp cod=
e.
>>>
>>
>>
>> git://ltp.git.sourceforge.net/gitroot/ltp/ltp master
>> OR
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
>>> -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------
>>> ::DISCLAIMER::
>>> -----------------------------------------------------------------------=
------------------------------------------------
>>>
>>> The contents of this e-mail and any attachment(s) are confidential and =
intended for the named recipient(s) only.
>>> It shall not attach any liability on the originator or HCL or its affil=
iates. Any views or opinions presented in
>>> this email are solely those of the author and may not necessarily refle=
ct the opinions of HCL or its affiliates.
>>> Any form of reproduction, dissemination, copying, disclosure, modificat=
ion, distribution and / or publication of
>>> this message without the prior written consent of the author of this e-=
mail is strictly prohibited. If you have
>>> received this email in error please delete it and notify the sender imm=
ediately. Before opening any mail and
>>> attachments please check them for viruses and defect.
>>>
>>> -----------------------------------------------------------------------=
------------------------------------------------
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Keep Your Developer Skills Current with LearnDevNow!
>>> The most comprehensive online learning library for Microsoft developers
>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3=
,
>>> Metro Style Apps, more. Free future releases when you subscribe now!
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



---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propriet=
ary or legally privileged information. In case you are not the original int=
ended Recipient of the message, you must not, directly or indirectly, use, =
disclose, distribute, print, or copy any part of this message and you are r=
equested to delete it and inform the sender. Any views expressed in this me=
ssage are those of the individual sender unless otherwise stated. Nothing c=
ontained in this message shall be construed as an offer or acceptance of an=
y offer by Sasken Communication Technologies Limited ("Sasken") unless sent=
 with that express intent and with due authority of Sasken. Sasken has take=
n enough precautions to prevent the spread of viruses. However the company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

--_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_
Content-Type: application/x-sh; name="config_r7.sh"
Content-Description: config_r7.sh
Content-Disposition: attachment; filename="config_r7.sh"; size=2310;
	creation-date="Tue, 17 Apr 2012 10:50:49 GMT";
	modification-date="Tue, 17 Apr 2012 10:50:49 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpBTkRfTkRLX1JPT1Q9L3UvbHRwL2FuZHJvaWQtbmRrLXI3YgpBTkRfU1lTUk9P
VD0kQU5EX05ES19ST09UL3BsYXRmb3Jtcy9hbmRyb2lkLTE0L2FyY2gtYXJtCkNST1NTX0NPTVBJ
TEU9JEFORF9OREtfUk9PVC90b29sY2hhaW5zL2FybS1saW51eC1hbmRyb2lkZWFiaS00LjQuMy9w
cmVidWlsdC9saW51eC14ODYvYmluL2FybS1saW51eC1hbmRyb2lkZWFiaQpBTkRfVFA9YCRDUk9T
U19DT01QSUxFLWdjYyAtbXRodW1iLWludGVyd29yayAtcHJpbnQtbGliZ2NjLWZpbGUtbmFtZWAK
QU5EX1RBUkdFVF9MRExJQlM9Ii1XbCwtcnBhdGgtbGluaz0kQU5EX1NZU1JPT1QvdXNyL2xpYiAk
QU5EX1RQIgoKCkNDPSRDUk9TU19DT01QSUxFLWdjYyBcCiNDRkxBR1M9Ii1ub3N0ZGxpYiIKQ1BQ
PSRDUk9TU19DT01QSUxFLWNwcCBBUj0kQ1JPU1NfQ09NUElMRS1hciBSQU5MSUI9JENST1NTX0NP
TVBJTEUtcmFubGliIFNUUklQPSRDUk9TU19DT01QSUxFLXN0cmlwIExEPSRDUk9TU19DT01QSUxF
LWxkIFwKQ1BQRkxBR1M9Ii1JJEFORF9TWVNST09UL3Vzci9pbmNsdWRlIC1EX19BUk1fQVJDSF83
X18gLURfX0FSTV9BUkNIXzdBX18gIC1EX19BUk1fQVJDSF83Ul9fIC1EX19BUk1fQVJDSF83TV9f
IC1EQU5EUk9JRCAtRF9fbGludXhfXyAtRERFVl9CU0laRT01MTIgLURTSUdDTEQ9U0lHQ0hMRCAt
RF9GSUxFX09GRlNFVF9CSVRTPTY0IiBcCkNGTEFHUz0iJENQUEZMQUdTIC1tYXJjaD1hcm12Ny1h
IC1tdHVuZT14c2NhbGUgLW1zb2Z0LWZsb2F0IC1mcGljIC1tdGh1bWItaW50ZXJ3b3JrIC1mZnVu
Y3Rpb24tc2VjdGlvbnMgLWZ1bndpbmQtdGFibGVzIC1mc3RhY2stcHJvdGVjdG9yIC1mbm8tc2hv
cnQtZW51bXMgLU8yIC1mb21pdC1mcmFtZS1wb2ludGVyIC1mdW5zd2l0Y2gtbG9vcHMgLWZpbmxp
bmUtbGltaXQ9MzAwIiBcCkNYWEZMQUdTPSItZm5vLWV4Y2VwdGlvbnMgLWZuby1ydHRpIiBcCkxE
RkxBR1M9Ii1ub3N0ZGxpYiAtQmR5bmFtaWMgLVdsLC1keW5hbWljLWxpbmtlciwvc3lzdGVtL2Jp
bi9saW5rZXIgIC1XbCwtLWdjLXNlY3Rpb25zICAtV2wsLXosbm9jb3B5cmVsb2MgLUwkQU5EX1NZ
U1JPT1QvdXNyL2xpYiIgIFwKI0xJQlM9IiRBTkRfU1lTUk9PVC91c3IvbGliL2NydGJlZ2luX2R5
bmFtaWMubyAkQU5EX1RBUkdFVF9MRExJQlMgLWxjIC1sbSAgJEFORF9TWVNST09UL3Vzci9saWIv
Y3J0ZW5kX2FuZHJvaWQubyAtTCRBTkRfTkRLX1JPT1QvcGxhdGZvcm1zL2FuZHJvaWQtMTQvYXJj
aC1hcm0vdXNyLyNsaWIgIiBcIFRoaXMgaXMgdXNlZCBmb3IgTkRLLXI1CkxJQlM9Ii91L2x0cC9h
bmRyb2lkLW5kay1yN2IvdG9vbGNoYWlucy9hcm0tbGludXgtYW5kcm9pZGVhYmktNC40LjMvcHJl
YnVpbHQvbGludXgteDg2L2xpYi9nY2MvYXJtLWxpbnV4LWFuZHJvaWRlYWJpLzQuNC4zL2FybXY3
LWEvY3J0YmVnaW4ubyAkQU5EX1RBUkdFVF9MRExJQlMgLWxjIC1sbSAgL3UvbHRwL2FuZHJvaWQt
bmRrLXI3Yi90b29sY2hhaW5zL2FybS1saW51eC1hbmRyb2lkZWFiaS00LjQuMy9wcmVidWlsdC9s
aW51eC14ODYvbGliL2djYy9hcm0tbGludXgtYW5kcm9pZGVhYmkvNC40LjMvYXJtdjctYS9jcnRl
bmQubyAtTC91L2x0cC9hbmRyb2lkLW5kay1yN2IvdG9vbGNoYWlucy9hcm0tbGludXgtYW5kcm9p
ZGVhYmktNC40LjMvcHJlYnVpbHQvbGludXgteDg2L2xpYi9nY2MvYXJtLWxpbnV4LWFuZHJvaWRl
YWJpLzQuNC4zL2FybXY3LWEgLUwvdS9sdHAvYW5kcm9pZC1uZGstcjdiL3Rvb2xjaGFpbnMvYXJt
LWxpbnV4LWFuZHJvaWRlYWJpLTQuNC4zL3ByZWJ1aWx0L2xpbnV4LXg4Ni9saWIvZ2NjL2FybS1s
aW51eC1hbmRyb2lkZWFiaS80LjQuMy9hcm12Ny1hL2xpYmdjYy5hIiBcCiNuZXcKZXhwb3J0IENS
T1NTX0NPTVBJTEUKZXhwb3J0IENGTEFHUwpleHBvcnQgQ0MKZXhwb3J0IENQUApleHBvcnQgQ1BQ
RkxBR1MKZXhwb3J0IExERkxBR1MKZXhwb3J0IExJQlMKZXhwb3J0IENYWEZMQUdTCmV4cG9ydCBB
UgpleHBvcnQgUkFOTElCCmV4cG9ydCBTVFJJUAoKIy4vY29uZmlndXJlIC0tdGFyZ2V0PWFybS1l
YWJpIC0taG9zdD1hcm0tZWFiaSAtLXByZWZpeD0vdG1wL2x0cAojLi9jb25maWd1cmUgIC0tdGFy
Z2V0PWFybS1lYWJpIC0taG9zdD14ODZfNjQtbGludXgtZ251IC0tYnVpbGQ9YXJtLWVhYmkgLS1w
cmVmaXg9L3RtcC9sdHAKCi4vY29uZmlndXJlIC0tdGFyZ2V0PWFybS1saW51eC1hbmRyb2lkZWFi
aSAtLWhvc3Q9eDg2XzY0LWxpbnV4LWdudSAtLXByZWZpeD0vdS9sdHAvbHRwLWR1bXAtdGltZXJz
CgoKI01vZGlmaWVkIGZvciBsdHAwNjA2MjAxMS4K

--_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_002_6F91E0FFDA542149961F7BDED2D2B94B568B9DE821EXGMBX01saske_--

