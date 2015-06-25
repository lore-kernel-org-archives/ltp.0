Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z80sW-0000an-Ci
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 06:43:16 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z80sQ-0001KO-Mw
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 06:43:16 +0000
Message-ID: <558BA2B1.9030508@huawei.com>
Date: Thu, 25 Jun 2015 14:41:53 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <558B6C8C.5000202@huawei.com>	<558B9D33.1090305@cn.fujitsu.com>
	<CALPnEb6td8AGRvRWSG1frhi=VZr67apQtqNd7UUvAgC8Wg4hDg@mail.gmail.com>
In-Reply-To: <CALPnEb6td8AGRvRWSG1frhi=VZr67apQtqNd7UUvAgC8Wg4hDg@mail.gmail.com>
Subject: Re: [LTP] Cedric
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6553179855559112345=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?UTF-8?B?Q8OpZHJpYyBIbnlkYQ==?= <ced.hnyda@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--===============6553179855559112345==
Content-Type: multipart/alternative;
	boundary="------------080302030600030600040605"

--------------080302030600030600040605
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Cedric,
     Thanks for your reminding. I understand.
Maybe it is better to add the following in these cases.

if (tst_kvercmp(3, 17, 0) < 0)
         tst_brkm(TCONF, NULL, "getrandom is not supported");

     Regards.
         Yuan

On 2015/6/25 14:32, Cédric Hnyda wrote:
> Hi!
>
> On 06/25/2015 04:50 AM, Yuan Sun wrote:
> > Hi Cedric,
> >      I encounter the following error in ubuntu14.04. Your patch
> > "syscall/getrandom: Add tests for getrandom" leads to the error.
> >      Do I need to install new libraries?
>
> getrandom() was introduced in version 3.17 of the Linux kernel.
> Ubuntu 14.04 gets shipped with kernel 3.13.
>
> Try to upgrade your kernel to a more recent version to get the syscall.
>
> Best,
> Cédric Hnyda


--------------080302030600030600040605
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Cedric,<br>
        Thanks for your reminding. I understand.<br>
    Maybe it is better to add the following in these cases.<br>
    <br>
    if (tst_kvercmp(3, 17, 0) &lt; 0)<br>
            tst_brkm(TCONF, NULL, "getrandom is not supported");<br>
    <br>
        Regards.<br>
            Yuan<br>
    <br>
    <div class="moz-cite-prefix">On 2015/6/25 14:32, Cédric Hnyda wrote:<br>
    </div>
    <blockquote
cite="mid:CALPnEb6td8AGRvRWSG1frhi=VZr67apQtqNd7UUvAgC8Wg4hDg@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div>
          <div>
            <div>Hi!<br>
              <br>
              <span class="im">On 06/25/2015 04:50 AM, Yuan Sun wrote:<br>
                &gt; Hi Cedric,<br>
                &gt;      I encounter the following error in
                ubuntu14.04. Your patch<br>
                &gt; "syscall/getrandom: Add tests for getrandom" leads
                to the error.<br>
                &gt;      Do I need to install new libraries?</span><br>
              <br>
            </div>
            getrandom() was introduced in version 3.17 of the Linux
            kernel.<br>
          </div>
          Ubuntu 14.04 gets shipped with kernel 3.13.<br>
          <br>
        </div>
        Try to upgrade your kernel to a more recent version to get the
        syscall.<br>
        <div>
          <div><br>
          </div>
          <div>Best,<br>
          </div>
          <div>Cédric Hnyda<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------080302030600030600040605--


--===============6553179855559112345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
--===============6553179855559112345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6553179855559112345==--

