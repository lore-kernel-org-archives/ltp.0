Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgdfL-0007gG-CQ
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 16:51:43 +0000
Received: from mail-bk0-f50.google.com ([209.85.214.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VgdfK-0000qP-D7
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 16:51:43 +0000
Received: by mail-bk0-f50.google.com with SMTP id v16so481349bkz.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 08:51:36 -0800 (PST)
MIME-Version: 1.0
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 00:51:15 +0800
Message-ID: <CAARHBVt_=_LFY1zdDyi1BeZnKPdpgJbG2Jhc7JK-G9t+eO+T=g@mail.gmail.com>
Subject: [LTP] LTP networking multicast test fail
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6544150560929595368=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Linaro Networking <linaro-networking@linaro.org>

--===============6544150560929595368==
Content-Type: multipart/alternative; boundary=001a11c397143359e004eb11c79e

--001a11c397143359e004eb11c79e
Content-Type: text/plain; charset=UTF-8

Hi,
I'm trying your newest code. All the multicast tests fail now.

It may cause by this line:
/opt/ltp/testcases/bin/mc_cmds: line 71: /opt/ltp/bin/gethost: No such file
or directory

Then I found this commit:
commit 743f2fcd5744744d649496d8f0524cf5ca7d3859
Author: Simon Xu <xu.simon@oracle.com>
Date:   Tue Nov 12 18:59:57 2013 +0800

    move gethost from tools to sendfile01

    Move tools/gethost.c to
     testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
    since sendfile01 is the only test that requires gethost.

    Signed-off-by: Simon Xu <xu.simon@oracle.com>
    Acked-by: Cyril Hrubis <chrubis@suse.cz>

Could you fix it? Thanks.

--
Regards,
Vincent Hsu

--001a11c397143359e004eb11c79e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>I&#39;m trying your newest code. All the multicast =
tests fail now.<br><br>It may cause by this line:<br>/opt/ltp/testcases/bin=
/mc_cmds: line 71: /opt/ltp/bin/gethost: No such file or directory<br><br>

Then I found this commit:<br>commit 743f2fcd5744744d649496d8f0524cf5ca7d385=
9<br>Author: Simon Xu &lt;<a href=3D"mailto:xu.simon@oracle.com">xu.simon@o=
racle.com</a>&gt;<br>Date: =C2=A0 Tue Nov 12 18:59:57 2013 +0800<br><br>=C2=
=A0 =C2=A0 move gethost from tools to sendfile01<br>

=C2=A0 =C2=A0<br>=C2=A0 =C2=A0 Move tools/gethost.c to<br>=C2=A0 =C2=A0 =C2=
=A0testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c<br>=C2=A0 =C2=
=A0 since sendfile01 is the only test that requires gethost.<br>=C2=A0 =C2=
=A0<br>=C2=A0 =C2=A0 Signed-off-by: Simon Xu &lt;<a href=3D"mailto:xu.simon=
@oracle.com">xu.simon@oracle.com</a>&gt;<br>

=C2=A0 =C2=A0 Acked-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz"=
>chrubis@suse.cz</a>&gt;<br><br>Could you fix it? Thanks.<br><br>--<br>Rega=
rds,<br>Vincent Hsu</div>

--001a11c397143359e004eb11c79e--


--===============6544150560929595368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
--===============6544150560929595368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6544150560929595368==--

