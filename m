Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <crosslonelyover@gmail.com>) id 1NdmgG-0006PW-1b
	for ltp-list@lists.sourceforge.net; Sat, 06 Feb 2010 15:34:44 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdmgF-00005Z-2D
	for ltp-list@lists.sourceforge.net; Sat, 06 Feb 2010 15:34:44 +0000
Received: by pxi38 with SMTP id 38so5129219pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 06 Feb 2010 07:34:37 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 6 Feb 2010 23:34:37 +0800
Message-ID: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
From: shenghui <crosslonelyover@gmail.com>
Subject: [LTP] about "hugetlbshmget03"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0660303348654025685=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0660303348654025685==
Content-Type: multipart/alternative; boundary=0016e64cd702445172047ef04e64

--0016e64cd702445172047ef04e64
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

       I want to know how to run hugetlbshmget03? Does it need some
arguments?
For I have run it several times, always got error "NOMEM" for cannot get
hugetlb
page. But "cat /proc/meminfo" shows that free hugetlb pages are enough for
its
request.
       Does anyone know how to handle this problem?

-- 


Thanks and Best Regards,
shenghui

--0016e64cd702445172047ef04e64
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br>=A0<br>=A0=A0=A0=A0=A0=A0 I want to know how to run hugetlbshmge=
t03? Does it need some arguments?<br>For I have run it several times, alway=
s got error &quot;NOMEM&quot; for cannot get hugetlb<br>page. But &quot;cat=
 /proc/meminfo&quot; shows that free hugetlb pages are enough for its<br>
request.<br>=A0=A0=A0=A0=A0=A0 Does anyone know how to handle this problem?=
<br clear=3D"all"><br>-- <br><br><br>Thanks and Best Regards,<br>shenghui<b=
r>

--0016e64cd702445172047ef04e64--


--===============0660303348654025685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--===============0660303348654025685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0660303348654025685==--

