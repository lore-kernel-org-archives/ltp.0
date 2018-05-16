From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 May 2018 13:44:38 +0200
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <5AFBFC35.3060400@cn.fujitsu.com>
References: <20180515095118.26282-1-rpalethorpe@suse.com>
 <20180515103042.GB7220@rei> <87bmdhyyrf.fsf@rpws.prws.suse.cz>
 <5AFBFC35.3060400@cn.fujitsu.com>
Message-ID: <20180516114438.GA26490@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the permission of /dev/watchdog was 0660(default permission on RHEL6), Reading /dev/watchdog as nobody
> user failed, but still led to system reboot.

If unprivileged user can reboot the system it's a bug.

-- 
Cyril Hrubis
chrubis@suse.cz
