Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgdZM-0008BG-Ou
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 14:36:28 +0000
Date: Fri, 30 Dec 2011 15:46:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111230144654.GC29431@saboteur.suse.cz>
References: <82BEC95A68153C46932D3E196B922B7217E7AE57AC@BLRKECMBX07.ad.infosys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82BEC95A68153C46932D3E196B922B7217E7AE57AC@BLRKECMBX07.ad.infosys.com>
Subject: Re: [LTP] Testcases for interaces and devices on linux
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
To: Pramod Gajula <pramod_gajula@infosys.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I'm trying to find  Testcases for below features on linux using LTP,
> 
> 
> 1. UART  6. Ethernet - MAC
> 
> 2. SPI
> 
> 3. I2C
> 4. I2S
> 
> 5. SDIO

I don't think that LTP has tests for kernel bus drivers. There are some
tests in testcases/kernel/device-drivers but these are broken and
unmaintained for some time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
