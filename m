Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SuN6j-0002nJ-9A
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 12:23:57 +0000
Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SuN6d-0000gU-HQ
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 12:23:57 +0000
Received: by ggnp4 with SMTP id p4so1886046ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 26 Jul 2012 05:23:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
References: <50093AD7.9040602@casparzhang.com>
	<134772967.3599142.1343297650967.JavaMail.root@redhat.com>
Date: Thu, 26 Jul 2012 19:21:39 +0800
Message-ID: <CAAEprPhtqh1jwOV8V1_pTwwF+y5hdwY32HBznDsbo_A1a9gHJw@mail.gmail.com>
From: Caspar Zhang <caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 0/2] numa_helper: get nodes with mem/cpu/both
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0090980382973159236=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============0090980382973159236==
Content-Type: multipart/alternative; boundary=14dae9340d319faabf04c5b9cc88

--14dae9340d319faabf04c5b9cc88
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jul 26, 2012 at 6:14 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "Caspar Zhang" <caspar@casparzhang.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Friday, 20 July, 2012 1:02:47 PM
> > Subject: Re: [LTP] [PATCH 0/2] numa_helper: get nodes with mem/cpu/both
> >
> > On 07/20/2012 06:19 PM, Jan Stancek wrote:
> > > numa_helper has been used for syscalls testcases, which
> > > care about nodes with memory. Based on discussion here:
> > > http://article.gmane.org/gmane.linux.ltp/16325
> > > it was deemed, that 'flag' extension would be useful,
> > > to allow tests to ask for nodes with memory/cpu/both.
> > >
> > > This patch series is introducing flag to get_allowed_nodes().
> > >
> > > For example, a config like this one:
> > >    # numactl -H
> > >    available: 3 nodes (2,4-5)
> > >    node 2 cpus: 0
> > >    node 2 size: 511 MB
> > >    node 2 free: 88 MB
> > >    node 4 cpus:
> > >    node 4 size: 256 MB
> > >    node 4 free: 34 MB
> > >    node 5 cpus:
> > >    node 5 size: 255 MB
> > >    node 5 free: 59 MB
> > >
> > > would return:
> > >    nodes (flag=0): 2 4 5 (any)
> > >    nodes (flag=1): 2 4 5 (mem)
> > >    nodes (flag=2): 2     (cpus)
> > >    nodes (flag=3): 2     (mem and cpus)
> > >
> > > Tested with:
> > > numactl-devel-0.9.8-7.el5
> > > numactl-devel-2.0.3-9.el6
> > > numactl-devel-2.0.7-6.el7
> > >
> > > numa_node_to_cpus() is broken in older libnuma < 1, so cpumap
> > > is used instead.
> > >
> > > Next step (not part of this series) is to move it outside
> > > syscalls area, so it can be used by other testcases.
> > >
> > > Jan Stancek (2):
> > >    numa_helper: add flag to get_allowed_nodes()
> > >    update testcases to use flag for get_allowed_nodes()
> > >
> > >   .../syscalls/get_mempolicy/get_mempolicy01.c       |    5 +-
> > >   testcases/kernel/syscalls/mbind/mbind01.c          |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages02.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages03.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages04.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages05.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages06.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages07.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages08.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages09.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages10.c      |    5 +-
> > >   .../kernel/syscalls/move_pages/move_pages11.c      |    5 +-
> > >   .../syscalls/move_pages/move_pages_support.c       |    8 +-
> > >   testcases/kernel/syscalls/numa/lib/numa_helper.c   |  211
> > >   +++++++++++++++-----
> > >   testcases/kernel/syscalls/numa/lib/numa_helper.h   |    8 +-
> > >   15 files changed, 203 insertions(+), 84 deletions(-)
> > >
> > >
> >
> > Thanks Jan for your patches! I want to test the patchset on all
> > arches
> > and on major releases, so would you mind if I hold on pushing until I
> > finish the testing next week?
> >
> > Also during that period, any comments from anyone is welcomed.
>
> I came across one issue. This happens on some arches, which do not support
> numa/get_mempolicy.
>
> What happens with v1 of this patch is:
> # ./mbind01
> mbind01     0  TINFO  :  (case00) START
> mbind01     1  TBROK  :  get_allowed_nodes(): -3: errno=EINVAL(22):
> Invalid argument
> mbind01     2  TBROK  :  Remaining cases broken
> which is bad, because it should end with TCONF stating, that numa is not
> supported.
>

ya, I encountered this too. I have a patch for it, and will send it along
with other numa related patches.

Caspar


>
> What happens with current HEAD depends on libnuma version. The problem is
> the
> same here: we use libnuma functions in numa_helper even when numa is not
> supported.
>
> mbind and get_mempolicy testcases (and numa_helper) check only for
> HAVE_NUMA_H, etc.
> but they don't check numa_available().
>
> Regards,
> Jan
>
> >
> > Thanks,
> > Caspar
> >
> >
>

--14dae9340d319faabf04c5b9cc88
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jul 26, 2012 at 6:14 PM, Jan Sta=
ncek <span dir=3D"ltr">&lt;<a href=3D"mailto:jstancek@redhat.com" target=3D=
"_blank">jstancek@redhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<div class=3D"im"><br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Caspar Zhang&quot; &lt;<a href=3D"mailto:caspar@casparzhan=
g.com">caspar@casparzhang.com</a>&gt;<br>
&gt; To: &quot;Jan Stancek&quot; &lt;<a href=3D"mailto:jstancek@redhat.com"=
>jstancek@redhat.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.s=
ourceforge.net</a><br>
&gt; Sent: Friday, 20 July, 2012 1:02:47 PM<br>
&gt; Subject: Re: [LTP] [PATCH 0/2] numa_helper: get nodes with mem/cpu/bot=
h<br>
&gt;<br>
</div><div><div class=3D"h5">&gt; On 07/20/2012 06:19 PM, Jan Stancek wrote=
:<br>
&gt; &gt; numa_helper has been used for syscalls testcases, which<br>
&gt; &gt; care about nodes with memory. Based on discussion here:<br>
&gt; &gt; <a href=3D"http://article.gmane.org/gmane.linux.ltp/16325" target=
=3D"_blank">http://article.gmane.org/gmane.linux.ltp/16325</a><br>
&gt; &gt; it was deemed, that &#39;flag&#39; extension would be useful,<br>
&gt; &gt; to allow tests to ask for nodes with memory/cpu/both.<br>
&gt; &gt;<br>
&gt; &gt; This patch series is introducing flag to get_allowed_nodes().<br>
&gt; &gt;<br>
&gt; &gt; For example, a config like this one:<br>
&gt; &gt; =A0 =A0# numactl -H<br>
&gt; &gt; =A0 =A0available: 3 nodes (2,4-5)<br>
&gt; &gt; =A0 =A0node 2 cpus: 0<br>
&gt; &gt; =A0 =A0node 2 size: 511 MB<br>
&gt; &gt; =A0 =A0node 2 free: 88 MB<br>
&gt; &gt; =A0 =A0node 4 cpus:<br>
&gt; &gt; =A0 =A0node 4 size: 256 MB<br>
&gt; &gt; =A0 =A0node 4 free: 34 MB<br>
&gt; &gt; =A0 =A0node 5 cpus:<br>
&gt; &gt; =A0 =A0node 5 size: 255 MB<br>
&gt; &gt; =A0 =A0node 5 free: 59 MB<br>
&gt; &gt;<br>
&gt; &gt; would return:<br>
&gt; &gt; =A0 =A0nodes (flag=3D0): 2 4 5 (any)<br>
&gt; &gt; =A0 =A0nodes (flag=3D1): 2 4 5 (mem)<br>
&gt; &gt; =A0 =A0nodes (flag=3D2): 2 =A0 =A0 (cpus)<br>
&gt; &gt; =A0 =A0nodes (flag=3D3): 2 =A0 =A0 (mem and cpus)<br>
&gt; &gt;<br>
&gt; &gt; Tested with:<br>
&gt; &gt; numactl-devel-0.9.8-7.el5<br>
&gt; &gt; numactl-devel-2.0.3-9.el6<br>
&gt; &gt; numactl-devel-2.0.7-6.el7<br>
&gt; &gt;<br>
&gt; &gt; numa_node_to_cpus() is broken in older libnuma &lt; 1, so cpumap<=
br>
&gt; &gt; is used instead.<br>
&gt; &gt;<br>
&gt; &gt; Next step (not part of this series) is to move it outside<br>
&gt; &gt; syscalls area, so it can be used by other testcases.<br>
&gt; &gt;<br>
&gt; &gt; Jan Stancek (2):<br>
&gt; &gt; =A0 =A0numa_helper: add flag to get_allowed_nodes()<br>
&gt; &gt; =A0 =A0update testcases to use flag for get_allowed_nodes()<br>
&gt; &gt;<br>
&gt; &gt; =A0 .../syscalls/get_mempolicy/get_mempolicy01.c =A0 =A0 =A0 | =
=A0 =A05 +-<br>
&gt; &gt; =A0 testcases/kernel/syscalls/mbind/mbind01.c =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages02.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages03.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages04.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages05.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages06.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages07.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages08.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages09.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages10.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../kernel/syscalls/move_pages/move_pages11.c =A0 =A0 =A0| =
=A0 =A05 +-<br>
&gt; &gt; =A0 .../syscalls/move_pages/move_pages_support.c =A0 =A0 =A0 | =
=A0 =A08 +-<br>
&gt; &gt; =A0 testcases/kernel/syscalls/numa/lib/numa_helper.c =A0 | =A0211=
<br>
&gt; &gt; =A0 +++++++++++++++-----<br>
&gt; &gt; =A0 testcases/kernel/syscalls/numa/lib/numa_helper.h =A0 | =A0 =
=A08 +-<br>
&gt; &gt; =A0 15 files changed, 203 insertions(+), 84 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; Thanks Jan for your patches! I want to test the patchset on all<br>
&gt; arches<br>
&gt; and on major releases, so would you mind if I hold on pushing until I<=
br>
&gt; finish the testing next week?<br>
&gt;<br>
&gt; Also during that period, any comments from anyone is welcomed.<br>
<br>
</div></div>I came across one issue. This happens on some arches, which do =
not support<br>
numa/get_mempolicy.<br>
<br>
What happens with v1 of this patch is:<br>
# ./mbind01<br>
mbind01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) START<br>
mbind01 =A0 =A0 1 =A0TBROK =A0: =A0get_allowed_nodes(): -3: errno=3DEINVAL(=
22): Invalid argument<br>
mbind01 =A0 =A0 2 =A0TBROK =A0: =A0Remaining cases broken<br>
which is bad, because it should end with TCONF stating, that numa is not su=
pported.<br></blockquote><div><br>ya, I encountered this too. I have a patc=
h for it, and will send it along with other numa related patches.<br><br>
Caspar<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
What happens with current HEAD depends on libnuma version. The problem is t=
he<br>
same here: we use libnuma functions in numa_helper even when numa is not su=
pported.<br>
<br>
mbind and get_mempolicy testcases (and numa_helper) check only for HAVE_NUM=
A_H, etc.<br>
but they don&#39;t check numa_available().<br>
<br>
Regards,<br>
Jan<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Caspar<br>
&gt;<br>
&gt;<br>
</blockquote></div><br>

--14dae9340d319faabf04c5b9cc88--


--===============0090980382973159236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============0090980382973159236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0090980382973159236==--

