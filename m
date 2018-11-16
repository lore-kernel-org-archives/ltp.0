From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Fri, 16 Nov 2018 04:03:13 +0000
Subject: [LTP] [PATCH] lib: Add library function for parsing
	kernel	config
In-Reply-To: <20181116035401.z2o67pjhxtutap6x@xpf-desktop>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <20181116035401.z2o67pjhxtutap6x@xpf-desktop>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A41437@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Pengfei Xu
> 
> Hi Cyril,
>   Thanks for kconfig checking API!
>   It's worked in most of Linux OS.
> 
>   Just add konfig to support Clear Linux which kconfig is saved
>   in "/lib/kernel/config-xxx"

Pengfei,

Is /lib/kernel/config-xxx something that only Clear Linux does,
or is this a new standard, done by lots of distros?

 -- Tim

