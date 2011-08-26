Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hakehuang@gmail.com>) id 1QwnLu-0000Vf-OJ
	for ltp-list@lists.sourceforge.net; Fri, 26 Aug 2011 03:45:06 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QwnLt-0002x7-MR
	for ltp-list@lists.sourceforge.net; Fri, 26 Aug 2011 03:45:06 +0000
Received: by mail-gw0-f47.google.com with SMTP id 11so2997606gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Aug 2011 20:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPt5XBfSWBkpa7gYFafubDbiavUCEnXnzK9bBBQsW=wzVkUbBQ@mail.gmail.com>
References: <mailman.321379.1313481992.22889.ltp-list@lists.sourceforge.net>
	<CAPt5XBfBW2-mTXVYR=B-mbaN2pCPG0UGa7vm0Bb2X7G6pyqRMA@mail.gmail.com>
	<20110825132441.GA16393@saboteur.suse.cz>
	<CAPt5XBfSWBkpa7gYFafubDbiavUCEnXnzK9bBBQsW=wzVkUbBQ@mail.gmail.com>
Date: Fri, 26 Aug 2011 11:45:05 +0800
Message-ID: <CAPt5XBd99L7KhKBDxs26_Mb-J0h3PhXptk0qBXVibg8ih90MBQ@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: [LTP] Fwd:  Ltp-list Digest, Vol 63, Issue 22
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1197344080653515845=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1197344080653515845==
Content-Type: multipart/alternative; boundary=0016e64762bef8eec904ab605e8f

--0016e64762bef8eec904ab605e8f
Content-Type: text/plain; charset=ISO-8859-1

CC

---------- Forwarded message ----------
From: hake huang <hakehuang@gmail.com>
Date: 2011/8/26
Subject: Re: [LTP] Ltp-list Digest, Vol 63, Issue 22
To: Cyril Hrubis <chrubis@suse.cz>


the log

#mmap1 -x 0.01
mmap1       0  TINFO  :  created thread[726717552]
mmap1       0  TINFO  :  pid[5117]: map, change contents, unmap files 1000
times
mmap1       0  TINFO  :  created thread[736490608]
mmap1       0  TINFO  :  pid[5117] - read contents of memory 0x2bf02000 1000
times
mmap1       0  TINFO  :  page fault occurred at 0x2ab27000
caught unexpected signal - 11 --- exiting

Regards,

Hake


2011/8/25 Cyril Hrubis <chrubis@suse.cz>

> Hi!
> > I test LTP in arm, cortex-a9 which is 4 core system, and find that the
> mmap1
> > of memtest06, failed. when I check the LTP mail list and find this patch
> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10706.html
> > however, when I apply this patch, I can still see the same problem but
> with
> > less frequency. It looks like the write process and read process are
> running
> > on different core, when write process unmap and remap the address, and
> the
> > other process is read at the same time.
> >
> > So any suggestions?
>
> There is probably a race condition, what is exact output from the test
> on the failure?
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>

--0016e64762bef8eec904ab605e8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

CC<br><br><div class=3D"gmail_quote">---------- Forwarded message ---------=
-<br>From: <b class=3D"gmail_sendername">hake huang</b> <span dir=3D"ltr">&=
lt;<a href=3D"mailto:hakehuang@gmail.com">hakehuang@gmail.com</a>&gt;</span=
><br>
Date: 2011/8/26<br>Subject: Re: [LTP] Ltp-list Digest, Vol 63, Issue 22<br>=
To: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>=
&gt;<br><br><br>the log<br><br>#mmap1 -x 0.01<br>mmap1=A0=A0=A0=A0=A0=A0 0=
=A0 TINFO=A0 :=A0 created thread[726717552]<br>
mmap1=A0=A0=A0=A0=A0=A0 0=A0 TINFO=A0 :=A0 pid[5117]: map, change contents,=
 unmap files 1000 times<br>mmap1=A0=A0=A0=A0=A0=A0 0=A0 TINFO=A0 :=A0 creat=
ed thread[736490608]<br>
mmap1=A0=A0=A0=A0=A0=A0 0=A0 TINFO=A0 :=A0 pid[5117] - read contents of mem=
ory 0x2bf02000 1000 times<br>mmap1=A0=A0=A0=A0=A0=A0 0=A0 TINFO=A0 :=A0 pag=
e fault occurred at 0x2ab27000<br>caught unexpected signal - 11 --- exiting=
<br><br>Regards,<br><font color=3D"#888888"><br>
Hake</font><div><div></div><div class=3D"h5"><br>
<br><div class=3D"gmail_quote">2011/8/25 Cyril Hrubis <span dir=3D"ltr">&lt=
;<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&g=
t;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">

<div>Hi!<br>
&gt; I test LTP in arm, cortex-a9 which is 4 core system, and find that the=
 mmap1<br>
&gt; of memtest06, failed. when I check the LTP mail list and find this pat=
ch<br>
&gt; <a href=3D"http://www.mail-archive.com/ltp-list@lists.sourceforge.net/=
msg10706.html" target=3D"_blank">http://www.mail-archive.com/ltp-list@lists=
.sourceforge.net/msg10706.html</a><br>
&gt; however, when I apply this patch, I can still see the same problem but=
 with<br>
&gt; less frequency. It looks like the write process and read process are r=
unning<br>
&gt; on different core, when write process unmap and remap the address, and=
 the<br>
&gt; other process is read at the same time.<br>
&gt;<br>
&gt; So any suggestions?<br>
<br>
</div>There is probably a race condition, what is exact output from the tes=
t<br>
on the failure?<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div>Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><br=
>
</div></div></blockquote></div><br>
</div></div></div><br>

--0016e64762bef8eec904ab605e8f--


--===============1197344080653515845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
--===============1197344080653515845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1197344080653515845==--

