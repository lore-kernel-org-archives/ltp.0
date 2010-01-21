Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NXlrF-0001K9-BK
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 01:29:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXlrC-0000l1-Ag
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 01:29:13 +0000
Message-ID: <4B57AE50.4020801@cn.fujitsu.com>
Date: Thu, 21 Jan 2010 09:30:56 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <5a774f4c1001201626g53dae882o50b5aa70b23d929e@mail.gmail.com>
	<5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com>
In-Reply-To: <5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com>
Subject: Re: [LTP]
	[patch]ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7241834833839700146=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Crossover Lonely <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7241834833839700146==
Content-Type: multipart/alternative;
	boundary="------------090806000406060307060501"

This is a multi-part message in MIME format.
--------------090806000406060307060501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

    In my box, I can add -c Xnumber to avoid the unexpect signal,
for example, ./hugeshmget -c 10. Maybe you can try this as well.

Thanks,
Liu Bo

On 01/21/2010 08:50 AM, Crossover Lonely wrote:
> For your convenience, I just made to patches against the signle file, not
> the whole directory.
>
> solution 1=======================
> --- hugeshmget01.c    2009-11-20 00:05:21.000000000 +0800
> +++ hugeshmget01_2.c    2010-01-21 08:43:11.790533086 +0800
> @@ -78,14 +78,14 @@
>          tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
>      }
>
> -    setup();            /* global setup */
> -
>      /* The following loop checks looping state if -i option given */
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
>               tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
>          else
>                huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>
> +    setup();            /* global setup */
> +
>          for (lc = 0; TEST_LOOPING(lc); lc++) {
>          /* reset Tst_count in case we are looping */
>          Tst_count = 0;
>
>
> solution 2==============================
> --- hugeshmget01.c    2009-11-20 00:05:21.000000000 +0800
> +++ hugeshmget01_1.c    2010-01-21 08:41:56.350057513 +0800
> @@ -160,7 +160,7 @@
>  setup(void)
>  {
>      /* capture signals */
> -    tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +    tst_sig(FORK, DEF_HANDLER, cleanup);
>
>      /* Pause if that option was specified */
>      TEST_PAUSE;
>
>
> 2010/1/21 Crossover Lonely <crosslonelyover@gmail.com>
>
>   
>> Hi all,
>>
>>      When the hugeshmget01 runs, it gets unexpected signal SIGCHLD/SIGCLD,
>> and thus stops immediately.
>>      I found two ways to resolve this problem. Please refer to the
>> following for two kinds of patch.
>>      Well, according to other code structures of hugeshmget0*.c, solution 1
>> is preferred. But for get_no_of_hugepages
>> will call popen(), so I think the second solution is the right one.
>>      Will you please choose the right one to apply to
>> ltp-intermediate-20100119 package?
>>      Looking forward to your confirmation!
>>
>> Thanks and Best Regards,
>> shenghui
>>
>> Solution 1===============================================================
>>
>> diff -Nur
>> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> ---
>> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> 2010-01-21 07:51:55.926035076 +0800
>> +++
>> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> 2010-01-21 08:14:05.470032624 +0800
>> @@ -78,14 +78,14 @@
>>          tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
>>      }
>>
>> -    setup();            /* global setup */
>> -
>>      /* The following loop checks looping state if -i option given */
>>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
>>               tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
>> sufficient availability of Hugepages on the system");
>>          else
>> -              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
>> hugepages_size() * 1024) / 2 ;
>> -
>> +              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
>> hugepages_size() * 1024) / 2 ;
>> +
>> +    setup();            /* global setup */
>> +
>>          for (lc = 0; TEST_LOOPING(lc); lc++) {
>>          /* reset Tst_count in case we are looping */
>>          Tst_count = 0;
>>
>>
>> Solution
>> 2=========================================================================================
>> diff -Nur
>> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> ---
>> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> 2010-01-21 07:51:55.926035076 +0800
>> +++
>> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
>> 2010-01-21 08:16:46.122032889 +0800
>> @@ -160,7 +160,7 @@
>>  setup(void)
>>  {
>>      /* capture signals */
>> -    tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +    tst_sig(FORK, DEF_HANDLER, cleanup);
>>
>>      /* Pause if that option was specified */
>>      TEST_PAUSE;
>>
>>     
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for Conference
> attendees to learn about information security's most important issues through
> interactions with peers, luminaries and emerging and established companies.
> http://p.sf.net/sfu/rsaconf-dev2dev
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


--------------090806000406060307060501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, <br>
<br>
&nbsp;&nbsp;&nbsp; In my box, I can add -c Xnumber to avoid the unexpect signal, <br>
for example, ./hugeshmget -c 10. Maybe you can try this as well.<br>
<br>
Thanks,<br>
Liu Bo<br>
<br>
On 01/21/2010 08:50 AM, Crossover Lonely wrote:
<blockquote
 cite="mid:5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com"
 type="cite">
  <pre wrap="">For your convenience, I just made to patches against the signle file, not
the whole directory.

solution 1=======================
--- hugeshmget01.c    2009-11-20 00:05:21.000000000 +0800
+++ hugeshmget01_2.c    2010-01-21 08:43:11.790533086 +0800
@@ -78,14 +78,14 @@
         tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
     }

-    setup();            /* global setup */
-
     /* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() &lt;= 0 || hugepages_size() &lt;= 0 )
              tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else
               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;

+    setup();            /* global setup */
+
         for (lc = 0; TEST_LOOPING(lc); lc++) {
         /* reset Tst_count in case we are looping */
         Tst_count = 0;


solution 2==============================
--- hugeshmget01.c    2009-11-20 00:05:21.000000000 +0800
+++ hugeshmget01_1.c    2010-01-21 08:41:56.350057513 +0800
@@ -160,7 +160,7 @@
 setup(void)
 {
     /* capture signals */
-    tst_sig(NOFORK, DEF_HANDLER, cleanup);
+    tst_sig(FORK, DEF_HANDLER, cleanup);

     /* Pause if that option was specified */
     TEST_PAUSE;


2010/1/21 Crossover Lonely <a class="moz-txt-link-rfc2396E" href="mailto:crosslonelyover@gmail.com">&lt;crosslonelyover@gmail.com&gt;</a>

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,

     When the hugeshmget01 runs, it gets unexpected signal SIGCHLD/SIGCLD,
and thus stops immediately.
     I found two ways to resolve this problem. Please refer to the
following for two kinds of patch.
     Well, according to other code structures of hugeshmget0*.c, solution 1
is preferred. But for get_no_of_hugepages
will call popen(), so I think the second solution is the right one.
     Will you please choose the right one to apply to
ltp-intermediate-20100119 package?
     Looking forward to your confirmation!

Thanks and Best Regards,
shenghui

Solution 1===============================================================

diff -Nur
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
---
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
2010-01-21 07:51:55.926035076 +0800
+++
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
2010-01-21 08:14:05.470032624 +0800
@@ -78,14 +78,14 @@
         tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
     }

-    setup();            /* global setup */
-
     /* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() &lt;= 0 || hugepages_size() &lt;= 0 )
              tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else
-              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
-
+              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
+
+    setup();            /* global setup */
+
         for (lc = 0; TEST_LOOPING(lc); lc++) {
         /* reset Tst_count in case we are looping */
         Tst_count = 0;


Solution
2=========================================================================================
diff -Nur
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
---
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
2010-01-21 07:51:55.926035076 +0800
+++
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
2010-01-21 08:16:46.122032889 +0800
@@ -160,7 +160,7 @@
 setup(void)
 {
     /* capture signals */
-    tst_sig(NOFORK, DEF_HANDLER, cleanup);
+    tst_sig(FORK, DEF_HANDLER, cleanup);

     /* Pause if that option was specified */
     TEST_PAUSE;

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/rsaconf-dev2dev">http://p.sf.net/sfu/rsaconf-dev2dev</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------090806000406060307060501--


--===============7241834833839700146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============7241834833839700146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7241834833839700146==--

