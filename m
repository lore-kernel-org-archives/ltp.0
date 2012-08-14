Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1T16Y8-0006kQ-TC
	for ltp-list@lists.sourceforge.net; Tue, 14 Aug 2012 02:08:04 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T16Y7-0008Uo-T0
	for ltp-list@lists.sourceforge.net; Tue, 14 Aug 2012 02:08:04 +0000
Message-ID: <5029B2B0.5080603@windriver.com>
Date: Tue, 14 Aug 2012 10:06:40 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] POSIX pthread_detach/4-3 fails with SIGSEGV randomly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5699908066458657198=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

--===============5699908066458657198==
Content-Type: multipart/alternative;
	boundary="------------060704090308020807030508"

--------------060704090308020807030508
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wanlong,

Case pthread_detach/4-3 fails with SIGSEGV randomly on x86_64 with 
Ubuntu 11.10.
I saw that you have made a patch for it. So would you like to give me 
some advice to solve it? Thanks.
It seems a multi-threads issue and I have try to debug with the core 
file but not much help.

The fail log:
[09:58:38]System abilities:
[09:58:38] TSA: 200809
[09:58:38] TSS: 200809
[09:58:38] TPS: 200809
[09:58:38] pagesize: 4096
[09:58:38] min stack size: 16384
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]WARNING: The TPS option is claimed to be supported but 
setscope fails
[09:58:38]All 33 thread attribute objects were initialized

Segmentation fault (core dumped)

Regards,
Kai

--------------060704090308020807030508
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <font size="+1">Hi Wanlong,<br>
      <br>
      Case pthread_detach/4-3 fails with SIGSEGV randomly on x86_64 with
      Ubuntu 11.10. <br>
      I saw that you have made a patch for it. So would you like to give
      me some advice to solve it? Thanks.<br>
      It seems a multi-threads issue and I have try to debug with the
      core file but not much help.<br>
      <br>
      The fail log:<br>
      [09:58:38]System abilities:<br>
      [09:58:38] TSA: 200809<br>
      [09:58:38] TSS: 200809<br>
      [09:58:38] TPS: 200809<br>
      [09:58:38] pagesize: 4096<br>
      [09:58:38] min stack size: 16384<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]WARNING: The TPS option is claimed to be supported but
      setscope fails<br>
      [09:58:38]All 33 thread attribute objects were initialized<br>
      <br>
      Segmentation fault (core dumped)<br>
      <br>
      Regards,<br>
      Kai<br>
    </font>
  </body>
</html>

--------------060704090308020807030508--


--===============5699908066458657198==
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
--===============5699908066458657198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5699908066458657198==--

