Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 20 Sep 2010 11:16:22 +0530
Message-ID: <AANLkTimuf2u6_X1J4fb+Ds3EY2emb01WQ41p6Y9yb4At@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] nfs testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5191210454991505481=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Ltp-list-request@lists.sourceforge.net

--===============5191210454991505481==
Content-Type: multipart/alternative; boundary=0016367fa2d0afc3210490aa6ef1

--0016367fa2d0afc3210490aa6ef1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

      while running NFS testcase in LTP, i am getting a diffent kind of
error.
      5 out of 8 testcases are failing due to same kind of error as
explained below:--

      Testcases are failing because instead of looking for 'nfs02', it is
looking for 'nfs028153' inside opt/ltp/testcases/bin, and this is not found.
Similar is the case with nfs03,nfs04,nfsstress etc.
      please tell why it is looking for some file which does not exist, and
how to rectify this problem.

-- 
Regards,
Arjit Sharma.

--0016367fa2d0afc3210490aa6ef1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0 while running NFS testcase in LTP, i am getting a diff=
ent kind of error.</div>
<div>=A0=A0=A0=A0=A0=A05 out of 8 testcases are failing due to same kind of=
 error as explained below:--</div>
<div>=A0</div>
<div>=A0=A0=A0=A0=A0=A0Testcases are failing because instead of looking for=
 &#39;nfs02&#39;, it is looking for &#39;nfs028153&#39; inside opt/ltp/test=
cases/bin, and this is not=A0found. Similar is the case with nfs03,nfs04,nf=
sstress etc.=A0=A0=A0=A0</div>

<div>=A0=A0=A0=A0=A0 please tell why it is looking for some file which does=
 not exist, and how to rectify this problem.=A0=A0=A0 <br clear=3D"all"><br=
>-- <br></div>
<div>Regards,</div>
<div>Arjit Sharma.</div><br>

--0016367fa2d0afc3210490aa6ef1--


--===============5191210454991505481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============5191210454991505481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5191210454991505481==--

