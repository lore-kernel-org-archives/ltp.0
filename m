Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tosubrata@gmail.com>) id 1MGWmz-0002aq-Bd
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 11:25:17 +0000
Received: from [209.85.222.191] (helo=mail-pz0-f191.google.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGWmn-0001PC-P3
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 11:25:06 +0000
MIME-Version: 1.0
In-Reply-To: <200906161646.50305.knikanth@suse.de>
References: <200906161646.50305.knikanth@suse.de>
Date: Tue, 16 Jun 2009 16:53:47 +0530
Message-ID: <bb33bcf20906160423r408b3c6awc0b47ec5a2edee1d@mail.gmail.com>
From: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [LTP] cpusets: document adding/removing cpus to cpuset
	elaborately
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3129675760171123601=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: ltp-list <ltp-list@lists.sf.net>, Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org, miaox@cn.fujitsu.com

--===============3129675760171123601==
Content-Type: multipart/alternative; boundary=001636457498896a3c046c75680e

--001636457498896a3c046c75680e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Jun 16, 2009 at 4:46 PM, Nikanth Karthikesan <knikanth@suse.de>wrote:

> Writing a pid to the file, tasks adds that task to that cgroup/cpuset. But
> to
> add a cpu/mem to a cpuset, the new list of cpus should be written to the
> cpuset.mems file which would replace the old list of cpus. Make this
> clearer
> in the documentation.
>
> Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>


Hey,

Great to see that you are working on the documentation part. Have you given
a try to test the CPUSET features in the kernel with the recently added
tests from LTP(
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/controllers/cpuset/)
? It would be great if you help us in improving them further.

Regards--
Subrata


>
> ---
>
> diff --git a/Documentation/cgroups/cpusets.txt
> b/Documentation/cgroups/cpusets.txt
> index f9ca389..1d7e978 100644
> --- a/Documentation/cgroups/cpusets.txt
> +++ b/Documentation/cgroups/cpusets.txt
> @@ -777,6 +777,18 @@ in cpuset directories:
>  # /bin/echo 1-4 > cpus         -> set cpus list to cpus 1,2,3,4
>  # /bin/echo 1,2,3,4 > cpus     -> set cpus list to cpus 1,2,3,4
>
> +To add a CPU to a cpuset, write the new list of CPUs including the
> +CPU to be added. To add 6 to the above cpuset:
> +
> +# /bin/echo 1-4,6 > cpus       -> set cpus list to cpus 1,2,3,4,6
> +
> +Similarly to remove a CPU from a cpuset, write the new list of CPUs
> +without the CPU to be removed.
> +
> +To remove all the CPUs:
> +
> +# /bin/echo "" > cpus          -> clear cpus list
> +
>  2.3 Setting flags
>  -----------------
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Regards & Thanks--
Subrata

--001636457498896a3c046c75680e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Jun 16, 2009 at 4:46 PM, Nikanth Karthik=
esan <span dir=3D"ltr">&lt;<a href=3D"mailto:knikanth@suse.de">knikanth@sus=
e.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
Writing a pid to the file, tasks adds that task to that cgroup/cpuset. But =
to<br>
add a cpu/mem to a cpuset, the new list of cpus should be written to the<br=
>
cpuset.mems file which would replace the old list of cpus. Make this cleare=
r<br>
in the documentation.<br>
<br>
Signed-off-by: Nikanth Karthikesan &lt;<a href=3D"mailto:knikanth@suse.de">=
knikanth@suse.de</a>&gt;</blockquote><div><br>Hey,<br><br>Great to see that=
 you are working on the documentation part. Have you given a try to test th=
e CPUSET features in the kernel with the recently added tests from LTP(<a h=
ref=3D"http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/contr=
ollers/cpuset/">http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/ker=
nel/controllers/cpuset/</a>) ? It would be great if you help us in improvin=
g them further.<br>
<br>Regards--<br>Subrata<br><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;"><br>
<br>
---<br>
<br>
diff --git a/Documentation/cgroups/cpusets.txt b/Documentation/cgroups/cpus=
ets.txt<br>
index f9ca389..1d7e978 100644<br>
--- a/Documentation/cgroups/cpusets.txt<br>
+++ b/Documentation/cgroups/cpusets.txt<br>
@@ -777,6 +777,18 @@ in cpuset directories:<br>
=C2=A0# /bin/echo 1-4 &gt; cpus =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; set cpus =
list to cpus 1,2,3,4<br>
=C2=A0# /bin/echo 1,2,3,4 &gt; cpus =C2=A0 =C2=A0 -&gt; set cpus list to cp=
us 1,2,3,4<br>
<br>
+To add a CPU to a cpuset, write the new list of CPUs including the<br>
+CPU to be added. To add 6 to the above cpuset:<br>
+<br>
+# /bin/echo 1-4,6 &gt; cpus =C2=A0 =C2=A0 =C2=A0 -&gt; set cpus list to cp=
us 1,2,3,4,6<br>
+<br>
+Similarly to remove a CPU from a cpuset, write the new list of CPUs<br>
+without the CPU to be removed.<br>
+<br>
+To remove all the CPUs:<br>
+<br>
+# /bin/echo &quot;&quot; &gt; cpus =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;=
 clear cpus list<br>
+<br>
=C2=A02.3 Setting flags<br>
=C2=A0-----------------<br>
<font color=3D"#888888"><br>
<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &amp; Th=
anks--<br>Subrata<br>

--001636457498896a3c046c75680e--


--===============3129675760171123601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============3129675760171123601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3129675760171123601==--

