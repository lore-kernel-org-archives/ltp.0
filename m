Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1NXlGH-0007KF-Uy
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 00:51:01 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXlGG-0002PU-Rk
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 00:51:01 +0000
Received: by pxi38 with SMTP id 38so2135470pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 16:50:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a774f4c1001201626g53dae882o50b5aa70b23d929e@mail.gmail.com>
References: <5a774f4c1001201626g53dae882o50b5aa70b23d929e@mail.gmail.com>
Date: Thu, 21 Jan 2010 08:50:44 +0800
Message-ID: <5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com>
From: Crossover Lonely <crosslonelyover@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6873644286359538900=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6873644286359538900==
Content-Type: multipart/alternative; boundary=0016e64aedd6d65c58047da21785

--0016e64aedd6d65c58047da21785
Content-Type: text/plain; charset=ISO-8859-1

For your convenience, I just made to patches against the signle file, not
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
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
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


2010/1/21 Crossover Lonely <crosslonelyover@gmail.com>

> Hi all,
>
>      When the hugeshmget01 runs, it gets unexpected signal SIGCHLD/SIGCLD,
> and thus stops immediately.
>      I found two ways to resolve this problem. Please refer to the
> following for two kinds of patch.
>      Well, according to other code structures of hugeshmget0*.c, solution 1
> is preferred. But for get_no_of_hugepages
> will call popen(), so I think the second solution is the right one.
>      Will you please choose the right one to apply to
> ltp-intermediate-20100119 package?
>      Looking forward to your confirmation!
>
> Thanks and Best Regards,
> shenghui
>
> Solution 1===============================================================
>
> diff -Nur
> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> ---
> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> 2010-01-21 07:51:55.926035076 +0800
> +++
> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> 2010-01-21 08:14:05.470032624 +0800
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
> -              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
> -
> +              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
> +
> +    setup();            /* global setup */
> +
>          for (lc = 0; TEST_LOOPING(lc); lc++) {
>          /* reset Tst_count in case we are looping */
>          Tst_count = 0;
>
>
> Solution
> 2=========================================================================================
> diff -Nur
> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> ---
> ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> 2010-01-21 07:51:55.926035076 +0800
> +++
> ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> 2010-01-21 08:16:46.122032889 +0800
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

--0016e64aedd6d65c58047da21785
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For your convenience, I just made to patches against the signle file, not t=
he whole directory.<br><br>solution 1=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- hugeshmget01.c=A0=A0=A0 2009-11-20=
 00:05:21.000000000 +0800<br>+++ hugeshmget01_2.c=A0=A0=A0 2010-01-21 08:43=
:11.790533086 +0800<br>
@@ -78,14 +78,14 @@<br>=A0=A0=A0=A0 =A0=A0=A0 tst_brkm(TBROK, cleanup, &quo=
t;OPTION PARSING ERROR - %s&quot;, msg);<br>=A0=A0=A0=A0 }<br>=A0<br>-=A0=
=A0=A0 setup();=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* global setup */<br>-<br>=A0=
=A0=A0=A0 /* The following loop checks looping state if -i option given */<=
br>
=A0=A0=A0=A0=A0=A0=A0=A0 if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_=
size() &lt;=3D 0 )<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBRO=
K, cleanup, &quot;Test cannot be continued owning to sufficient availabilit=
y of Hugepages on the system&quot;);<br>=A0=A0=A0=A0=A0=A0=A0=A0 else=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 huge_pages_shm_to_be_allocated =
=3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;<br>=A0=A0=A0=
=A0=A0=A0=A0=A0 <br>+=A0=A0=A0 setup();=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* glo=
bal setup */<br>+<br>=A0=A0=A0=A0=A0=A0=A0=A0 for (lc =3D 0; TEST_LOOPING(l=
c); lc++) {<br>
=A0=A0=A0=A0 =A0=A0=A0 /* reset Tst_count in case we are looping */<br>=A0=
=A0=A0=A0 =A0=A0=A0 Tst_count =3D 0;<br><br><br>solution 2=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>--- hugeshmget01.c=A0=A0=A0 2009-11-20 00:05:21.000000000 +0800<br>+++ =
hugeshmget01_1.c=A0=A0=A0 2010-01-21 08:41:56.350057513 +0800<br>
@@ -160,7 +160,7 @@<br>=A0setup(void)<br>=A0{<br>=A0=A0=A0=A0 /* capture si=
gnals */<br>-=A0=A0=A0 tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>+=A0=A0=A0=
 tst_sig(FORK, DEF_HANDLER, cleanup);<br>=A0<br>=A0=A0=A0=A0 /* Pause if th=
at option was specified */<br>
=A0=A0=A0=A0 TEST_PAUSE;<br><br><br><div class=3D"gmail_quote">2010/1/21 Cr=
ossover Lonely <span dir=3D"ltr">&lt;<a href=3D"mailto:crosslonelyover@gmai=
l.com">crosslonelyover@gmail.com</a>&gt;</span><br><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Hi all,<br><br>=A0=A0=A0=A0 When the hugeshmget01 runs, it gets unexpected =
signal SIGCHLD/SIGCLD, and thus stops immediately.<br>=A0 =A0=A0 I found tw=
o ways to resolve this problem. Please refer to the following for two kinds=
 of patch. <br>

=A0=A0=A0=A0 Well, according to other code structures of hugeshmget0*.c, so=
lution 1 is preferred. But for get_no_of_hugepages<br>will call popen(), so=
 I think the second solution is the right one.<br>=A0=A0=A0=A0 Will you ple=
ase choose the right one to apply to ltp-intermediate-20100119 package?<br>

=A0=A0=A0=A0 Looking forward to your confirmation!<br><br>Thanks and Best R=
egards,<br>shenghui<br><br>Solution 1=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br><br>diff -Nur ltp-intermediate-20100119-origin/testcases/kernel/mem/=
hugetlb/hugeshmget/hugeshmget01.c ltp-intermediate-20100119/testcases/kerne=
l/mem/hugetlb/hugeshmget/hugeshmget01.c<br>

--- ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmge=
t/hugeshmget01.c=A0=A0=A0 2010-01-21 07:51:55.926035076 +0800<br>+++ ltp-in=
termediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=
=A0=A0=A0 2010-01-21 08:14:05.470032624 +0800<br>

@@ -78,14 +78,14 @@<br>=A0=A0=A0=A0 =A0=A0=A0 tst_brkm(TBROK, cleanup, &quo=
t;OPTION PARSING ERROR - %s&quot;, msg);<br>=A0=A0=A0=A0 }<br>=A0<br>-=A0=
=A0=A0 setup();=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* global setup */<br>-<br>=A0=
=A0=A0=A0 /* The following loop checks looping state if -i option given */<=
br>

=A0=A0=A0=A0=A0=A0=A0=A0 if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_=
size() &lt;=3D 0 )<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBRO=
K, cleanup, &quot;Test cannot be continued owning to sufficient availabilit=
y of Hugepages on the system&quot;);<br>=A0=A0=A0=A0=A0=A0=A0=A0 else=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>

-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 huge_pages_shm_to_be_allocated =3D=
 ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;<br>-=A0=A0=A0=A0=
=A0=A0=A0 <br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 huge_pages_shm_to_be=
_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ; <br=
>

+<br>+=A0=A0=A0 setup();=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* global setup */<br=
>+<br>=A0=A0=A0=A0=A0=A0=A0=A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>=
=A0=A0=A0=A0 =A0=A0=A0 /* reset Tst_count in case we are looping */<br>=A0=
=A0=A0=A0 =A0=A0=A0 Tst_count =3D 0;<br><br><br>Solution 2=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>

diff -Nur ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hug=
eshmget/hugeshmget01.c ltp-intermediate-20100119/testcases/kernel/mem/huget=
lb/hugeshmget/hugeshmget01.c<br>--- ltp-intermediate-20100119-origin/testca=
ses/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=A0=A0=A0 2010-01-21 07:51:=
55.926035076 +0800<br>

+++ ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/huges=
hmget01.c=A0=A0=A0 2010-01-21 08:16:46.122032889 +0800<br>@@ -160,7 +160,7 =
@@<br>=A0setup(void)<br>=A0{<br>=A0=A0=A0=A0 /* capture signals */<br>-=A0=
=A0=A0 tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>

+=A0=A0=A0 tst_sig(FORK, DEF_HANDLER, cleanup);<br>=A0<br>=A0=A0=A0=A0 /* P=
ause if that option was specified */<br>=A0=A0=A0=A0 TEST_PAUSE;<br>
</blockquote></div><br>

--0016e64aedd6d65c58047da21785--


--===============6873644286359538900==
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
--===============6873644286359538900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6873644286359538900==--

