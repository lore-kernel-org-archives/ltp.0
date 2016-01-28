From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 16:02:16 +0100
Subject: [LTP] [PATCH] sssd/sssd-lib.sh: fix the permission of sssd.conf
In-Reply-To: <1448554618-24055-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1448554618-24055-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160128150216.GC16175@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In order to restart sssd service successfully, the permission of
> sssd.conf should be set to 0600.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
