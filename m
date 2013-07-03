Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.sun@oracle.com>) id 1UuCZe-0002Y9-R5
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 02:13:38 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UuCZc-0000c7-R2
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 02:13:38 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r63279Xe015478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 02:07:10 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r632DS5m026095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 02:13:29 GMT
Received: from abhmt104.oracle.com (abhmt104.oracle.com [141.146.116.56])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r632DSgQ010220
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 02:13:28 GMT
Message-ID: <51D38924.8090400@oracle.com>
Date: Wed, 03 Jul 2013 10:15:00 +0800
From: Eko <hong.sun@oracle.com>
MIME-Version: 1.0
References: <mailman.80890.1372765469.12996.ltp-list@lists.sourceforge.net>
In-Reply-To: <mailman.80890.1372765469.12996.ltp-list@lists.sourceforge.net>
Subject: Re: [LTP] [ltp-full-20130503] runltp cleanup() can't remove ${TMP}
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1532199317449404269=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1532199317449404269==
Content-Type: multipart/alternative;
	boundary="------------080801080400040401060208"

This is a multi-part message in MIME format.
--------------080801080400040401060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi,

  I executed runltp command in my box, everything is OK, but when 
cleaning the environment, got following errors:

        ###############################################################
             Done executing testcases.
             LTP Version:  20130503
        ###############################################################
rm: cannot remove `/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458': Device or resource busy
rm: cannot remove `/tmp/ltp-9NAwvmAbI5/sandbox': Device or resource busy


Because /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458 and 
/tmp/ltp-9NAwvmAbI5/sandbox are still mounted, so can't delete them, the 
best way is:
# umount /tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458
# umount /tmp/ltp-9NAwvmAbI5/sandbox

and then:

     [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
     [ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img
     rm -rf ${TMP}


-- 
Best Regards,
Eko
--


--------------080801080400040401060208
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    hi,<br>
    <br>
    &nbsp;I executed runltp command in my box, everything is OK, but when
    cleaning the environment, got following errors:<br>
    <br>
    <pre style="color:#ffffff;background:transparent; border:0;"><font color="#000000">       ###############################################################
            Done executing testcases.
            LTP Version:  20130503
       ###############################################################
rm: cannot remove `/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458': Device or resource busy
rm: cannot remove `/tmp/ltp-9NAwvmAbI5/sandbox': Device or resource busy</font></pre>
    <br>
    Because&nbsp; <font color="#000000">/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458
      and&nbsp; </font><font color="#000000">/tmp/ltp-9NAwvmAbI5/sandbox are
      still mounted, so can't delete them, the best way is:<br>
      # umount </font><font color="#000000">/tmp/ltp-9NAwvmAbI5/moulTfFCf/mnt_4458<br>
      # umount </font><font color="#000000"> </font><font
      color="#000000">/tmp/ltp-9NAwvmAbI5/sandbox<br>
      <br>
      and then:<br>
      <br>
      &nbsp;&nbsp;&nbsp; [ "$LOOP_DEV" ] &amp;&amp; losetup -d $LOOP_DEV<br>
      &nbsp;&nbsp;&nbsp; [ -e "${TEMP}/test.img" ] &amp;&amp; rm -f ${TEMP}/test.img<br>
      &nbsp;&nbsp;&nbsp; rm -rf ${TMP}<br>
      <br>
      <br>
    </font>
    <pre class="moz-signature" cols="72">-- 
Best Regards,
Eko
--</pre>
  </body>
</html>

--------------080801080400040401060208--


--===============1532199317449404269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============1532199317449404269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1532199317449404269==--

