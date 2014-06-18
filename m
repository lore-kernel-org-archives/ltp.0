Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aman.wardak@gmail.com>) id 1Wx4G7-00056l-4G
	for ltp-list@lists.sourceforge.net; Wed, 18 Jun 2014 01:01:51 +0000
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wx4G5-0003Zj-BI
	for ltp-list@lists.sourceforge.net; Wed, 18 Jun 2014 01:01:51 +0000
Received: by mail-qc0-f169.google.com with SMTP id c9so132503qcz.0
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Jun 2014 18:01:43 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jun 2014 18:01:43 -0700
Message-ID: <CAK2H_WyTJkN+_5SVe=cW-fw8vbork6nFad8xnh96v3Y8P-Kvqg@mail.gmail.com>
From: Aman Wardak <aman.wardak@gmail.com>
Subject: [LTP] Cross compiling LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3555943446373706098=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3555943446373706098==
Content-Type: multipart/alternative; boundary=089e0149ccdec316c704fc11cdf8

--089e0149ccdec316c704fc11cdf8
Content-Type: text/plain; charset=UTF-8

The INSTALL file says:

===
To cross compile, you must specify the correct variables:

1. When running configure (CC, CXX, CXXFLAGS, LDLIBS, etc).
2. Manually edit include/mk/config.mk, as described in Configuration.

Note: Do not specify variables on the command-line. Use config.mk instead.
===

I copied include/mk/config.mk.default to include/mk/config.mk and edited
include/mk/config.mk to include the my cross-compile variables:

CROSS_COMPILE := <my path>
SYSROOT := --sysroot=<my path to my sysroot>
CC   := $(CROSS_COMPILE)gcc $(SYSROOT)
LD   := $(CROSS_COMPILE)ld  $(SYSROOT)

I then ran "./configure --host=x86_64-linux-gnu
--prefix=/nobackup/awardak/ltp/ltp-full-20140115/build/"  and it overwrote
my config.mk changes above.

How do I properly set my cross compilation env?

Thanks,
Aman

--089e0149ccdec316c704fc11cdf8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>The INSTALL file says:<br><br>=3D=3D=3D<br>=
To cross compile, you must specify the correct variables:<br><br>1. When ru=
nning configure (CC, CXX, CXXFLAGS, LDLIBS, etc).<br>2. Manually edit inclu=
de/mk/<a href=3D"http://config.mk">config.mk</a>, as described in Configura=
tion.<br>
<br>Note: Do not specify variables on the command-line. Use <a href=3D"http=
://config.mk">config.mk</a> instead.<br>=3D=3D=3D<br><br></div>I copied inc=
lude/mk/config.mk.default to include/mk/<a href=3D"http://config.mk">config=
.mk</a> and edited include/mk/<a href=3D"http://config.mk">config.mk</a> to=
 include the my cross-compile variables:<br>
<br>CROSS_COMPILE :=3D &lt;my path&gt;<br>SYSROOT :=3D --sysroot=3D&lt;my p=
ath to my sysroot&gt;<br>CC=C2=A0=C2=A0 :=3D $(CROSS_COMPILE)gcc $(SYSROOT)=
<br>LD=C2=A0=C2=A0 :=3D $(CROSS_COMPILE)ld=C2=A0 $(SYSROOT)<br><br></div>I =
then ran &quot;./configure --host=3Dx86_64-linux-gnu --prefix=3D/nobackup/a=
wardak/ltp/ltp-full-20140115/build/&quot;=C2=A0 and it overwrote my <a href=
=3D"http://config.mk">config.mk</a> changes above.<br>
<br>How do I properly set my cross compilation env?<br><br>Thanks,<br></div=
>Aman<br></div>

--089e0149ccdec316c704fc11cdf8--


--===============3555943446373706098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
--===============3555943446373706098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3555943446373706098==--

