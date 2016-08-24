From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Aug 2016 16:44:13 +0200
Subject: [LTP] [PATCH 2/2] syscalls/access02: add behaviour check for
	F_OK
In-Reply-To: <1471598374-26908-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20160804165028.GD3367@rei.lan>
 <1471598374-26908-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1471598374-26908-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160824144413.GD12443@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - *  As well as verify that, these test files can be read/written/executed
> - *  indeed as root and nobody respectively.
> + *  As well as verify that, these test files can be got status or
> + *  read/written/executed indeed as root and nobody respectively.

I've changed this sentence to be more clear on what we do for the check
and pushed both patches. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
