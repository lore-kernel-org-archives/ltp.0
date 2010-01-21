Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1NXmZF-0007sc-Ng
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 02:14:41 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXmZE-0006GO-Ju
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 02:14:41 +0000
Received: by pwj11 with SMTP id 11so3999897pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 18:14:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B57AE50.4020801@cn.fujitsu.com>
References: <5a774f4c1001201626g53dae882o50b5aa70b23d929e@mail.gmail.com>
	<5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com>
	<4B57AE50.4020801@cn.fujitsu.com>
Date: Thu, 21 Jan 2010 10:14:33 +0800
Message-ID: <5a774f4c1001201814ta9a25a2j150fe0cf99226952@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2927880113646176208=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--===============2927880113646176208==
Content-Type: multipart/alternative; boundary=00504502eacf9300da047da34313

--00504502eacf9300da047da34313
Content-Type: text/plain; charset=ISO-8859-1

It works!
But isn't weird? Why just use ./hugeshmget won't work?
I traced it, and found it calls tsg_sig() in setup():
        tst_sig(NOFORK, DEF_HANDLER, cleanup);
and in tsg_sig():
        ...
               case SIGCLD:
            if (fork_flag == FORK || STD_COPIES > 1)
                continue;

        default:
            if (tst_setup_signal(sig, handler) == SIG_ERR)
                tst_resm(TWARN | TERRNO,
                    "signal() failed for signal %d", sig);
            break;
        ...

so here  hugeshmget set its action to SIGCLD to handler - here is
def_handler(), which can
rise "Unexpected signal %d received." message when recived SIGCLD.
static void def_handler(int sig)
{
    /*
     * Break remaining test cases, do any cleanup, then exit
     */
    tst_brkm(TBROK, 0, "Unexpected signal %d received.", sig);

    /* now cleanup and exit */
    if (T_cleanup)
        (*T_cleanup) ();

    tst_exit();
}

So I think it's better to correct it!

Thanks and Best Regards,
shenghui

2010/1/21 liubo <liubo2009@cn.fujitsu.com>

>  Hi,
>
>     In my box, I can add -c Xnumber to avoid the unexpect signal,
> for example, ./hugeshmget -c 10. Maybe you can try this as well.
>
> Thanks,
> Liu Bo
>
>
> On 01/21/2010 08:50 AM, Crossover Lonely wrote:
>
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
> 2010/1/21 Crossover Lonely <crosslonelyover@gmail.com> <crosslonelyover@gmail.com>
>
>    Hi all,
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
>
>
>    ------------------------------
>
> ------------------------------------------------------------------------------
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for Conference
> attendees to learn about information security's most important issues through
> interactions with peers, luminaries and emerging and established companies.http://p.sf.net/sfu/rsaconf-dev2dev
>
> ------------------------------
>
> _______________________________________________
> Ltp-list mailing listLtp-list@lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
>

--00504502eacf9300da047da34313
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It works!<br>But isn&#39;t weird? Why just use ./hugeshmget won&#39;t work?=
<br>I traced it, and found it calls tsg_sig() in setup():<br>=A0=A0=A0=A0=
=A0=A0=A0  tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>and in tsg_sig():<br>=
=A0=A0=A0=A0=A0=A0=A0 ...<br>
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 case SIGCLD:<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 if (fork_flag =3D=3D FORK || STD_COPIES &gt; 1)<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;<br><br>=A0=A0=A0 =A0=A0=A0 default:<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (tst_setup_signal(sig, handler) =3D=3D SI=
G_ERR)<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tst_resm(TWARN | TERRNO,<=
br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 &quot;signal() failed for=
 signal %d&quot;, sig);<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;<br>=A0=A0=
=A0=A0=A0=A0=A0 ...<br><br>so here=A0 hugeshmget set its action to SIGCLD t=
o handler - here is def_handler(), which can<br>rise  &quot;Unexpected sign=
al %d received.&quot; message when recived SIGCLD.<br>
static void def_handler(int sig)<br>{<br>=A0=A0=A0 /*<br>=A0=A0=A0 =A0* Bre=
ak remaining test cases, do any cleanup, then exit<br>=A0=A0=A0 =A0*/<br>=
=A0=A0=A0 tst_brkm(TBROK, 0, &quot;Unexpected signal %d received.&quot;, si=
g);<br><br>=A0=A0=A0 /* now cleanup and exit */<br>
=A0=A0=A0 if (T_cleanup)<br>=A0=A0=A0 =A0=A0=A0 (*T_cleanup) ();<br><br>=A0=
=A0=A0 tst_exit();<br>}<br><br>So I think it&#39;s better to correct it!<br=
><br>Thanks and Best Regards,<br>shenghui<br><br><div class=3D"gmail_quote"=
>2010/1/21 liubo <span dir=3D"ltr">&lt;<a href=3D"mailto:liubo2009@cn.fujit=
su.com">liubo2009@cn.fujitsu.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


 =20
 =20

<div bgcolor=3D"#ffffff" text=3D"#000000">
Hi, <br>
<br>
=A0=A0=A0 In my box, I can add -c Xnumber to avoid the unexpect signal, <br=
>
for example, ./hugeshmget -c 10. Maybe you can try this as well.<br>
<br>
Thanks,<br>
Liu Bo<div><div></div><div class=3D"h5"><br>
<br>
On 01/21/2010 08:50 AM, Crossover Lonely wrote:
</div></div><blockquote type=3D"cite"><div><div></div><div class=3D"h5">
  <pre>For your convenience, I just made to patches against the signle file=
, not
the whole directory.

solution 1=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--- hugeshmget01.c    2009-11-20 00:05:21.000000000 +0800
+++ hugeshmget01_2.c    2010-01-21 08:43:11.790533086 +0800
@@ -78,14 +78,14 @@
         tst_brkm(TBROK, cleanup, &quot;OPTION PARSING ERROR - %s&quot;, ms=
g);
     }

-    setup();            /* global setup */
-
     /* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D 0=
 )
              tst_brkm(TBROK, cleanup, &quot;Test cannot be continued ownin=
g to
sufficient availability of Hugepages on the system&quot;);
         else
               huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;

+    setup();            /* global setup */
+
         for (lc =3D 0; TEST_LOOPING(lc); lc++) {
         /* reset Tst_count in case we are looping */
         Tst_count =3D 0;


solution 2=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
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


2010/1/21 Crossover Lonely <a href=3D"mailto:crosslonelyover@gmail.com" tar=
get=3D"_blank">&lt;crosslonelyover@gmail.com&gt;</a>

  </pre>
  <blockquote type=3D"cite">
    <pre>Hi all,

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

Solution 1=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff -Nur
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hu=
geshmget01.c
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t01.c
---
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hu=
geshmget01.c
2010-01-21 07:51:55.926035076 +0800
+++
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t01.c
2010-01-21 08:14:05.470032624 +0800
@@ -78,14 +78,14 @@
         tst_brkm(TBROK, cleanup, &quot;OPTION PARSING ERROR - %s&quot;, ms=
g);
     }

-    setup();            /* global setup */
-
     /* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() &lt;=3D 0 || hugepages_size() &lt;=3D 0=
 )
              tst_brkm(TBROK, cleanup, &quot;Test cannot be continued ownin=
g to
sufficient availability of Hugepages on the system&quot;);
         else
-              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
-
+              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
+
+    setup();            /* global setup */
+
         for (lc =3D 0; TEST_LOOPING(lc); lc++) {
         /* reset Tst_count in case we are looping */
         Tst_count =3D 0;


Solution
2=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -Nur
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hu=
geshmget01.c
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t01.c
---
ltp-intermediate-20100119-origin/testcases/kernel/mem/hugetlb/hugeshmget/hu=
geshmget01.c
2010-01-21 07:51:55.926035076 +0800
+++
ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t01.c
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
  <pre>  </pre>
  </div></div><pre><hr size=3D"4" width=3D"90%">
---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world&#39;s best and brightest in the field, creating opportunities for Con=
ference
attendees to learn about information security&#39;s most important issues t=
hrough
interactions with peers, luminaries and emerging and established companies.
<a href=3D"http://p.sf.net/sfu/rsaconf-dev2dev" target=3D"_blank">http://p.=
sf.net/sfu/rsaconf-dev2dev</a></pre>
  <pre><hr size=3D"4" width=3D"90%">
_______________________________________________
Ltp-list mailing list
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</div>

</blockquote></div><br>

--00504502eacf9300da047da34313--


--===============2927880113646176208==
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
--===============2927880113646176208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2927880113646176208==--

