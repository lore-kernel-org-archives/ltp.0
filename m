Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NLayu-0004DL-Nu
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 11:26:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLayp-0005EP-0t
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 11:26:48 +0000
Message-ID: <4B2B6723.3030107@cn.fujitsu.com>
Date: Fri, 18 Dec 2009 19:27:31 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B28C68C.1080304@cn.fujitsu.com>	
	<1173683636.495591261014366483.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<364299f40912161857k15592002ibfefe99111d51d71@mail.gmail.com>
In-Reply-To: <364299f40912161857k15592002ibfefe99111d51d71@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2407104511570013659=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============2407104511570013659==
Content-Type: multipart/alternative;
	boundary="------------030604070606000708070700"

This is a multi-part message in MIME format.
--------------030604070606000708070700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/17/2009 10:57 AM, Garrett Cooper wrote:
> On Wed, Dec 16, 2009 at 5:46 PM, Caspar Zhang <czhang@redhat.com> wrote:
>   
>> ----- "liubo" <liubo2009@cn.fujitsu.com> wrote:
>>
>>     
>>> Command "ar -tv" 's output doesn't match with "ls -ln" 's output on
>>> item
>>> "permission".
>>>
>>> s/-$permissions/-$permissions./
>>>       
>> This strange dot only appears in RHEL6, I don't see this dot in other
>> distros or releases.
>>     
>
> Is this perhaps because of a version upgrade?
> Thanks,
> -Garrett
>
>   

Yes, this problem does occur because of the version...
In binutils-2.19.51.0.2, the strange dot appears.
In binutils-2.17.50.0.18, the strange dot does not appear.
And these cause the dismatch.

Thanks,
Liu Bo

>>> This patch fixed the bug.
>>>
>>> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>>>
>>> ---
>>>  testcases/commands/ade/ar/ar01 |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/testcases/commands/ade/ar/ar01
>>> b/testcases/commands/ade/ar/ar01
>>> index c8f85eb..c393959 100755
>>> --- a/testcases/commands/ade/ar/ar01
>>> +++ b/testcases/commands/ade/ar/ar01
>>> @@ -584,7 +584,7 @@ ar -tv $TCtmp/lib.a |
>>>  while
>>>  read permissions uid size month day time year file_name
>>>  do
>>> -echo "-$permissions;$uid;$size;$month;$day;$time;$file_name"
>>> +echo "-$permissions.;$uid;$size;$month;$day;$time;$file_name"
>>>  done >> $TCtmp/lib.a.stdout
>>>  ttest
>>>
>>> --
>>> 1.6.2.2
>>>
>>>
>>>
>>>
>>>
>>>
>>> ------------------------------------------------------------------------------
>>> This SF.Net email is sponsored by the Verizon Developer Community
>>> Take advantage of Verizon's best-in-class app development support
>>> A streamlined, 14 day to market process makes app distribution fast
>>> and easy
>>> Join now and get one step closer to millions of Verizon customers
>>> http://p.sf.net/sfu/verizon-dev2dev
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>       
>> --
>> /-------------------------------------------\
>> | Name: Caspar Zhang                        |
>> | Position: Kernel Qualification Engineer   |
>> | IRC: czhang on #kernel-qe, #eng-china     |
>> | Phone: +86-10-6260-8150                   |
>> | Cellphone: +86-1381-073-0090              |
>> \-------------------------------------------/
>>
>>
>> ------------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Verizon Developer Community
>> Take advantage of Verizon's best-in-class app development support
>> A streamlined, 14 day to market process makes app distribution fast and easy
>> Join now and get one step closer to millions of Verizon customers
>> http://p.sf.net/sfu/verizon-dev2dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>     
>
>
>   


--------------030604070606000708070700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 12/17/2009 10:57 AM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f40912161857k15592002ibfefe99111d51d71@mail.gmail.com"
 type="cite">
  <pre wrap="">On Wed, Dec 16, 2009 at 5:46 PM, Caspar Zhang <a class="moz-txt-link-rfc2396E" href="mailto:czhang@redhat.com">&lt;czhang@redhat.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">----- "liubo" <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Command "ar -tv" 's output doesn't match with "ls -ln" 's output on
item
"permission".

s/-$permissions/-$permissions./
      </pre>
    </blockquote>
    <pre wrap="">This strange dot only appears in RHEL6, I don't see this dot in other
distros or releases.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is this perhaps because of a version upgrade?
Thanks,
-Garrett

  </pre>
</blockquote>
<br>
Yes, this problem does occur because of the version...<br>
In binutils-2.19.51.0.2, the strange dot appears.<br>
In binutils-2.17.50.0.18, the strange dot does not appear.<br>
And these cause the dismatch.<br>
<br>
Thanks,<br>
Liu Bo<br>
<br>
<blockquote
 cite="mid:364299f40912161857k15592002ibfefe99111d51d71@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">This patch fixed the bug.

Signed-off-by: Liu Bo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a>

---
&nbsp;testcases/commands/ade/ar/ar01 | &nbsp; &nbsp;2 +-
&nbsp;1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/ade/ar/ar01
b/testcases/commands/ade/ar/ar01
index c8f85eb..c393959 100755
--- a/testcases/commands/ade/ar/ar01
+++ b/testcases/commands/ade/ar/ar01
@@ -584,7 +584,7 @@ ar -tv $TCtmp/lib.a |
&nbsp;while
&nbsp;read permissions uid size month day time year file_name
&nbsp;do
-echo "-$permissions;$uid;$size;$month;$day;$time;$file_name"
+echo "-$permissions.;$uid;$size;$month;$day;$time;$file_name"
&nbsp;done &gt;&gt; $TCtmp/lib.a.stdout
&nbsp;ttest

--
1.6.2.2






------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast
and easy
Join now and get one step closer to millions of Verizon customers
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/verizon-dev2dev">http://p.sf.net/sfu/verizon-dev2dev</a>
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
      </pre>
    </blockquote>
    <pre wrap="">--
/-------------------------------------------\
| Name: Caspar Zhang &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
| Position: Kernel Qualification Engineer &nbsp; |
| IRC: czhang on #kernel-qe, #eng-china &nbsp; &nbsp; |
| Phone: +86-10-6260-8150 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
| Cellphone: +86-1381-073-0090 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
\-------------------------------------------/


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/verizon-dev2dev">http://p.sf.net/sfu/verizon-dev2dev</a>
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
<br>
</body>
</html>

--------------030604070606000708070700--


--===============2407104511570013659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============2407104511570013659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2407104511570013659==--

