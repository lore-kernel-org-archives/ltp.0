Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Nenig-0006AD-8g
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 10:53:26 +0000
Received: from mail-pz0-f198.google.com ([209.85.222.198])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nenif-000498-F2
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 10:53:26 +0000
Received: by pzk36 with SMTP id 36so8123386pzk.23
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Feb 2010 02:53:19 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Feb 2010 16:23:19 +0530
Message-ID: <f5a7b3811002090253u412c926ds3f0ef9895631e4f6@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] Got warning message "FATAL: Test suite not installed
	correctly INFO: as root user type 'make ;
	make install'" on ltp-full-20100131 while running ./runltp even i
	have installed correctly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: shachin <er_sachin@rediffmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi Shachin,

>Hi shachin here,

>Even i am unable to use  ltp-full-20100131 build i also got warning message
>"FATAL: Test suite not installed correctly
>INFO: as root user type 'make ; make install'
>[root@mwg5 ltp-full-20100131]#'
>even i have installed it correctly.

>is anybody can help out on this?

when we do "make install" the binaries will copied in to
/opt/ltp/testcase/bin/ as default path.
please check the what are the files available under the /opt/ltp
#cd /opt/ltp/
# tree

and please run the runltp command from
#cd /opt/ltp/
#./runltp

Hope it works
please let me knw if u find any issues again.


>thanks
>shachin

Best regards
Naresh Kamboju

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
