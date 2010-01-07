Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <md.zafar.ziya@gmail.com>) id 1NSp1P-0004zI-O3
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:51:15 +0000
Received: from mail-pz0-f233.google.com ([209.85.222.233])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSp1O-00044w-Q3
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:51:15 +0000
Received: by pzk22 with SMTP id 22so2034275pzk.7
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 01:51:08 -0800 (PST)
MIME-Version: 1.0
Message-ID: <00504502e114aa0527047c900214@google.com>
Date: Thu, 07 Jan 2010 09:51:08 +0000
From: md.zafar.ziya@gmail.com
Subject: [LTP] Cross compiling ltp for android platfrom error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2607320451763377195=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2607320451763377195==
Content-Type: multipart/alternative; boundary=00504502e114aa0518047c900211

--00504502e114aa0518047c900211
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

hi,

While cross compiling ltp for android platform i am getting absurd error.


bionic/libc/include/sys/types.h:122: error: expected '=', ',', ';', 'asm'  
or '__attribute__' before 'u_int64_t'
this error is coming form android header file.

Some sites are telling that compiler picking C++ header ,so because of that  
error is comming


Any help

Regards
zafar ziya

--00504502e114aa0518047c900211
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br /><br />While cross compiling ltp for android platform i am getting =
absurd error.<br /><br /><br />bionic/libc/include/sys/types.h:122: error: =
expected &#39;=3D&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__a=
ttribute__&#39; before &#39;u_int64_t&#39;<br /> this error is coming form =
android header file.<br /><br />Some sites are telling that compiler pickin=
g C++ header ,so because of that error  is comming <br /><br /><br />Any he=
lp<br /><br />Regards<br />zafar ziya
--00504502e114aa0518047c900211--


--===============2607320451763377195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============2607320451763377195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2607320451763377195==--

