Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0WaP-00019v-Ft
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:20:49 +0000
Date: Tue, 7 Jan 2014 14:20:32 +0100
From: chrubis@suse.cz
Message-ID: <20140107132032.GA27135@rei.Home>
References: <1600529877.1004229.1387350736311.JavaMail.root@wmthree-2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600529877.1004229.1387350736311.JavaMail.root@wmthree-2>
Subject: Re: [LTP] LTP nfs testcases exportfs problem
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
To: ????????? <xunwei.fan@bj.cs2c.com.cn>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> <style>table.customTableClassName {margin-bottom: 10px;border-collapse: collapse;display: table;}.customTableClassName td, .customTableClassName th {border: 1px solid #ddd;}</style><div id="write-custom-write"><span style="font-family: arial, sans-serif; font-size: 12px; color: rgb(34, 34, 34);  background-color: rgb(255, 255, 255);">Hi,</span><br style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);"><p style="font-family: ??????; font-size: 16px;"><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 12px;  background-color: rgb(255, 255, 255);">We are using LTP "ltp-full-20130904" on Fedora 20.The nfs testcases are failing.</span></p><p style="font-family: ??????; font-size: 16px;"><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 12px;  background-color: rgb(255, 255, 255);">We got the same errors:</span></p><p style="font-family: 
 ??????; 
 font-size: 16px;"><span style="font-family: arial, helvetica, sans-serif; font-size: 12px;">exportfs: /tmp/nfsxxxxxx.testdir requires fsid= for NFS export</span></p><p style="font-family: ??????; font-size: 16px;"><span style="font-family: arial, helvetica, sans-serif; font-size: 12px;">The default mount type of /tmp is tmpfs on Fedora 20. It seems that fsid must be set in exportfs options.</span></p><p style="font-family: ??????; font-size: 16px;"><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);">Any thoughts?</span><br></p><p style="font-family: ??????; font-size: 16px;"><span style="font-family: arial, helvetica, sans-serif; font-size: 12px;"><br></span></p><p style="font-size: 16px;"><span style="font-size: 12px; background-color: rgb(255, 255, 255);"><font color="#222222" face="arial, sans-serif">Thanks,</font></span></p><p style="font-size: 16px;"><span style="font-size: 12p
 x; backg
 round-color: rgb(255, 255, 255);"><font color="#222222" face="arial, sans-serif">Xunwei Fan</font></span></p></div>

No HTML emails on the list please.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
