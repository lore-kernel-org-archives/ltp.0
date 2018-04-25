From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Apr 2018 15:44:00 +0200
Subject: [LTP] LTP Release preparations
In-Reply-To: <327336229.15630466.1524663755614.JavaMail.zimbra@redhat.com>
References: <20180412113532.GA5963@rei> <20180419141749.GA13045@rei>
 <20180424133931.GA18016@rei>
 <547086855.15481908.1524604124480.JavaMail.zimbra@redhat.com>
 <20180425132319.GA24333@rei>
 <327336229.15630466.1524663755614.JavaMail.zimbra@redhat.com>
Message-ID: <20180425134400.GC24333@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> That worked for me, though I missed only 2 defines:
> XFRMNLGRP_NONE
> XFRM_MSG_GETPOLICY
> 
> Are you missing three after you drop linux/xfrm.h?

I just grepped the file for XFRM_ and expect these macros to be defined
in the xfrm header, looking closer the NETLINK_XFRM is indeed defined in
the netlink header.

-- 
Cyril Hrubis
chrubis@suse.cz
