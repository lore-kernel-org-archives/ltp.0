Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1NXqIp-0002QR-5h
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 06:13:59 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXqIn-0002Tq-VQ
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 06:13:59 +0000
Received: by pzk37 with SMTP id 37so1876355pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 22:13:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B57D0D5.8090307@cn.fujitsu.com>
References: <5a774f4c1001201626g53dae882o50b5aa70b23d929e@mail.gmail.com>
	<5a774f4c1001201650l600b5540x8a91143aff2385ad@mail.gmail.com>
	<4B57AE50.4020801@cn.fujitsu.com>
	<5a774f4c1001201814ta9a25a2j150fe0cf99226952@mail.gmail.com>
	<4B57D0D5.8090307@cn.fujitsu.com>
Date: Thu, 21 Jan 2010 14:13:51 +0800
Message-ID: <5a774f4c1001202213w60a194abo713a5b50d78c21ce@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0746149104660770885=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--===============0746149104660770885==
Content-Type: multipart/alternative; boundary=0016e64ce5845fd87f047da69b95

--0016e64ce5845fd87f047da69b95
Content-Type: text/plain; charset=ISO-8859-1

Hi,
     I have tried "gdb ./hugeshmget01 -c 2" and "set follow-fork-mode
child".
Then I traced into the child thread, and got
           "hugeshmget01    1  TBROK  :  Unexpected signal 17 received."


2010/1/21 liubo <liubo2009@cn.fujitsu.com>

>  Hi,
>
>     The hugeshmget01 case is designed for testing standard SYSV shared
> memory system calls "shmget", and it do need a few concurrent copies
> in order to fulfill a multi-process memory-allocated environment.
>
>     IMO, "-c Xnumber" is needed.
>
> Thanks,
> Liu Bo
>
>
>
> On 01/21/2010 10:14 AM, Crossover Lonely wrote:
>
> It works!
> But isn't weird? Why just use ./hugeshmget won't work?
> I traced it, and found it calls tsg_sig() in setup():
>         tst_sig(NOFORK, DEF_HANDLER, cleanup);
> and in tsg_sig():
>         ...
>                case SIGCLD:
>             if (fork_flag == FORK || STD_COPIES > 1)
>                 continue;
>
>         default:
>             if (tst_setup_signal(sig, handler) == SIG_ERR)
>                 tst_resm(TWARN | TERRNO,
>                     "signal() failed for signal %d", sig);
>             break;
>         ...
>
> so here  hugeshmget set its action to SIGCLD to handler - here is
> def_handler(), which can
> rise "Unexpected signal %d received." message when recived SIGCLD.
> static void def_handler(int sig)
> {
>     /*
>      * Break remaining test cases, do any cleanup, then exit
>      */
>     tst_brkm(TBROK, 0, "Unexpected signal %d received.", sig);
>
>     /* now cleanup and exit */
>     if (T_cleanup)
>         (*T_cleanup) ();
>
>     tst_exit();
> }
>
> So I think it's better to correct it!
>
> Thanks and Best Regards,
> shenghui
>
> 2010/1/21 liubo <liubo2009@cn.fujitsu.com> <liubo2009@cn.fujitsu.com>
>
>     Hi,
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
> solution 2=============================
> =
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
> 2010/1/21 Crossover Lonely <crosslonelyover@gmail.com> <crosslonelyover@gmail.com> <crosslonelyover@gmail.com> <crosslonelyover@gmail.com>
>
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
> ______________________________
> _________________
> Ltp-list mailing listLtp-list@lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
>
>
>


-- 


Thanks and Best Regards,
shenghui

--0016e64ce5845fd87f047da69b95
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0=A0=A0=A0 I have tried &quot;gdb ./hugeshmget01 -c 2&quot; and &q=
uot;set follow-fork-mode child&quot;.<br>Then I traced into the child threa=
d, and got<br>=A0 =A0 =A0 =A0 =A0=A0 &quot;hugeshmget01=A0=A0=A0 1=A0 TBROK=
=A0 :=A0 Unexpected signal 17 received.&quot;<br>
<br><br><div class=3D"gmail_quote">2010/1/21 liubo <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:liubo2009@cn.fujitsu.com">liubo2009@cn.fujitsu.com</a>&gt;<=
/span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



 =20

<div bgcolor=3D"#ffffff" text=3D"#000000">
Hi,<br>
<br>
=A0=A0=A0 The hugeshmget01 case is designed for testing standard SYSV share=
d <br>
memory system calls &quot;shmget&quot;, and it do need a few concurrent cop=
ies <br>
in order to fulfill a multi-process memory-allocated environment.<br>
=A0=A0=A0=A0 <br>
=A0=A0=A0 IMO, &quot;-c Xnumber&quot; is needed.<br>
<br>
Thanks,<br>
Liu Bo<div><div></div><div class=3D"h5"><br>
<pre><a name=3D"1264f0609f38cffc_L14"></a></pre>
<br>
<br>
On 01/21/2010 10:14 AM, Crossover Lonely wrote:
</div></div><blockquote type=3D"cite"><div><div></div><div class=3D"h5">
  <pre>It works!
But isn&#39;t weird? Why just use ./hugeshmget won&#39;t work?
I traced it, and found it calls tsg_sig() in setup():
        tst_sig(NOFORK, DEF_HANDLER, cleanup);
and in tsg_sig():
        ...
               case SIGCLD:
            if (fork_flag =3D=3D FORK || STD_COPIES &gt; 1)
                continue;

        default:
            if (tst_setup_signal(sig, handler) =3D=3D SIG_ERR)
                tst_resm(TWARN | TERRNO,
                    &quot;signal() failed for signal %d&quot;, sig);
            break;
        ...

so here  hugeshmget set its action to SIGCLD to handler - here is
def_handler(), which can
rise &quot;Unexpected signal %d received.&quot; message when recived SIGCLD=
.
static void def_handler(int sig)
{
    /*
     * Break remaining test cases, do any cleanup, then exit
     */
    tst_brkm(TBROK, 0, &quot;Unexpected signal %d received.&quot;, sig);

    /* now cleanup and exit */
    if (T_cleanup)
        (*T_cleanup) ();

    tst_exit();
}

So I think it&#39;s better to correct it!

Thanks and Best Regards,
shenghui

2010/1/21 liubo <a href=3D"mailto:liubo2009@cn.fujitsu.com" target=3D"_blan=
k">&lt;liubo2009@cn.fujitsu.com&gt;</a>

  </pre>
  </div></div><blockquote type=3D"cite">
    <pre><div><div></div><div class=3D"h5"> Hi,

    In my box, I can add -c Xnumber to avoid the unexpect signal,
for example, ./hugeshmget -c 10. Maybe you can try this as well.

Thanks,
Liu Bo


On 01/21/2010 08:50 AM, Crossover Lonely wrote:

For your convenience, I just made to patches against the signle file, not
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
=3D=3D=3D=3D=3D=3D=3D=3D</div></div>=3D
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
get=3D"_blank">&lt;crosslonelyover@gmail.com&gt;</a> <a href=3D"mailto:cros=
slonelyover@gmail.com" target=3D"_blank">&lt;crosslonelyover@gmail.com&gt;<=
/a><div>
<div></div><div class=3D"h5">

   Hi all,

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



   ------------------------------

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world&#39;s best and brightest in the field, creating opportunities for Con=
ference
attendees to learn about information security&#39;s most important issues t=
hrough
interactions with peers, luminaries and emerging and established companies.=
<a href=3D"http://p.sf.net/sfu/rsaconf-dev2dev" target=3D"_blank">http://p.=
sf.net/sfu/rsaconf-dev2dev</a>

------------------------------

______________________________</div></div>_________________
Ltp-list mailing <a href=3D"mailto:listLtp-list@lists.sourceforge.nethttps:=
//lists.sourceforge.net/lists/listinfo/ltp-list" target=3D"_blank">listLtp-=
list@lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/ltp-=
list</a>



    </pre>
  </blockquote>
  <pre>  </pre>
</blockquote>
<br>
</div>

</blockquote></div><br><br clear=3D"all"><br>-- <br><br><br>Thanks and Best=
 Regards,<br>shenghui<br>

--0016e64ce5845fd87f047da69b95--


--===============0746149104660770885==
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
--===============0746149104660770885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0746149104660770885==--

